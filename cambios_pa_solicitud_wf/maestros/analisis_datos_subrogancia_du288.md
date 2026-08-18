# Analisis corregido de datos para subrogancias DU288

## 1. Fuentes y responsabilidad

| Tabla | Responsabilidad comprobada |
| :--- | :--- |
| `sp_orco` | Ocupante de un cargo por contrato. La vigencia operativa es `sp_orco.vigente = 'S'`. |
| `sp_orde` | Ocupante de un cargo por designacion. La vigencia operativa es `sp_orde.vigente = 'S'`. |
| `sp_aufi` | Relaciona el cargo representado (`cod_organi`) con los cargos habilitados para subrogarlo (`cod_organ2`) y su `prioridad`. |
| `es_orga` | Describe ambos cargos y declara su jerarquia y forma habitual de provision. |
| `sp_desg` | Aporta antecedentes de la designacion. No debe decidir la vigencia operativa de ORDE. |
| `sp_pers` | Aporta la identidad y el nombre de las personas resueltas. |

La referencia historica `es_orgasSecgen01` confirma esta interpretacion: une
`sp_aufi.cod_organ2` con ocupantes vigentes ORCO/ORDE y marca esas filas como
`subrogante = 'S'`. No filtra por `sp_desg.vigencia`.

## 2. Regla de resolucion existente

El motor `sg_etasSecgen01` ya aplica esta precedencia para resolver un cargo:

1. Buscar un ocupante ORCO con `vigente = 'S'` en el cargo requerido.
2. Si no existe, buscar un ocupante ORDE con `vigente = 'S'` en el mismo cargo.
3. Si tampoco existe, buscar en AUFI la menor prioridad que tenga un ocupante
   ORCO u ORDE vigente.
4. Rechazar resultados ambiguos cuando una fuente devuelve mas de una persona.

Esta regla debe reutilizarse; `sp_desg.vigencia` no forma parte de ella.

## 3. Interpretacion del caso Alicia Castro

Los datos encontrados son:

| Campo | Valor |
| :--- | :--- |
| Cargo | `60 - ENCARGADA DE DIRECCION DE INFORMATICA` |
| ORDE vigente | `101661210 - ALICIA JOSEFA CASTRO PARRA` |
| ORCO vigente en el mismo cargo | `176525665` |
| `es_orga.por_desig` | `S` |
| Relacion AUFI para el cargo 60 | No existe |

Por lo tanto, Alicia es una ocupante vigente por designacion del cargo 60. El
solo hecho de que exista otro RUT ORCO en el mismo cargo no demuestra que
Alicia lo subrogue. Como el cargo 60 no aparece relacionado en `sp_aufi`, el PA
de contextos debe devolver solo `PERSONAL` para `101661210`.

El resultado obtenido es correcto:

```text
PERSONAL | PERSONAL | 101661210 | 101661210 | ALICIA JOSEFA CASTRO PARRA
```

## 4. Caso real disponible para probar AUFI

El simulador ya contiene un caso completo:

| Dato | Valor |
| :--- | :--- |
| Cargo representado | `39 - VICERRECTOR DE ADMINISTRACION Y FINANZAS` |
| Titular ORCO vigente | `13158007K - JORGE ANDRES PETIT-BREUILH SEPULVEDA` |
| AUFI prioridad 1 | Cargo `41 - DIRECTOR DE FINANZAS` |
| Ocupante ORDE vigente del cargo 41 | `14220231K - MIGUEL ANGEL SANDOVAL ALVAREZ` |
| AUFI prioridad 2 | Cargo `50 - DIRECTOR DE PERSONAL` |
| Ocupante ORCO vigente del cargo 50 | `129856963 - JOAQUIN ANTONIO BASCUNAN MUNOZ` |

Cruce certificado en los archivos:

```text
sp_aufi: 39 -> 41, prioridad 1
sp_aufi: 39 -> 50, prioridad 2
sp_orco: cargo 39, RUT 13158007K, vigente S
sp_orde: cargo 41, RUT 14220231K, vigente S
sp_orco: cargo 50, RUT 129856963, vigente S
```

Si la politica efectiva utiliza solo la primera prioridad disponible, Miguel
es el candidato correcto para probar una representacion de VRAF.

## 5. Consulta de diagnostico

```sql
SELECT
    aufi.cod_organi AS cod_organi_representado,
    rtrim(representado.des_organi) AS cargo_representado,
    aufi.cod_organ2 AS cod_organi_actor,
    rtrim(actor_org.des_organi) AS cargo_actor,
    aufi.prioridad,
    isnull(orco.rut_person, orde.rut_person) AS rut_actor,
    CASE WHEN orco.rut_person IS NOT NULL THEN 'AUFI_ORCO'
         ELSE 'AUFI_ORDE' END AS fuente_actor
FROM sisper_db.dbo.sp_aufi aufi
INNER JOIN ufro_db.dbo.es_orga representado
    ON representado.cod_organi = aufi.cod_organi
INNER JOIN ufro_db.dbo.es_orga actor_org
    ON actor_org.cod_organi = aufi.cod_organ2
LEFT JOIN sisper_db.dbo.sp_orco orco
    ON orco.cod_organi = aufi.cod_organ2
   AND orco.vigente = 'S'
LEFT JOIN sisper_db.dbo.sp_orde orde
    ON orde.cod_organi = aufi.cod_organ2
   AND orde.vigente = 'S'
WHERE aufi.cod_organi = 39
ORDER BY aufi.prioridad
```

## 6. Contexto esperado para Miguel

Si se adopta la menor prioridad disponible, `sp_ordesSecgen01` debe devolver:

```text
PERSONAL | PERSONAL | 14220231K | 14220231K
REP:39:13158007K | REPRESENTACION | 14220231K | 13158007K
```

La segunda fila debe informar al menos:

```json
{
  "context_key": "REP:39:13158007K",
  "context_type": "REPRESENTACION",
  "rut_actor": "14220231K",
  "rut_titular": "13158007K",
  "cod_organi_representado": 39,
  "cargo_representado": "VICERRECTOR DE ADMINISTRACION Y FINANZAS",
  "tipo_representacion": "SUBROGANCIA",
  "fuente": "AUFI_ORDE",
  "prioridad": 1
}
```

## 7. Alcance evaluado y descartado

> La creacion y edicion por cuenta del titular fue descartada posteriormente.
> La decision vigente limita la subrogancia a tareas de aprobacion, revision y
> firma.

El subrogante puede operar como gestor del titular durante el ciclo de la
solicitud, sin cambiar la identidad de la sesion:

1. Crear y enviar solicitudes a nombre del titular.
2. Consultar y editar solicitudes activas del titular dentro del contexto.
3. Revisar y decidir tareas dirigidas al titular o al cargo representado.
4. Conservar al titular en `sg_soli.rut_solici` y `sg_apso.rut_usua`.
5. Registrar al subrogante real en `sg_hist.rut_accion` y, al decidir, en
   `sg_apso.rut_autori`.

`sg_apso` no reemplaza la trazabilidad de creacion: una solicitud que todavia
no posee tarea se audita mediante los eventos `DRAFT`, `SUBMISSION` y
`REQUEST_EDIT` de `sg_hist`.

## 8. Decisiones pendientes antes de autorizar tareas

Los datos permiten identificar candidatos AUFI, pero existen dos comportamientos
historicos diferentes:

1. `es_orgasSecgen01` lista al titular y a todos los subrogantes AUFI vigentes,
   respetando su prioridad.
2. `sg_etasSecgen01` usa AUFI solo cuando el cargo no tiene ocupante directo y
   selecciona la menor prioridad disponible.

Para gestionar tareas ajenas sin modificar la base de datos, la alternativa
mas restrictiva es autorizar unicamente al ocupante vigente de la menor
prioridad AUFI. Autorizar todas las prioridades permitiria que varios usuarios
decidieran simultaneamente por el mismo cargo. Exigir `ausente = 'S'` no es
aplicable con los datos actuales porque los volcados no contienen ocupantes
vigentes marcados de esa forma.

Los PA de contextos, bandejas y decisiones no deben redesplegarse hasta aplicar
la misma politica AUFI en todos ellos. La implementacion actual basada en
ORCO/ORDE del mismo cargo debe reemplazarse.

Tambien debe confirmarse si el mismo subrogante puede aprobar una solicitud que
el mismo creo o edito a nombre del titular. La recomendacion tecnica es permitir
que revise otras solicitudes del titular, pero bloquear la decision sobre una
solicitud en la que figure como creador o editor, salvo autorizacion normativa
expresa.

## 9. Alcance final para la implementacion

1. No se crean solicitudes a nombre del titular.
2. El responsable de la etapa se resuelve mediante ORCO directo disponible,
   ORDE directo disponible y luego todo el AUFI directo en orden ascendente de
   prioridad.
3. `vigente = 'S'` y `ausente <> 'S'` definen disponibilidad en ORCO/ORDE.
4. El subrogante se guarda como destinatario efectivo en `sg_apso.rut_usua`.
5. Al decidir, el JWT se guarda en `sg_apso.rut_autori` y `sg_hist.rut_accion`.
6. `sg_hist.observaci` registra cargo representado, fuente AUFI y prioridad.
7. Cada prioridad AUFI combina y deduplica ocupantes ORCO/ORDE; mas de una
   persona distinta bloquea el nivel como ambiguo.
8. No se encadena AUFI y no se usa `es_orga.cod_orgjef` como reemplazo
   automatico. Se recorren todas las prioridades directas configuradas,
   incluso cuando existan 12 o mas.
