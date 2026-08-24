use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_apsosSecgen02')
   drop procedure Analisis2.sg_apsosSecgen02
go

/* Procedimiento : sg_apsosSecgen02

    Entrada  :
        @nro_solici  -> Numero de solicitud
    Objetivo : Trae los aprobadores para revisar estado

    Creacion: GE 2023/04/23
    Actualizacion: AI 2023/04/25

*/

create procedure  Analisis2.sg_apsosSecgen02
    @nro_solici int = NULL

    as

    if @nro_solici is null
    begin
        select 'Falta campo numero de solicitud' msg
        return
    end
 SELECT apso.rut_usua, per1.des_perfil, apso.cod_estapr
        FROM sg_soli as soli
        INNER JOIN sg_apso as apso ON (soli.nro_solici = apso.nro_solici)
        INNER JOIN sistema_db..bd_pri2 as pri2 ON (pri2.rut = apso.rut_usua)
        INNER JOIN sistema_db..bd_per1 as per1 ON (per1.cod_perfil = pri2.cod_perfil AND per1.cod_sistem = 'SG' AND per1.cod_modulo = 'SISSOLIC')
        WHERE soli.nro_solici = @nro_solici



        commit tran
go

grant execute on Analisis2.sg_apsosSecgen02 to UsuaVrac
go

/*
execute secgen_db.Analisis2.sg_apsosSecgen02 @nro_solici = 331;
 */
