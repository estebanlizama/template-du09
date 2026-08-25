USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_cctosSecgen04'
)
    DROP PROCEDURE Analisis2.sg_cctosSecgen04
GO

/* Procedimiento : Analisis2.sg_cctosSecgen04

   Entrada :
   @rut                 -> RUT del funcionario. (Opcional)

   Objetivo : Lista de centros de costo por rut y asociados a la unidad de usuario

   Creacion: ELA 2024 / 08 / 29
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_cctosSecgen04 @rut char(9) = NULL as
    if @rut is null
begin
	select
	'Falta el rut. Se aborta el procedimiento' msg return
end

DECLARE @unidad_mayor CHAR(8)

SELECT 
    @unidad_mayor = substring(uni.cod_unidad, 1, 2) + '000000'
FROM 
    sisper_db..sp_pers pers
INNER JOIN 
    ufro_db..es_unid uni 
    ON uni.cod_unidad = pers.u_original
WHERE 
    pers.rut_person = @rut
AND 
    uni.vigente = 'S'

SELECT
    pers.rut_person,
    ccto.cod_ccto,
    ccto.cod_unifin,
    ccto.cod_tfinan,
    ccto.cod_ftfn,
    ftfn.des_ftfn AS fuente_financiamiento,
    ccto.cod_tcsald,
    ccto.f_creacion,
    ecct.rut,
    ccto.nom_ccto,
    ccto.nom_ab_cct,
    pers.nom_nombre,
    pers.nom_appate,
    pers.nom_apmate
FROM
    fin21_db..es_ccto ccto
LEFT JOIN 
    fin21_db..es_ecct ecct 
    ON ecct.cod_ccto = ccto.cod_ccto
    AND ecct.cod_unifin = ccto.cod_unifin
LEFT JOIN 
    fin21_db..sf_ftfn ftfn
    ON ftfn.cod_ftfn = ccto.cod_ftfn
LEFT JOIN 
    sisper_db..sp_pers pers
    ON ecct.rut = pers.rut_person
LEFT JOIN 
    ufro_db..es_unid uni 
    ON uni.cod_unidad = pers.u_original
WHERE
    uni.cod_unidad LIKE LEFT(@unidad_mayor, 2) + '%'
AND 
    ecct.vigente = 'S'


GRANT EXECUTE ON Analisis2.sg_cctosSecgen04 TO UsuaVrac
GO
