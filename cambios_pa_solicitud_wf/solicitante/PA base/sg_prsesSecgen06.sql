USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen06'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen06
GO

/* Procedimiento : Analisis2.sg_prsesSecgen06

   Objetivo : Listar prestaciones de servicios vigentes para administracion.

   Creacion: CHL 2022/12/27
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen06
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

GRANT EXECUTE ON Analisis2.sg_prsesSecgen06 TO UsuaVrac
go

--grant execute on Analisis2.sg_prsesSecgen06 to UsuaVrac2
--go
