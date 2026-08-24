use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'bd_pri2sSecgen01')
   drop procedure Analisis2.bd_pri2sSecgen01
go

/* Procedimiento : bd_pri2sSecgen01

    Entrada  :
        @des_perfil         ->nombre Perfil de Usuario
        @cod_sistem         -> Codigo del sistema
        @cod_modulo         -> Codigo del modulo del sistema
    Objetivo : traer todos los usuarios de un sistema con un rol en especifico (des_perfil)

    Creacion: SSY 2023/04/18
    Actualizacion:

*/

create procedure  Analisis2.bd_pri2sSecgen01
    @des_perfil varchar(100) = null,
    @cod_sistem char(2) = null,
    @cod_modulo varchar(100) = null
    as

    if @des_perfil is null
    begin
        select 'Falta campo des_perfil del Perfil' msg
        return
    end

        if @cod_sistem is null
    begin
        select 'Falta campo cod_sistem del Sistema' msg
        return
    end

        if @cod_modulo is null
    begin
        select 'Falta campo cod_modulo del Modulo' msg
        return
    end

    begin tran


        SELECT pri2.rut, pri2.cod_sistem, pri2.cod_modulo, per1.des_perfil, per1.cod_perfil,pers.nom_appate + ' ' + pers.nom_apmate + ' ' + pers.nom_nombre nombre
        FROM sistema_db..bd_pri2 pri2
        LEFT JOIN sistema_db..bd_per1 per1 ON (per1.cod_sistem = pri2.cod_sistem AND per1.cod_modulo = pri2.cod_modulo and per1.cod_perfil = pri2.cod_perfil)
        left join sisper_db..sp_pers pers on (pers.rut_person = pri2.rut)
        WHERE pri2.cod_sistem = @cod_sistem AND pri2.cod_modulo = @cod_modulo and per1.des_perfil = @des_perfil

    commit tran
go

grant execute on Analisis2.bd_pri2sSecgen01 to UsuaVrac
go

/*
execute secgen_db.Analisis2.bd_pri2sSecgen01 @cod_sistem = 'SG', @cod_modulo = 'SISSOLIC', @des_perfil = 'recruitment_professional';
 */
