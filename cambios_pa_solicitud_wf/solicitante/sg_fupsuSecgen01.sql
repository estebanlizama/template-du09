USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupsuSecgen01')
    DROP PROCEDURE Analisis2.sg_fupsuSecgen01
GO

/* Procedimiento : Analisis2.sg_fupsuSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Opcional)
   @rut                 -> RUT del funcionario. (Opcional)
   @cod_cargo           -> Codigo del cargo. (Opcional)
   @cod_sitm            -> Parametro de entrada. (Opcional)
   @itm_global          -> Parametro de entrada. (Opcional)
   @motivo              -> Parametro de entrada. (Opcional)
   @periodos            -> Parametro de entrada. (Opcional)
   @monto_mes           -> Parametro de entrada. (Obligatorio)
   @mto_total           -> Parametro de entrada. (Obligatorio)
   @cod_moneda          -> Parametro de entrada. (Opcional)
   @cod_tpps            -> Parametro de entrada. (Opcional)
   @f_inicio            -> Parametro de entrada. (Opcional)
   @f_termino           -> Parametro de entrada. (Opcional)
   @dentro_jor          -> Parametro de entrada. (Opcional)
   @cod_contra          -> Parametro de entrada. (Opcional)
   @mes_haber           -> Parametro de entrada. (Opcional)
   @ano_haber           -> Parametro de entrada. (Opcional)
   @mto_haber           -> Parametro de entrada. (Opcional)
   @mto_tope            -> Parametro de entrada. (Opcional)
   @f_cal_tope          -> Parametro de entrada. (Opcional)
   @tot_cuotas          -> Parametro de entrada. (Opcional)
   @cod_estfun          -> Parametro de entrada. (Opcional)
   @rut_visado          -> Parametro de entrada. (Opcional)

   Objetivo : Actualizar datos de un funcionario prestación de servicios (sg_fups), compatible con DU288 y legacy. Entrada       : @id_funprse  int @rut         char(9) @cod_cargo   smallint @cod_sitm    varchar(5) @itm_global  varchar(15) @motivo      varchar(255) @periodos    tinyint @monto_mes   decimal(19,2) @mto_total   decimal(19,2) @cod_moneda  tinyint @dentro_jor  char(1) = NULL (NUEVO DU288) @cod_contra  int = NULL (NUEVO DU288) @mes_haber   tinyint = NULL (NUEVO DU288) @ano_haber   smallint = NULL (NUEVO DU288) @mto_haber   int = NULL (NUEVO DU288) @mto_tope    int = NULL (NUEVO DU288) @f_cal_tope  datetime = NULL (NUEVO DU288) @tot_cuotas  tinyint = NULL (NUEVO DU288)

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fupsuSecgen01
    @id_funprse int = NULL,
    @rut char(9) = NULL,
    @cod_cargo smallint = NULL,
    @cod_sitm varchar(5) = NULL,
    @itm_global varchar(15) = NULL,
    @motivo varchar(255) = NULL,
    @periodos tinyint = NULL,
    @monto_mes decimal(19,2) = NULL,
    @mto_total decimal(19,2) = NULL,
    @cod_moneda tinyint = NULL,
    @cod_tpps smallint = NULL,
    @f_inicio datetime = NULL,
    @f_termino datetime = NULL,
    @dentro_jor char(1) = NULL,
    @cod_contra int = NULL,
    @mes_haber tinyint = NULL,
    @ano_haber smallint = NULL,
    @mto_haber int = NULL,
    @mto_tope int = NULL,
    @f_cal_tope datetime = NULL,
    @tot_cuotas tinyint = NULL,
    @cod_estfun tinyint = NULL,
    @rut_visado char(9) = NULL
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @cod_modprs tinyint
    DECLARE @nro_solici int
    DECLARE @rows_updated int
    DECLARE @err int
    DECLARE @current_estfun tinyint

    SELECT @cod_modprs = isnull(prse.cod_modprs, 1),
           @nro_solici = fu.nro_solici,
           @current_estfun = fu.cod_estfun
    FROM secgen_db.dbo.sg_prse prse
    JOIN sg_fups fu ON prse.nro_solici = fu.nro_solici
    WHERE fu.id_funprse = @id_funprse

    IF @cod_modprs IS NULL
        SELECT @cod_modprs = 1

    IF @id_funprse IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Id Funcionarios prestación de servicios' AS msg
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT 0 AS status, 'STAFF_NOT_FOUND' AS code, 'El funcionario especificado no existe' AS msg
        RETURN
    END

    IF @rut IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo RUT' AS msg
        RETURN
    END

    IF @cod_cargo IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Codigo Cargo' AS msg
        RETURN
    END

    IF @cod_sitm IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Codigo Situacion M' AS msg
        RETURN
    END

    IF @itm_global IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Itm Global' AS msg
        RETURN
    END

    IF @motivo IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_ACTIVITY' AS code, 'Falta campo Motivo' AS msg
        RETURN
    END

    IF @cod_modprs = 2 AND len(ltrim(rtrim(@motivo))) < 10
    BEGIN
        SELECT 0 AS status, 'DU288_INVALID_ACTIVITY' AS code, 'La actividad del funcionario debe tener al menos 10 caracteres' AS msg
        RETURN
    END

    IF @cod_modprs <> 2 AND @periodos IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Periodos' AS msg
        RETURN
    END

    IF @cod_modprs <> 2 AND @monto_mes IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Monto Mensual' AS msg
        RETURN
    END

    IF @mto_total IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Monto Total' AS msg
        RETURN
    END

    IF @cod_moneda IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo Codigo Moneda' AS msg
        RETURN
    END

    -- Validar fechas de inicio y término
    IF @f_inicio IS NOT NULL AND @f_termino IS NOT NULL AND @f_inicio > @f_termino
    BEGIN
        SELECT 0 AS status, 'INVALID_PERIOD' AS code, 'La fecha de inicio no puede ser posterior a la fecha de término' AS msg
        RETURN
    END

    IF @cod_modprs = 2 AND (
        SELECT count(*)
        FROM secgen_db.dbo.sg_fups
        WHERE nro_solici = @nro_solici
    ) <> 1
    BEGIN
        SELECT 0 AS status,
               'DU288_CARDINALITY_INCONSISTENT' AS code,
               'La solicitud DU288 no posee exactamente un funcionario y no puede actualizarse.' AS msg
        RETURN
    END

    BEGIN TRAN

    IF @cod_modprs = 2 AND @cod_estfun IS NOT NULL
    BEGIN
        -- Validar que el estado exista en sg_efun
        IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_efun WHERE cod_estfun = @cod_estfun)
        BEGIN
            SELECT 0 AS status, 'INVALID_STAFF_STATUS' AS code, 'El estado especificado no existe en el catálogo de estados' AS msg
            IF @@transtate <> 0
                ROLLBACK TRAN
            RETURN
        END
    END

    IF @cod_modprs = 2
    BEGIN
        -- Compatibilidad con la BDD vigente: periodos y monto_mes son NOT NULL.
        -- DU288 no los utiliza para crear cuotas; la fuente oficial es @mto_total.
        IF @periodos IS NULL
            SELECT @periodos = 1
        IF @monto_mes IS NULL
            SELECT @monto_mes = @mto_total
        SELECT @tot_cuotas = NULL

        -- Flujo DU288: actualiza todos los campos nuevos
        UPDATE sg_fups
        SET
            rut = @rut,
            cod_cargo = @cod_cargo,
            cod_sitm = @cod_sitm,
            itm_global = @itm_global,
            motivo = @motivo,
            periodos = @periodos,
            monto_mes = @monto_mes,
            mto_total = @mto_total,
            cod_moneda = @cod_moneda,
            cod_tpps = @cod_tpps,
            f_inicio = @f_inicio,
            f_termino = @f_termino,
            dentro_jor = @dentro_jor,
            cod_contra = @cod_contra,
            mes_haber = @mes_haber,
            ano_haber = @ano_haber,
            mto_haber = @mto_haber,
            mto_tope = @mto_tope,
            f_cal_tope = @f_cal_tope,
            tot_cuotas = NULL,
            cod_estfun = isnull(@cod_estfun, cod_estfun)
        WHERE
            id_funprse = @id_funprse

        SELECT @err = @@error, @rows_updated = @@rowcount

        IF @err <> 0
        BEGIN
            SELECT 0 AS status, 'STAFF_UPDATE_ERROR' AS code, 'Error al actualizar registro DU288' AS msg
            IF @@transtate <> 0
                ROLLBACK TRAN
            RETURN
        END

        -- Historizar el cambio de estado si corresponde
        IF @cod_estfun IS NOT NULL AND (isnull(@current_estfun, 0) <> @cod_estfun)
        BEGIN
            INSERT INTO sg_his2 (
                id_funprse,
                f_visacion,
                rut_visado,
                cod_estact,
                cod_estnue
            ) VALUES (
                @id_funprse,
                getdate(),
                isnull(@rut_visado, 'SYSTEM'),
                isnull(@current_estfun, 1),
                @cod_estfun
            )

            IF @@error <> 0
            BEGIN
                SELECT 0 AS status, 'STAFF_HISTORY_ERROR' AS code, 'Error al registrar historial de visación del funcionario (sg_his2)' AS msg
                IF @@transtate <> 0
                    ROLLBACK TRAN
                RETURN
            END
        END


        UPDATE secgen_db.dbo.sg_prse
        SET actividad = @motivo
        WHERE nro_solici = @nro_solici

        IF @@error <> 0 OR @@rowcount <> 1
        BEGIN
            SELECT 0 AS status, 'DU288_ACTIVITY_SYNC_ERROR' AS code, 'No fue posible sincronizar la actividad de la prestacion' AS msg
            IF @@transtate <> 0
                ROLLBACK TRAN
            RETURN
        END
    END
    ELSE
    BEGIN
        -- Flujo Legacy: actualiza unicamente los campos historicos.
        -- Las columnas DU288 quedan fuera del SET.
        UPDATE sg_fups
        SET
            rut = @rut,
            cod_cargo = @cod_cargo,
            cod_sitm = @cod_sitm,
            itm_global = @itm_global,
            motivo = @motivo,
            periodos = @periodos,
            monto_mes = @monto_mes,
            mto_total = @mto_total,
            cod_moneda = @cod_moneda,
            cod_tpps = @cod_tpps,
            f_inicio = @f_inicio,
            f_termino = @f_termino
        WHERE
            id_funprse = @id_funprse

        SELECT @err = @@error, @rows_updated = @@rowcount

        IF @err <> 0
        BEGIN
            SELECT 0 AS status, 'STAFF_UPDATE_ERROR' AS code, 'Error al actualizar registro Legacy' AS msg
            IF @@transtate <> 0
                ROLLBACK TRAN
            RETURN
        END
    END

    IF @rows_updated = 0
    BEGIN
        SELECT 0 AS status, 'STAFF_NOT_UPDATED' AS code, 'No se actualizó ningún registro o no hubo cambios' AS msg
        IF @@transtate <> 0
            ROLLBACK TRAN
        RETURN
    END

    IF @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 0 AS status, 'STAFF_UPDATE_ERROR' AS code, 'Error al actualizar información de validación de proceso. Se aborta el procedimiento' AS msg
        IF @@transtate <> 0
            ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
    SELECT 1 AS status, 'OK' AS code, 'Funcionario actualizado correctamente' AS msg, @id_funprse AS id_funprse
END
GO

GRANT EXECUTE ON Analisis2.sg_fupsuSecgen01 TO UsuaVrac
GO
