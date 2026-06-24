USE secgen_db
GO

/* PENDIENTE FASE 2 - NO DESPLEGAR TODAVIA.
   Referencia para cuando sg_fume sea creada formalmente.
*/

/* Tabla       : dbo.sg_fume
   Objetivo    : Registrar los meses exactos de ejecucion de cada funcionario
                 asociado a una solicitud PDS.
   Unicidad    : Un funcionario solo puede tener un registro vigente por
                 anio y mes calendario.
*/
IF NOT EXISTS (
    SELECT 1
    FROM sysobjects
    WHERE name = 'sg_fume'
      AND type = 'U'
)
BEGIN
    CREATE TABLE dbo.sg_fume (
        id_funmes int identity NOT NULL,
        id_funprse int NOT NULL,
        nro_mes tinyint NOT NULL,
        anio smallint NOT NULL,
        vigente char(1) NOT NULL,
        CONSTRAINT PK_sg_fume PRIMARY KEY (id_funmes),
        CONSTRAINT FK_sg_fume_sg_fups
            FOREIGN KEY (id_funprse)
            REFERENCES dbo.sg_fups (id_funprse),
        CONSTRAINT CK_sg_fume_mes
            CHECK (nro_mes BETWEEN 1 AND 12),
        CONSTRAINT CK_sg_fume_anio
            CHECK (anio BETWEEN 2000 AND 2100),
        CONSTRAINT CK_sg_fume_vigente
            CHECK (vigente IN ('S', 'N'))
    )
END
GO

/* Aplicable tanto a una tabla nueva como a una sg_fume ya existente. */
IF NOT EXISTS (
    SELECT 1
    FROM sysindexes
    WHERE id = object_id('dbo.sg_fume')
      AND name = 'UQ_sg_fume_funcionario_mes'
)
BEGIN
    IF EXISTS (
        SELECT id_funprse, anio, nro_mes
        FROM dbo.sg_fume
        GROUP BY id_funprse, anio, nro_mes
        HAVING count(*) > 1
    )
    BEGIN
        PRINT 'No se creo UQ_sg_fume_funcionario_mes: existen meses duplicados'
    END
    ELSE
    BEGIN
        CREATE UNIQUE INDEX UQ_sg_fume_funcionario_mes
            ON dbo.sg_fume (id_funprse, anio, nro_mes)
    END
END
GO
