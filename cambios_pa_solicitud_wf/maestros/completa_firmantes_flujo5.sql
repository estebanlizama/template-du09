USE secgen_db

/* Jefe de Decretacion -> Secretario General */
IF NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)
BEGIN
    INSERT INTO secgen_db.dbo.sg_eta2
    (cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
    SELECT 5, 60, 70, 2, 3
END

/* Secretario General -> VRAF */
IF NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)
BEGIN
    INSERT INTO secgen_db.dbo.sg_eta2
    (cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
    SELECT 5, 70, 80, 2, 3
END

SELECT
    eta2.cod_flusol,
    eta2.cod_etapa1,
    origen.des_etapa AS etapa_origen,
    eta2.cod_etapa2,
    destino.des_etapa AS etapa_destino,
    eta2.id_tipacc,
    accion.des_accion,
    eta2.cod_estsol
FROM secgen_db.dbo.sg_eta2 eta2
INNER JOIN secgen_db.dbo.sg_eta1 origen
    ON origen.cod_flusol = eta2.cod_flusol
   AND origen.cod_etapa = eta2.cod_etapa1
INNER JOIN secgen_db.dbo.sg_eta1 destino
    ON destino.cod_flusol = eta2.cod_flusol
   AND destino.cod_etapa = eta2.cod_etapa2
INNER JOIN secgen_db.dbo.sg_tacc accion
    ON accion.id_tipacc = eta2.id_tipacc
WHERE eta2.cod_flusol = 5
  AND eta2.cod_etapa1 IN (60, 70)
  AND eta2.id_tipacc = 2
ORDER BY eta2.cod_etapa1
