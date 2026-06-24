USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupsdSecgen01')
    DROP PROCEDURE Analisis2.sg_fupsdSecgen01
GO

/* Procedimiento : Analisis2.sg_fupsdSecgen01
   Objetivo      : Eliminar de forma transaccional un funcionario de sg_fups y sus compensaciones en sg_fuco de forma atómica.
   Entrada       :
       @id_funprse int
*/
CREATE PROCEDURE Analisis2.sg_fupsdSecgen01
    @id_funprse int = NULL
AS
BEGIN
    IF @id_funprse IS NULL
    BEGIN
        SELECT 'Falta id del funcionario' AS msg
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT 'El funcionario especificado no existe' AS msg
        RETURN
    END

    BEGIN TRAN

    -- TODO Fase 2: eliminar meses de sg_fume cuando la tabla sea desplegada.

    -- 1. Eliminar de sg_fuco
    DELETE FROM secgen_db.dbo.sg_fuco 
    WHERE id_funprse = @id_funprse
    
    IF @@error <> 0
    BEGIN
        SELECT 'Error al eliminar compensaciones del funcionario' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    -- 2. Eliminar de sg_fups
    DELETE FROM secgen_db.dbo.sg_fups 
    WHERE id_funprse = @id_funprse

    IF @@error <> 0
    BEGIN
        SELECT 'Error al eliminar el funcionario' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
    SELECT 'Funcionario y compensaciones eliminados correctamente' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fupsdSecgen01 TO UsuaVrac
GO
