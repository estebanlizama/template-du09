USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fucouSecgen01')
    DROP PROCEDURE Analisis2.sg_fucouSecgen01
GO

/* Procedimiento : Analisis2.sg_fucouSecgen01
   Objetivo      : Actualiza las compensaciones semanales de un funcionario prestación de servicios de manera atómica.
   Entrada       :
       @id_funprse  int,
       @hor_lun     tinyint = NULL,
       @hor_mar     tinyint = NULL,
       @hor_mie     tinyint = NULL,
       @hor_jue     tinyint = NULL,
       @hor_vie     tinyint = NULL,
       @hor_sab     tinyint = NULL,
       @hor_dom     tinyint = NULL
   Salida        :
       id_funprse           int,
       registros_insertados int,
       msg                  varchar(255)
*/
CREATE PROCEDURE Analisis2.sg_fucouSecgen01
    @id_funprse int = NULL,
    @hor_lun tinyint = NULL,
    @hor_mar tinyint = NULL,
    @hor_mie tinyint = NULL,
    @hor_jue tinyint = NULL,
    @hor_vie tinyint = NULL,
    @hor_sab tinyint = NULL,
    @hor_dom tinyint = NULL
AS
BEGIN
    -- 1. Validar id_funprse
    IF @id_funprse IS NULL
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Falta ID del funcionario' AS msg
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: El funcionario especificado no existe' AS msg
        RETURN
    END

    -- 2. Confirmar modalidad DU288 y dentro de jornada
    DECLARE @cod_modprs tinyint
    DECLARE @dentro_jor char(1)
    SELECT 
        @cod_modprs = isnull(prse.cod_modprs, 1),
        @dentro_jor = isnull(fu.dentro_jor, 'N')
    FROM secgen_db.dbo.sg_prse prse
    JOIN secgen_db.dbo.sg_fups fu ON prse.nro_solici = fu.nro_solici
    WHERE fu.id_funprse = @id_funprse

    IF @cod_modprs <> 2
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: El funcionario no corresponde a la modalidad DU288' AS msg
        RETURN
    END

    -- Validar que no se permitan compensaciones si está fuera de jornada
    IF @dentro_jor <> 'S' AND (
        @hor_lun IS NOT NULL OR @hor_mar IS NOT NULL OR @hor_mie IS NOT NULL OR
        @hor_jue IS NOT NULL OR @hor_vie IS NOT NULL OR @hor_sab IS NOT NULL OR @hor_dom IS NOT NULL
    )
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: No se permiten horas de compensación si el funcionario está fuera de jornada' AS msg
        RETURN
    END

    -- 3. Validar horas entre 1 y 3
    IF (@hor_lun IS NOT NULL AND (@hor_lun < 1 OR @hor_lun > 3)) OR
       (@hor_mar IS NOT NULL AND (@hor_mar < 1 OR @hor_mar > 3)) OR
       (@hor_mie IS NOT NULL AND (@hor_mie < 1 OR @hor_mie > 3)) OR
       (@hor_jue IS NOT NULL AND (@hor_jue < 1 OR @hor_jue > 3)) OR
       (@hor_vie IS NOT NULL AND (@hor_vie < 1 OR @hor_vie > 3)) OR
       (@hor_sab IS NOT NULL AND (@hor_sab < 1 OR @hor_sab > 3)) OR
       (@hor_dom IS NOT NULL AND (@hor_dom < 1 OR @hor_dom > 3))
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error: Las horas de compensación deben estar entre 1 y 3' AS msg
        RETURN
    END

    -- 4. Iniciar transacción
    BEGIN TRAN

    -- 5. Eliminar compensaciones existentes
    DELETE FROM secgen_db.dbo.sg_fuco 
    WHERE id_funprse = @id_funprse

    IF @@error <> 0
    BEGIN
        SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al limpiar compensaciones anteriores' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    -- 6. Insertar los días cuyos parámetros no sean NULL
    DECLARE @insertados int
    SELECT @insertados = 0

    IF @dentro_jor = 'S'
    BEGIN
        IF @hor_lun IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 1, @hor_lun)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Lunes' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
        IF @hor_mar IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 2, @hor_mar)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Martes' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
        IF @hor_mie IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 3, @hor_mie)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Miércoles' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
        IF @hor_jue IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 4, @hor_jue)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Jueves' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
        IF @hor_vie IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 5, @hor_vie)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Viernes' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
        IF @hor_sab IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 6, @hor_sab)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Sábado' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
        IF @hor_dom IS NOT NULL
        BEGIN
            INSERT INTO secgen_db.dbo.sg_fuco (id_funprse, dia_semana, cant_horas) VALUES (@id_funprse, 7, @hor_dom)
            IF @@error <> 0
            BEGIN
                SELECT @id_funprse AS id_funprse, 0 AS registros_insertados, 'Error al guardar compensación de Domingo' AS msg
                IF @@transtate = 2 ROLLBACK TRAN
                RETURN
            END
            SELECT @insertados = @insertados + 1
        END
    END

    -- 7. Confirmar transacción
    COMMIT TRAN
    SELECT @id_funprse AS id_funprse, @insertados AS registros_insertados, 'Compensaciones actualizadas correctamente' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fucouSecgen01 TO UsuaVrac
GO
