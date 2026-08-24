USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_prseiSecgen01')
    DROP PROCEDURE Analisis2.sg_prseiSecgen01
GO

/* Procedimiento : Analisis2.sg_prseiSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @actividad           -> Parametro de entrada. (Opcional)
   @per_desde           -> Parametro de entrada. (Opcional)
   @per_hasta           -> Parametro de entrada. (Opcional)
   @rut_jefpro          -> Parametro de entrada. (Opcional)
   @cod_unifin          -> Unidad financiera. (Opcional)
   @cod_ccto            -> Centro de costo. (Opcional)
   @cc_global           -> Parametro de entrada. (Opcional)
   @pry_global          -> Parametro de entrada. (Opcional)
   @cod_modprs          -> Parametro de entrada. (Opcional)

   Objetivo : Insertar la cabecera especifica de una Prestacion de Servicios en sg_prse, incluyendo la modalidad de prestacion.

   Creacion: Sin registro
   Actualizacion: Sin registro
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
        SELECT 'Modalidad de prestacion no existe' msg
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
