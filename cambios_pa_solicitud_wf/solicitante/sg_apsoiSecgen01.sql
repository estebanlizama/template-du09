USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_apsoiSecgen01'
)
    DROP PROCEDURE Analisis2.sg_apsoiSecgen01
GO

/*
Procedimiento : Analisis2.sg_apsoiSecgen01
Objetivo      : Crear una tarea de aprobacion asociada al flujo y etapa
                actuales de la solicitud.

Compatibilidad:
    Mantiene compatibles los tres parametros legacy. Los nuevos parametros
    son opcionales. Si la solicitud aun no posee flujo configurado,
    cod_flusol y cod_etapa se guardan NULL.
*/
CREATE PROCEDURE Analisis2.sg_apsoiSecgen01
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL,
    @cod_estapr tinyint = NULL,
    @id_funprse int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Numero Solicitud' AS msg
        RETURN
    END

    IF @rut_usua IS NULL
    BEGIN
        SELECT 'Falta campo RUT Usuario' AS msg
        RETURN
    END

    IF @cod_estapr IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Estado Aprobacion' AS msg
        RETURN
    END

    DECLARE @nro_aproba int
    DECLARE @cod_flusol tinyint
    DECLARE @cod_etapa tinyint

    IF @id_funprse = 0
        SELECT @id_funprse = NULL

    SELECT
        @cod_flusol = cod_flusol,
        @cod_etapa = cod_etapa
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_apso
        WHERE nro_solici = @nro_solici
          AND cod_estapr = @cod_estapr
          AND isnull(cod_flusol, 0) = isnull(@cod_flusol, 0)
          AND isnull(cod_etapa, 0) = isnull(@cod_etapa, 0)
          AND isnull(id_funprse, 0) = isnull(@id_funprse, 0)
          AND rut_usua = @rut_usua
    )
    BEGIN
        SELECT
            nro_aproba,
            cod_flusol,
            cod_etapa,
            id_funprse
        FROM secgen_db.dbo.sg_apso
        WHERE nro_solici = @nro_solici
          AND cod_estapr = @cod_estapr
          AND isnull(cod_flusol, 0) = isnull(@cod_flusol, 0)
          AND isnull(cod_etapa, 0) = isnull(@cod_etapa, 0)
          AND isnull(id_funprse, 0) = isnull(@id_funprse, 0)
          AND rut_usua = @rut_usua
        RETURN
    END

    BEGIN TRAN

    SELECT @nro_aproba = max(ultimo_id)
    FROM secgen_db.dbo.sg_parm
    WHERE nom_tabla LIKE 'sg_apso'

    SELECT @nro_aproba = isnull(@nro_aproba, 0) + 1

    UPDATE secgen_db.dbo.sg_parm
    SET ultimo_id = @nro_aproba
    WHERE nom_tabla LIKE 'sg_apso'

    IF @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al actualizar correlativo. Se aborta el procedimiento' AS msg
        IF @@transtate = 2
            ROLLBACK TRAN
        RETURN
    END

    INSERT INTO secgen_db.dbo.sg_apso (
        nro_aproba,
        nro_solici,
        rut_usua,
        cod_estapr,
        f_aprobac,
        f_creacion,
        f_ultmodif,
        cod_flusol,
        cod_etapa,
        rut_autori,
        id_funprse
    ) VALUES (
        @nro_aproba,
        @nro_solici,
        @rut_usua,
        @cod_estapr,
        NULL,
        getdate(),
        getdate(),
        @cod_flusol,
        @cod_etapa,
        NULL,
        @id_funprse
    )

    IF @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al crear la tarea de aprobacion. Se aborta el procedimiento' AS msg
        IF @@transtate = 2
            ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN

    SELECT
        @nro_aproba AS nro_aproba,
        @cod_flusol AS cod_flusol,
        @cod_etapa AS cod_etapa,
        @rut_usua AS rut_usua,
        @id_funprse AS id_funprse
END
GO

GRANT EXECUTE ON Analisis2.sg_apsoiSecgen01 TO UsuaVrac
GO
