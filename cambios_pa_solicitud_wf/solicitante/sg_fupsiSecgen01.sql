USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupsiSecgen01')
    DROP PROCEDURE Analisis2.sg_fupsiSecgen01
GO

/* Procedimiento : Analisis2.sg_fupsiSecgen01
   Objetivo      : Insertar funcionarios prestación de servicios (sg_fups), compatible con DU288 y flujo legacy.
   Entrada       :
       @nro_solici  int
       @rut         char(9)
       @cod_cargo   smallint
       @cod_sitm    varchar(5)
       @itm_global  varchar(15)
       @motivo      varchar(255)
       @periodos    tinyint
       @monto_mes   decimal(19,2)
       @mto_total   decimal(19,2)
       @cod_moneda  tinyint
       @cod_tpps    smallint (Legacy)
       @f_inicio    datetime (Legacy)
       @f_termino   datetime (Legacy)
       @cod_modprs  tinyint = 1 (Modalidad)
       @dentro_jor  char(1) = NULL (NUEVO DU288)
       @cod_contra  int = NULL (NUEVO DU288)
       @mes_haber   tinyint = NULL (NUEVO DU288)
       @ano_haber   smallint = NULL (NUEVO DU288)
       @mto_haber   int = NULL (NUEVO DU288)
       @mto_tope    int = NULL (NUEVO DU288)
       @f_cal_tope  datetime = NULL (NUEVO DU288)
       @tot_cuotas  tinyint = NULL (NUEVO DU288)
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
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Numero Solicitud' AS msg
        RETURN
    END

    IF @rut IS NULL
    BEGIN
        SELECT 'Falta campo RUT' AS msg
        RETURN
    END

    IF @cod_cargo IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Cargo' AS msg
        RETURN
    END

    IF @cod_sitm IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Situacion M' AS msg
        RETURN
    END

    IF @itm_global IS NULL
    BEGIN
        SELECT 'Falta campo Itm Global' AS msg
        RETURN
    END

    IF @motivo IS NULL
    BEGIN
        SELECT 'Falta campo Motivo' AS msg
        RETURN
    END

    IF @periodos IS NULL
    BEGIN
        SELECT 'Falta campo Periodos' AS msg
        RETURN
    END

    IF @monto_mes IS NULL
    BEGIN
        SELECT 'Falta campo Monto Mensual' AS msg
        RETURN
    END

    IF @mto_total IS NULL
    BEGIN
        SELECT 'Falta campo Monto Total' AS msg
        RETURN
    END

    IF @cod_moneda IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Moneda' AS msg
        RETURN
    END

    IF @cod_tpps IS NULL
    BEGIN
        SELECT 'Falta campo tipo de periodo' AS msg
        RETURN
    END

    IF @f_inicio IS NULL
    BEGIN
        SELECT 'Falta campo fecha de inicio' AS msg
        RETURN
    END

    IF @f_termino IS NULL
    BEGIN
        SELECT 'Falta campo fecha de término' AS msg
        RETURN
    END

    -- Validar fechas de inicio y término
    IF @f_inicio > @f_termino
    BEGIN
        SELECT 'La fecha de inicio no puede ser posterior a la fecha de término' AS msg
        RETURN
    END

    -- Resolver la modalidad desde sg_prse
    DECLARE @resolved_modprs tinyint
    SELECT @resolved_modprs = cod_modprs
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF @resolved_modprs IS NOT NULL
        SELECT @cod_modprs = @resolved_modprs
    ELSE
    BEGIN
        IF @cod_modprs IS NULL
            SELECT @cod_modprs = 1
    END

    -- Determinar el estado del funcionario (por defecto 1 para DU288 si es NULL)
    IF @cod_modprs = 2
    BEGIN
        IF @cod_estfun IS NULL
            SELECT @cod_estfun = 1

        -- Validar que el estado exista en sg_efun
        IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_efun WHERE cod_estfun = @cod_estfun)
        BEGIN
            SELECT 'El estado especificado no existe en el catálogo de estados' AS msg
            RETURN
        END

    END
    ELSE
    BEGIN
        -- Para legacy, no debe guardarse estado
        SELECT @cod_estfun = NULL
    END

    BEGIN TRAN

    DECLARE @id_funprse int
    SELECT @id_funprse = max(ultimo_id) FROM secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_fups'
    SELECT @id_funprse = isnull(@id_funprse, 0) + 1

    UPDATE secgen_db..sg_parm
    SET ultimo_id = @id_funprse
    WHERE nom_tabla LIKE 'sg_fups'

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al actualizar correlativo. Se aborta el procedimiento' AS msg
        IF @@transtate = 2
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
        SELECT 'Error al actualizar información de validación de proceso. Se aborta el procedimiento' AS msg
        IF @@transtate = 2
            ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
    SELECT 'Funcionario insertado correctamente' AS msg, @id_funprse AS id_funprse
END
GO

GRANT EXECUTE ON Analisis2.sg_fupsiSecgen01 TO UsuaVrac
GO
