USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_histiSecgen03'
)
    DROP PROCEDURE Analisis2.sg_histiSecgen03
GO

/* Procedimiento : Analisis2.sg_histiSecgen03

   Entrada :
   @cod_tipsol          -> Tipo de solicitud. (Opcional)
   @nro_solici          -> Numero de solicitud. (Opcional)
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @ano_resolu          -> Parametro de entrada. (Opcional)
   @id_tipacc           -> Identificador tipo de accion. (Opcional)
   @observaci           -> Parametro de entrada. (Opcional)
   @rut_accion          -> Parametro de entrada. (Opcional)
   @id_perfil           -> Parametro de entrada. (Opcional)

   Objetivo : Registrar el historial funcional de la solicitud.
Salida        : Una fila con status, id_histor y msg. Este contrato es obligatorio para confirmar atomicamente la escritura desde el backend.

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_histiSecgen03
    @cod_tipsol tinyint = NULL,
    @nro_solici int = NULL,
    @nro_resolu int = NULL,
    @ano_resolu smallint = NULL,
    @id_tipacc tinyint = NULL,
    @observaci varchar(250) = NULL,
    @rut_accion char(9) = NULL,
    @id_perfil smallint = NULL
AS
BEGIN
    IF @cod_tipsol IS NULL
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'Falta campo Codigo Tipo de Solicitud' AS msg
        RETURN
    END

    IF @nro_solici IS NULL
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'Falta campo Numero Solicitud' AS msg
        RETURN
    END

    IF @id_tipacc IS NULL
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'Falta campo Tipo de Accion' AS msg
        RETURN
    END

    IF @rut_accion IS NULL
       OR ltrim(rtrim(@rut_accion)) = ''
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'Falta campo RUT Accion' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_soli
        WHERE nro_solici = @nro_solici
    )
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'La solicitud no existe' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_tsol
        WHERE cod_tipsol = @cod_tipsol
    )
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'El tipo de solicitud no existe' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_tacc
        WHERE id_tipacc = @id_tipacc
    )
    BEGIN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'El tipo de accion no existe' AS msg
        RETURN
    END

    DECLARE @id_histor int
    DECLARE @error int
    DECLARE @filas int

    BEGIN TRAN

    UPDATE secgen_db.dbo.sg_parm
    SET ultimo_id = isnull(ultimo_id, 0) + 1
    WHERE nom_tabla = 'sg_hist'

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0 OR @filas <> 1
    BEGIN
        IF @@transtate <> 0
            ROLLBACK TRAN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'Error al actualizar correlativo de sg_hist' AS msg
        RETURN
    END

    SELECT @id_histor = ultimo_id
    FROM secgen_db.dbo.sg_parm
    WHERE nom_tabla = 'sg_hist'

    IF @id_histor IS NULL
    BEGIN
        IF @@transtate <> 0
            ROLLBACK TRAN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'No fue posible obtener correlativo de sg_hist' AS msg
        RETURN
    END

    INSERT INTO secgen_db.dbo.sg_hist (
        id_histor,
        cod_tipsol,
        nro_solici,
        nro_resolu,
        ano_resolu,
        id_tipacc,
        observaci,
        rut_accion,
        id_perfil,
        f_creacion,
        f_ultmodif
    ) VALUES (
        @id_histor,
        @cod_tipsol,
        @nro_solici,
        @nro_resolu,
        @ano_resolu,
        @id_tipacc,
        @observaci,
        @rut_accion,
        @id_perfil,
        getdate(),
        getdate()
    )

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0 OR @filas <> 1
    BEGIN
        IF @@transtate <> 0
            ROLLBACK TRAN
        SELECT 0 AS status, convert(int, NULL) AS id_histor,
               'Error al insertar historial' AS msg
        RETURN
    END

    COMMIT TRAN

    SELECT 1 AS status, @id_histor AS id_histor,
           convert(varchar(100), NULL) AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_histiSecgen03 TO UsuaVrac
GO
