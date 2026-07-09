USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
      WHERE a.uid  = b.uid
        AND a.type = 'P'
        AND b.name = 'Analisis2'
        AND a.name = 'sg_prsesSecgen15')
   DROP PROCEDURE Analisis2.sg_prsesSecgen15
GO

/* Procedimiento : Analisis2.sg_prsesSecgen15
    Entrada      :
    Objetivo     : Seleccionar las solicitudes pendientes para ser archivadas en prestación de servicios con modalidad y nombre del solicitante
*/

CREATE PROCEDURE Analisis2.sg_prsesSecgen15
AS
BEGIN
    SELECT 
        soli.nro_solici, 
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
        apre.nro_resolu, 
        soli.cod_estsol,
        soli.cod_tipsol, 
        soli.f_solicit, 
        soli.f_creacion, 
        soli.f_ultmodif, 
        tiposol.des_tipsol, 
        estsol.des_estsol,
        SUM(funps.mto_total) AS total,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' + isnull(pers.nom_appate, '') + ' ' + isnull(pers.nom_apmate, ''))) AS nombre
    FROM secgen_db.dbo.sg_prse prse
    JOIN secgen_db.dbo.sg_soli soli
        ON (prse.nro_solici = soli.nro_solici)
    JOIN secgen_db.dbo.sg_tsol tiposol
        ON (soli.cod_tipsol = tiposol.cod_tipsol)
    JOIN secgen_db.dbo.sg_esol estsol
        ON (soli.cod_estsol = estsol.cod_estsol) AND (soli.cod_estsol = 8)
    JOIN secgen_db.dbo.sg_fups funps
        ON (soli.nro_solici = funps.nro_solici)
    JOIN secgen_db.dbo.sg_apre apre
        ON (soli.ano_resolu = apre.ano_resolu AND soli.nro_resolu = apre.nro_resolu)
    JOIN secgen_db.dbo.sg_rslc rslc
        ON (soli.ano_resolu = rslc.ano_resolu AND soli.nro_resolu = rslc.nro_resolu) AND (rslc.cod_estres IN (1, 9))
    LEFT JOIN sisper_db.dbo.sp_pers pers
        ON (soli.rut_solici = pers.rut_person)
    GROUP BY 
        soli.nro_solici, 
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
        apre.nro_resolu, 
        soli.cod_estsol,
        soli.cod_tipsol, 
        soli.f_solicit, 
        soli.f_creacion, 
        soli.f_ultmodif, 
        tiposol.des_tipsol, 
        estsol.des_estsol,
        pers.nom_nombre,
        pers.nom_appate,
        pers.nom_apmate
    ORDER BY soli.nro_solici DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen15 TO UsuaVrac
GO
