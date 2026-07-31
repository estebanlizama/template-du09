USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen13')
    DROP PROCEDURE Analisis2.sg_prsesSecgen13
GO

/*
Procedimiento : Analisis2.sg_prsesSecgen13
Objetivo      : Listar tareas PDS pendientes asignadas al RUT autenticado.
                Cada fila representa una tarea concreta de sg_apso.
*/

CREATE PROCEDURE Analisis2.sg_prsesSecgen13
    @rut_solici varchar(9) = NULL
AS
BEGIN
    IF @rut_solici IS NULL
    BEGIN
        SELECT 'Falta Rut de Usuario' AS msg
        RETURN
    END

    SELECT
        apso.nro_aproba,
        apso.id_funprse,
        apso.cod_flusol,
        apso.cod_etapa,
        eta.cod_perfil,
        eta.des_etapa,
        apso.cod_estapr,
        'TAREA' AS tipo_acceso,
        prse.nro_solici,
        prse.actividad,
        prse.per_desde,
        prse.per_hasta,
        prse.rut_jefpro,
        prse.cod_unifin,
        prse.cod_ccto,
        prse.cc_global,
        prse.pry_global,
        prse.cod_modprs,
        soli.rut_solici,
        soli.nro_resolu,
        soli.cod_estsol,
        soli.cod_tipsol,
        soli.f_solicit,
        soli.f_creacion,
        soli.f_ultmodif,
        tiposol.des_tipsol,
        estsol.des_estsol,
        isnull(funps_total.total, 0) AS total,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' +
                    isnull(pers.nom_appate, '') + ' ' +
                    isnull(pers.nom_apmate, ''))) AS nombre
    FROM secgen_db.dbo.sg_apso apso
    INNER JOIN secgen_db.dbo.sg_prse prse
        ON prse.nro_solici = apso.nro_solici
    INNER JOIN secgen_db.dbo.sg_soli soli
        ON soli.nro_solici = prse.nro_solici
    INNER JOIN secgen_db.dbo.sg_eta1 eta
        ON eta.cod_flusol = apso.cod_flusol
       AND eta.cod_etapa = apso.cod_etapa
    INNER JOIN secgen_db.dbo.sg_tsol tiposol
        ON tiposol.cod_tipsol = soli.cod_tipsol
    INNER JOIN secgen_db.dbo.sg_esol estsol
        ON estsol.cod_estsol = soli.cod_estsol
    LEFT JOIN sisper_db..sp_pers pers
        ON pers.rut_person = soli.rut_solici
    LEFT JOIN (
        SELECT nro_solici, sum(mto_total) AS total
        FROM secgen_db.dbo.sg_fups
        GROUP BY nro_solici
    ) funps_total
        ON funps_total.nro_solici = soli.nro_solici
    WHERE apso.rut_usua = @rut_solici
      AND apso.cod_estapr = 4
      AND isnull(eta.vigente, 'S') = 'S'
      AND soli.cod_estsol != 7
    ORDER BY soli.nro_solici DESC, apso.nro_aproba
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen13 TO UsuaVrac
GO
