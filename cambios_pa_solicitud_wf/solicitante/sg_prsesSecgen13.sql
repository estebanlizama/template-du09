USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_prsesSecgen13'
)
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

    /* Materializa la subrogancia para mantener cada consulta bajo el limite
       de 14 tablas del optimizador de ASE. */
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

    SELECT DISTINCT
        apso.nro_aproba,
        apso.id_funprse,
        apso.rut_usua,
        apso.rut_autori,
        fun_tarea.rut AS rut_funcionario,
        ltrim(rtrim(isnull(pers_fun.nom_nombre, '') + ' ' +
                    isnull(pers_fun.nom_appate, '') + ' ' +
                    isnull(pers_fun.nom_apmate, ''))) AS nombre_funcionario,
        apso.cod_flusol,
        apso.cod_etapa,
        eta.cod_perfil,
        eta.des_etapa,
        apso.cod_estapr,
        CASE WHEN apso.rut_usua = @rut_solici
             THEN 'ASIGNACION_DIRECTA' ELSE 'REPRESENTACION' END AS tipo_acceso,
        CASE WHEN apso.rut_usua = @rut_solici
             THEN 'PERSONAL'
             ELSE 'REP:' + convert(varchar(10), rep.cod_organi) + ':' + rtrim(apso.rut_usua)
        END AS context_key,
        CASE WHEN apso.rut_usua = @rut_solici
             THEN convert(char(9), NULL) ELSE apso.rut_usua END AS rut_titular,
        CASE WHEN apso.rut_usua = @rut_solici
             THEN convert(int, NULL) ELSE rep.cod_organi END AS cod_organi_representado,
        CASE WHEN apso.rut_usua = @rut_solici
             THEN convert(varchar(100), NULL) ELSE rep.cargo END AS cargo_representado,
        CASE WHEN apso.rut_usua = @rut_solici THEN convert(varchar(40), NULL)
             ELSE 'SUBROGANCIA' END AS tipo_representacion,
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
       AND prse.cod_flusol = apso.cod_flusol
       AND prse.cod_etapa = apso.cod_etapa
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
    LEFT JOIN secgen_db.dbo.sg_fups fun_tarea
        ON fun_tarea.id_funprse = apso.id_funprse
       AND fun_tarea.nro_solici = apso.nro_solici
    LEFT JOIN sisper_db..sp_pers pers_fun
        ON pers_fun.rut_person = fun_tarea.rut
    LEFT JOIN #representaciones rep
        ON rep.rut_titular = apso.rut_usua
       AND rep.rut_actor = @rut_solici
    LEFT JOIN (
        SELECT nro_solici, sum(mto_total) AS total
        FROM secgen_db.dbo.sg_fups
        GROUP BY nro_solici
    ) funps_total
        ON funps_total.nro_solici = soli.nro_solici
    WHERE apso.cod_estapr = 4
      AND (
          apso.rut_usua = @rut_solici
          OR (
              prse.cod_modprs = 2
              AND
              rep.rut_actor = @rut_solici
          )
      )
      AND isnull(eta.vigente, 'S') = 'S'
      AND soli.cod_estsol != 7
    ORDER BY soli.nro_solici DESC, apso.nro_aproba
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen13 TO UsuaVrac
GO
