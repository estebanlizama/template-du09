USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fuhodSecgen01')
    DROP PROCEDURE Analisis2.sg_fuhodSecgen01
GO

/* Procedimiento : Analisis2.sg_fuhodSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Obligatorio)

   Objetivo : Elimina los tramos horarios de ejecucion en sg_fuho para un funcionario. Entrada       : @id_funprse int

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fuhodSecgen01
    @id_funprse int
AS
BEGIN
    IF @id_funprse IS NULL
    BEGIN
        SELECT 'Parametro id_funprse requerido' AS msg
        RETURN
    END

    DELETE FROM secgen_db.dbo.sg_fuho
    WHERE id_funprse = @id_funprse

    SELECT 'OK' AS status
END
GO

GRANT EXECUTE ON Analisis2.sg_fuhodSecgen01 TO UsuaVrac
GO
