USE secgen_db
GO

/* Diagnostico de solo lectura para la etapa Decano del flujo Facultad. */
DECLARE @nro_solici int
DECLARE @cod_unidad char(8)
DECLARE @prefijo char(2)
DECLARE @cod_organi_decano int

SELECT @nro_solici = 278

SELECT @cod_unidad = ufin.cod_unidad
FROM dbo.sg_prse prse
INNER JOIN fin21_db..es_ccto ccto
  ON ccto.cod_unifin = prse.cod_unifin
 AND ccto.cod_ccto = prse.cod_ccto
INNER JOIN fin21_db..es_ufin ufin
  ON ufin.cod_unifin = ccto.cod_unifin
WHERE prse.nro_solici = @nro_solici
  AND ccto.vigente = '1'

SELECT @prefijo = SUBSTRING(@cod_unidad, 1, 2)

SELECT @cod_organi_decano = MIN(orga.cod_organi)
FROM ufro_db.dbo.es_orga orga
WHERE orga.cod_unidad = @prefijo + '010000'
  AND orga.cod_tiporg = 1
  AND orga.cod_estame = 1
  AND orga.por_contra = 'S'
  AND UPPER(LTRIM(RTRIM(orga.des_organi))) LIKE 'DECAN%FACULTAD%'

SELECT @nro_solici nro_solici, @cod_unidad unidad_financiera,
       @prefijo prefijo_facultad, @cod_organi_decano cod_organi_decano

SELECT orga.cod_organi, orga.cod_unidad, orga.des_organi,
       orga.por_contra, orga.por_desig, orga.cod_estame
FROM ufro_db.dbo.es_orga orga
WHERE orga.cod_unidad = @prefijo + '010000'
  AND orga.cod_tiporg = 1
  AND UPPER(LTRIM(RTRIM(orga.des_organi))) LIKE 'DECAN%FACULTAD%'

SELECT f.id_funprse, f.rut rut_funcionario, p.nom_nombre,
       p.nom_appate, p.nom_apmate
FROM dbo.sg_fups f
LEFT JOIN sisper_db.dbo.sp_pers p ON p.rut_person = f.rut
WHERE f.nro_solici = @nro_solici

SELECT 'ORCO' fuente, orco.rut_person, orco.vigente, orco.ausente,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.sg_fups f
           WHERE f.nro_solici = @nro_solici AND f.rut = orco.rut_person
       ) THEN 'S' ELSE 'N' END es_funcionario_solicitud
FROM sisper_db.dbo.sp_orco orco
WHERE orco.cod_organi = @cod_organi_decano

SELECT 'ORDE' fuente, orde.rut_person, orde.vigente,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.sg_fups f
           WHERE f.nro_solici = @nro_solici AND f.rut = orde.rut_person
       ) THEN 'S' ELSE 'N' END es_funcionario_solicitud
FROM sisper_db.dbo.sp_orde orde
WHERE orde.cod_organi = @cod_organi_decano

SELECT aufi.prioridad, aufi.cod_organ2 cod_organi_subrogante,
       orga.des_organi cargo_subrogante, 'AUFI_ORCO' fuente,
       orco.rut_person rut_candidato,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.sg_fups f
           WHERE f.nro_solici = @nro_solici
             AND f.rut = orco.rut_person
       ) THEN 'S' ELSE 'N' END es_funcionario_solicitud
FROM sisper_db.dbo.sp_aufi aufi
INNER JOIN ufro_db.dbo.es_orga orga
  ON orga.cod_organi = aufi.cod_organ2
INNER JOIN sisper_db.dbo.sp_orco orco
  ON orco.cod_organi = aufi.cod_organ2 AND orco.vigente = 'S'
 AND UPPER(LTRIM(RTRIM(ISNULL(orco.ausente, 'N')))) <> 'S'
WHERE aufi.cod_organi = @cod_organi_decano
UNION ALL
SELECT aufi.prioridad, aufi.cod_organ2 cod_organi_subrogante,
       orga.des_organi cargo_subrogante, 'AUFI_ORDE' fuente,
       orde.rut_person rut_candidato,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.sg_fups f
           WHERE f.nro_solici = @nro_solici
             AND f.rut = orde.rut_person
       ) THEN 'S' ELSE 'N' END es_funcionario_solicitud
FROM sisper_db.dbo.sp_aufi aufi
INNER JOIN ufro_db.dbo.es_orga orga
  ON orga.cod_organi = aufi.cod_organ2
INNER JOIN sisper_db.dbo.sp_orde orde
  ON orde.cod_organi = aufi.cod_organ2 AND orde.vigente = 'S'
WHERE aufi.cod_organi = @cod_organi_decano
ORDER BY prioridad, cod_organi_subrogante, fuente

EXECUTE Analisis2.sg_etasSecgen01
    @nro_solici = @nro_solici,
    @cod_etapa = 50,
    @cod_flusol = 1
GO
