USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_pldesSecgen01'
)
    DROP PROCEDURE Analisis2.sg_pldesSecgen01
GO

/* Procedimiento : Analisis2.sg_pldesSecgen01

   Entrada :
   @id_planti           -> Parametro de entrada. (Obligatorio)

   Objetivo : select Plantilla Detalle

   Creacion: CHL 2022/12/13
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_pldesSecgen01
    @id_planti smallint = None
    as


    if @id_planti is null
    begin
        select 'Falta campo Id Plantilla' msg
        return
    end


        select
        plde.id_pladet,
        plde.id_planti,
        plde.cod_tipsec,
        plde.nombre,
        plde.valor,
        plde.editable,
        plde.orden,
        plde.f_creacion,
        plde.f_ultmodif
        from sg_plde as plde
        where plde.id_planti = @id_planti
        commit tran
go

GRANT EXECUTE ON Analisis2.sg_pldesSecgen01 TO UsuaVrac
go
