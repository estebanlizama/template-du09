USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_rslciSecgen01'
)
    DROP PROCEDURE Analisis2.sg_rslciSecgen01
GO

/* Procedimiento : Analisis2.sg_rslciSecgen01

   Entrada :
   @ano_resolu          -> Parametro de entrada. (Obligatorio)
   @respon_res          -> Parametro de entrada. (Opcional)
   @id_planti           -> Parametro de entrada. (Opcional)
   @cod_estres          -> Parametro de entrada. (Obligatorio)
   @id_docum            -> Parametro de entrada. (Opcional)

   Objetivo : insertar Resoluciones

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/09
*/
CREATE PROCEDURE Analisis2.sg_rslciSecgen01
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


GRANT EXECUTE ON Analisis2.sg_rslciSecgen01 TO UsuaVrac
go
