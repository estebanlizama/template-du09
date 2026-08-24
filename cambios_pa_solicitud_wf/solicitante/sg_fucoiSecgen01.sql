USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fucoiSecgen01')
    DROP PROCEDURE Analisis2.sg_fucoiSecgen01
GO

/*
    Entrada  :
    
    Salida   :

    Objetivo : Insertar o registrar compromisos horarios de un funcionario
    Creacion : ELA 2026/08/24
    Modificacion :
*/
CREATE PROCEDURE Analisis2.sg_fucoiSecgen01
    @id_funprse int = NULL,
    @fec_compro datetime = NULL,
    @hora_ini time = NULL,
    @hora_ter time = NULL
AS
BEGIN
    DECLARE @cod_modprs tinyint
    DECLARE @dentro_jor char(1)
    DECLARE @f_inicio datetime
    DECLARE @f_termino datetime
    DECLARE @fecha_base datetime
    DECLARE @inicio_dt datetime
    DECLARE @termino_dt datetime

    IF @id_funprse IS NULL OR @fec_compro IS NULL
       OR @hora_ini IS NULL OR @hora_ter IS NULL
    BEGIN
        SELECT 'Error: Datos de compensacion incompletos' AS msg
        RETURN
    END

    SELECT
        @cod_modprs = isnull(prse.cod_modprs, 1),
        @dentro_jor = isnull(fu.dentro_jor, 'N'),
        @f_inicio = fu.f_inicio,
        @f_termino = fu.f_termino
    FROM secgen_db.dbo.sg_prse prse,
         secgen_db.dbo.sg_fups fu
    WHERE prse.nro_solici = fu.nro_solici
      AND fu.id_funprse = @id_funprse

    IF @cod_modprs IS NULL OR @cod_modprs <> 2
    BEGIN
        SELECT 'Error: El funcionario no corresponde a la modalidad DU288' AS msg
        RETURN
    END

    IF @dentro_jor NOT IN ('S', 'D')
    BEGIN
        SELECT 'Error: El funcionario no requiere compensacion horaria' AS msg
        RETURN
    END

    IF @hora_ter = @hora_ini
    BEGIN
        SELECT 'Error: Las horas de inicio y termino deben ser distintas' AS msg
        RETURN
    END

    /*
       fec_compro conserva la fecha y hora real de inicio. Si hora_ter es
       menor que hora_ini, el termino corresponde al dia siguiente.
    */
    SELECT @fecha_base = dateadd(
        day,
        datediff(day, convert(datetime, '19000101'), @fec_compro),
        convert(datetime, '19000101')
    )
    SELECT @inicio_dt = dateadd(
        minute,
        datepart(hh, @hora_ini) * 60 + datepart(mi, @hora_ini),
        @fecha_base
    )
    SELECT @termino_dt = dateadd(
        minute,
        datepart(hh, @hora_ter) * 60 + datepart(mi, @hora_ter),
        @fecha_base
    )
    IF @hora_ter < @hora_ini
        SELECT @termino_dt = dateadd(day, 1, @termino_dt)

    IF @f_inicio IS NULL OR @f_termino IS NULL
       OR datediff(day, @f_inicio, @inicio_dt) < 0
       OR datediff(day, @termino_dt, @f_termino) < 0
    BEGIN
        SELECT 'Error: La compensacion esta fuera del periodo autorizado' AS msg
        RETURN
    END

    /* Rechazar duplicados y traslapes, incluso entre fechas consecutivas. */
    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fuco fc
        WHERE fc.id_funprse = @id_funprse
          AND @inicio_dt < dateadd(
                day,
                CASE WHEN fc.hora_ter < fc.hora_ini THEN 1 ELSE 0 END,
                dateadd(
                    minute,
                    datepart(hh, fc.hora_ter) * 60 + datepart(mi, fc.hora_ter),
                    dateadd(
                        day,
                        datediff(day, convert(datetime, '19000101'), fc.fec_compro),
                        convert(datetime, '19000101')
                    )
                )
              )
          AND dateadd(
                minute,
                datepart(hh, fc.hora_ini) * 60 + datepart(mi, fc.hora_ini),
                dateadd(
                    day,
                    datediff(day, convert(datetime, '19000101'), fc.fec_compro),
                    convert(datetime, '19000101')
                )
              ) < @termino_dt
    )
    BEGIN
        SELECT 'Error: El tramo de compensacion esta duplicado o superpuesto' AS msg
        RETURN
    END

    INSERT INTO secgen_db.dbo.sg_fuco
        (id_funprse, fec_compro, hora_ini, hora_ter)
    VALUES
        (@id_funprse, @inicio_dt, @hora_ini, @hora_ter)

    IF @@error <> 0
    BEGIN
        SELECT 'Error: No fue posible guardar el tramo de compensacion' AS msg
        RETURN
    END

    SELECT 'OK' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_fucoiSecgen01 TO UsuaVrac
GO
