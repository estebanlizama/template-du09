use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_redeiSecgen01')
   drop procedure Analisis2.sg_redeiSecgen01
go

/* Procedimiento : sg_redeiSecgen01

    Entrada  :
        @id_resdet         -> Id Detalle Resolucion
        @ano_resolu         -> Año Resolucion
        @nro_resolu         -> Numero Resolucion
        @id_pladet         -> Id Plantilla Detalle
        @cod_tipsec         -> Codigo Tipo Secccion
        @nombre         -> Nombre
        @valor         -> Valor
        @editable         -> Editable
        @orden         -> Orden
        @f_creacion         -> Fecha Creacion
        @f_ultmodif         -> Fecha Ultima Modificacion
    Objetivo : insertar Detalle de resolución

    Creacion: CHL 2022/12/13
    Actualizacion:

*/

create procedure  Analisis2.sg_redeiSecgen01
    @ano_resolu smallint = None,
    @nro_resolu int = None,
    @id_pladet int = None,
    @cod_tipsec tinyint = NULL,
    @nombre varchar(100) = NULL,
    @editable char(1) = NULL,
    @orden tinyint = None
    as


    if @ano_resolu is null
    begin
        select 'Falta campo Año Resolucion' msg
        return
    end

    if @nro_resolu is null
    begin
        select 'Falta campo Numero Resolucion' msg
        return
    end

    if @id_pladet is null
    begin
        select 'Falta campo Id Plantilla Detalle' msg
        return
    end

    if @cod_tipsec is null
    begin
        select 'Falta campo Codigo Tipo Secccion' msg
        return
    end

    if @nombre is null
    begin
        select 'Falta campo Nombre' msg
        return
    end

    if @editable is null
    begin
        select 'Falta campo Editable' msg
        return
    end

    if @orden is null
    begin
        select 'Falta campo Orden' msg
        return
    end

    begin tran

    declare @id_resdet int
    select @id_resdet = max(ultimo_id)from secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_rede'
        select @id_resdet = isnull(@id_resdet,0) + 1

         update secgen_db..sg_parm
             set ultimo_id = @id_resdet
             WHERE nom_tabla LIKE 'sg_rede'

    if @@transtate = 2 or @@transtate = 3
        begin
             select 'Error al actualizar correlativo. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
            return
        end

    insert into sg_rede (
        id_resdet,
        ano_resolu,
        nro_resolu,
        id_pladet,
        cod_tipsec,
        nombre,
        editable,
        orden,
        f_creacion,
        f_ultmodif
    )values(
        @id_resdet,
        @ano_resolu,
        @nro_resolu,
        @id_pladet,
        @cod_tipsec,
        @nombre,
        @editable,
        @orden,
        getDate(),
        getDate()
    )

    select @id_resdet as id_resdet

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar información. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

grant execute on Analisis2.sg_redeiSecgen01 to UsuaVrac
go

/*
execute secgen_db.Analisis2.sg_redeiSecgen01
        @ano_resolu = 2023
        @nro_resolu = 2
        @id_pladet = 3
        @cod_tipsec = 1
        @nombre = ''
        @editable = 'S'
        @orden = 1
 */
