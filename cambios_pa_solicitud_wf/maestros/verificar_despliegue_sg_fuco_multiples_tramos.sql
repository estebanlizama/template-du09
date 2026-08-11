USE secgen_db
GO

/*
   Verificacion no destructiva del despliegue FUCO con la estructura actual.
   Compatible con Sybase ASE 12.5.

   Resultado esperado:
   1. La primera consulta retorna las cuatro columnas existentes de sg_fuco.
   2. La segunda consulta retorna los cuatro procedimientos de Analisis2.
   3. Las ejecuciones finales retornan mensajes de validacion por parametros
      faltantes. Esos mensajes confirman que los PA existen sin modificar datos.
*/

SELECT
    u.name AS propietario,
    o.name AS tabla,
    c.name AS columna,
    c.length AS largo
FROM sysobjects o,
     sysusers u,
     syscolumns c
WHERE o.uid = u.uid
  AND o.id = c.id
  AND u.name = 'dbo'
  AND o.name = 'sg_fuco'
  AND c.name IN ('id_funprse', 'fec_compro', 'hora_ini', 'hora_ter')
ORDER BY c.colid
GO

/* La clave/indice existente permanece sin modificaciones. */
SELECT
    i.name AS indice,
    index_col('dbo.sg_fuco', i.indid, 1) AS columna_1,
    index_col('dbo.sg_fuco', i.indid, 2) AS columna_2,
    index_col('dbo.sg_fuco', i.indid, 3) AS columna_3,
    index_col('dbo.sg_fuco', i.indid, 4) AS columna_4
FROM sysindexes i
WHERE i.id = object_id('dbo.sg_fuco')
  AND i.indid > 0
  AND i.indid < 255
GO

SELECT
    u.name AS propietario,
    o.name AS procedimiento
FROM sysobjects o,
     sysusers u
WHERE o.uid = u.uid
  AND o.type = 'P'
  AND u.name = 'Analisis2'
  AND o.name IN (
      'sg_fucodSecgen01',
      'sg_fucoiSecgen01',
      'sg_fucosSecgen01',
      'sg_fucouSecgen01'
  )
ORDER BY o.name
GO

/* Pruebas de existencia seguras: todos los parametros poseen valores NULL por defecto. */
EXECUTE secgen_db.Analisis2.sg_fucodSecgen01
GO

EXECUTE secgen_db.Analisis2.sg_fucoiSecgen01
GO

EXECUTE secgen_db.Analisis2.sg_fucosSecgen01
GO
