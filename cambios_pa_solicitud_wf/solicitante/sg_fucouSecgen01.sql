USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fucouSecgen01')
    DROP PROCEDURE Analisis2.sg_fucouSecgen01
GO

/* Procedimiento : Analisis2.sg_fucouSecgen01
   Objetivo      : Actualiza las compensaciones (fecha y rango horario) de un funcionario prestación de servicios de manera atómica por CSV.
   Entrada       :
       @id_funprse         int,
       @compensaciones_csv varchar(2000) = NULL -- Formato: 'YYYY-MM-DD|HH:MM|HH:MM;YYYY-MM-DD|HH:MM|HH:MM'
   Salida        :
       id_funprse           int,
       registros_insertados int,
       msg                  varchar(255)
*/
CREATE PROCEDURE Analisis2.sg_fucouSecgen01
    @id_funprse int = NULL,
    @compensaciones_csv varchar(2000) = NULL
AS
BEGIN
    -- 1. Validar id_funprse
    IF @id_funprse IS NULL
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Falta ID del funcionario' AS msg
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: El funcionario especificado no existe' AS msg
        RETURN
    END

    -- 2. Confirmar modalidad DU288
    DECLARE @cod_modprs tinyint
    DECLARE @dentro_jor char(1)
    SELECT 
        @cod_modprs = isnull(prse.cod_modprs, 1),
        @dentro_jor = isnull(fu.dentro_jor, 'N')
    FROM secgen_db.dbo.sg_prse prse
    JOIN secgen_db.dbo.sg_fups fu ON prse.nro_solici = fu.nro_solici
    WHERE fu.id_funprse = @id_funprse

    IF @cod_modprs <> 2
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: El funcionario no corresponde a la modalidad DU288' AS msg
        RETURN
    END

    -- Validar que no se permitan compensaciones si está fuera de jornada
    IF @dentro_jor <> 'S' AND @compensaciones_csv IS NOT NULL AND ltrim(rtrim(@compensaciones_csv)) <> ''
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: No se permiten horas de compensación si el funcionario está fuera de jornada' AS msg
        RETURN
    END

    CREATE TABLE #comps (
        fec_compro datetime NOT NULL,
        hora_ini time(3) NOT NULL,
        hora_ter time(3) NOT NULL
    )

    -- 3. Validar y parsear todo el CSV antes de modificar las compensaciones persistidas.
    IF @compensaciones_csv IS NOT NULL AND ltrim(rtrim(@compensaciones_csv)) <> ''
    BEGIN
        DECLARE @pos int
        DECLARE @chunk varchar(100)
        DECLARE @col_pos1 int
        DECLARE @col_pos2 int
        DECLARE @fec_str varchar(20)
        DECLARE @ini_str varchar(15)
        DECLARE @ter_str varchar(15)

        SELECT @compensaciones_csv = @compensaciones_csv + ';'

        WHILE charindex(';', @compensaciones_csv) > 0
        BEGIN
            SELECT @pos = charindex(';', @compensaciones_csv)
            SELECT @chunk = ltrim(rtrim(substring(@compensaciones_csv, 1, @pos - 1)))
            SELECT @compensaciones_csv = substring(
                @compensaciones_csv,
                @pos + 1,
                char_length(@compensaciones_csv) - @pos
            )

            IF @chunk <> ''
            BEGIN
                -- Buscar el primer pipe '|'
                SELECT @col_pos1 = charindex('|', @chunk)
                IF @col_pos1 <= 1 OR @col_pos1 = char_length(@chunk)
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Formato de compensación inválido. Use fecha|hora_ini|hora_ter' AS msg
                    RETURN
                END

                SELECT @fec_str = ltrim(rtrim(substring(@chunk, 1, @col_pos1 - 1)))
                
                -- Buscar el segundo pipe '|'
                DECLARE @subchunk varchar(100)
                SELECT @subchunk = substring(@chunk, @col_pos1 + 1, char_length(@chunk) - @col_pos1)
                SELECT @col_pos2 = charindex('|', @subchunk)
                
                IF @col_pos2 <= 1 OR @col_pos2 = char_length(@subchunk)
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Formato de compensación inválido. Falta hora de término.' AS msg
                    RETURN
                END

                SELECT @ini_str = ltrim(rtrim(substring(@subchunk, 1, @col_pos2 - 1)))
                SELECT @ter_str = ltrim(rtrim(substring(@subchunk, @col_pos2 + 1, char_length(@subchunk) - @col_pos2)))

                -- Validar conversiones
                IF isdate(@fec_str) = 0
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Fecha de compensación no válida: ' + @fec_str AS msg
                    RETURN
                END

                IF charindex(':', @ini_str) = 0 OR charindex(':', @ter_str) = 0
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Rango horario no válido. Use HH:MM.' AS msg
                    RETURN
                END

                -- Validar duplicados en la misma transacción temporal
                IF EXISTS (
                    SELECT 1 
                    FROM #comps 
                    WHERE fec_compro = convert(datetime, @fec_str)
                )
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Fecha de compensación duplicada en la misma carga: ' + @fec_str AS msg
                    RETURN
                END
                
                -- Insertar en tabla temporal
                INSERT INTO #comps (fec_compro, hora_ini, hora_ter)
                VALUES (convert(datetime, @fec_str), convert(time, @ini_str), convert(time, @ter_str))

                IF @@error <> 0
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al procesar fila de compensación: ' + @chunk AS msg
                    RETURN
                END
            END
        END
    END

    -- 4. Iniciar transacción
    BEGIN TRAN

    -- 5. Eliminar compensaciones existentes
    DELETE FROM secgen_db.dbo.sg_fuco 
    WHERE id_funprse = @id_funprse

    IF @@error <> 0
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al limpiar compensaciones anteriores' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    -- 6. Insertar registros procesados
    DECLARE @insertados int
    SELECT @insertados = 0

    INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, fec_compro, hora_ini, hora_ter)
    SELECT @id_funprse, fec_compro, hora_ini, hora_ter
    FROM #comps

    IF @@error <> 0
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensaciones' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    SELECT @insertados = @@rowcount

    -- 7. Confirmar transacción
    COMMIT TRAN
    SELECT @id_funprse AS id_funprse, @insertados AS registros_insertados, 'Compensaciones actualizadas correctamente' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fucouSecgen01 TO UsuaVrac
GO
