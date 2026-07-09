USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
      WHERE a.uid  = b.uid
        AND a.type = 'P'
        AND b.name = 'Analisis2'
        AND a.name = 'sg_prsesSecgen14')
   DROP PROCEDURE Analisis2.sg_prsesSecgen14
GO

/* Procedimiento : Analisis2.sg_prsesSecgen14
    Entrada      : @rut_solici --> rut del firmante/solicitante
    Objetivo     : Seleccionar las solicitudes pendientes de firma en prestación de servicios con su modalidad y nombre del solicitante
*/

CREATE PROCEDURE Analisis2.sg_prsesSecgen14
    @rut_solici varchar(9) = null
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
        ISNULL(SUM(funps.mto_total), 0) AS total,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' + isnull(pers.nom_appate, '') + ' ' + isnull(pers.nom_apmate, ''))) AS nombre
    FROM secgen_db.dbo.sg_prse prse
    JOIN secgen_db.dbo.sg_soli soli
        ON (prse.nro_solici = soli.nro_solici)
    JOIN secgen_db.dbo.sg_tsol tiposol
        ON (soli.cod_tipsol = tiposol.cod_tipsol)
    JOIN secgen_db.dbo.sg_esol estsol
        ON (soli.cod_estsol = estsol.cod_estsol) AND (soli.cod_estsol IN (1,2,3,5,7))
    LEFT JOIN secgen_db.dbo.sg_fups funps
        ON (soli.nro_solici = funps.nro_solici)
    JOIN (
        SELECT
            ano_resolu,
            nro_resolu,
            rut_aprob
        FROM secgen_db.dbo.sg_apre
        WHERE cod_estapr IN (4,6)
        GROUP BY ano_resolu, nro_resolu, rut_aprob
    ) apre
        ON (soli.ano_resolu = apre.ano_resolu AND soli.nro_resolu = apre.nro_resolu AND apre.rut_aprob = @rut_solici)
    LEFT JOIN sisper_db.dbo.sp_pers pers
        ON (soli.rut_solici = pers.rut_person)
    WHERE apre.rut_aprob = @rut_solici
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

GRANT EXECUTE ON Analisis2.sg_prsesSecgen14 TO UsuaVrac
GO
