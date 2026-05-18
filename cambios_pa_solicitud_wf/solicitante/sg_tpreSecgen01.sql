/* 
Procedimiento : Analisis2.sg_tpreSecgen01
Objetivo     : Obtener el listado maestro de tipos de prestación (Asistencia Técnica, Investigación, etc.)
               para el flujo DU09/Fase 2.
Modificaciones:
- 2026/05/13: Creación inicial siguiendo estándares institucionales de creación de PA.
*/

CREATE PROCEDURE Analisis2.sg_tpreSecgen01
    @id_tpre tinyint = NULL -- Opcional: Filtrar por un tipo específico
AS
BEGIN
    SELECT 
        id_tpre,
        des_tpre
    FROM 
        secgen_db.dbo.sg_tpre
    WHERE 
        (@id_tpre IS NULL OR id_tpre = @id_tpre)
    ORDER BY 
        id_tpre ASC
END
