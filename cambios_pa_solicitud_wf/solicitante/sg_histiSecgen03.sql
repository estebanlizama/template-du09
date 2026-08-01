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

/*
Procedimiento : Analisis2.sg_histiSecgen03
Objetivo      : Registrar el historial funcional de la solicitud.
*/
CREATE PROCEDURE Analisis2.sg_histiSecgen03
    @cod_tipsol tinyint = NULL,
    @nro_solici int = NULL,
    @nro_resolu int = NULL,
    @ano_resolu int = NULL,
    @id_tipacc tinyint = NULL,
    @observaci varchar(250) = NULL,
    @rut_accion char(9) = NULL,
    @id_perfil tinyint = NULL
AS
BEGIN
    IF @cod_tipsol IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Tipo de Solicitud' AS msg
        RETURN
    END

    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Numero Solicitud' AS msg
        RETURN
    END

    DECLARE @id_histor int

    BEGIN TRAN

    SELECT @id_histor = max(ultimo_id)
    FROM secgen_db.dbo.sg_parm
    WHERE nom_tabla LIKE 'sg_hist'

    SELECT @id_histor = isnull(@id_histor, 0) + 1

    UPDATE secgen_db.dbo.sg_parm
    SET ultimo_id = @id_histor
    WHERE nom_tabla LIKE 'sg_hist'

    IF @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al actualizar correlativo. Se aborta el procedimiento' AS msg
        IF @@transtate = 2
            ROLLBACK TRAN
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

    IF @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al insertar historial. Se aborta el procedimiento' AS msg
        IF @@transtate = 2
            ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN

    SELECT @id_histor AS id_histor
END
GO

GRANT EXECUTE ON Analisis2.sg_histiSecgen03 TO UsuaVrac
GO
