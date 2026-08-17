USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_apsosSecgen03'
)
    DROP PROCEDURE Analisis2.sg_apsosSecgen03
GO

/*
Procedimiento : Analisis2.sg_apsosSecgen03
Objetivo      : Obtener la tarea pendiente del usuario autenticado junto con
                el flujo, etapa y perfil que autorizan la accion.

sg_apso.rut_usua conserva al destinatario original. El PA autoriza tambien al
representante vigente, sin reasignar ni duplicar la tarea.
*/
CREATE PROCEDURE Analisis2.sg_apsosSecgen03
    @nro_solici int = NULL,
    @cod_estapr int = NULL,
    @rut_usua varchar(9) = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo numero de solicitud' AS msg
        RETURN
    END

    IF @cod_estapr IS NULL
    BEGIN
        SELECT 'Falta campo codigo de estado de aprobacion' AS msg
        RETURN
    END

    IF @rut_usua IS NULL
    BEGIN
        SELECT 'Falta campo rut de usuario' AS msg
        RETURN
    END

    CREATE TABLE #titulares_activos (
        cod_organi int not null,
        cantidad int not null
    )

    INSERT INTO #titulares_activos (cod_organi, cantidad)
    SELECT cod_organi, count(DISTINCT rut_person)
    FROM sisper_db.dbo.sp_orco
    WHERE vigente = 'S'
    GROUP BY cod_organi

    CREATE TABLE #designados_vigentes (
        cod_organi int not null,
        cantidad int not null
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

    SELECT DISTINCT
        apso.nro_aproba,
        apso.nro_solici,
        apso.rut_usua,
        apso.cod_estapr,
        convert(varchar(255), apso.comentario) AS comentario,
        apso.f_aprobac,
        apso.f_creacion,
        apso.f_ultmodif,
        apso.cod_flusol,
        apso.cod_etapa,
        apso.rut_autori,
        apso.id_funprse,
        eta.cod_perfil,
        eta.des_etapa,
        @rut_usua AS rut_actor,
        CASE WHEN apso.rut_usua = @rut_usua
             THEN 'ASIGNACION_DIRECTA' ELSE 'REPRESENTACION' END AS tipo_acceso,
        CASE WHEN apso.rut_usua = @rut_usua
             THEN convert(char(9), NULL) ELSE apso.rut_usua END AS rut_titular,
        CASE WHEN apso.rut_usua = @rut_usua THEN convert(varchar(255), NULL)
             ELSE ltrim(rtrim(isnull(titular.nom_nombre, '') + ' ' +
                              isnull(titular.nom_appate, '') + ' ' +
                              isnull(titular.nom_apmate, ''))) END AS nombre_titular,
        CASE WHEN apso.rut_usua = @rut_usua
             THEN convert(int, NULL) ELSE orde.cod_organi END AS cod_organi_representado,
        CASE WHEN apso.rut_usua = @rut_usua
             THEN convert(varchar(100), NULL) ELSE rtrim(orga.des_organi) END AS cargo_representado
    FROM secgen_db.dbo.sg_apso apso
    INNER JOIN secgen_db.dbo.sg_prse prse
      ON prse.nro_solici = apso.nro_solici
     AND prse.cod_flusol = apso.cod_flusol
     AND prse.cod_etapa = apso.cod_etapa
    INNER JOIN secgen_db.dbo.sg_eta1 eta
      ON eta.cod_flusol = apso.cod_flusol
     AND eta.cod_etapa = apso.cod_etapa
    LEFT JOIN sisper_db.dbo.sp_orco orco
      ON orco.rut_person = apso.rut_usua
     AND orco.vigente = 'S'
    LEFT JOIN #titulares_activos titulares
      ON titulares.cod_organi = orco.cod_organi
    LEFT JOIN sisper_db.dbo.sp_pers titular
      ON titular.rut_person = apso.rut_usua
    LEFT JOIN sisper_db.dbo.sp_orde orde
      ON orde.cod_organi = orco.cod_organi
     AND orde.rut_person = @rut_usua
     AND orde.vigente = 'S'
    LEFT JOIN #designados_vigentes designados
      ON designados.cod_organi = orde.cod_organi
    LEFT JOIN sisper_db.dbo.sp_desg desg
      ON desg.cod_design = orde.cod_design
     AND desg.cod_des_su = '1'
     AND desg.vigencia IN ('1', 'S')
     AND desg.f_inicio <= getdate()
     AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
    LEFT JOIN ufro_db.dbo.es_orga orga
      ON orga.cod_organi = orde.cod_organi
    WHERE apso.cod_estapr = @cod_estapr
      AND apso.nro_solici = @nro_solici
      AND (
          apso.rut_usua = @rut_usua
          OR (
              prse.cod_modprs = 2
              AND
              orde.rut_person = @rut_usua
              AND orga.por_desig = 'S'
              AND titulares.cantidad = 1
              AND designados.cantidad = 1
          )
      )
      AND isnull(eta.vigente, 'S') = 'S'
    ORDER BY apso.nro_aproba DESC

    DROP TABLE #designados_vigentes
    DROP TABLE #titulares_activos
END
GO

GRANT EXECUTE ON Analisis2.sg_apsosSecgen03 TO UsuaVrac
GO
