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

/*
Procedimiento : Analisis2.sg_prsesSecgen18
Objetivo      : Autorizar el acceso de un RUT a una solicitud PDS.

Las tareas ya se crean con el RUT responsable en sg_apso.rut_usua.
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen18
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL
AS
BEGIN
    IF @nro_solici IS NULL OR @rut_usua IS NULL
    BEGIN
        SELECT
            convert(int, isnull(@nro_solici, 0)) AS nro_solici,
            convert(tinyint, NULL) AS cod_estsol,
            'N' AS es_solicitante,
            'N' AS tiene_tarea_pendiente,
            'N' AS participo_flujo,
            'N' AS puede_ver,
            'N' AS puede_editar
        RETURN
    END

    CREATE TABLE #tarea_actual (
        nro_aproba int not null
    )

    INSERT INTO #tarea_actual (nro_aproba)
    SELECT apso.nro_aproba
    FROM secgen_db.dbo.sg_apso apso
    INNER JOIN secgen_db.dbo.sg_prse prse
        ON prse.nro_solici = apso.nro_solici
       AND prse.cod_flusol = apso.cod_flusol
       AND prse.cod_etapa = apso.cod_etapa
    WHERE apso.nro_solici = @nro_solici
      AND apso.cod_estapr = 4
      AND apso.rut_usua = @rut_usua

    SELECT
        soli.nro_solici,
        soli.cod_estsol,
        CASE WHEN soli.rut_solici = @rut_usua THEN 'S' ELSE 'N' END AS es_solicitante,
        CASE WHEN EXISTS (SELECT 1 FROM #tarea_actual)
             THEN 'S' ELSE 'N' END AS tiene_tarea_pendiente,
        CASE WHEN EXISTS (
            SELECT 1
            FROM secgen_db.dbo.sg_apso apso
            WHERE apso.nro_solici = soli.nro_solici
              AND (apso.rut_usua = @rut_usua OR apso.rut_autori = @rut_usua)
        ) THEN 'S' ELSE 'N' END AS participo_flujo,
        CASE WHEN soli.rut_solici = @rut_usua
                  OR EXISTS (SELECT 1 FROM #tarea_actual)
                  OR EXISTS (
            SELECT 1
            FROM secgen_db.dbo.sg_apso apso
            WHERE apso.nro_solici = soli.nro_solici
              AND (apso.rut_usua = @rut_usua OR apso.rut_autori = @rut_usua)
        ) THEN 'S' ELSE 'N' END AS puede_ver,
        CASE WHEN soli.rut_solici = @rut_usua
                  AND soli.cod_estsol IN (5, 6)
             THEN 'S' ELSE 'N' END AS puede_editar
    FROM secgen_db.dbo.sg_soli soli
    INNER JOIN secgen_db.dbo.sg_prse prse
        ON prse.nro_solici = soli.nro_solici
    WHERE soli.nro_solici = @nro_solici

    DROP TABLE #tarea_actual
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen18 TO UsuaVrac
GO
