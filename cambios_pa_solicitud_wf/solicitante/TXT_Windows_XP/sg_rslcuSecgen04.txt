USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_rslcuSecgen04'
)
    DROP PROCEDURE Analisis2.sg_rslcuSecgen04
GO

/* Procedimiento : Analisis2.sg_rslcuSecgen04

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @cod_estres          -> Parametro de entrada. (Opcional)

   Objetivo : Marcar una resoluciA�n como ingresada

   Creacion: AI 2023/03/14
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_rslcuSecgen04
        @nro_resolu int = null,
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

        declare @status_code int

             select @status_code = rslc.cod_estres from sg_rslc as rslc where nro_resolu = @nro_resolu

        if(@status_code = 7)
begin
    UPDATE sg_rslc SET cod_estres = 8
    where nro_resolu = @nro_resolu


      update sg_soli set cod_estsol = @cod_estres where nro_resolu = @nro_resolu
end
    if(@status_code != 7)
        begin
    UPDATE sg_rslc SET cod_estres = @cod_estres
        where nro_resolu = @nro_resolu

end
    commit tran
go
    GRANT EXECUTE ON Analisis2.sg_rslcuSecgen04 TO UsuaVrac
go
    