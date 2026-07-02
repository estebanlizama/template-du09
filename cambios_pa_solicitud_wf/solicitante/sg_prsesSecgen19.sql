use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
           where a.uid  = b.uid
             and a.type = 'P'
             and b.name = 'Analisis2'
             and a.name = 'sg_prsesSecgen19')
    drop procedure Analisis2.sg_prsesSecgen19
go

/* Procedimiento : sg_prsesSecgen19

    Entrada  :
        @rut_jefdep varchar(9)

    Objetivo : Seleccionar las solicitudes DU288 pendientes de aprobaciÃ³n
               para el rol Jefe de Departamento del Jefe de Proyecto.

    Creacion: AI 2026/07/01
    Actualizacion:

*/

create procedure Analisis2.sg_prsesSecgen19
    @rut_jefdep varchar(9) = NULL
as
begin
    if @rut_jefdep is null
    begin
        select 'Falta Rut de Jefe de Departamento del Jefe de Proyecto' msg
        return
    end

    SELECT prse.nro_solici, prse.actividad, prse.per_desde,
           prse.per_hasta, prse.rut_jefpro, prse.cod_unifin, prse.cod_ccto,
           prse.cc_global, prse.pry_global, prse.cod_modprs, soli.rut_solici, soli.nro_resolu, soli.cod_estsol,
           soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol, isnull(funps_total.total, 0) as total,
           (pers.nom_nombre + ' ' + pers.nom_appate + ' ' + pers.nom_apmate) as nombre
    FROM secgen_db.dbo.sg_prse prse
         JOIN secgen_db.dbo.sg_soli soli ON (prse.nro_solici = soli.nro_solici)
         JOIN secgen_db.dbo.sg_tsol tiposol ON (soli.cod_tipsol = tiposol.cod_tipsol)
         JOIN secgen_db.dbo.sg_esol estsol ON (soli.cod_estsol = estsol.cod_estsol)
         LEFT JOIN sisper_db..sp_pers as pers ON (soli.rut_solici = pers.rut_person)
         LEFT JOIN (
             SELECT nro_solici, SUM(mto_total) AS total
             FROM secgen_db.dbo.sg_fups
             GROUP BY nro_solici
         ) funps_total ON (soli.nro_solici = funps_total.nro_solici)
    WHERE soli.cod_estsol != 7
      AND prse.cod_modprs = 2
      AND EXISTS (
          SELECT 1
          FROM secgen_db.dbo.sg_apso apso
          WHERE apso.nro_solici = soli.nro_solici
            AND apso.cod_estapr = 4
            AND apso.rut_usua = @rut_jefdep
      )
    GROUP BY prse.nro_solici, prse.actividad, prse.per_desde, prse.per_hasta, prse.rut_jefpro, prse.cod_unifin, prse.cod_ccto, prse.cc_global, prse.pry_global, prse.cod_modprs, funps_total.total,
             soli.rut_solici, soli.nro_resolu, soli.cod_estsol,
             soli.cod_tipsol, soli.f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol, pers.rut_person, pers.nom_nombre, pers.nom_appate, pers.nom_apmate
    ORDER BY soli.nro_solici DESC
end
go

grant execute on Analisis2.sg_prsesSecgen19 to UsuaVrac
go
