USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_rslcuSecgen03'
)
    DROP PROCEDURE Analisis2.sg_rslcuSecgen03
GO

/* Procedimiento : Analisis2.sg_rslcuSecgen03

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @rut_archiv          -> Parametro de entrada. (Opcional)
   @cod_estres          -> Parametro de entrada. (Opcional)

   Objetivo : Cambiar el estado de una resoluciA�n

   Creacion: AI 2023/02/23
   Actualizacion: AI 2023/04/10
*/
CREATE PROCEDURE Analisis2.sg_rslcuSecgen03
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
    GRANT EXECUTE ON Analisis2.sg_rslcuSecgen03 TO UsuaVrac
go
    