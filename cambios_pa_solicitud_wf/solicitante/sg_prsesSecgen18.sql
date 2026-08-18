USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_prsesSecgen18'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen18
GO

/* Autoriza por identidad JWT: titular, tarea efectiva o participacion previa. */
CREATE PROCEDURE Analisis2.sg_prsesSecgen18
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL
AS
BEGIN
    DECLARE @rut_titular char(9)
    DECLARE @cod_estsol tinyint
    DECLARE @es_solicitante char(1)
    DECLARE @tarea_directa char(1)
    DECLARE @participo char(1)

    IF @nro_solici IS NULL OR @rut_usua IS NULL
    BEGIN
        SELECT convert(int, isnull(@nro_solici, 0)) AS nro_solici,
               convert(tinyint, NULL) AS cod_estsol,
               convert(char(9), NULL) AS rut_titular,
               convert(int, NULL) AS cod_organi_representado,
               'N' AS es_solicitante, 'N' AS es_representante,
               'N' AS tiene_tarea_pendiente, 'N' AS participo_flujo,
               'N' AS puede_ver, 'N' AS puede_editar,
               convert(varchar(20), 'SIN_ACCESO') AS tipo_acceso
        RETURN
    END

    SELECT
        @rut_titular = soli.rut_solici,
        @cod_estsol = soli.cod_estsol
    FROM secgen_db.dbo.sg_soli soli
    WHERE soli.nro_solici = @nro_solici

    SELECT @es_solicitante = CASE
        WHEN @rut_titular = @rut_usua THEN 'S' ELSE 'N'
    END

    SELECT @tarea_directa = CASE WHEN EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_apso apso
        INNER JOIN secgen_db.dbo.sg_prse prse
          ON prse.nro_solici = apso.nro_solici
         AND prse.cod_flusol = apso.cod_flusol
         AND prse.cod_etapa = apso.cod_etapa
        WHERE apso.nro_solici = @nro_solici
          AND apso.cod_estapr = 4
          AND apso.rut_usua = @rut_usua
    ) THEN 'S' ELSE 'N' END

    SELECT @participo = CASE WHEN EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_apso apso
        WHERE apso.nro_solici = @nro_solici
          AND (apso.rut_usua = @rut_usua OR apso.rut_autori = @rut_usua)
    ) OR EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_hist hist
        WHERE hist.nro_solici = @nro_solici
          AND hist.rut_accion = @rut_usua
    ) THEN 'S' ELSE 'N' END

    SELECT
        @nro_solici AS nro_solici,
        @cod_estsol AS cod_estsol,
        @rut_titular AS rut_titular,
        convert(int, NULL) AS cod_organi_representado,
        @es_solicitante AS es_solicitante,
        'N' AS es_representante,
        @tarea_directa AS tiene_tarea_pendiente,
        @participo AS participo_flujo,
        CASE WHEN @es_solicitante = 'S' OR @tarea_directa = 'S' OR @participo = 'S'
             THEN 'S' ELSE 'N' END AS puede_ver,
        CASE WHEN @cod_estsol IN (5, 6) AND @es_solicitante = 'S'
             THEN 'S' ELSE 'N' END AS puede_editar,
        CASE WHEN @es_solicitante = 'S' THEN 'PROPIA'
             WHEN @tarea_directa = 'S' THEN 'ASIGNACION_DIRECTA'
             WHEN @participo = 'S' THEN 'PARTICIPACION'
             ELSE 'SIN_ACCESO' END AS tipo_acceso
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen18 TO UsuaVrac
GO
