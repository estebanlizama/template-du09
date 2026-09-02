use secgen_db
go

if exists (select 1
             from sysobjects a, sysusers b
            where a.uid = b.uid
              and a.type = 'P'
              and b.name = 'Analisis2'
              and a.name = 'sg_rslcuSecgen03')
begin
    drop procedure Analisis2.sg_rslcuSecgen03
end
go

/* Procedimiento : sg_rslcuSecgen03

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @rut_archiv          -> Parametro de entrada. (Opcional)
   @cod_estres          -> Parametro de entrada. (Opcional)

   Objetivo : Cambiar el estado de una resolución

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/

create procedure Analisis2.sg_rslcuSecgen03
    @nro_resolu int = null,
    @rut_archiv character(9) = null,
    @cod_estres int = null
        as

        if @nro_resolu is null begin
select
    'Falta campo Numero Resolucion' msg return
end

             if @cod_estres is null begin
select
    'Falta campo código de estado de la resolución' msg return
end

begin tran
update
    sg_rslc
set
    rut_archiv = @rut_archiv,
    f_archivad = getDate(),
    cod_estres = @cod_estres
where
    nro_resolu = @nro_resolu

    update sg_soli set cod_estsol = @cod_estres where nro_resolu = @nro_resolu

        commit tran
go

grant execute on Analisis2.sg_rslcuSecgen03 to UsuaVrac
go
