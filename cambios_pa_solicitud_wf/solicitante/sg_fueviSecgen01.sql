USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_fueviSecgen01')
    DROP PROCEDURE Analisis2.sg_fueviSecgen01
GO

/* 
Procedimiento : Analisis2.sg_fueviSecgen01
Objetivo     : Registrar hitos de cumplimiento (entregables) que gatillan los pagos.
               Cada hito está vinculado a un funcionario específico.
Entrada      : 
    @id_funprse   -> FK funcionario (sg_fups).
    @des_evid     -> Descripción del entregable (ej: "Informe de Avance 1").
    @f_estimada   -> Fecha proyectada para la entrega.
    @ind_entregado -> Estado inicial ('S'/'N'). Por defecto 'N'.
Creación     : 2026/05/14
*/

CREATE PROCEDURE Analisis2.sg_fueviSecgen01
    @id_funprse int = NULL,
    @des_evid varchar(100) = NULL,
    @f_estimada datetime = NULL,
    @ind_entregado char(1) = 'N'
AS
BEGIN
    -- 1. Validaciones
    IF @id_funprse IS NULL OR @des_evid IS NULL OR @f_estimada IS NULL
    BEGIN
        SELECT 'Error: Faltan datos para el registro de evidencia/entregable' msg
        RETURN
    END

    -- 2. Integridad Referencial
    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT 'Error: No se encontró el registro de staff para el ID ' + convert(varchar, @id_funprse) msg
        RETURN
    END

    -- 3. Transacción
    BEGIN TRAN

    INSERT INTO secgen_db.dbo.sg_fuev (
        id_funprse,
        des_evid,
        f_estimada,
        ind_entregado
    ) VALUES (
        @id_funprse,
        @des_evid,
        @f_estimada,
        @ind_entregado
    )

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al guardar evidencia para id_funprse ' + convert(varchar, @id_funprse) msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_fueviSecgen01 TO UsuaVrac
GO
