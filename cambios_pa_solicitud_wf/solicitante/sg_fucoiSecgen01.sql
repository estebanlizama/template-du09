USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_fucoiSecgen01')
    DROP PROCEDURE Analisis2.sg_fucoiSecgen01
GO

/* 
Procedimiento : Analisis2.sg_fucoiSecgen01
Objetivo     : Registrar la compensación horaria para un funcionario trabajando dentro de jornada.
               Exigencia legal DU09 para trazabilidad ante Contraloría.
Entrada      : 
    @id_funprse -> FK funcionario (sg_fups).
    @dia_semana -> 1=Lunes, 2=Martes, 3=Miércoles, 4=Jueves, 5=Viernes, 6=Sábado.
    @can_horas  -> Cantidad de horas (formato decimal ej: 1.5).
Creación     : 2026/05/14
*/

CREATE PROCEDURE Analisis2.sg_fucoiSecgen01
    @id_funprse int = NULL,
    @dia_semana tinyint = NULL,
    @can_horas decimal(4,2) = NULL
AS
BEGIN
    -- 1. Validaciones
    IF @id_funprse IS NULL OR @dia_semana IS NULL OR @can_horas IS NULL
    BEGIN
        SELECT 'Error: Faltan datos obligatorios para compensación horaria' msg
        RETURN
    END

    -- 2. Integridad Referencial
    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_fups WHERE id_funprse = @id_funprse)
    BEGIN
        SELECT 'Error: El ID de funcionario ' + convert(varchar, @id_funprse) + ' no existe' msg
        RETURN
    END

    -- 3. Transacción
    BEGIN TRAN

    INSERT INTO secgen_db.dbo.sg_fuco (
        id_funprse,
        dia_semana,
        can_horas
    ) VALUES (
        @id_funprse,
        @dia_semana,
        @can_horas
    )

    IF @@error <> 0 OR @@transtate = 2 OR @@transtate = 3
    BEGIN
        SELECT 'Error al registrar compensación horaria para id_funprse ' + convert(varchar, @id_funprse) msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
END
GO

GRANT EXECUTE ON Analisis2.sg_fucoiSecgen01 TO UsuaVrac
GO
