use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_prsesSecgen06')
   drop procedure Analisis2.sg_prsesSecgen06
go

/* Procedimiento : sg_prsesSecgen06

    Entrada  :
        @rut_solici         -> Rut Funcionario Solicitud

    Objetivo : select Prestación de servicios

    Creacion: CHL 2022/12/27
    Actualizacion:

*/

create procedure  Analisis2.sg_prsesSecgen06
    as
        SELECT
            prse.nro_solici,
            actividad,
            per_desde,
            per_hasta,
            rut_jefpro,
            cod_unifin,
            cod_ccto,
            cc_global,
            pry_global,
            rut_solici,
            nro_resolu,
            soli.cod_estsol,
            soli.cod_tipsol,
            f_solicit,
            f_creacion,
            f_ultmodif,
            tiposol.des_tipsol,
            estsol.des_estsol,
            SUM(funps.mto_total) AS total
        FROM
            sg_prse prse
        JOIN sg_soli soli ON	(prse.nro_solici = soli.nro_solici)
        JOIN sg_tsol tiposol ON	(soli.cod_tipsol = tiposol.cod_tipsol)
        JOIN sg_esol estsol ON	(soli.cod_estsol = estsol.cod_estsol)
        JOIN sg_fups funps ON	(soli.nro_solici = funps.nro_solici)
        GROUP BY
            prse.nro_solici,
            actividad,
            per_desde,
            per_hasta,
            rut_jefpro,
            cod_unifin,
            cod_ccto,
            cc_global,
            pry_global,
            rut_solici,
            nro_resolu,
            soli.cod_estsol,
            soli.cod_tipsol,
            f_solicit,
            f_creacion,
            f_ultmodif,
            tiposol.des_tipsol,
            estsol.des_estsol
go

grant execute on Analisis2.sg_prsesSecgen06 to UsuaVrac
go

--grant execute on Analisis2.sg_prsesSecgen06 to UsuaVrac2
--go
/*
EXECUTE secgen_db.Analisis2.sg_prsesSecgen06
 */
