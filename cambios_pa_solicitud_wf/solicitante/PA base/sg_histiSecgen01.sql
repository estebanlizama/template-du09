use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_histiSecgen01')
   drop procedure Analisis2.sg_histiSecgen01
go

/* Procedimiento : sg_histiSecgen01

    Entrada  :
        @id_histor         -> Id Registro de históricos de solicitud, resolución
        @cod_tipsol         -> Codigo Tipo de Solicitud
        @nro_solici         -> Numero Solicitud
        @id_tipacc         -> Id Tipo de Resolucion
        @rut_accion         -> RUT Accion
        @id_perfil         -> Id Perfil

    Objetivo : insertar Registro de históricos de solicitud
    Creacion: CHL 2022/12/13
    Actualizacion: AI 2023/03/15

*/

create procedure  Analisis2.sg_histiSecgen01
    @cod_tipsol tinyint = NULL,
    @nro_solici int = NULL,
    @id_tipacc tinyint = NULL,
    @rut_accion char(9) = NULL,
    @id_perfil tinyint = NULL
    as

    if @cod_tipsol is null
    begin
        select 'Falta campo Codigo Tipo de Solicitud' msg
        return
    end

    if @nro_solici is null
    begin
        select 'Falta campo Numero Solicitud' msg
        return
    end

    if @id_tipacc is null
    begin
        select 'Falta campo Id Tipo de Resolucion' msg
        return
    end

    if @rut_accion is null
    begin
        select 'Falta campo RUT Accion' msg
        return
    end

    if @id_perfil is null
    begin
        select 'Falta campo Id Perfil' msg
        return
    end


    begin tran

    declare @id_histor int
    select @id_histor = max(ultimo_id)from secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_hist'
        select @id_histor = isnull(@id_histor,0) + 1

         update secgen_db..sg_parm
             set ultimo_id = @id_histor
             WHERE nom_tabla LIKE 'sg_hist'

    if @@transtate = 2 or @@transtate = 3
        begin
             select 'Error al actualizar correlativo. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
            return
        end

    insert into sg_hist (
        id_histor,
        cod_tipsol,
        nro_solici,
        id_tipacc,
        rut_accion,
        id_perfil,
        f_creacion,
        f_ultmodif
    )values(
        @id_histor,
        @cod_tipsol,
        @nro_solici,
        @id_tipacc,
        @rut_accion,
        @id_perfil,
        getDate(),
        getDate()
    )

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al insertar datos. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

grant execute on Analisis2.sg_histiSecgen01 to UsuaVrac

go
/*
execute secgen_db.Analisis2.sg_histiSecgen01
        @cod_tipsol = 4,
        @nro_solici = 88,
        @id_tipacc = 1,
        @rut_accion = '092867439',
        @id_perfil = 1
 */
