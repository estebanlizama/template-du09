USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_apsouSecgen03'
)
    DROP PROCEDURE Analisis2.sg_apsouSecgen03
GO

/*
Procedimiento : Analisis2.sg_apsouSecgen03
Objetivo      : Registrar de forma atomica la decision de una tarea DU288.

Reglas:
    - La tarea debe estar pendiente y pertenecer al RUT autenticado.
    - La tarea debe corresponder a la etapa actual de sg_prse.
    - rut_autori identifica a quien ejecuto realmente la accion.
*/
CREATE PROCEDURE Analisis2.sg_apsouSecgen03
    @nro_aproba int = NULL,
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL,
    @cod_estapr tinyint = NULL,
    @comentario varchar(255) = NULL
AS
BEGIN
    DECLARE @filas int
    DECLARE @error int
    DECLARE @cod_flusol tinyint
    DECLARE @cod_etapa tinyint

    IF @nro_aproba IS NULL OR @nro_solici IS NULL
       OR @rut_usua IS NULL OR @cod_estapr IS NULL
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'Faltan parametros para registrar la decision' AS mensaje
        RETURN
    END

    IF @cod_estapr NOT IN (1, 2, 3)
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'La decision de la tarea no es valida' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_eapr
        WHERE cod_estapr = @cod_estapr
    )
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'El estado de aprobacion no existe' AS mensaje
        RETURN
    END

    IF ltrim(rtrim(isnull(@comentario, ''))) = ''
        SELECT @comentario = NULL

    SELECT
        @cod_flusol = cod_flusol,
        @cod_etapa = cod_etapa
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF @cod_flusol IS NULL OR @cod_etapa IS NULL
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'La solicitud no posee una etapa de flujo vigente' AS mensaje
        RETURN
    END

    UPDATE secgen_db.dbo.sg_apso
    SET cod_estapr = @cod_estapr,
        comentario = @comentario,
        rut_autori = @rut_usua,
        f_aprobac = getdate(),
        f_ultmodif = getdate()
    WHERE nro_aproba = @nro_aproba
      AND nro_solici = @nro_solici
      AND rut_usua = @rut_usua
      AND cod_estapr = 4
      AND cod_flusol = @cod_flusol
      AND cod_etapa = @cod_etapa

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'Error al registrar la decision de la tarea' AS mensaje
        RETURN
    END

    IF @filas <> 1
    BEGIN
        SELECT 0 AS status, @filas AS filas_actualizadas,
               'La tarea no esta pendiente, cambio de etapa o no pertenece al usuario' AS mensaje
        RETURN
    END

    SELECT 1 AS status, @filas AS filas_actualizadas,
           CONVERT(varchar(255), NULL) AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_apsouSecgen03 TO UsuaVrac
GO
