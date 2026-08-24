use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_pldesSecgen01')
   drop procedure Analisis2.sg_pldesSecgen01
go

/* Procedimiento : sg_pldesSecgen01

    Entrada  :
        @id_pladet         -> Id Plantilla Detalle
        @id_planti         -> Id Plantilla
        @cod_tipsec         -> Codigo Tipo Sec
        @nombre         -> Nombre
        @valor         -> Valor
        @editable         -> Es Editable
        @orden         -> Orden
        @f_creacion         -> Fecha Creacion
        @f_ultmodif         -> Fecha Ultima Modificacion
    Objetivo : select Plantilla Detalle

    Creacion: CHL 2022/12/13
    Actualizacion:

*/

create procedure  Analisis2.sg_pldesSecgen01
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

grant execute on Analisis2.sg_pldesSecgen01 to UsuaVrac
go

/*
execute secgen_db.Analisis2.sg_pldesSecgen01 @id_planti = 3
 */
