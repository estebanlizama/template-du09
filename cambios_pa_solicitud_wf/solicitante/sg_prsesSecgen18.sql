use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
           where a.uid  = b.uid
             and a.type = 'P'
             and b.name = 'Analisis2'
             and a.name = 'sg_prsesSecgen18')
    drop procedure Analisis2.sg_prsesSecgen18
go

/* Procedimiento : sg_prsesSecgen18

    Entrada  :
        @rut_jefpro varchar(9)

    Objetivo : Seleccionar las solicitudes en etapa de Jefe de Proyecto pendientes de aprobación para su RUT

    Creacion: AI 2026/06/30
    Actualizacion:

*/

create procedure Analisis2.sg_prsesSecgen18
    @rut_jefpro varchar(9) = NULL
as
begin
    if @rut_jefpro is null
    begin
        select 'Falta Rut de Jefe de Proyecto' msg
        return
    end

    SELECT prse.nro_solici, prse.actividad, prse.per_desde,
           prse.per_hasta, prse.rut_jefpro, prse.cod_unifin, prse.cod_ccto,
           prse.cc_global, prse.pry_global, prse.cod_modprs, soli.rut_solici, soli.nro_resolu, soli.cod_estsol,
           soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol, SUM(funps.mto_total) as total,
           (pers.nom_nombre + ' ' + pers.nom_appate + ' ' + pers.nom_apmate) as nombre
    FROM secgen_db.dbo.sg_prse prse
         JOIN secgen_db.dbo.sg_soli soli ON (prse.nro_solici = soli.nro_solici)
         JOIN secgen_db.dbo.sg_tsol tiposol ON (soli.cod_tipsol = tiposol.cod_tipsol)
         JOIN secgen_db.dbo.sg_esol estsol ON (soli.cod_estsol = estsol.cod_estsol)
         JOIN secgen_db.dbo.sg_apso apso ON (soli.nro_solici = apso.nro_solici)
         LEFT JOIN sisper_db..sp_pers as pers ON (soli.rut_solici = pers.rut_person)
         JOIN secgen_db.dbo.sg_fups funps ON (soli.nro_solici = funps.nro_solici)
    WHERE soli.cod_estsol != 7
      AND apso.cod_estapr = 4
      -- TODO: DU288_PROD_RUT_JEFPRO: Habilitar el filtro de rut_jefpro para produccion
      -- AND prse.rut_jefpro = @rut_jefpro
      AND apso.rut_usua = @rut_jefpro
    GROUP BY prse.nro_solici, prse.actividad, prse.per_desde, prse.per_hasta, prse.rut_jefpro, prse.cod_unifin, prse.cod_ccto, prse.cc_global, prse.pry_global, prse.cod_modprs,
             soli.rut_solici, soli.nro_resolu, soli.cod_estsol,
             soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol, pers.rut_person, pers.nom_nombre, pers.nom_appate, pers.nom_apmate
    ORDER BY soli.nro_solici DESC
end
go

grant execute on Analisis2.sg_prsesSecgen18 to UsuaVrac
go
