use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
           where a.uid  = b.uid
             and a.type = 'P'
             and b.name = 'Analisis2'
             and a.name = 'sg_apsosSecgen01')
    drop procedure Analisis2.sg_apsosSecgen01
go

/*
    Entrada  :

    @nro_solici         -> Numero Resolucion

    Objetivo : Seleccionar comentario de solicitud

    Creacion: CHL 2022/12/13
    Actualizacion: AI 2023/02/15

    */
create procedure Analisis2.sg_apsosSecgen01 @nro_solici int = None
as
    if @nro_solici is null
        begin
            select
                'Falta campo Numero Solicitud' msg return
        end begin tran
select
    apso.comentario,
    apso.f_aprobac,
    pers.nom_appate + ' ' + pers.nom_apmate + ' ' + pers.nom_nombre nombre,
    per1.des_perext
from
    sg_apso as apso
        left join sisper_db..sp_pers pers on (pers.rut_person = apso.rut_usua)
        left join sistema_db..bd_pri2 pri2 on (apso.rut_usua = pri2.rut) and (pri2.cod_sistem = 'SG') and (pri2.cod_modulo = 'SISSOLIC')
        left join sistema_db..bd_per1 per1 on (pri2.cod_perfil = per1.cod_perfil) and (per1.cod_sistem = 'SG') and (per1.cod_modulo = 'SISSOLIC')
where
        apso.nro_solici = @nro_solici and apso.comentario like '%'
    commit tran
go
grant execute on Analisis2.sg_apsosSecgen01 to UsuaVrac
go
/*
 execute secgen_db.Analisis2.sg_apsosSecgen01 @nro_solici = 18
 */
