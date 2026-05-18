USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_fumeiSecgen01')
    DROP PROCEDURE Analisis2.sg_fumeiSecgen01
GO

/* 
Procedimiento : Analisis2.sg_fumeiSecgen01
Objetivo     : Insertar la planificación mensual de pagos para un funcionario.
               Soporta el límite de 2 meses exigido por la normativa Fase 2.
Entrada      : 
    @id_funprse -> ID único del funcionario en la prestación (sg_fups).
    @mes        -> Mes de ejecución (1-12).
    @ano        -> Año de ejecución.
    @monto_mes  -> Valor bruto asignado para este mes específico.
Creación     : 2026/05/14
*/

CREATE PROCEDURE Analisis2.sg_fumeiSecgen01
    @id_funprse int = NULL,
    @mes tinyint = NULL,
    @ano smallint = NULL,
    @monto_mes decimal(19,2) = 0
AS
BEGIN
    -- 1. Validaciones
    IF @id_funprse IS NULL OR @mes IS NULL OR @ano IS NULL
    BEGIN
        SELECT 'Error: Faltan campos obligatorios para el registro mensual' msg
        RETURN
    END

    -- 2. Integridad Referencial
    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT 'Error: El ID de funcionario ' + convert(varchar, @id_funprse) + ' no existe en sg_fups' msg
        RETURN
    END

    -- 3. Proceso Transaccional
    BEGIN TRAN

    INSERT INTO secgen_db.dbo.sg_fume (
        id_funprse,
        mes,
        ano,
        monto_mes
    ) VALUES (
        @id_funprse,
        @mes,
        @ano,
        @monto_mes
    )

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al guardar el mes ' + convert(varchar, @mes) + ' para el funcionario ' + convert(varchar, @id_funprse) msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_fumeiSecgen01 TO UsuaVrac
GO
