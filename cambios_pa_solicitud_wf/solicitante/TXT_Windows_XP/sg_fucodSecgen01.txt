USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fucodSecgen01')
    DROP PROCEDURE Analisis2.sg_fucodSecgen01
GO

/*
    Entrada  :
    
    Salida   :

    Objetivo : Eliminar un funcionario asociado a una prestacion de servicios
    Creacion : ELA 2026/08/24
    Modificacion :
*/
CREATE PROCEDURE Analisis2.sg_fucodSecgen01
    @id_funprse int = NULL
AS
BEGIN
    IF @id_funprse IS NULL
    BEGIN
        SELECT 'Error: Falta ID del funcionario' AS msg
        RETURN
    END

    DELETE FROM secgen_db.dbo.sg_fuco
    WHERE id_funprse = @id_funprse

    IF @@error <> 0
    BEGIN
        SELECT 'Error: No fue posible eliminar las compensaciones anteriores' AS msg
        RETURN
    END

    SELECT 'OK' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fucodSecgen01 TO UsuaVrac
GO
