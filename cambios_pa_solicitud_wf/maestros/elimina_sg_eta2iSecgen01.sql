USE secgen_db

/*
Elimina el antiguo PA de carga de sg_eta2
La carga maestra se realiza mediante carga_sg_eta2_desde_eta1.sql
*/

IF EXISTS (
    SELECT 1
    FROM sysobjects objeto,
         sysusers propietario
    WHERE objeto.uid = propietario.uid
      AND objeto.type = 'P'
      AND propietario.name = 'Analisis2'
      AND objeto.name = 'sg_eta2iSecgen01'
)
BEGIN
    DROP PROCEDURE Analisis2.sg_eta2iSecgen01

    SELECT
        1 AS status,
        'Procedimiento sg_eta2iSecgen01 eliminado' AS mensaje
END
ELSE
BEGIN
    SELECT
        1 AS status,
        'Procedimiento sg_eta2iSecgen01 no existe' AS mensaje
END
