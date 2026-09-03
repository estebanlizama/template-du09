USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prm1sSecgen01'
)
    DROP PROCEDURE Analisis2.sg_prm1sSecgen01
GO

/* Procedimiento : Analisis2.sg_prm1sSecgen01

   Objetivo : Consultar el ultimo ano de proceso registrado.

   Creacion: SSY 2023/04/20
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prm1sSecgen01
AS
    BEGIN TRAN

    SELECT MAX(ano_proces) ano_proces FROM sg_prm1

    COMMIT TRAN
GO

GRANT EXECUTE ON Analisis2.sg_prm1sSecgen01 TO UsuaVrac
GO
