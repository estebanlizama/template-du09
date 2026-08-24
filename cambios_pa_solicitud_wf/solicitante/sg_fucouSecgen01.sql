USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fucouSecgen01')
    DROP PROCEDURE Analisis2.sg_fucouSecgen01
GO

/* Procedimiento : Analisis2.sg_fucouSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Opcional)
   @compensaciones_csv  -> Parametro de entrada. (Opcional)

   Objetivo : Reemplaza las compensaciones FUCO de un funcionario DU288. Compatibilidad: Sybase ASE 12.5. No crea tablas temporales y respeta la transaccion iniciada por el proceso llamador. Entrada       : @id_funprse         int, @compensaciones_csv varchar(2000) = NULL Formato: YYYY-MM-DD|HH:MM|HH:MM;YYYY-MM-DD|HH:MM|HH:MM Salida        : id_funprse            int, registros_insertados int, msg                   varchar(255)

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fucouSecgen01
    @id_funprse int = NULL,
    @compensaciones_csv varchar(2000) = NULL
AS
BEGIN
    DECLARE @cod_modprs tinyint
    DECLARE @dentro_jor char(1)
    DECLARE @f_inicio datetime
    DECLARE @f_termino datetime
    DECLARE @csv_original varchar(2048)
    DECLARE @csv_trabajo varchar(2048)
    DECLARE @pos int
    DECLARE @chunk varchar(100)
    DECLARE @subchunk varchar(100)
    DECLARE @col_pos1 int
    DECLARE @col_pos2 int
    DECLARE @fec_str varchar(20)
    DECLARE @ini_str varchar(15)
    DECLARE @ter_str varchar(15)
    DECLARE @anio int
    DECLARE @mes int
    DECLARE @dia int
    DECLARE @dias_mes int
    DECLARE @hora_ini int
    DECLARE @min_ini int
    DECLARE @hora_ter int
    DECLARE @min_ter int
    DECLARE @fec_val datetime
    DECLARE @fin_val datetime
    DECLARE @ini_val time
    DECLARE @ter_val time
    DECLARE @insertados int
    DECLARE @tran_inicial int
    DECLARE @transaccion_propia tinyint

    /* Guardar el nivel antes de ejecutar consultas o DML. */
    SELECT @tran_inicial = @@trancount
    SELECT @transaccion_propia = 0
    SELECT @insertados = 0

    /* 1. Validar funcionario y modalidad. */
    IF @id_funprse IS NULL
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
               'Error: Falta ID del funcionario' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fups
        WHERE id_funprse = @id_funprse
    )
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
               'Error: El funcionario especificado no existe' AS msg
        RETURN
    END

    SELECT
        @cod_modprs = isnull(prse.cod_modprs, 1),
        @dentro_jor = isnull(fu.dentro_jor, 'N'),
        @f_inicio = fu.f_inicio,
        @f_termino = fu.f_termino
    FROM secgen_db.dbo.sg_prse prse,
         secgen_db.dbo.sg_fups fu
    WHERE prse.nro_solici = fu.nro_solici
      AND fu.id_funprse = @id_funprse

    IF @cod_modprs IS NULL OR @cod_modprs <> 2
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
               'Error: El funcionario no corresponde a la modalidad DU288' AS msg
        RETURN
    END

    IF @f_inicio IS NULL OR @f_termino IS NULL
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
               'Error: El funcionario no tiene un periodo de ejecucion valido' AS msg
        RETURN
    END

    IF @dentro_jor NOT IN ('S', 'D')
       AND @compensaciones_csv IS NOT NULL
       AND ltrim(rtrim(@compensaciones_csv)) <> ''
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
               'Error: No se permiten compensaciones fuera de jornada' AS msg
        RETURN
    END

    SELECT @csv_original = isnull(ltrim(rtrim(@compensaciones_csv)), '')

    /*
       2. Primera pasada: validar el CSV completo antes de modificar sg_fuco.
       Se valida manualmente fecha y hora porque ASE 12.5 no dispone de ISDATE
       en esta instalacion y una conversion invalida abortaria el procedimiento.
    */
    IF @csv_original <> ''
    BEGIN
        SELECT @csv_trabajo = @csv_original + ';'

        WHILE charindex(';', @csv_trabajo) > 0
        BEGIN
            SELECT @pos = charindex(';', @csv_trabajo)
            SELECT @chunk = ltrim(rtrim(substring(@csv_trabajo, 1, @pos - 1)))
            SELECT @csv_trabajo = substring(
                @csv_trabajo,
                @pos + 1,
                char_length(@csv_trabajo) - @pos
            )

            IF @chunk <> ''
            BEGIN
                SELECT @col_pos1 = charindex('|', @chunk)

                IF @col_pos1 <= 1 OR @col_pos1 = char_length(@chunk)
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Formato invalido. Use fecha|hora_ini|hora_ter' AS msg
                    RETURN
                END

                SELECT @fec_str = ltrim(rtrim(substring(@chunk, 1, @col_pos1 - 1)))
                SELECT @subchunk = substring(
                    @chunk,
                    @col_pos1 + 1,
                    char_length(@chunk) - @col_pos1
                )
                SELECT @col_pos2 = charindex('|', @subchunk)

                IF @col_pos2 <= 1 OR @col_pos2 = char_length(@subchunk)
                   OR charindex('|', substring(
                        @subchunk,
                        @col_pos2 + 1,
                        char_length(@subchunk) - @col_pos2
                   )) > 0
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Formato invalido. Use fecha|hora_ini|hora_ter' AS msg
                    RETURN
                END

                SELECT @ini_str = ltrim(rtrim(substring(@subchunk, 1, @col_pos2 - 1)))
                SELECT @ter_str = ltrim(rtrim(substring(
                    @subchunk,
                    @col_pos2 + 1,
                    char_length(@subchunk) - @col_pos2
                )))

                /* Validar YYYY-MM-DD sin funciones no disponibles en ASE 12.5. */
                IF char_length(@fec_str) <> 10
                   OR substring(@fec_str, 5, 1) <> '-'
                   OR substring(@fec_str, 8, 1) <> '-'
                   OR substring(@fec_str, 1, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 2, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 3, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 4, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 6, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 7, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 9, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@fec_str, 10, 1) NOT BETWEEN '0' AND '9'
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Fecha invalida. Use YYYY-MM-DD' AS msg
                    RETURN
                END

                SELECT @anio = convert(int, substring(@fec_str, 1, 4))
                SELECT @mes = convert(int, substring(@fec_str, 6, 2))
                SELECT @dia = convert(int, substring(@fec_str, 9, 2))

                IF @anio < 1753 OR @anio > 9999 OR @mes < 1 OR @mes > 12
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Fecha fuera del rango valido' AS msg
                    RETURN
                END

                SELECT @dias_mes = 31
                IF @mes IN (4, 6, 9, 11)
                    SELECT @dias_mes = 30
                IF @mes = 2
                BEGIN
                    SELECT @dias_mes = 28
                    IF (@anio % 400 = 0) OR ((@anio % 4 = 0) AND (@anio % 100 <> 0))
                        SELECT @dias_mes = 29
                END

                IF @dia < 1 OR @dia > @dias_mes
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Fecha calendario invalida' AS msg
                    RETURN
                END

                /* Construir datetime desde una fecha base segura y no ambigua. */
                SELECT @fec_val = dateadd(
                    day,
                    @dia - 1,
                    dateadd(
                        month,
                        @mes - 1,
                        dateadd(year, @anio - 1900, convert(datetime, '19000101'))
                    )
                )

                /* Validar HH:MM antes de convertir a time. */
                IF char_length(@ini_str) <> 5
                   OR substring(@ini_str, 3, 1) <> ':'
                   OR substring(@ini_str, 1, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@ini_str, 2, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@ini_str, 4, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@ini_str, 5, 1) NOT BETWEEN '0' AND '9'
                   OR char_length(@ter_str) <> 5
                   OR substring(@ter_str, 3, 1) <> ':'
                   OR substring(@ter_str, 1, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@ter_str, 2, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@ter_str, 4, 1) NOT BETWEEN '0' AND '9'
                   OR substring(@ter_str, 5, 1) NOT BETWEEN '0' AND '9'
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Rango horario invalido. Use HH:MM' AS msg
                    RETURN
                END

                SELECT @hora_ini = convert(int, substring(@ini_str, 1, 2))
                SELECT @min_ini = convert(int, substring(@ini_str, 4, 2))
                SELECT @hora_ter = convert(int, substring(@ter_str, 1, 2))
                SELECT @min_ter = convert(int, substring(@ter_str, 4, 2))

                IF @hora_ini < 0 OR @hora_ini > 23
                   OR @min_ini < 0 OR @min_ini > 59
                   OR @hora_ter < 0 OR @hora_ter > 23
                   OR @min_ter < 0 OR @min_ter > 59
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Rango horario invalido. Use HH:MM' AS msg
                    RETURN
                END

                SELECT @ini_val = convert(time, @ini_str)
                SELECT @ter_val = convert(time, @ter_str)

                IF @ter_val = @ini_val
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Las horas de inicio y termino deben ser distintas' AS msg
                    RETURN
                END

                SELECT @fin_val = dateadd(
                    minute,
                    @hora_ter * 60 + @min_ter,
                    @fec_val
                )
                SELECT @fec_val = dateadd(
                    minute,
                    @hora_ini * 60 + @min_ini,
                    @fec_val
                )
                IF @ter_val < @ini_val
                    SELECT @fin_val = dateadd(day, 1, @fin_val)

                IF datediff(day, @f_inicio, @fec_val) < 0
                   OR datediff(day, @fin_val, @f_termino) < 0
                BEGIN
                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: La compensacion esta fuera del periodo autorizado' AS msg
                    RETURN
                END

            END
        END
    END

    /* 3. Iniciar una transaccion solo cuando el llamador no tiene una activa. */
    IF @tran_inicial = 0
    BEGIN
        BEGIN TRAN
        SELECT @transaccion_propia = 1
    END

    DELETE FROM secgen_db.dbo.sg_fuco
    WHERE id_funprse = @id_funprse

    IF @@error <> 0
    BEGIN
        IF @transaccion_propia = 1 AND @@trancount > @tran_inicial
            ROLLBACK TRAN

        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
               'Error al limpiar compensaciones anteriores' AS msg
        RETURN
    END

    /* 4. Segunda pasada: insertar directamente, sin DDL ni tabla temporal. */
    IF @csv_original <> ''
    BEGIN
        SELECT @csv_trabajo = @csv_original + ';'

        WHILE charindex(';', @csv_trabajo) > 0
        BEGIN
            SELECT @pos = charindex(';', @csv_trabajo)
            SELECT @chunk = ltrim(rtrim(substring(@csv_trabajo, 1, @pos - 1)))
            SELECT @csv_trabajo = substring(
                @csv_trabajo,
                @pos + 1,
                char_length(@csv_trabajo) - @pos
            )

            IF @chunk <> ''
            BEGIN
                SELECT @col_pos1 = charindex('|', @chunk)
                SELECT @fec_str = ltrim(rtrim(substring(@chunk, 1, @col_pos1 - 1)))
                SELECT @subchunk = substring(
                    @chunk,
                    @col_pos1 + 1,
                    char_length(@chunk) - @col_pos1
                )
                SELECT @col_pos2 = charindex('|', @subchunk)
                SELECT @ini_str = ltrim(rtrim(substring(@subchunk, 1, @col_pos2 - 1)))
                SELECT @ter_str = ltrim(rtrim(substring(
                    @subchunk,
                    @col_pos2 + 1,
                    char_length(@subchunk) - @col_pos2
                )))

                SELECT @anio = convert(int, substring(@fec_str, 1, 4))
                SELECT @mes = convert(int, substring(@fec_str, 6, 2))
                SELECT @dia = convert(int, substring(@fec_str, 9, 2))
                SELECT @fec_val = dateadd(
                    day,
                    @dia - 1,
                    dateadd(
                        month,
                        @mes - 1,
                        dateadd(year, @anio - 1900, convert(datetime, '19000101'))
                    )
                )
                SELECT @ini_val = convert(time, @ini_str)
                SELECT @ter_val = convert(time, @ter_str)
                SELECT @hora_ini = convert(int, substring(@ini_str, 1, 2))
                SELECT @min_ini = convert(int, substring(@ini_str, 4, 2))
                SELECT @hora_ter = convert(int, substring(@ter_str, 1, 2))
                SELECT @min_ter = convert(int, substring(@ter_str, 4, 2))
                SELECT @fin_val = dateadd(
                    minute,
                    @hora_ter * 60 + @min_ter,
                    @fec_val
                )
                SELECT @fec_val = dateadd(
                    minute,
                    @hora_ini * 60 + @min_ini,
                    @fec_val
                )
                IF @ter_val < @ini_val
                    SELECT @fin_val = dateadd(day, 1, @fin_val)

                IF EXISTS (
                    SELECT 1
                    FROM secgen_db.dbo.sg_fuco fc
                    WHERE fc.id_funprse = @id_funprse
                      AND @fec_val < dateadd(
                            day,
                            CASE WHEN fc.hora_ter < fc.hora_ini THEN 1 ELSE 0 END,
                            dateadd(
                                minute,
                                datepart(hh, fc.hora_ter) * 60 + datepart(mi, fc.hora_ter),
                                dateadd(
                                    day,
                                    datediff(day, convert(datetime, '19000101'), fc.fec_compro),
                                    convert(datetime, '19000101')
                                )
                            )
                          )
                      AND dateadd(
                            minute,
                            datepart(hh, fc.hora_ini) * 60 + datepart(mi, fc.hora_ini),
                            dateadd(
                                day,
                                datediff(day, convert(datetime, '19000101'), fc.fec_compro),
                                convert(datetime, '19000101')
                            )
                          ) < @fin_val
                )
                BEGIN
                    IF @transaccion_propia = 1 AND @@trancount > @tran_inicial
                        ROLLBACK TRAN

                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error: Existe un tramo FUCO duplicado o superpuesto' AS msg
                    RETURN
                END

                INSERT INTO secgen_db.dbo.sg_fuco
                    (id_funprse, fec_compro, hora_ini, hora_ter)
                VALUES
                    (@id_funprse, @fec_val, @ini_val, @ter_val)

                IF @@error <> 0
                BEGIN
                    IF @transaccion_propia = 1 AND @@trancount > @tran_inicial
                        ROLLBACK TRAN

                    SELECT @id_funprse AS id_funprse, 0 AS registros_insertados,
                           'Error al guardar compensaciones' AS msg
                    RETURN
                END

                SELECT @insertados = @insertados + 1
            END
        END
    END

    IF @transaccion_propia = 1 AND @@trancount > @tran_inicial
        COMMIT TRAN

    SELECT @id_funprse AS id_funprse,
           @insertados AS registros_insertados,
           'Compensaciones actualizadas correctamente' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fucouSecgen01 TO UsuaVrac
GO
