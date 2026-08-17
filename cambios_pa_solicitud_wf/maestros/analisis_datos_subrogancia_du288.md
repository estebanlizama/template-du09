# Analisis de datos para probar subrogancias DU288

## 1. Fuentes disponibles

| Archivo / tabla | Datos utilizables | Uso en la regla |
| :--- | :--- | :--- |
| `datos_sisper_db_sp_orco.md` / `sp_orco` | `cod_organi`, `cod_contra`, `rut_person`, `vigente`, `ausente` | Identificar al titular vigente del cargo. |
| `datos_sisper_db_sp_orde.md` / `sp_orde` | `cod_organi`, `cod_design`, `rut_person`, `vigente`, `ausente` | Identificar a la persona designada para la organizacion. |
| `sp_desg` | `cod_design`, `cod_des_su`, `vigencia`, `f_inicio`, `f_termino`, `num_resol` | Certificar tipo 1, vigencia temporal y resolucion. No existe un volcado local de esta tabla. |
| `sp_tdsu` | `cod_des_su`, descripcion | Catalogo certificado: 1 Designacion, 2 Sumario, 3 Fondos Fijos. |
| `datos_ufro_db_orga.md` / `es_orga` | `cod_organi`, `des_organi`, `por_desig`, jerarquia | Obtener cargo y exigir `por_desig = 'S'`. |
| `sp_pers` | RUT y nombres | Obtener nombres del actor y del titular. No existe un volcado local completo. |
| `datos_sisper_db_sg_aufi.md` / `sg_aufi` | Organizacion padre, organizacion relacionada y prioridad | Jerarquia funcional alternativa; no acredita por si sola una subrogancia. |

## 2. Resultado del cruce local

Resumen de los archivos disponibles:

| Control | Resultado |
| :--- | ---: |
| Filas `sp_orco` | 89 |
| Filas `sp_orco` vigentes | 40 |
| Organizaciones con ORCO vigente | 39 |
| Organizaciones con mas de un titular vigente | 1 (`cod_organi = 579`) |
| ORCO vigentes con `ausente = 'S'` | 0 |
| Filas `sp_orde` | 405 |
| Filas `sp_orde` vigentes | 404 |
| Organizaciones con ORDE vigente | 403 |
| Organizaciones habilitadas con `es_orga.por_desig = 'S'` | 778 |

El unico cruce local entre un ORCO vigente y una persona ORDE vigente distinta,
para una organizacion habilitada por designacion, es:

| Campo | Valor conocido |
| :--- | :--- |
| `cod_organi` | `60` |
| Cargo | `ENCARGADA DE DIRECCION DE INFORMATICA` |
| Unidad | `03250000` |
| RUT actor/designado | `101661210` |
| Nombre actor | `ALICIA JOSEFA CASTRO PARRA` |
| `cod_design` | `3477` |
| RUT titular | `176525665` |
| `es_orga.por_desig` | `S` |
| `sp_orco.vigente` | `S` |
| `sp_orde.vigente` | `S` |

Este registro es solo candidato hasta verificar `sp_desg`.

## 3. Consulta de certificacion

```sql
SELECT
    orde.rut_person AS rut_actor,
    ltrim(rtrim(isnull(actor.nom_nombre, '') + ' ' +
                isnull(actor.nom_appate, '') + ' ' +
                isnull(actor.nom_apmate, ''))) AS nombre_actor,
    orco.rut_person AS rut_titular,
    ltrim(rtrim(isnull(titular.nom_nombre, '') + ' ' +
                isnull(titular.nom_appate, '') + ' ' +
                isnull(titular.nom_apmate, ''))) AS nombre_titular,
    orde.cod_organi,
    rtrim(orga.des_organi) AS cargo_representado,
    orde.cod_design,
    desg.cod_des_su,
    rtrim(tdsu.des_des_su) AS tipo_designacion,
    desg.vigencia AS vigencia_designacion,
    desg.f_inicio,
    desg.f_termino,
    desg.num_resol,
    orco.ausente AS titular_ausente,
    orga.por_desig
FROM sisper_db.dbo.sp_orde orde
INNER JOIN sisper_db.dbo.sp_desg desg
    ON desg.cod_design = orde.cod_design
INNER JOIN sisper_db.dbo.sp_tdsu tdsu
    ON tdsu.cod_des_su = desg.cod_des_su
INNER JOIN sisper_db.dbo.sp_orco orco
    ON orco.cod_organi = orde.cod_organi
INNER JOIN sisper_db.dbo.sp_pers actor
    ON actor.rut_person = orde.rut_person
INNER JOIN sisper_db.dbo.sp_pers titular
    ON titular.rut_person = orco.rut_person
INNER JOIN ufro_db.dbo.es_orga orga
    ON orga.cod_organi = orde.cod_organi
WHERE orde.rut_person = '101661210'
  AND orde.cod_design = '3477'
  AND orde.vigente = 'S'
  AND orco.vigente = 'S'
  AND orga.por_desig = 'S'
```

Para habilitar la prueba, la consulta debe retornar `cod_des_su = '1'`, una
designacion vigente y una fecha actual dentro de `f_inicio`/`f_termino`.

## 4. Respuesta esperada del PA

```sql
EXEC Analisis2.sp_ordesSecgen01
    @rut_actor = '101661210'
```

Debe retornar dos contextos si `sp_desg` certifica el candidato:

```json
[
  {
    "context_key": "PERSONAL",
    "context_type": "PERSONAL",
    "rut_actor": "101661210",
    "rut_titular": "101661210",
    "estado_resolucion": "VIGENTE"
  },
  {
    "context_key": "REP:60:176525665",
    "context_type": "REPRESENTACION",
    "rut_actor": "101661210",
    "rut_titular": "176525665",
    "cod_organi_representado": 60,
    "cargo_representado": "ENCARGADA DE DIRECCION DE INFORMATICA",
    "cod_design": "3477",
    "cod_des_su": "1",
    "tipo_representacion": "SUBROGANCIA",
    "fuente": "ORDE",
    "estado_resolucion": "VIGENTE",
    "puede_ver": "S",
    "puede_crear": "S",
    "puede_editar": "S",
    "puede_decidir": "S",
    "puede_firmar": "S"
  }
]
```

El endpoint transforma esos nombres al contrato camelCase del frontend:
`contextKey`, `contextType = REPRESENTATION`, `actorDni`, `principalDni`,
`principalName`, `representedOrganizationId`, `representedPosition`,
`designationId`, `designationTypeCode`, `source`, `validFrom`, `validTo`,
`principalAbsent`, `resolutionNumber` y las capacidades booleanas.

## 5. Observaciones

1. `ausente` no puede usarse como unica condicion: en el volcado no existe ningun ORCO vigente con valor `S`.
2. La organizacion 579 sirve para probar ambiguedad de titular porque posee dos RUT ORCO vigentes.
3. La organizacion 79 posee dos designaciones ORDE vigentes para el mismo RUT; no es ambigua al contar personas distintas.
4. `sg_aufi` sirve para jerarquia/prioridad entre organizaciones, pero no sustituye `sp_orde + sp_desg` para acreditar al actor.
5. La primera version del PA excedia el limite de 14 tablas del optimizador ASE. La version actual materializa conteos en temporales; debe redesplegarse antes de repetir la prueba.
