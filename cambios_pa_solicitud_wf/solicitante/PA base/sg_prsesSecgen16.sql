USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen16'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen16
GO

/* Procedimiento : Analisis2.sg_prsesSecgen16

   Objetivo : Seleccionar las solicitudes listas para marcar como ingresada en prestacion de servicios.

   Creacion: AI 2023/05/11
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen16
    as
               SELECT soli.nro_solici, prse.actividad, prse.per_desde, prse.per_hasta, prse.rut_jefpro, prse.cod_unifin,
        prse.cod_ccto, prse.cc_global, prse.pry_global, soli.rut_solici, rslc.nro_resolu, soli.cod_estsol,
        soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol
    FROM secgen_db.dbo.sg_prse prse
    JOIN secgen_db.dbo.sg_soli soli
        ON (prse.nro_solici = soli.nro_solici)
    JOIN secgen_db.dbo.sg_tsol tiposol
        ON (soli.cod_tipsol = tiposol.cod_tipsol)
    JOIN secgen_db.dbo.sg_esol estsol
        ON (soli.cod_estsol = estsol.cod_estsol) AND (soli.cod_estsol = 8)
    JOIN secgen_db.dbo.sg_fups funps
        ON (soli.nro_solici = funps.nro_solici)
    JOIN secgen_db.dbo.sg_rslc rslc
        ON (soli.ano_resolu = rslc.ano_resolu AND soli.nro_resolu = rslc.nro_resolu AND rslc.cod_estres = 3)
    GROUP BY soli.nro_solici, prse.actividad, prse.per_desde, prse.per_hasta, prse.rut_jefpro, prse.cod_unifin,
        prse.cod_ccto, prse.cc_global, prse.pry_global, soli.rut_solici, rslc.nro_resolu, soli.cod_estsol,
        soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol
    ORDER BY soli.f_creacion DESC
go
GRANT EXECUTE ON Analisis2.sg_prsesSecgen16 TO UsuaVrac
go
