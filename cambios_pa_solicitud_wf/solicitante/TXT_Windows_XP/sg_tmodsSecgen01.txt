USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_tmodsSecgen01'
)
    DROP PROCEDURE Analisis2.sg_tmodsSecgen01
GO

/* Procedimiento : Analisis2.sg_tmodsSecgen01

   Objetivo : Listar los tipos de modalidades maestras de prestacion de servicios

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_tmodsSecgen01
AS
BEGIN
    SELECT
        cod_modprs,
        des_modprs
    FROM secgen_db.dbo.sg_tmod
    ORDER BY cod_modprs
END
GO

GRANT EXECUTE ON Analisis2.sg_tmodsSecgen01 TO UsuaVrac
GO
