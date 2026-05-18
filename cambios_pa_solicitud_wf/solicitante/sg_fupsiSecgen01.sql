USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_fupsiSecgen01')
    DROP PROCEDURE Analisis2.sg_fupsiSecgen01
GO

/* 
Procedimiento : Analisis2.sg_fupsiSecgen01
Objetivo     : Insertar un funcionario (Staff) vinculado a una solicitud de PDS.
               Modificado para Fase 2 (DU09) incorporando control de jornada.
Entrada      : 
    @nro_solici    -> Número de la solicitud madre.
    @rut           -> RUT del funcionario.
    @cod_cargo     -> Código del cargo institucional.
    @cod_sitm      -> Situación presupuestaria.
    @itm_global    -> Ítem presupuestario global (DU09).
    @motivo        -> Actividad específica o motivo.
    @periodos      -> Cantidad total de periodos (meses).
    @monto_mes     -> Monto bruto mensual.
    @mto_total     -> Monto bruto total de la prestación.
    @cod_moneda    -> Tipo de moneda (1: CLP).
    @cod_tpps      -> Tipo de periodo.
    @f_inicio      -> Fecha inicio contrato prestación.
    @f_termino     -> Fecha término contrato prestación.
    @ind_dentro_jor -> Modalidad: 'S' (Dentro de jornada), 'N' (Fuera de jornada).
Creación     : 2024/08/29 (ELA)
Actualización: 2026/05/14 (Modificado para Fase 2 - DU09)
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
    @cod_tpps smallint= NULL,
    @f_inicio datetime = NULL,
    @f_termino datetime = NULL,
    @ind_dentro_jor char(1) = 'N'
AS
BEGIN
    -- 1. Validaciones
    IF @nro_solici IS NULL OR @rut IS NULL OR @cod_cargo IS NULL OR @f_inicio IS NULL OR @f_termino IS NULL
    BEGIN
        SELECT 'Error: Faltan campos obligatorios para registrar al funcionario en la solicitud' msg
        RETURN
    END

    -- 2. Transacción
    BEGIN TRAN

    -- 2.1 Actualización de Correlativo en sg_parm para sg_fups
    DECLARE @id_funprse int
    SELECT @id_funprse = max(ultimo_id) FROM secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_fups'
    SELECT @id_funprse = isnull(@id_funprse, 0) + 1

    UPDATE secgen_db..sg_parm
    SET ultimo_id = @id_funprse
    WHERE nom_tabla LIKE 'sg_fups'

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al actualizar correlativo en sg_parm para sg_fups' msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    -- 2.2 Inserción de Datos Staff
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
        ind_dentro_jor
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
        @ind_dentro_jor
    )

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al insertar registro en sg_fups para funcionario ' + @rut msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    -- 3. Retornar el ID generado (Es vital para los satélites sg_fume, sg_fuco, sg_fuev)
    SELECT @id_funprse as id_funprse

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_fupsiSecgen01 TO UsuaVrac
GO
