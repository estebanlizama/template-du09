USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_eapriSecgen01'
)
    DROP PROCEDURE Analisis2.sg_eapriSecgen01
GO

/*
Procedimiento : Analisis2.sg_eapriSecgen01
Objetivo      : Asegurar el estado tecnico usado para cerrar tareas pendientes
                hermanas cuando una etapa paralela se rechaza o devuelve.

Uso           : Ejecutar una vez durante el despliegue, antes de habilitar el
                motor DU288. No se ejecuta al procesar solicitudes.
*/
CREATE PROCEDURE Analisis2.sg_eapriSecgen01
AS
BEGIN
    DECLARE @descripcion varchar(30)
    DECLARE @error int

    SELECT @descripcion = des_estapr
    FROM secgen_db.dbo.sg_eapr
    WHERE cod_estapr = 11

    IF @descripcion IS NOT NULL
    BEGIN
        IF upper(ltrim(rtrim(@descripcion))) <> 'CANCELADA POR CIERRE ETAPA'
        BEGIN
            SELECT 0 AS status, 11 AS cod_estapr, 0 AS filas_insertadas,
                   'El codigo 11 ya existe con otro significado' AS mensaje
            RETURN
        END

        SELECT 1 AS status, 11 AS cod_estapr, 0 AS filas_insertadas,
               'El estado tecnico ya se encontraba configurado' AS mensaje
        RETURN
    END

    INSERT INTO secgen_db.dbo.sg_eapr (cod_estapr, des_estapr)
    VALUES (11, 'CANCELADA POR CIERRE ETAPA')

    SELECT @error = @@error

    IF @error <> 0
    BEGIN
        SELECT 0 AS status, 11 AS cod_estapr, 0 AS filas_insertadas,
               'No fue posible crear el estado tecnico' AS mensaje
        RETURN
    END

    SELECT 1 AS status, 11 AS cod_estapr, 1 AS filas_insertadas,
           'Estado tecnico configurado correctamente' AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_eapriSecgen01 TO UsuaVrac
GO
