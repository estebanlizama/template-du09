USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsouSecgen02'
)
    DROP PROCEDURE Analisis2.sg_apsouSecgen02
GO

/* Procedimiento : Analisis2.sg_apsouSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @cod_flusol          -> Codigo de flujo de solicitud. (Opcional)
   @cod_etapa           -> Parametro de entrada. (Opcional)
   @cod_estapr          -> Codigo de estado de aprobacion. (Opcional)

   Objetivo : Sin descripcion

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_apsouSecgen02
    @nro_solici int = NULL,
    @cod_flusol tinyint = NULL,
    @cod_etapa tinyint = NULL,
    @cod_estapr tinyint = NULL
AS
BEGIN
    IF @nro_solici IS NULL OR @cod_flusol IS NULL
       OR @cod_etapa IS NULL OR @cod_estapr IS NULL
    BEGIN
        SELECT 0 AS status, 'Faltan parametros para cerrar tareas pendientes' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_eapr
        WHERE cod_estapr = @cod_estapr
    )
    BEGIN
        SELECT 0 AS status, 'El estado para cerrar las tareas no existe' AS mensaje
        RETURN
    END

    DECLARE @filas int
    DECLARE @error int

    UPDATE secgen_db.dbo.sg_apso
    SET cod_estapr = @cod_estapr,
        f_ultmodif = getdate()
    WHERE nro_solici = @nro_solici
      AND cod_flusol = @cod_flusol
      AND cod_etapa = @cod_etapa
      AND cod_estapr = 4

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'Error al cerrar las tareas pendientes' AS mensaje
        RETURN
    END

    SELECT
        1 AS status,
        @filas AS filas_actualizadas,
        CONVERT(varchar(255), NULL) AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_apsouSecgen02 TO UsuaVrac
GO
