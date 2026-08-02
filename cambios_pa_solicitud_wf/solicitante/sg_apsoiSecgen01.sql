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
    son opcionales. @exige_flujo debe enviarse en 1 desde el motor DU288 para
    impedir tareas sin flujo o etapa; los consumidores legacy pueden omitirlo.
*/
CREATE PROCEDURE Analisis2.sg_apsoiSecgen01
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL,
    @cod_estapr tinyint = NULL,
    @id_funprse int = NULL,
    @exige_flujo tinyint = 0
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
    DECLARE @error int
    DECLARE @filas int

    IF @id_funprse = 0
        SELECT @id_funprse = NULL

    SELECT
        @cod_flusol = cod_flusol,
        @cod_etapa = cod_etapa
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_eapr
        WHERE cod_estapr = @cod_estapr
    )
    BEGIN
        SELECT 0 AS status, 'El estado de aprobacion no existe' AS msg
        RETURN
    END

    IF isnull(@exige_flujo, 0) = 1
       AND (
           @cod_flusol IS NULL
           OR @cod_etapa IS NULL
           OR NOT EXISTS (
               SELECT 1
               FROM secgen_db.dbo.sg_eta1
               WHERE cod_flusol = @cod_flusol
                 AND cod_etapa = @cod_etapa
                 AND isnull(vigente, 'S') = 'S'
           )
       )
    BEGIN
        SELECT 0 AS status, 'La solicitud no posee una etapa de flujo vigente' AS msg
        RETURN
    END

    IF @id_funprse IS NOT NULL
       AND NOT EXISTS (
           SELECT 1
           FROM secgen_db.dbo.sg_fups
           WHERE id_funprse = @id_funprse
             AND nro_solici = @nro_solici
       )
    BEGIN
        SELECT 0 AS status, 'El funcionario no pertenece a la solicitud' AS msg
        RETURN
    END

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
            1 AS status,
            nro_aproba,
            cod_flusol,
            cod_etapa,
            rut_usua,
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

    UPDATE secgen_db.dbo.sg_parm
    SET ultimo_id = isnull(ultimo_id, 0) + 1
    WHERE nom_tabla = 'sg_apso'

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0 OR @filas <> 1
    BEGIN
        IF @@transtate <> 0
            ROLLBACK TRAN
        SELECT 0 AS status, 'Error al actualizar correlativo de sg_apso' AS msg
        RETURN
    END

    SELECT @nro_aproba = ultimo_id
    FROM secgen_db.dbo.sg_parm
    WHERE nom_tabla = 'sg_apso'

    IF @nro_aproba IS NULL
    BEGIN
        IF @@transtate <> 0
            ROLLBACK TRAN
        SELECT 0 AS status, 'No fue posible obtener correlativo de sg_apso' AS msg
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

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0 OR @filas <> 1
    BEGIN
        IF @@transtate <> 0
            ROLLBACK TRAN
        SELECT 0 AS status, 'Error al crear la tarea de aprobacion' AS msg
        RETURN
    END

    COMMIT TRAN

    SELECT
        1 AS status,
        @nro_aproba AS nro_aproba,
        @cod_flusol AS cod_flusol,
        @cod_etapa AS cod_etapa,
        @rut_usua AS rut_usua,
        @id_funprse AS id_funprse
END
GO

GRANT EXECUTE ON Analisis2.sg_apsoiSecgen01 TO UsuaVrac
GO
