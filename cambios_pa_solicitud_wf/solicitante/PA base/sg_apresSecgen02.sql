USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apresSecgen02'
)
    DROP PROCEDURE Analisis2.sg_apresSecgen02
GO

/* Procedimiento : Analisis2.sg_apresSecgen02

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)

   Objetivo : seleccionar la cantidad de aprocaciones de una resoluciA³n

   Creacion: AI 2023/02/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_apresSecgen02 @nro_resolu int = null as
    declare @cant_aprobaciones tinyint
select
    @cant_aprobaciones = count(nro_resolu)
from
    sg_apre
where
    cod_estapr = 1
    and nro_resolu = @nro_resolu
select
    @cant_aprobaciones as cant_aprobaciones
go
    GRANT EXECUTE ON Analisis2.sg_apresSecgen02 TO UsuaVrac
go
    