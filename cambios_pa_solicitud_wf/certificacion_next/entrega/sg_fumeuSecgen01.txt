USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fumeuSecgen01'
)
    DROP PROCEDURE Analisis2.sg_fumeuSecgen01
GO

/* Procedimiento : Analisis2.sg_fumeuSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Opcional)
   @meses_csv           -> Lista de meses propuestos, formato ano:mes separados por punto y coma. (Opcional)
   @cod_estcuo          -> Estado inicial de la cuota; usa 1 (Propuesta) si no se envia. (Opcional)

   Objetivo : Sincronizar de forma diferencial los meses de ejecucion de un funcionario: borra
   solo los que salen de la propuesta, inserta solo los que entran y conserva el nro_cuota de
   los que siguen.

   Creacion: ELA 2026/08/24
   Actualizacion: ELA 2026/09/07 - sincronizacion diferencial
*/
CREATE PROCEDURE Analisis2.sg_fumeuSecgen01
    @id_funprse int = NULL,
    @meses_csv varchar(500) = NULL,
    @cod_estcuo int = 1
AS
BEGIN
    SET NOCOUNT ON

    IF @id_funprse IS NULL
    BEGIN
        SELECT 'Error: Falta ID del funcionario' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fups
        WHERE id_funprse = @id_funprse
    )
    BEGIN
        SELECT 'Error: El funcionario especificado no existe' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fups fu
        INNER JOIN secgen_db.dbo.sg_prse prse
            ON prse.nro_solici = fu.nro_solici
        WHERE fu.id_funprse = @id_funprse
          AND isnull(prse.cod_modprs, 1) = 2
    )
    BEGIN
        SELECT 'Error: El funcionario no corresponde a la modalidad DU288' AS msg
        RETURN
    END

    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fume
        WHERE id_funprse = @id_funprse
          AND cod_estcuo NOT IN (1, 3)
    )
    BEGIN
        SELECT 'Error: No se pueden modificar las cuotas porque están en proceso de visación o pago' AS msg
        RETURN
    END

    CREATE TABLE #meses_raw (
        anio smallint NOT NULL,
        nro_mes tinyint NOT NULL
    )

    IF @meses_csv IS NOT NULL AND ltrim(rtrim(@meses_csv)) <> ''
    BEGIN
        DECLARE @pos int
        DECLARE @chunk varchar(50)
        DECLARE @col_pos int
        DECLARE @anio varchar(10)
        DECLARE @nro_mes varchar(10)

        SELECT @meses_csv = @meses_csv + ';'

        WHILE charindex(';', @meses_csv) > 0
        BEGIN
            SELECT @pos = charindex(';', @meses_csv)
            SELECT @chunk = ltrim(rtrim(substring(@meses_csv, 1, @pos - 1)))
            SELECT @meses_csv = substring(
                @meses_csv,
                @pos + 1,
                char_length(@meses_csv) - @pos
            )

            IF @chunk <> ''
            BEGIN
                SELECT @col_pos = charindex(':', @chunk)

                IF @col_pos <= 1 OR @col_pos = char_length(@chunk)
                BEGIN
                    SELECT 'Error: Formato de mes invalido. Use anio:mes' AS msg
                    RETURN
                END

                SELECT @anio = ltrim(rtrim(substring(@chunk, 1, @col_pos - 1)))
                SELECT @nro_mes = ltrim(rtrim(substring(
                    @chunk,
                    @col_pos + 1,
                    char_length(@chunk) - @col_pos
                )))

                IF @anio = ''
                   OR @nro_mes = ''
                   OR patindex('%[^0-9]%', @anio) > 0
                   OR patindex('%[^0-9]%', @nro_mes) > 0
                BEGIN
                    SELECT 'Error: Anio o mes no numerico' AS msg
                    RETURN
                END

                IF convert(int, @anio) < 2000 OR convert(int, @anio) > 2100
                BEGIN
                    SELECT 'Error: Anio fuera de rango' AS msg
                    RETURN
                END

                IF convert(int, @nro_mes) < 1 OR convert(int, @nro_mes) > 12
                BEGIN
                    SELECT 'Error: Mes fuera de rango' AS msg
                    RETURN
                END

                IF EXISTS (
                    SELECT 1
                    FROM #meses_raw
                    WHERE anio = convert(smallint, @anio)
                      AND nro_mes = convert(tinyint, @nro_mes)
                )
                BEGIN
                    SELECT 'Error: Mes de ejecucion duplicado' AS msg
                    RETURN
                END

                INSERT INTO #meses_raw (anio, nro_mes)
                VALUES (convert(smallint, @anio), convert(tinyint, @nro_mes))
            END
        END
    END

    CREATE TABLE #meses (
        orden numeric(4,0) identity,
        anio smallint NOT NULL,
        nro_mes tinyint NOT NULL
    )

    INSERT INTO #meses (anio, nro_mes)
    SELECT anio, nro_mes
    FROM #meses_raw
    ORDER BY anio, nro_mes

    CREATE TABLE #meses_nuevos (
        correlativ numeric(4,0) identity,
        anio smallint NOT NULL,
        nro_mes tinyint NOT NULL
    )

    CREATE TABLE #cuotas_salen (
        nro_cuota tinyint NOT NULL
    )

    DECLARE @max_cuota int

    INSERT INTO #cuotas_salen (nro_cuota)
    SELECT f.nro_cuota
    FROM secgen_db.dbo.sg_fume f
    WHERE f.id_funprse = @id_funprse
      AND NOT EXISTS (
          SELECT 1
          FROM #meses m
          WHERE m.anio = f.ano_prop
            AND m.nro_mes = f.mes_prop
      )

    IF @@error <> 0
    BEGIN
        SELECT 'Error al determinar los meses de ejecucion que se retiran' AS msg
        RETURN
    END

    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fuc2 c
        WHERE c.id_funprse = @id_funprse
          AND c.nro_cuota IN (SELECT nro_cuota FROM #cuotas_salen)
    )
    BEGIN
        SELECT 'Error: No se puede quitar un mes de ejecucion que ya tiene compensaciones registradas' AS msg
        RETURN
    END

    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fum2 h
        WHERE h.id_funprse = @id_funprse
          AND h.nro_cuota IN (SELECT nro_cuota FROM #cuotas_salen)
    )
    BEGIN
        SELECT 'Error: No se puede quitar un mes de ejecucion que ya tiene historial de cuota' AS msg
        RETURN
    END

    BEGIN TRAN

    DELETE FROM secgen_db.dbo.sg_fume
    WHERE id_funprse = @id_funprse
      AND nro_cuota IN (SELECT nro_cuota FROM #cuotas_salen)

    IF @@error <> 0
    BEGIN
        SELECT 'Error al limpiar meses de ejecucion anteriores' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    INSERT INTO #meses_nuevos (anio, nro_mes)
    SELECT m.anio, m.nro_mes
    FROM #meses m
    WHERE NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fume f
        WHERE f.id_funprse = @id_funprse
          AND f.ano_prop = m.anio
          AND f.mes_prop = m.nro_mes
    )
    ORDER BY m.anio, m.nro_mes

    IF @@error <> 0
    BEGIN
        SELECT 'Error al determinar los meses de ejecucion nuevos' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    SELECT @max_cuota = isnull(max(nro_cuota), 0)
    FROM secgen_db.dbo.sg_fume
    WHERE id_funprse = @id_funprse

    INSERT INTO secgen_db.dbo.sg_fume (
        id_funprse,
        nro_cuota,
        ano_prop,
        mes_prop,
        cod_estcuo
    )
    SELECT
        @id_funprse,
        @max_cuota + correlativ,
        anio,
        nro_mes,
        @cod_estcuo
    FROM #meses_nuevos

    IF @@error <> 0
    BEGIN
        SELECT 'Error al insertar meses de ejecucion' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
    SELECT 'Meses de ejecucion actualizados correctamente' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fumeuSecgen01 TO UsuaVrac
GO
