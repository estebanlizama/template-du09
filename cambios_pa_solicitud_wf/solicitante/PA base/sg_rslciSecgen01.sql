use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_rslciSecgen01')
   drop procedure Analisis2.sg_rslciSecgen01
go

/* Procedimiento : sg_rslciSecgen01

    Entrada  :
        @ano_resolu         -> Año Resolucion
        @nro_resolu         -> Numero Resolucion
        @respon_res         -> Responsable Resolucion
        @id_planti         -> Id Plantilla
        @cod_estres         -> Codigo Estado Resolucion
        @id_docum         -> Id Documento
    Objetivo : insertar Resoluciones

    Creacion: CHL 2022/12/13
    Actualizacion: AI 2023/02/09

*/

create procedure  Analisis2.sg_rslciSecgen01
    @ano_resolu smallint = None,
    @respon_res varchar(40) = NULL,
    @id_planti smallint = NULL,
    @cod_estres tinyint = None,
    @id_docum int = NULL
    as

    if @ano_resolu is null
    begin
        select 'Falta campo Año Resolucion' msg
        return
    end

    if @id_planti is null
    begin
        select 'Falta campo Id Plantilla' msg
        return
    end

    if @cod_estres is null
    begin
        select 'Falta campo Codigo Estado Resolucion' msg
        return
    end

    begin tran

    declare @nro_resolu int
    select @nro_resolu = max(ultimo_id)from secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_rslc'
        select @nro_resolu = isnull(@nro_resolu,0) + 1

         update secgen_db..sg_parm
             set ultimo_id = @nro_resolu
             WHERE nom_tabla LIKE 'sg_rslc'

    if @@transtate = 2 or @@transtate = 3
        begin
             select 'Error al actualizar correlativo. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
            return
        end

    insert into sg_rslc (
        ano_resolu,
        nro_resolu,
        respon_res,
        f_resolucio,
        id_planti,
        cod_estres,
        id_docum
    )values(
        @ano_resolu,
        @nro_resolu,
        @respon_res,
        getDate(),
        @id_planti,
        @cod_estres,
        @id_docum
    )

select @nro_resolu as nro_resolu

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar información. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go


grant execute on Analisis2.sg_rslciSecgen01 to UsuaVrac
go

/*
execute secgen_db.Analisis2.sg_rslciSecgen01
        @ano_resolu = 2023,
        @respon_res = '',
        @id_planti = 3,
        @cod_estres = 1,
        @id_docum = 3595
 */
