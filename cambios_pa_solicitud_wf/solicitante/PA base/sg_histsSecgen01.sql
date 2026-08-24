use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_histsSecgen01')
   drop procedure Analisis2.sg_histsSecgen01
go

/* Procedimiento : sg_histsSecgen01

    Entrada  :
        @id_perfil         -> Id Registro de históricos de solicitud, resolución
        @id_tipacc         -> Codigo Tipo de Solicitud
        @nro_resolu

    Objetivo : Obtener lista de una accion realizada un por perfil
    Creacion: SSY 31/03/2023
    Actualizacion:

*/

create procedure  Analisis2.sg_histsSecgen01
    @id_perfil tinyint = NULL,
    @id_tipacc tinyint = NULL,
    @nro_resolu tinyint = NULL
    as

    if @id_perfil is null
    begin
        select 'Falta campo Codigo Tipo de Solicitud' msg
        return
    end

    if @id_tipacc is null
    begin
        select 'Falta campo Numero Solicitud' msg
        return
    end

    if @nro_resolu is null
    begin
        select 'Falta campo Numero de resolucion' msg
        return
    end

    begin tran

    SELECT id_histor, cod_tipsol, nro_solici, nro_resolu, ano_resolu, id_tipacc,
    observaci, rut_accion, id_perfil, f_creacion, f_ultmodif FROM sg_hist WHERE id_perfil = @id_perfil and id_tipacc = @id_tipacc and nro_resolu = @nro_resolu


    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al insertar datos. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

grant execute on Analisis2.sg_histsSecgen01 to UsuaVrac

go
/*
execute secgen_db.Analisis2.sg_histsSecgen01
        @id_perfil = 8,
        @id_tipacc = 13,
        @nro_resolu = 8
 */
