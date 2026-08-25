USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen13'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen13
GO

/*
    Entrada  :
    
    Salida   :

    Objetivo : Obtener las solicitudes de prestacion de servicios asignadas o pendientes para un usuario
    Creacion : ELA 2026/08/24
    Modificacion :
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

    SELECT apso.nro_aproba, apso.id_funprse, apso.rut_usua, apso.rut_autori,
        fun_tarea.rut rut_funcionario,
        ltrim(rtrim(isnull(pers_fun.nom_nombre, '') + ' ' +
                    isnull(pers_fun.nom_appate, '') + ' ' +
                    isnull(pers_fun.nom_apmate, ''))) nombre_funcionario,
        apso.cod_flusol, apso.cod_etapa, eta.cod_perfil, eta.des_etapa,
        apso.cod_estapr,
        convert(varchar(255), apso.comentario) comentario_asignacion,
        CASE WHEN substring(convert(varchar(255), apso.comentario), 1, 13) = '[SUBROGANCIA]'
             THEN 'SUBROGANCIA' ELSE 'ASIGNACION_DIRECTA' END tipo_acceso,
        'PERSONAL' context_key, convert(char(9), NULL) rut_titular,
        convert(int, NULL) cod_organi_representado,
        convert(varchar(100), NULL) cargo_representado,
        convert(varchar(40), NULL) tipo_representacion,
        prse.nro_solici, prse.actividad, prse.per_desde, prse.per_hasta,
        prse.rut_jefpro, prse.cod_unifin, prse.cod_ccto,
        prse.cc_global, prse.pry_global, prse.cod_modprs,
        soli.rut_solici, soli.nro_resolu, soli.cod_estsol, soli.cod_tipsol,
        soli.f_solicit, soli.f_creacion, soli.f_ultmodif,
        tiposol.des_tipsol, estsol.des_estsol,
        isnull(funps_total.total, 0) total,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' +
                    isnull(pers.nom_appate, '') + ' ' +
                    isnull(pers.nom_apmate, ''))) nombre
    FROM secgen_db.dbo.sg_apso apso
    INNER JOIN secgen_db.dbo.sg_prse prse
      ON prse.nro_solici = apso.nro_solici
     AND prse.cod_flusol = apso.cod_flusol
     AND prse.cod_etapa = apso.cod_etapa
    INNER JOIN secgen_db.dbo.sg_soli soli ON soli.nro_solici = prse.nro_solici
    INNER JOIN secgen_db.dbo.sg_eta1 eta
      ON eta.cod_flusol = apso.cod_flusol AND eta.cod_etapa = apso.cod_etapa
    INNER JOIN secgen_db.dbo.sg_tsol tiposol ON tiposol.cod_tipsol = soli.cod_tipsol
    INNER JOIN secgen_db.dbo.sg_esol estsol ON estsol.cod_estsol = soli.cod_estsol
    LEFT JOIN sisper_db..sp_pers pers ON pers.rut_person = soli.rut_solici
    LEFT JOIN secgen_db.dbo.sg_fups fun_tarea
      ON fun_tarea.id_funprse = apso.id_funprse
     AND fun_tarea.nro_solici = apso.nro_solici
    LEFT JOIN sisper_db..sp_pers pers_fun ON pers_fun.rut_person = fun_tarea.rut
    LEFT JOIN (
        SELECT nro_solici, sum(mto_total) total
        FROM secgen_db.dbo.sg_fups GROUP BY nro_solici
    ) funps_total ON funps_total.nro_solici = soli.nro_solici
    WHERE apso.cod_estapr = 4
      AND apso.rut_usua = @rut_solici
      AND isnull(eta.vigente, 'S') = 'S'
      AND soli.cod_estsol != 7
    ORDER BY soli.nro_solici DESC, apso.nro_aproba
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen13 TO UsuaVrac
GO
