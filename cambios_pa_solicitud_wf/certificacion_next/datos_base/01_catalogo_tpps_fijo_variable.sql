/*
===============================================================================
DU288 - CATALOGO sg_tpps: tipo de monto (fijo / variable)
Motor : Sybase ASE 12.5

DU288 usa sg_fups.cod_tpps como señal del tipo de monto de la prestacion, en
vez de agregar una columna nueva: son la misma distincion.

    cod_tpps = 1  ->  Fijo      (pago mensual, monto parejo entre los meses
                                 de ejecucion; la cantidad de cuotas se
                                 determina con certeza en la solicitud)
    cod_tpps = 2  ->  Variable  (pago diario, el monto real de cada mes
                                 depende de lo efectivamente trabajado; la
                                 solicitud solo declara el techo maximo y el
                                 reparto se define al momento del pago)

Respaldo funcional: ClickUp S0-013 (86e2zrkh4), Q-A06 -- "también hay pagos
fijos y variables".

Este script solo actualiza la DESCRIPCION del catalogo; no cambia codigos ni
estructura. Ningun consumidor del backend o del frontend lee des_tpps (se
verifico por busqueda en ambos repositorios), asi que el cambio es seguro:
lo unico que se usa es el valor numerico de cod_tpps.
===============================================================================
*/

USE secgen_db
GO

SET NOCOUNT ON
GO

UPDATE secgen_db.dbo.sg_tpps
SET des_tpps = 'Fijo'
WHERE cod_tpps = 1
GO

UPDATE secgen_db.dbo.sg_tpps
SET des_tpps = 'Variable'
WHERE cod_tpps = 2
GO

INSERT INTO secgen_db.dbo.sg_tpps (cod_tpps, des_tpps)
SELECT 1, 'Fijo'
WHERE NOT EXISTS (
    SELECT 1 FROM secgen_db.dbo.sg_tpps WHERE cod_tpps = 1
)
GO

INSERT INTO secgen_db.dbo.sg_tpps (cod_tpps, des_tpps)
SELECT 2, 'Variable'
WHERE NOT EXISTS (
    SELECT 1 FROM secgen_db.dbo.sg_tpps WHERE cod_tpps = 2
)
GO
