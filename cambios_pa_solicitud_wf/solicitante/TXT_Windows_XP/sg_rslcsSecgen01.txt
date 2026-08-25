USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_rslcsSecgen01'
)
    DROP PROCEDURE Analisis2.sg_rslcsSecgen01
GO

/* Procedimiento : Analisis2.sg_rslcsSecgen01

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)

   Objetivo : seleccionar datos de resoluciA³n

   Creacion: AI 2023/02/28
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_rslcsSecgen01
        @nro_resolu int = null
     as
        if @nro_resolu is null
        begin
            select
            'Falta campo Numero Resolucion' msg
            return
        end

begin tran
select  rslc.num_resolu,
   rslc.codigo_sdg,
   rslc.f_resolucio
from sg_rslc as rslc
where rslc.nro_resolu = @nro_resolu
commit tran
go
    GRANT EXECUTE ON Analisis2.sg_rslcsSecgen01 TO UsuaVrac
go
    