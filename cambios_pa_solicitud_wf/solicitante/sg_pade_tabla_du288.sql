/*
===============================================================================
DU288 - TABLA sg_pade (detalle de pago por cuota)
Motor : Sybase ASE 12.5

Objetivo: registrar, para cada mes propuesto en sg_fume, a que CUOTA DE PAGO
real (nro_cuota_pago) se asigna y por que monto -- separa "mes propuesto"
(sg_fume.nro_cuota, uno por mes, sin limite) de "cuota de pago" (nro_cuota_pago,
maximo 2 por año calendario segun el Decreto 009/2026 numeral 6, salvo ANID
que no tiene ese limite, MOD-11). La asignacion se hace al momento del pago
(resolucion/decretacion), no al crear la solicitud -- sg_fume ya propone los
meses libremente y no cambia.

Como el PK de sg_pade es su propio id_pagdet (no una combinacion que incluya
nro_cuota_pago), varias filas pueden compartir el mismo nro_cuota_pago -- eso
es lo que permite que una cuota de pago cubra varios meses propuestos, sin
chocar con la PK de sg_fume (id_funprse, nro_cuota), que solo admite una fila
por mes.

cod_estdet reutiliza el catalogo sg_ecuo (mismos estados que sg_fume.cod_estcuo)
-- si el detalle de pago necesita estados propios, hay que reemplazar esta FK
por un catalogo nuevo.
===============================================================================
*/

USE secgen_db
GO

CREATE TABLE secgen_db.dbo.sg_pade (
	id_pagdet int identity,
	nro_solici int NOT NULL,
	id_funprse int NOT NULL,
	nro_cuota tinyint NOT NULL,
	nro_cuota_pago tinyint NOT NULL,
	mto_solpag decimal(19,2) NOT NULL,
	cod_estdet tinyint NOT NULL,
	CONSTRAINT SG_PADE_PK PRIMARY KEY (id_pagdet)
)
GO

CREATE UNIQUE INDEX PK_sg_pade ON secgen_db.dbo.sg_pade (id_pagdet)
GO

CREATE INDEX NC_sg_pade_solici ON secgen_db.dbo.sg_pade (nro_solici)
GO

CREATE INDEX NC_sg_pade_cuota ON secgen_db.dbo.sg_pade (id_funprse, nro_cuota)
GO

ALTER TABLE secgen_db.dbo.sg_pade ADD CONSTRAINT FK_sg_pade_sg_soli
	FOREIGN KEY (nro_solici) REFERENCES secgen_db.dbo.sg_soli(nro_solici)
	ON DELETE RESTRICT ON UPDATE RESTRICT
GO

ALTER TABLE secgen_db.dbo.sg_pade ADD CONSTRAINT FK_sg_pade_sg_fume
	FOREIGN KEY (id_funprse, nro_cuota) REFERENCES secgen_db.dbo.sg_fume(id_funprse, nro_cuota)
	ON DELETE RESTRICT ON UPDATE RESTRICT
GO

ALTER TABLE secgen_db.dbo.sg_pade ADD CONSTRAINT FK_sg_pade_sg_ecuo
	FOREIGN KEY (cod_estdet) REFERENCES secgen_db.dbo.sg_ecuo(cod_estcuo)
	ON DELETE RESTRICT ON UPDATE RESTRICT
GO
