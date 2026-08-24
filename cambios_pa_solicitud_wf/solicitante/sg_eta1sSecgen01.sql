USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_eta1sSecgen01'
)
    DROP PROCEDURE Analisis2.sg_eta1sSecgen01
GO

/* Procedimiento : Analisis2.sg_eta1sSecgen01

   Entrada :
   @cod_flusol          -> Codigo de flujo de solicitud. (Opcional)

   Objetivo : Sin descripcion

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_eta1sSecgen01
    @cod_flusol tinyint = NULL
AS
BEGIN
    IF @cod_flusol IS NULL
    BEGIN
        SELECT 'Falta Codigo de Flujo' AS msg
        RETURN
    END

    SELECT cod_etapa, des_etapa, cod_perfil, est_final
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'
    ORDER BY cod_etapa
END
GO

GRANT EXECUTE ON Analisis2.sg_eta1sSecgen01 TO UsuaVrac
GO
