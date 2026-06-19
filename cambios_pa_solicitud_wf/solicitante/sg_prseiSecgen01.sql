USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_prseiSecgen01')
    DROP PROCEDURE Analisis2.sg_prseiSecgen01
GO

/*
Procedimiento : Analisis2.sg_prseiSecgen01
Objetivo      : Insertar la cabecera especifica de una Prestacion de Servicios
                en sg_prse, incluyendo la modalidad de prestacion.
Parametros    :
    @nro_solici  int          : Numero de solicitud.
    @actividad   varchar(255) : Actividad o servicio a realizar.
    @per_desde   datetime     : Fecha inicio del periodo de prestacion.
    @per_hasta   datetime     : Fecha termino del periodo de prestacion.
    @rut_jefpro  char(9)      : RUT jefe de proyecto.
    @cod_unifin  smallint     : Codigo unidad financiera.
    @cod_ccto    smallint     : Codigo centro de costo.
    @cc_global   varchar(9)   : Centro de costo global, si aplica.
    @pry_global  varchar(12)  : Proyecto global, si aplica.
    @cod_modprs  tinyint      : Modalidad PDS. 1 legacy, 2 DU288-D09/2026.
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
    @cod_modprs tinyint = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Numero Solicitud' msg
        RETURN
    END

    IF @actividad IS NULL OR ltrim(rtrim(@actividad)) = ''
    BEGIN
        SELECT 'Falta campo Actividad' msg
        RETURN
    END

    IF @per_desde IS NULL
    BEGIN
        SELECT 'Falta campo Periodo Desde' msg
        RETURN
    END

    IF @per_hasta IS NULL
    BEGIN
        SELECT 'Falta campo Periodo Hasta' msg
        RETURN
    END

    IF @per_desde > @per_hasta
    BEGIN
        SELECT 'Periodo Desde no puede ser mayor a Periodo Hasta' msg
        RETURN
    END

    IF @rut_jefpro IS NULL OR ltrim(rtrim(@rut_jefpro)) = ''
    BEGIN
        SELECT 'Falta campo RUT jefe Prestacion de Servicio' msg
        RETURN
    END

    IF @cod_unifin IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Unidad Fin' msg
        RETURN
    END

    IF @cod_ccto IS NULL
    BEGIN
        SELECT 'Falta campo Codigo Cuenta' msg
        RETURN
    END

    IF @cod_modprs IS NULL
        SELECT @cod_modprs = 1

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_tmod
        WHERE cod_modprs = @cod_modprs
    )
    BEGIN
        SELECT 'Modalidad de prestacion no existe en sg_tmod' msg
        RETURN
    END

    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_prse
        WHERE nro_solici = @nro_solici
    )
    BEGIN
        SELECT 'Ya existe prestacion de servicios para la solicitud indicada' msg
        RETURN
    END

    BEGIN TRAN

    INSERT INTO secgen_db.dbo.sg_prse (
        nro_solici,
        actividad,
        per_desde,
        per_hasta,
        rut_jefpro,
        cod_unifin,
        cod_ccto,
        cc_global,
        pry_global,
        cod_modprs
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
        @cod_modprs
    )

    IF @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al insertar prestacion de servicios. Se aborta el procedimiento' msg
        IF @@transtate = 2
            ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_prseiSecgen01 TO UsuaVrac
GO
