USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_solidSecgen01'
)
    DROP PROCEDURE Analisis2.sg_solidSecgen01
GO

/* Procedimiento : Analisis2.sg_solidSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud PDS. (Obligatorio)
   @rut_usua            -> RUT del usuario que pide el borrado. (Obligatorio)

   Objetivo : Eliminar de forma transaccional una solicitud PDS que esta en
              borrador y que nunca fue enviada a visacion, junto con todo su
              subarbol de datos.

   Creacion: ELA 2026/09/16
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_solidSecgen01
    @nro_solici int = NULL,
    @rut_usua   char(9) = NULL
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @cod_tipsol   tinyint
    DECLARE @cod_estsol   tinyint
    DECLARE @rut_titular  char(9)
    DECLARE @ano_resolu   smallint
    DECLARE @nro_resolu   int
    DECLARE @cod_flusol   tinyint
    DECLARE @cod_etapa    tinyint
    DECLARE @funcionarios int
    DECLARE @paso         varchar(30)

    IF @nro_solici IS NULL OR @rut_usua IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_PARAMS' AS code,
               'Faltan parametros obligatorios' AS msg,
               convert(int, isnull(@nro_solici, 0)) AS nro_solici,
               0 AS funcionarios_eliminados
        RETURN
    END

    SELECT @cod_tipsol  = soli.cod_tipsol,
           @cod_estsol  = soli.cod_estsol,
           @rut_titular = soli.rut_solici,
           @ano_resolu  = soli.ano_resolu,
           @nro_resolu  = soli.nro_resolu
    FROM secgen_db.dbo.sg_soli soli
    WHERE soli.nro_solici = @nro_solici

    IF @cod_estsol IS NULL
    BEGIN
        SELECT 0 AS status, 'REQUEST_NOT_FOUND' AS code,
               'La solicitud especificada no existe' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF @cod_tipsol <> 1
    BEGIN
        SELECT 0 AS status, 'REQUEST_NOT_PDS' AS code,
               'La solicitud no es una prestacion de servicios' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF @rut_titular <> @rut_usua
    BEGIN
        SELECT 0 AS status, 'REQUEST_NOT_OWNED' AS code,
               'La solicitud no pertenece al usuario' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF @cod_estsol <> 5
    BEGIN
        SELECT 0 AS status, 'REQUEST_NOT_DRAFT' AS code,
               'Solo se puede eliminar una solicitud en estado borrador' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF @ano_resolu IS NOT NULL OR @nro_resolu IS NOT NULL
    BEGIN
        SELECT 0 AS status, 'REQUEST_HAS_RESOLUTION' AS code,
               'La solicitud tiene una resolucion asociada y no puede eliminarse' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

SELECT @cod_flusol = prse.cod_flusol,
           @cod_etapa  = prse.cod_etapa
    FROM secgen_db.dbo.sg_prse prse
    WHERE prse.nro_solici = @nro_solici

    IF @cod_flusol IS NOT NULL OR @cod_etapa IS NOT NULL
    BEGIN
        SELECT 0 AS status, 'REQUEST_IN_WORKFLOW' AS code,
               'La solicitud ya tiene un flujo de visacion iniciado' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_apso
        WHERE nro_solici = @nro_solici
    )
    BEGIN
        SELECT 0 AS status, 'REQUEST_ALREADY_SUBMITTED' AS code,
               'La solicitud fue enviada a visacion y no puede eliminarse' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_hist
        WHERE nro_solici = @nro_solici
          AND isnull(id_tipacc, 0) NOT IN (29, 15)
    )
    BEGIN
        SELECT 0 AS status, 'REQUEST_HAS_SUBMISSION_HISTORY' AS code,
               'La solicitud registra acciones de tramitacion y no puede eliminarse' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_fume
        WHERE id_funprse IN (
            SELECT id_funprse FROM secgen_db.dbo.sg_fups
            WHERE nro_solici = @nro_solici
        )
    )
    BEGIN
        SELECT 0 AS status, 'REQUEST_HAS_INSTALLMENTS' AS code,
               'La solicitud tiene cuotas comprometidas y no puede eliminarse' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

IF EXISTS (SELECT 1 FROM secgen_db.dbo.sg_apcc WHERE nro_solici = @nro_solici)
    OR EXISTS (SELECT 1 FROM secgen_db.dbo.sg_cicc WHERE nro_solici = @nro_solici)
    OR EXISTS (SELECT 1 FROM secgen_db.dbo.sg_drec WHERE nro_solici = @nro_solici)
    OR EXISTS (SELECT 1 FROM secgen_db.dbo.sg_inpc WHERE nro_solici = @nro_solici)
    OR EXISTS (SELECT 1 FROM secgen_db.dbo.sg_baco WHERE nro_solici = @nro_solici)
    BEGIN
        SELECT 0 AS status, 'REQUEST_HAS_EXTERNAL_DATA' AS code,
               'La solicitud tiene datos de otro modulo asociados y no puede eliminarse' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

    BEGIN TRAN

SELECT @cod_estsol = soli.cod_estsol
    FROM secgen_db.dbo.sg_soli soli HOLDLOCK
    WHERE soli.nro_solici = @nro_solici

    IF @cod_estsol <> 5
    BEGIN
        ROLLBACK TRAN
        SELECT 0 AS status, 'REQUEST_NOT_DRAFT' AS code,
               'La solicitud cambio de estado durante la operacion' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

    IF EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_apso
        WHERE nro_solici = @nro_solici
    )
    BEGIN
        ROLLBACK TRAN
        SELECT 0 AS status, 'REQUEST_ALREADY_SUBMITTED' AS code,
               'La solicitud fue enviada a visacion durante la operacion' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

    IF EXISTS (
        SELECT 1 FROM secgen_db.dbo.sg_fume
        WHERE id_funprse IN (
            SELECT id_funprse FROM secgen_db.dbo.sg_fups
            WHERE nro_solici = @nro_solici
        )
    )
    BEGIN
        ROLLBACK TRAN
        SELECT 0 AS status, 'REQUEST_HAS_INSTALLMENTS' AS code,
               'La solicitud comprometio cuotas durante la operacion' AS msg,
               @nro_solici AS nro_solici, 0 AS funcionarios_eliminados
        RETURN
    END

    SELECT @funcionarios = count(*)
    FROM secgen_db.dbo.sg_fups
    WHERE nro_solici = @nro_solici

SELECT @paso = 'sg_fuco'
    DELETE FROM secgen_db.dbo.sg_fuco
    WHERE id_funprse IN (
        SELECT id_funprse FROM secgen_db.dbo.sg_fups
        WHERE nro_solici = @nro_solici
    )
    IF @@error <> 0 GOTO fallo

    SELECT @paso = 'sg_fuho'
    DELETE FROM secgen_db.dbo.sg_fuho
    WHERE id_funprse IN (
        SELECT id_funprse FROM secgen_db.dbo.sg_fups
        WHERE nro_solici = @nro_solici
    )
    IF @@error <> 0 GOTO fallo

    SELECT @paso = 'sg_his2'
    DELETE FROM secgen_db.dbo.sg_his2
    WHERE id_funprse IN (
        SELECT id_funprse FROM secgen_db.dbo.sg_fups
        WHERE nro_solici = @nro_solici
    )
    IF @@error <> 0 GOTO fallo

    SELECT @paso = 'sg_fups'
    DELETE FROM secgen_db.dbo.sg_fups
    WHERE nro_solici = @nro_solici
    IF @@error <> 0 GOTO fallo

    SELECT @paso = 'sg_hist'
    DELETE FROM secgen_db.dbo.sg_hist
    WHERE nro_solici = @nro_solici
    IF @@error <> 0 GOTO fallo

    SELECT @paso = 'sg_prse'
    DELETE FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici
    IF @@error <> 0 GOTO fallo

    SELECT @paso = 'sg_soli'
    DELETE FROM secgen_db.dbo.sg_soli
    WHERE nro_solici = @nro_solici
    IF @@error <> 0 GOTO fallo

    IF @@transtate = 2 OR @@transtate = 3 GOTO fallo

    COMMIT TRAN

    SELECT 1 AS status, 'OK' AS code,
           'Solicitud en borrador eliminada correctamente' AS msg,
           @nro_solici AS nro_solici,
           isnull(@funcionarios, 0) AS funcionarios_eliminados
    RETURN

fallo:
    IF @@trancount > 0
        ROLLBACK TRAN

    SELECT 0 AS status, 'REQUEST_DELETE_ERROR' AS code,
           'Error al eliminar la solicitud en el paso ' + @paso
           + '. No se modifico ningun dato.' AS msg,
           @nro_solici AS nro_solici,
           0 AS funcionarios_eliminados
END
GO

GRANT EXECUTE ON Analisis2.sg_solidSecgen01 TO UsuaVrac
GO
