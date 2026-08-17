USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_prsesSecgen08'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen08
GO

/*
Procedimiento : Analisis2.sg_prsesSecgen08
Objetivo      : Listar solicitudes PDS activas propias y aquellas cuyo
                solicitante es representado actualmente por el RUT autenticado.
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen08
    @rut_solici varchar(9) = NULL
AS
BEGIN
    IF @rut_solici IS NULL
    BEGIN
        SELECT 'Falta campo Rut Solicitud' AS msg
        RETURN
    END

    /*
    ASE limita la cantidad de tablas que puede optimizar en una consulta.
    Se materializan primero las representaciones univocas y vigentes para que
    el listado principal no repita las validaciones de ORCO/ORDE/DESG.
    */
    CREATE TABLE #titulares_activos (
        cod_organi int NOT NULL,
        cantidad int NOT NULL
    )

    INSERT INTO #titulares_activos (cod_organi, cantidad)
    SELECT cod_organi, count(DISTINCT rut_person)
    FROM sisper_db.dbo.sp_orco
    WHERE vigente = 'S'
    GROUP BY cod_organi

    CREATE TABLE #designados_vigentes (
        cod_organi int NOT NULL,
        cantidad int NOT NULL
    )

    INSERT INTO #designados_vigentes (cod_organi, cantidad)
    SELECT orde.cod_organi, count(DISTINCT orde.rut_person)
    FROM sisper_db.dbo.sp_orde orde
    INNER JOIN sisper_db.dbo.sp_desg desg
        ON desg.cod_design = orde.cod_design
       AND desg.cod_des_su = '1'
       AND desg.vigencia IN ('1', 'S')
       AND desg.f_inicio <= getdate()
       AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
    WHERE orde.vigente = 'S'
    GROUP BY orde.cod_organi

    CREATE TABLE #representaciones (
        rut_actor char(9) NOT NULL,
        rut_titular char(9) NOT NULL,
        cod_organi int NOT NULL,
        cargo varchar(100) NULL
    )

    INSERT INTO #representaciones (rut_actor, rut_titular, cod_organi, cargo)
    SELECT DISTINCT
        orde.rut_person,
        orco.rut_person,
        orde.cod_organi,
        rtrim(orga.des_organi)
    FROM sisper_db.dbo.sp_orde orde
    INNER JOIN sisper_db.dbo.sp_desg desg
        ON desg.cod_design = orde.cod_design
       AND desg.cod_des_su = '1'
       AND desg.vigencia IN ('1', 'S')
       AND desg.f_inicio <= getdate()
       AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
    INNER JOIN sisper_db.dbo.sp_orco orco
        ON orco.cod_organi = orde.cod_organi
       AND orco.vigente = 'S'
    INNER JOIN ufro_db.dbo.es_orga orga
        ON orga.cod_organi = orde.cod_organi
       AND orga.por_desig = 'S'
    INNER JOIN #titulares_activos titulares
        ON titulares.cod_organi = orde.cod_organi
       AND titulares.cantidad = 1
    INNER JOIN #designados_vigentes designados
        ON designados.cod_organi = orde.cod_organi
       AND designados.cantidad = 1
    WHERE orde.rut_person = @rut_solici
      AND orde.vigente = 'S'
      AND orco.rut_person <> @rut_solici

    SELECT
        soli.nro_solici,
        soli.cod_tipsol,
        soli.cod_estsol,
        prse.cod_modprs,
        prse.cod_flusol,
        prse.cod_etapa,
        eta.des_etapa,
        prse.cc_global,
        prse.pry_global,
        soli.rut_solici,
        soli.f_solicit,
        soli.f_creacion,
        soli.f_ultmodif,
        tiposol.des_tipsol,
        estsol.des_estsol,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' +
                    isnull(pers.nom_appate, '') + ' ' +
                    isnull(pers.nom_apmate, ''))) AS nombre,
        isnull(funps_total.total, 0) AS total,
        'PROPIA' AS tipo_acceso,
        'PERSONAL' AS context_key,
        convert(char(9), NULL) AS rut_titular,
        convert(int, NULL) AS cod_organi_representado,
        convert(varchar(100), NULL) AS cargo_representado,
        convert(varchar(40), NULL) AS tipo_representacion
    FROM secgen_db.dbo.sg_prse prse
    INNER JOIN secgen_db.dbo.sg_soli soli
        ON prse.nro_solici = soli.nro_solici
    INNER JOIN secgen_db.dbo.sg_tsol tiposol
        ON soli.cod_tipsol = tiposol.cod_tipsol
    INNER JOIN secgen_db.dbo.sg_esol estsol
        ON soli.cod_estsol = estsol.cod_estsol
    LEFT JOIN secgen_db.dbo.sg_eta1 eta
        ON eta.cod_flusol = prse.cod_flusol
       AND eta.cod_etapa = prse.cod_etapa
    LEFT JOIN sisper_db..sp_pers pers
        ON pers.rut_person = soli.rut_solici
    LEFT JOIN (
        SELECT nro_solici, sum(mto_total) AS total
        FROM secgen_db.dbo.sg_fups
        GROUP BY nro_solici
    ) funps_total
        ON funps_total.nro_solici = soli.nro_solici
    WHERE soli.rut_solici = @rut_solici
      AND soli.cod_tipsol = 1
      AND soli.cod_estsol IN (1, 2, 3, 5, 6, 7, 10)
    UNION ALL

    SELECT DISTINCT
        soli.nro_solici,
        soli.cod_tipsol,
        soli.cod_estsol,
        prse.cod_modprs,
        prse.cod_flusol,
        prse.cod_etapa,
        eta.des_etapa,
        prse.cc_global,
        prse.pry_global,
        soli.rut_solici,
        soli.f_solicit,
        soli.f_creacion,
        soli.f_ultmodif,
        tiposol.des_tipsol,
        estsol.des_estsol,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' +
                    isnull(pers.nom_appate, '') + ' ' +
                    isnull(pers.nom_apmate, ''))) AS nombre,
        isnull(funps_total.total, 0) AS total,
        'REPRESENTACION' AS tipo_acceso,
        'REP:' + convert(varchar(10), rep.cod_organi) + ':' + rtrim(soli.rut_solici) AS context_key,
        soli.rut_solici AS rut_titular,
        rep.cod_organi AS cod_organi_representado,
        rep.cargo AS cargo_representado,
        'SUBROGANCIA' AS tipo_representacion
    FROM secgen_db.dbo.sg_prse prse
    INNER JOIN secgen_db.dbo.sg_soli soli
        ON prse.nro_solici = soli.nro_solici
    INNER JOIN secgen_db.dbo.sg_tsol tiposol
        ON soli.cod_tipsol = tiposol.cod_tipsol
    INNER JOIN secgen_db.dbo.sg_esol estsol
        ON soli.cod_estsol = estsol.cod_estsol
    LEFT JOIN secgen_db.dbo.sg_eta1 eta
        ON eta.cod_flusol = prse.cod_flusol
       AND eta.cod_etapa = prse.cod_etapa
    LEFT JOIN sisper_db.dbo.sp_pers pers
        ON pers.rut_person = soli.rut_solici
    LEFT JOIN (
        SELECT nro_solici, sum(mto_total) AS total
        FROM secgen_db.dbo.sg_fups
        GROUP BY nro_solici
    ) funps_total
        ON funps_total.nro_solici = soli.nro_solici
    INNER JOIN #representaciones rep
        ON rep.rut_titular = soli.rut_solici
       AND rep.rut_actor = @rut_solici
    WHERE soli.rut_solici <> @rut_solici
      AND soli.cod_tipsol = 1
      AND prse.cod_modprs = 2
      AND soli.cod_estsol IN (1, 2, 3, 5, 6, 7, 10)

    ORDER BY f_creacion DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen08 TO UsuaVrac
GO
