USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_prtpiSecgen01')
    DROP PROCEDURE Analisis2.sg_prtpiSecgen01
GO

/* 
Procedimiento : Analisis2.sg_prtpiSecgen01
Objetivo     : Insertar la relación entre una solicitud y sus tipos de prestación (N:M).
               Permite la selección múltiple de naturalezas de servicio (Paso 4).
Entrada      : 
    @nro_solici    -> Número de la solicitud madre (sg_soli).
    @id_tpre       -> ID del catálogo de naturalezas (sg_tpre).
    @des_especifica -> Descripción manual si el tipo es 'Otro'.
Creación     : 2026/05/14
Actualización: -
*/

CREATE PROCEDURE Analisis2.sg_prtpiSecgen01
    @nro_solici int = NULL,
    @id_tpre smallint = NULL,
    @des_especifica varchar(255) = NULL
AS
BEGIN
    -- 1. Validaciones Iniciales
    IF @nro_solici IS NULL OR @id_tpre IS NULL
    BEGIN
        SELECT 'Error: Faltan campos obligatorios (Solicitud o Tipo de Prestación)' msg
        RETURN
    END

    -- 2. Validación de Integridad Referencial
    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_prse WHERE nro_solici = @nro_solici)
    BEGIN
        SELECT 'Error: La solicitud ' + convert(varchar, @nro_solici) + ' no existe en el detalle (sg_prse)' msg
        RETURN
    END

    -- 3. Transaccionalidad
    BEGIN TRAN

    INSERT INTO secgen_db.dbo.sg_prtp (
        nro_solici,
        id_tpre,
        des_especifica
    ) VALUES (
        @nro_solici,
        @id_tpre,
        @des_especifica
    )

    -- Manejo de Errores de Inserción
    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al insertar tipo de prestación para solicitud ' + convert(varchar, @nro_solici) msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_prtpiSecgen01 TO UsuaVrac
GO
