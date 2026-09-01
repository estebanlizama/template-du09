use secgen_db
go

if exists (select 1
             from sysobjects a, sysusers b
            where a.uid = b.uid
              and a.type = 'P'
              and b.name = 'Analisis2'
              and a.name = 'sg_prsesSecgen16')
begin
    drop procedure Analisis2.sg_prsesSecgen16
end
go

/* Procedimiento : sg_prsesSecgen16

   Objetivo : Seleccionar las solicitudes listas para marcar como ingresada en prestación de servicios

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/

create procedure Analisis2.sg_prsesSecgen16
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

grant execute on Analisis2.sg_prsesSecgen16 to UsuaVrac
go
