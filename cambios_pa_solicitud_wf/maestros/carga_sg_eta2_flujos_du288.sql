USE secgen_db

/*
Objetivo : Cargar las transiciones base de los flujos DU288 desde el orden
           vigente definido en sg_eta1.

Reglas:
    1  Enviar solicitud       : etapa inicial -> primera etapa revisora. Se
                                utiliza tambien para reenviar una correccion.
    2  Aprobar solicitud      : etapa actual -> siguiente etapa vigente.
    3  Rechazar solicitud     : conserva la etapa revisora, estado rechazado.
    4  Devolver a correccion  : etapa revisora -> etapa inicial, estado correccion.

La accion 28 se registra solamente en sg_hist cuando se reenvia una solicitud
corregida. No se agrega a sg_eta2 porque comparte la ruta de la accion 1 y la
clave actual identifica una transicion por flujo, origen y destino.

La entrada a la etapa de perfil 12 inicia el estado de resolucion. Las etapas
posteriores conservan ese estado. Aprobar la etapa final conserva la etapa y
marca la solicitud como archivada.

El script es idempotente: solo inserta combinaciones que no existen. No elimina
ni reemplaza transiciones especiales configuradas por el administrador.
*/

/* Envio inicial: Solicitante -> primera etapa revisora. */
INSERT INTO secgen_db.dbo.sg_eta2
(
    cod_flusol,
    cod_etapa1,
    cod_etapa2,
    id_tipacc,
    cod_estsol
)
SELECT
    origen.cod_flusol,
    origen.cod_etapa,
    min(destino.cod_etapa),
    1,
    2
FROM secgen_db.dbo.sg_eta1 origen,
     secgen_db.dbo.sg_eta1 destino,
     secgen_db.dbo.sg_tfls flujo
WHERE flujo.cod_flusol = origen.cod_flusol
  AND destino.cod_flusol = origen.cod_flusol
  AND destino.cod_etapa > origen.cod_etapa
  AND isnull(flujo.vigente, 'S') = 'S'
  AND isnull(origen.vigente, 'S') = 'S'
  AND isnull(destino.vigente, 'S') = 'S'
  AND origen.cod_etapa = (
      SELECT min(inicial.cod_etapa)
      FROM secgen_db.dbo.sg_eta1 inicial
      WHERE inicial.cod_flusol = origen.cod_flusol
        AND isnull(inicial.vigente, 'S') = 'S'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM secgen_db.dbo.sg_eta2 existente
      WHERE existente.cod_flusol = origen.cod_flusol
        AND existente.cod_etapa1 = origen.cod_etapa
        AND existente.id_tipacc = 1
  )
GROUP BY origen.cod_flusol, origen.cod_etapa

/* Aprobacion lineal: cada etapa revisora avanza a la siguiente. */
INSERT INTO secgen_db.dbo.sg_eta2
(
    cod_flusol,
    cod_etapa1,
    cod_etapa2,
    id_tipacc,
    cod_estsol
)
SELECT
    origen.cod_flusol,
    origen.cod_etapa,
    min(destino.cod_etapa),
    2,
    CASE
        WHEN min(destino.cod_etapa) >= isnull(
            (
                SELECT min(decretacion.cod_etapa)
                FROM secgen_db.dbo.sg_eta1 decretacion
                WHERE decretacion.cod_flusol = origen.cod_flusol
                  AND decretacion.cod_perfil = 12
                  AND isnull(decretacion.vigente, 'S') = 'S'
            ),
            255
        ) THEN 3
        ELSE 2
    END
FROM secgen_db.dbo.sg_eta1 origen,
     secgen_db.dbo.sg_eta1 destino,
     secgen_db.dbo.sg_tfls flujo
WHERE flujo.cod_flusol = origen.cod_flusol
  AND destino.cod_flusol = origen.cod_flusol
  AND destino.cod_etapa > origen.cod_etapa
  AND isnull(flujo.vigente, 'S') = 'S'
  AND isnull(origen.vigente, 'S') = 'S'
  AND isnull(destino.vigente, 'S') = 'S'
  AND origen.cod_etapa > (
      SELECT min(inicial.cod_etapa)
      FROM secgen_db.dbo.sg_eta1 inicial
      WHERE inicial.cod_flusol = origen.cod_flusol
        AND isnull(inicial.vigente, 'S') = 'S'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM secgen_db.dbo.sg_eta2 existente
      WHERE existente.cod_flusol = origen.cod_flusol
        AND existente.cod_etapa1 = origen.cod_etapa
        AND existente.id_tipacc = 2
  )
GROUP BY origen.cod_flusol, origen.cod_etapa

/* Rechazo definitivo desde cualquier etapa revisora. */
INSERT INTO secgen_db.dbo.sg_eta2
(
    cod_flusol,
    cod_etapa1,
    cod_etapa2,
    id_tipacc,
    cod_estsol
)
SELECT
    origen.cod_flusol,
    origen.cod_etapa,
    origen.cod_etapa,
    3,
    4
FROM secgen_db.dbo.sg_eta1 origen,
     secgen_db.dbo.sg_tfls flujo
WHERE flujo.cod_flusol = origen.cod_flusol
  AND isnull(flujo.vigente, 'S') = 'S'
  AND isnull(origen.vigente, 'S') = 'S'
  AND isnull(origen.est_final, 'N') <> 'S'
  AND origen.cod_etapa > (
      SELECT min(inicial.cod_etapa)
      FROM secgen_db.dbo.sg_eta1 inicial
      WHERE inicial.cod_flusol = origen.cod_flusol
        AND isnull(inicial.vigente, 'S') = 'S'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM secgen_db.dbo.sg_eta2 existente
      WHERE existente.cod_flusol = origen.cod_flusol
        AND existente.cod_etapa1 = origen.cod_etapa
        AND existente.id_tipacc = 3
  )

/* Devolucion a correccion desde cualquier etapa revisora. */
INSERT INTO secgen_db.dbo.sg_eta2
(
    cod_flusol,
    cod_etapa1,
    cod_etapa2,
    id_tipacc,
    cod_estsol
)
SELECT
    origen.cod_flusol,
    origen.cod_etapa,
    min(destino.cod_etapa),
    4,
    6
FROM secgen_db.dbo.sg_eta1 origen,
     secgen_db.dbo.sg_eta1 destino,
     secgen_db.dbo.sg_tfls flujo
WHERE flujo.cod_flusol = origen.cod_flusol
  AND destino.cod_flusol = origen.cod_flusol
  AND isnull(flujo.vigente, 'S') = 'S'
  AND isnull(origen.vigente, 'S') = 'S'
  AND isnull(destino.vigente, 'S') = 'S'
  AND isnull(origen.est_final, 'N') <> 'S'
  AND origen.cod_etapa > (
      SELECT min(inicial.cod_etapa)
      FROM secgen_db.dbo.sg_eta1 inicial
      WHERE inicial.cod_flusol = origen.cod_flusol
        AND isnull(inicial.vigente, 'S') = 'S'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM secgen_db.dbo.sg_eta2 existente
      WHERE existente.cod_flusol = origen.cod_flusol
        AND existente.cod_etapa1 = origen.cod_etapa
        AND existente.id_tipacc = 4
  )
GROUP BY origen.cod_flusol, origen.cod_etapa

/* Cierre de la etapa final. */
INSERT INTO secgen_db.dbo.sg_eta2
(
    cod_flusol,
    cod_etapa1,
    cod_etapa2,
    id_tipacc,
    cod_estsol
)
SELECT
    final.cod_flusol,
    final.cod_etapa,
    final.cod_etapa,
    2,
    11
FROM secgen_db.dbo.sg_eta1 final,
     secgen_db.dbo.sg_tfls flujo
WHERE flujo.cod_flusol = final.cod_flusol
  AND isnull(flujo.vigente, 'S') = 'S'
  AND isnull(final.vigente, 'S') = 'S'
  AND isnull(final.est_final, 'N') = 'S'
  AND NOT EXISTS (
      SELECT 1
      FROM secgen_db.dbo.sg_eta2 existente
      WHERE existente.cod_flusol = final.cod_flusol
        AND existente.cod_etapa1 = final.cod_etapa
        AND existente.id_tipacc = 2
  )

SELECT
    transicion.cod_flusol,
    transicion.cod_etapa1,
    origen.des_etapa AS des_etapa1,
    transicion.id_tipacc,
    accion.des_accion,
    transicion.cod_etapa2,
    destino.des_etapa AS des_etapa2,
    transicion.cod_estsol,
    estado.des_estsol
FROM secgen_db.dbo.sg_eta2 transicion
INNER JOIN secgen_db.dbo.sg_eta1 origen
    ON origen.cod_flusol = transicion.cod_flusol
   AND origen.cod_etapa = transicion.cod_etapa1
INNER JOIN secgen_db.dbo.sg_eta1 destino
    ON destino.cod_flusol = transicion.cod_flusol
   AND destino.cod_etapa = transicion.cod_etapa2
INNER JOIN secgen_db.dbo.sg_tacc accion
    ON accion.id_tipacc = transicion.id_tipacc
LEFT JOIN secgen_db.dbo.sg_esol estado
    ON estado.cod_estsol = transicion.cod_estsol
ORDER BY transicion.cod_flusol, transicion.cod_etapa1, transicion.id_tipacc
