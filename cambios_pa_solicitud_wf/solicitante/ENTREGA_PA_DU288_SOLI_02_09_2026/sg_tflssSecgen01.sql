USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_tflssSecgen01'
)
    DROP PROCEDURE Analisis2.sg_tflssSecgen01
GO

/* Procedimiento : Analisis2.sg_tflssSecgen01

   Objetivo : Listar los tipos de flujos de solicitud (tfls) vigentes en el sistema.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_tflssSecgen01
AS
BEGIN
    SELECT cod_flusol, des_flusol, abr_flusol
    FROM secgen_db.dbo.sg_tfls
    WHERE isnull(vigente, 'S') = 'S'
    ORDER BY cod_flusol
END
GO

GRANT EXECUTE ON Analisis2.sg_tflssSecgen01 TO UsuaVrac
GO
