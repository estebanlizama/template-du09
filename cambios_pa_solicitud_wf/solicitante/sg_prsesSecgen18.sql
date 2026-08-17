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

/* Autoriza lectura y edicion usando identidad directa o representacion vigente. */
CREATE PROCEDURE Analisis2.sg_prsesSecgen18
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL
AS
BEGIN
    DECLARE @rut_titular char(9)
    DECLARE @cod_estsol tinyint
    DECLARE @cod_modprs tinyint
    DECLARE @cod_organi int
    DECLARE @es_solicitante char(1)
    DECLARE @tarea_directa char(1)
    DECLARE @representa_solicitante char(1)
    DECLARE @tarea_representada char(1)
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

    SELECT @rut_titular = soli.rut_solici,
           @cod_estsol = soli.cod_estsol,
           @cod_modprs = prse.cod_modprs
    FROM secgen_db.dbo.sg_soli soli
    INNER JOIN secgen_db.dbo.sg_prse prse
        ON prse.nro_solici = soli.nro_solici
    WHERE soli.nro_solici = @nro_solici

    SELECT @es_solicitante = CASE WHEN @rut_titular = @rut_usua THEN 'S' ELSE 'N' END

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

    SELECT @representa_solicitante = CASE WHEN @cod_modprs = 2 AND EXISTS (
        SELECT 1
        FROM sisper_db.dbo.sp_orco orco
        INNER JOIN sisper_db.dbo.sp_orde orde
          ON orde.cod_organi = orco.cod_organi
         AND orde.rut_person = @rut_usua
         AND orde.vigente = 'S'
        INNER JOIN sisper_db.dbo.sp_desg desg
          ON desg.cod_design = orde.cod_design
         AND desg.cod_des_su = '1'
         AND desg.vigencia IN ('1', 'S')
         AND desg.f_inicio <= getdate()
         AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
        INNER JOIN ufro_db.dbo.es_orga orga
          ON orga.cod_organi = orde.cod_organi
         AND orga.por_desig = 'S'
        WHERE orco.rut_person = @rut_titular
          AND orco.vigente = 'S'
          AND (SELECT count(DISTINCT o2.rut_person)
               FROM sisper_db.dbo.sp_orco o2
               WHERE o2.cod_organi = orde.cod_organi AND o2.vigente = 'S') = 1
          AND (SELECT count(DISTINCT d2.rut_person)
               FROM sisper_db.dbo.sp_orde d2
               INNER JOIN sisper_db.dbo.sp_desg g2 ON g2.cod_design = d2.cod_design
               WHERE d2.cod_organi = orde.cod_organi
                 AND d2.vigente = 'S'
                 AND g2.cod_des_su = '1'
                 AND g2.vigencia IN ('1', 'S')
                 AND g2.f_inicio <= getdate()
                 AND (g2.f_termino IS NULL OR g2.f_termino >= getdate())) = 1
    ) THEN 'S' ELSE 'N' END

    SELECT @cod_organi = min(orde.cod_organi)
    FROM sisper_db.dbo.sp_orco orco
    INNER JOIN sisper_db.dbo.sp_orde orde
      ON orde.cod_organi = orco.cod_organi
     AND orde.rut_person = @rut_usua
     AND orde.vigente = 'S'
    INNER JOIN sisper_db.dbo.sp_desg desg
      ON desg.cod_design = orde.cod_design
     AND desg.cod_des_su = '1'
     AND desg.vigencia IN ('1', 'S')
     AND desg.f_inicio <= getdate()
     AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
    INNER JOIN ufro_db.dbo.es_orga orga
      ON orga.cod_organi = orde.cod_organi
     AND orga.por_desig = 'S'
    WHERE orco.rut_person = @rut_titular
      AND orco.vigente = 'S'

    SELECT @tarea_representada = CASE WHEN @cod_modprs = 2 AND EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_apso apso
        INNER JOIN secgen_db.dbo.sg_prse prse
          ON prse.nro_solici = apso.nro_solici
         AND prse.cod_flusol = apso.cod_flusol
         AND prse.cod_etapa = apso.cod_etapa
        INNER JOIN sisper_db.dbo.sp_orco orco
          ON orco.rut_person = apso.rut_usua AND orco.vigente = 'S'
        INNER JOIN sisper_db.dbo.sp_orde orde
          ON orde.cod_organi = orco.cod_organi
         AND orde.rut_person = @rut_usua AND orde.vigente = 'S'
        INNER JOIN sisper_db.dbo.sp_desg desg
          ON desg.cod_design = orde.cod_design
         AND desg.cod_des_su = '1'
         AND desg.vigencia IN ('1', 'S')
         AND desg.f_inicio <= getdate()
         AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
        INNER JOIN ufro_db.dbo.es_orga orga
          ON orga.cod_organi = orde.cod_organi
         AND orga.por_desig = 'S'
        WHERE apso.nro_solici = @nro_solici
          AND apso.cod_estapr = 4
          AND (SELECT count(DISTINCT o2.rut_person)
               FROM sisper_db.dbo.sp_orco o2
               WHERE o2.cod_organi = orde.cod_organi AND o2.vigente = 'S') = 1
          AND (SELECT count(DISTINCT d2.rut_person)
               FROM sisper_db.dbo.sp_orde d2
               INNER JOIN sisper_db.dbo.sp_desg g2 ON g2.cod_design = d2.cod_design
               WHERE d2.cod_organi = orde.cod_organi
                 AND d2.vigente = 'S'
                 AND g2.cod_des_su = '1'
                 AND g2.vigencia IN ('1', 'S')
                 AND g2.f_inicio <= getdate()
                 AND (g2.f_termino IS NULL OR g2.f_termino >= getdate())) = 1
    ) THEN 'S' ELSE 'N' END

    SELECT @participo = CASE WHEN EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_apso apso
        WHERE apso.nro_solici = @nro_solici
          AND (apso.rut_usua = @rut_usua OR apso.rut_autori = @rut_usua)
    ) OR EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_hist hist
        WHERE hist.nro_solici = @nro_solici AND hist.rut_accion = @rut_usua
    ) THEN 'S' ELSE 'N' END

    SELECT
        @nro_solici AS nro_solici,
        @cod_estsol AS cod_estsol,
        @rut_titular AS rut_titular,
        CASE WHEN @representa_solicitante = 'S' OR @tarea_representada = 'S'
             THEN @cod_organi ELSE convert(int, NULL) END AS cod_organi_representado,
        @es_solicitante AS es_solicitante,
        CASE WHEN @representa_solicitante = 'S' OR @tarea_representada = 'S'
             THEN 'S' ELSE 'N' END AS es_representante,
        CASE WHEN @tarea_directa = 'S' OR @tarea_representada = 'S'
             THEN 'S' ELSE 'N' END AS tiene_tarea_pendiente,
        @participo AS participo_flujo,
        CASE WHEN @es_solicitante = 'S' OR @tarea_directa = 'S'
                       OR @representa_solicitante = 'S' OR @tarea_representada = 'S'
                       OR @participo = 'S' THEN 'S' ELSE 'N' END AS puede_ver,
        CASE WHEN @cod_estsol IN (5, 6)
                       AND (@es_solicitante = 'S' OR @representa_solicitante = 'S')
             THEN 'S' ELSE 'N' END AS puede_editar,
        CASE WHEN @es_solicitante = 'S' THEN 'PROPIA'
             WHEN @representa_solicitante = 'S' OR @tarea_representada = 'S' THEN 'REPRESENTACION'
             WHEN @tarea_directa = 'S' THEN 'ASIGNACION_DIRECTA'
             WHEN @participo = 'S' THEN 'PARTICIPACION'
             ELSE 'SIN_ACCESO' END AS tipo_acceso
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen18 TO UsuaVrac
GO
