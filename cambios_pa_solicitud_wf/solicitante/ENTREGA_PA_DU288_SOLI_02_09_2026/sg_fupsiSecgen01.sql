USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fupsiSecgen01'
)
    DROP PROCEDURE Analisis2.sg_fupsiSecgen01
GO

/* Procedimiento : Analisis2.sg_fupsiSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @rut                 -> RUT del funcionario. (Opcional)
   @cod_cargo           -> Codigo del cargo. (Opcional)
   @cod_sitm            -> Parametro de entrada. (Opcional)
   @itm_global          -> Parametro de entrada. (Opcional)
   @motivo              -> Parametro de entrada. (Opcional)
   @periodos            -> Parametro de entrada. (Opcional)
   @monto_mes           -> Parametro de entrada. (Opcional)
   @mto_total           -> Parametro de entrada. (Opcional)
   @cod_moneda          -> Parametro de entrada. (Opcional)
   @cod_tpps            -> Parametro de entrada. (Opcional)
   @f_inicio            -> Parametro de entrada. (Opcional)
   @f_termino           -> Parametro de entrada. (Opcional)
   @cod_modprs          -> Parametro de entrada. (Opcional)
   @dentro_jor          -> Parametro de entrada. (Opcional)
   @cod_contra          -> Parametro de entrada. (Opcional)
   @mes_haber           -> Parametro de entrada. (Opcional)
   @ano_haber           -> Parametro de entrada. (Opcional)
   @mto_haber           -> Parametro de entrada. (Opcional)
   @mto_tope            -> Parametro de entrada. (Opcional)
   @f_cal_tope          -> Parametro de entrada. (Opcional)
   @tot_cuotas          -> Parametro de entrada. (Opcional)
   @cod_estfun          -> Parametro de entrada. (Opcional)

   Objetivo : Registrar un funcionario asociado a una prestacion de servicios,
              compatible con DU288 y el flujo legado.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fupsiSecgen01
    @nro_solici int = NULL,
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
    @cod_modprs tinyint = NULL,
    @dentro_jor char(1) = NULL,
    @cod_contra int = NULL,
    @mes_haber tinyint = NULL,
    @ano_haber smallint = NULL,
    @mto_haber int = NULL,
    @mto_tope int = NULL,
    @f_cal_tope datetime = NULL,
    @tot_cuotas tinyint = NULL,
    @cod_estfun tinyint = NULL
AS
BEGIN
    SET NOCOUNT ON

    -- La modalidad persistida en sg_prse es la fuente de verdad.
    DECLARE @resolved_modprs tinyint
    SELECT @resolved_modprs = cod_modprs
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF @resolved_modprs IS NOT NULL
        SELECT @cod_modprs = @resolved_modprs
    ELSE IF @cod_modprs IS NULL
        SELECT @cod_modprs = 1

    IF @nro_solici IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_REQUEST' AS code, 'Falta campo Numero Solicitud' AS msg
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

    IF @cod_tpps IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo tipo de periodo' AS msg
        RETURN
    END

    IF @f_inicio IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo fecha de inicio' AS msg
        RETURN
    END

    IF @f_termino IS NULL
    BEGIN
        SELECT 0 AS status, 'INVALID_STAFF' AS code, 'Falta campo fecha de término' AS msg
        RETURN
    END

    -- Validar fechas de inicio y término
    IF @f_inicio > @f_termino
    BEGIN
        SELECT 0 AS status, 'INVALID_PERIOD' AS code, 'La fecha de inicio no puede ser posterior a la fecha de término' AS msg
        RETURN
    END

    -- Determinar el estado del funcionario (por defecto 1 para DU288 si es NULL)
    IF @cod_modprs = 2
    BEGIN
        -- Compatibilidad con la BDD vigente: periodos y monto_mes son NOT NULL.
        -- DU288 no los utiliza para crear cuotas; la fuente oficial es @mto_total.
        IF @periodos IS NULL
            SELECT @periodos = 1
        IF @monto_mes IS NULL
            SELECT @monto_mes = @mto_total
        SELECT @tot_cuotas = NULL

        IF @cod_estfun IS NULL
            SELECT @cod_estfun = 1

        -- Validar que el estado exista en sg_efun
        IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_efun WHERE cod_estfun = @cod_estfun)
        BEGIN
            SELECT 0 AS status, 'INVALID_STAFF_STATUS' AS code, 'El estado especificado no existe en el catálogo de estados' AS msg
            RETURN
        END

    END
    ELSE
    BEGIN
        -- Para legacy, no debe guardarse estado
        SELECT @cod_estfun = NULL
    END

    DECLARE @id_funprse int

    BEGIN TRAN

    -- Serializa la comprobacion y asignacion sin consumir el correlativo al rechazar.
    SELECT @id_funprse = max(ultimo_id)
    FROM secgen_db..sg_parm HOLDLOCK
    WHERE nom_tabla LIKE 'sg_fups'

    IF @cod_modprs = 2 AND EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fups
        WHERE nro_solici = @nro_solici
    )
    BEGIN
        ROLLBACK TRAN
        SELECT 0 AS status,
               'DU288_STAFF_LIMIT' AS code,
               'La solicitud DU288 ya posee un funcionario. Debe actualizar el registro existente.' AS msg
        RETURN
    END

    SELECT @id_funprse = isnull(@id_funprse, 0) + 1

    UPDATE secgen_db..sg_parm
    SET ultimo_id = @id_funprse
    WHERE nom_tabla LIKE 'sg_fups'

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 0 AS status, 'CORRELATIVE_ERROR' AS code, 'Error al actualizar correlativo. Se aborta el procedimiento' AS msg
        IF @@transtate <> 0
            ROLLBACK TRAN
        RETURN
    END

    -- Bifurcación según la modalidad
    IF @cod_modprs = 2
    BEGIN
        -- Flujo DU288: incluye todos los campos nuevos
        INSERT INTO sg_fups (
            id_funprse,
            nro_solici,
            rut,
            cod_cargo,
            cod_sitm,
            itm_global,
            motivo,
            periodos,
            monto_mes,
            mto_total,
            cod_moneda,
            cod_tpps,
            f_inicio,
            f_termino,
            cod_estfun,
            dentro_jor,
            cod_contra,
            mes_haber,
            ano_haber,
            mto_haber,
            mto_tope,
            f_cal_tope,
            tot_cuotas
        ) VALUES (
            @id_funprse,
            @nro_solici,
            @rut,
            @cod_cargo,
            @cod_sitm,
            @itm_global,
            @motivo,
            @periodos,
            @monto_mes,
            @mto_total,
            @cod_moneda,
            @cod_tpps,
            @f_inicio,
            @f_termino,
            @cod_estfun,
            @dentro_jor,
            @cod_contra,
            @mes_haber,
            @ano_haber,
            @mto_haber,
            @mto_tope,
            @f_cal_tope,
            @tot_cuotas
        )
    END
    ELSE
    BEGIN
        -- Flujo Legacy: mantiene estructura original de inserción
        INSERT INTO sg_fups (
            id_funprse,
            nro_solici,
            rut,
            cod_cargo,
            cod_sitm,
            itm_global,
            motivo,
            periodos,
            monto_mes,
            mto_total,
            cod_moneda,
            cod_tpps,
            f_inicio,
            f_termino
        ) VALUES (
            @id_funprse,
            @nro_solici,
            @rut,
            @cod_cargo,
            @cod_sitm,
            @itm_global,
            @motivo,
            @periodos,
            @monto_mes,
            @mto_total,
            @cod_moneda,
            @cod_tpps,
            @f_inicio,
            @f_termino
        )
    END

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 0 AS status, 'STAFF_INSERT_ERROR' AS code, 'Error al actualizar información de validación de proceso. Se aborta el procedimiento' AS msg
        IF @@transtate <> 0
            ROLLBACK TRAN
        RETURN
    END

    IF @cod_modprs = 2
    BEGIN
        UPDATE secgen_db.dbo.sg_prse
        SET actividad = @motivo
        WHERE nro_solici = @nro_solici

        IF @@error <> 0 OR @@rowcount <> 1 OR @@transtate = 2 OR @@transtate = 3
        BEGIN
            SELECT 0 AS status, 'DU288_ACTIVITY_SYNC_ERROR' AS code, 'No fue posible sincronizar la actividad de la prestacion' AS msg
            IF @@transtate <> 0
                ROLLBACK TRAN
            RETURN
        END
    END

    COMMIT TRAN
    SELECT 1 AS status, 'OK' AS code, 'Funcionario insertado correctamente' AS msg, @id_funprse AS id_funprse
END
GO

GRANT EXECUTE ON Analisis2.sg_fupsiSecgen01 TO UsuaVrac
GO
