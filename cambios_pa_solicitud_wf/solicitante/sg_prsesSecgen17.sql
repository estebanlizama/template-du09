use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_prsesSecgen17')
   drop procedure Analisis2.sg_prsesSecgen17
go

/* Procedimiento : sg_prsesSecgen17

    Entrada  :

    Objetivo : Seleccionar lista de solicitudes historicas en prestación de servicios.
               Incluye la columna prse.cod_modprs para permitir la correcta clasificación por flujo en el frontend.

    Creacion: AI 2023/05/11
    Actualizacion: UFRO 2026
*/

create procedure  Analisis2.sg_prsesSecgen17
    as
       SELECT soli.nro_solici, prse.cc_global, prse.pry_global, soli.f_solicit, soli.f_ultmodif,
            tiposol.des_tipsol, estsol.des_estsol, SUM(funps.mto_total) as total, soli.nro_resolu, prse.cod_modprs,
            ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' + isnull(pers.nom_appate, '') + ' ' + isnull(pers.nom_apmate, ''))) as nombre
        FROM secgen_db.dbo.sg_prse prse
        JOIN secgen_db.dbo.sg_soli soli
            ON (prse.nro_solici = soli.nro_solici)
        JOIN secgen_db.dbo.sg_tsol tiposol
            ON (soli.cod_tipsol = tiposol.cod_tipsol)
        JOIN secgen_db.dbo.sg_esol estsol
            ON (soli.cod_estsol = estsol.cod_estsol) AND (soli.cod_estsol IN (4, 8, 9, 11) AND (soli.cod_tipsol = 1))
        JOIN secgen_db.dbo.sg_fups funps
            ON (soli.nro_solici = funps.nro_solici)
        LEFT JOIN sisper_db..sp_pers pers
            ON (pers.rut_person = soli.rut_solici)
        GROUP BY soli.nro_solici, prse.actividad, prse.per_desde, prse.per_hasta, prse.rut_jefpro, prse.cod_unifin,
            prse.cod_ccto, prse.cc_global, prse.pry_global, prse.cod_modprs, soli.rut_solici, soli.nro_resolu, soli.cod_estsol,
            soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol, soli.cod_tipsol, pers.rut_person
        ORDER BY soli.f_creacion DESC
go
grant execute on Analisis2.sg_prsesSecgen17 to UsuaVrac
go

/*
execute secgen_db.Analisis2.sg_prsesSecgen17
 */
