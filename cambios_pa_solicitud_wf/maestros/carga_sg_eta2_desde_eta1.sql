USE secgen_db

/*
Carga maestra de transiciones PDS DU288
Compatible con Sybase ASE
Sin GO
Sin punto y coma
Sin insercion multiple mediante VALUES
Idempotente no duplica una transicion ya registrada
*/

/* Flujo 1 Facultad */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 60, 70, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 80, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 80
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 90, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 90
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 100, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 100
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 110, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 110
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 120, 130, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 120
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 120, 120, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 120
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 120, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 120
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 120
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 1, 130, 130, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 130
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 1
      AND cod_etapa1 = 130
      AND id_tipacc = 2
)

/* Flujo 2 Investigacion */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 60, 70, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 80, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 80
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 90, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 90
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 100, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 100
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 110, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 110
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 120, 130, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 120
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 120, 120, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 120
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 120, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 120
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 120
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 2, 130, 130, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 130
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 2
      AND cod_etapa1 = 130
      AND id_tipacc = 2
)

/* Flujo 3 DITT */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 60, 70, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 80, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 80
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 90, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 90
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 100, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 100
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 110, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 110
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 120, 130, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 120
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 120, 120, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 120
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 120, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 120
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 120
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 3, 130, 130, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 130
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 3
      AND cod_etapa1 = 130
      AND id_tipacc = 2
)

/* Flujo 4 Instituto */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 60, 70, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 80, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 80
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 90, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 90
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 100, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 100
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 110, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 110
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 120, 130, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 120
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 120, 120, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 120
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 120, 80, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 120
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 120
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 4, 130, 130, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 130
      AND cod_etapa2 = 130
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 4
      AND cod_etapa1 = 130
      AND id_tipacc = 2
)

/* Flujo 5 VRAF */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 50, 60, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 60, 70, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 70, 60, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 80, 60, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 80
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 90, 60, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 90
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 100, 60, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 100
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 5, 110, 110, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 5
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

/* Flujo 6 VRAC */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 60, 70, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 80, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 80
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 90, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 90
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 100, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 100
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 110, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 110
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 6, 120, 120, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 6
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

/* Flujo 7 VIPRE */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 60, 70, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 80, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 80
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 90, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 90
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 100, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 100
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 110, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 110
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 7, 120, 120, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 7
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

/* Flujo 8 VRIP */

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 10, 20, 1, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 10
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 10
      AND id_tipacc = 1
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 20, 30, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 20
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 20
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 20, 20, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 20
      AND cod_etapa2 = 20
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 20
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 20, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 20
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 20
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 30, 40, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 30
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 30
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 30, 30, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 30
      AND cod_etapa2 = 30
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 30
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 30, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 30
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 30
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 40, 50, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 40
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 40
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 40, 40, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 40
      AND cod_etapa2 = 40
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 40
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 40, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 40
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 40
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 50, 60, 2, 2
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 50
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 50
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 50, 50, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 50
      AND cod_etapa2 = 50
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 50
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 50, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 50
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 50
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 60, 70, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 60
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 60
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 60, 60, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 60
      AND cod_etapa2 = 60
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 60
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 60, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 60
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 60
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 70, 80, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 70
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 70
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 70, 70, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 70
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 70
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 70, 10, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 70
      AND cod_etapa2 = 10
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 70
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 80, 90, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 80
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 80
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 80, 80, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 80
      AND cod_etapa2 = 80
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 80
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 80, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 80
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 80
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 90, 100, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 90
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 90
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 90, 90, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 90
      AND cod_etapa2 = 90
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 90
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 90, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 90
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 90
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 100, 110, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 100
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 100
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 100, 100, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 100
      AND cod_etapa2 = 100
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 100
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 100, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 100
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 100
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 110, 120, 2, 3
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 110
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 110
      AND id_tipacc = 2
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 110, 110, 3, 4
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 110
      AND cod_etapa2 = 110
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 110
      AND id_tipacc = 3
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 110, 70, 4, 6
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 110
      AND cod_etapa2 = 70
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 110
      AND id_tipacc = 4
)

INSERT INTO secgen_db.dbo.sg_eta2
(cod_flusol, cod_etapa1, cod_etapa2, id_tipacc, cod_estsol)
SELECT 8, 120, 120, 2, 11
WHERE NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 120
      AND cod_etapa2 = 120
)
  AND NOT EXISTS (
    SELECT 1
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = 8
      AND cod_etapa1 = 120
      AND id_tipacc = 2
)

/* Verificacion final */
SELECT
    cod_flusol,
    count(*) AS trans_configuradas
FROM secgen_db.dbo.sg_eta2
WHERE cod_flusol IN (1, 2, 3, 4, 5, 6, 7, 8)
GROUP BY cod_flusol
ORDER BY cod_flusol

