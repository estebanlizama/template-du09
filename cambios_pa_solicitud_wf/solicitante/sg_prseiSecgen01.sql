USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_prseiSecgen01')
    DROP PROCEDURE Analisis2.sg_prseiSecgen01
GO

/* 
Procedimiento : Analisis2.sg_prseiSecgen01
Objetivo     : Insertar la información técnica y financiera de una solicitud de PDS.
               Modificado para Fase 2 (DU09) incorporando id_modprse.
Entrada      : 
    @nro_solici -> Número único de solicitud (FK sg_soli).
    @actividad  -> Descripción de la actividad técnica.
    @per_desde  -> Fecha inicio ejecución.
    @per_hasta  -> Fecha término ejecución.
    @rut_jefpro -> RUT del responsable técnico.
    @cod_unifin -> Unidad Financiera.
    @cod_ccto   -> Centro de Costo.
    @cc_global  -> Centro de Costo Global (DU09).
    @pry_global -> Proyecto Global (DU09).
    @id_modprse -> Tipo de flujo (1: Docentes Especiales, 2: Fase 2 DU09).
Creación     : 2022/12/13 (CHL)
Actualización: 2026/05/14 (Modificado para Fase 2)
*/

CREATE PROCEDURE Analisis2.sg_prseiSecgen01
    @nro_solici int = NULL,
    @actividad varchar(255) = NULL,
    @per_desde datetime = NULL,
    @per_hasta datetime = NULL,
    @rut_jefpro char(9) = NULL,
    @cod_unifin smallint = NULL,
    @cod_ccto smallint = NULL,
    @cc_global varchar(9) = NULL,
    @pry_global varchar(12) = NULL,
    @id_modprse tinyint = 1 
AS
BEGIN
    -- 1. Validaciones de Parámetros
    IF @nro_solici IS NULL OR @actividad IS NULL OR @per_desde IS NULL OR @per_hasta IS NULL OR @rut_jefpro IS NULL
    BEGIN
        SELECT 'Error: Faltan campos obligatorios para insertar el detalle de la solicitud' msg
        RETURN
    END

    -- 2. Transacción para asegurar consistencia
    BEGIN TRAN

    -- 2.1 Actualización de Correlativo (Estándar UFRO en sg_parm)
    DECLARE @id_regtra int
    SELECT @id_regtra = max(ultimo_id) FROM secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_prse'
    SELECT @id_regtra = isnull(@id_regtra, 0) + 1

    UPDATE secgen_db..sg_parm
    SET ultimo_id = @id_regtra
    WHERE nom_tabla LIKE 'sg_prse'

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al actualizar correlativo en sg_parm para sg_prse' msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    -- 2.2 Inserción de Datos
    INSERT INTO sg_prse (
        nro_solici,
        actividad,
        per_desde,
        per_hasta,
        rut_jefpro,
        cod_unifin,
        cod_ccto,
        cc_global,
        pry_global,
        id_modprse
    ) VALUES (
        @nro_solici,
        @actividad,
        @per_desde,
        @per_hasta,
        @rut_jefpro,
        @cod_unifin,
        @cod_ccto,
        @cc_global,
        @pry_global,
        @id_modprse
    )

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al insertar registro en sg_prse para solicitud ' + convert(varchar, @nro_solici) msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_prseiSecgen01 TO UsuaVrac
GO
