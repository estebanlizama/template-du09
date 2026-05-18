/* 
Procedimiento : Analisis2.sg_tmodSecgen01
Objetivo     : Obtener el listado de modalidades/flujos de prestación de servicios.
               Permite distinguir entre Docentes Especiales (Legacy) y DU09 (Fase 2).
Modificaciones:
- 2026/05/14: Creación inicial para control de flujo Fase 2.
*/

CREATE PROCEDURE Analisis2.sg_tmodSecgen01
AS
BEGIN
    SELECT 
        id_modprse,
        des_modprse
    FROM 
        secgen_db.dbo.sg_tmod
    ORDER BY 
        id_modprse ASC
END
GO
