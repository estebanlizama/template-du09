/* 
Procedimiento : Analisis2.sg_tevidSecgen01
Objetivo     : Obtener el listado maestro de tipos de evidencias o productos entregables.
Modificaciones:
- 2026/05/13: Creación inicial para alimentar el checklist de evidencias del Paso 4.
*/

CREATE PROCEDURE Analisis2.sg_tevidSecgen01
    @id_tevid tinyint = NULL -- Opcional: Filtrar por un tipo específico
AS
BEGIN
    SELECT 
        id_tevid,
        des_tevid
    FROM 
        secgen_db.dbo.sg_tevid
    WHERE 
        (@id_tevid IS NULL OR id_tevid = @id_tevid)
    ORDER BY 
        id_tevid ASC
END
