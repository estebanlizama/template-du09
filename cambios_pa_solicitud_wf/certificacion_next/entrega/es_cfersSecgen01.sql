USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'es_cfersSecgen01'
)
    DROP PROCEDURE Analisis2.es_cfersSecgen01
GO

/* Procedimiento : Analisis2.es_cfersSecgen01

   Entrada :
   @f_inicio           -> Fecha inicial del periodo. (Obligatorio)
   @f_termino          -> Fecha final del periodo. (Obligatorio)

   Objetivo : Obtener feriados y fechas institucionales de un periodo

   Creacion: ELA 2026/09/08
   Actualizacion: ELA 2026/09/08 - Catalogo de tipos integrado
*/
CREATE PROCEDURE Analisis2.es_cfersSecgen01
    @f_inicio datetime = NULL,
    @f_termino datetime = NULL
AS
BEGIN
    SET NOCOUNT ON

    IF @f_inicio IS NULL OR @f_termino IS NULL
       OR datediff(day, @f_inicio, @f_termino) < 0
    BEGIN
        SELECT 'Error: El periodo del calendario institucional no es valido' AS msg
        RETURN
    END

    SELECT
        c.f_feriado,
        c.cod_tipfer,
        CASE c.cod_tipfer
            WHEN 1 THEN 'Feriado nacional'
            WHEN 2 THEN 'Feriado universitario'
            WHEN 3 THEN 'Suspension de actividades lectivas'
            ELSE 'Tipo no informado'
        END AS des_tipfer
    FROM ufro_db.dbo.es_cfer c
    WHERE datediff(day, @f_inicio, c.f_feriado) >= 0
      AND datediff(day, c.f_feriado, @f_termino) >= 0
      AND c.cod_tipfer IN (1, 2, 3)
    ORDER BY c.f_feriado, c.cod_tipfer
END
GO

GRANT EXECUTE ON Analisis2.es_cfersSecgen01 TO UsuaVrac
GO
