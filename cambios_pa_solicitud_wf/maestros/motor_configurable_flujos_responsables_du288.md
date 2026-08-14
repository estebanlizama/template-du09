# Resolución de flujos y responsables DU288 sin nuevas tablas

## Alcance

La implementación se adecua al modelo existente. No requiere `CREATE TABLE`, `ALTER TABLE` ni nuevos maestros. Las reglas quedan centralizadas en los PA y utilizan únicamente información que ya existe.

## Fuentes utilizadas

| Fuente existente | Uso |
|---|---|
| `fin21_db..es_ccto` y `fin21_db..es_ufin` | Obtener el Centro de Costo y su unidad institucional. |
| `secgen_db.dbo.sg_tfls` | Validar el flujo DU288 vigente. |
| `secgen_db.dbo.sg_eta1` | Obtener la etapa, perfil y `cod_organi` configurado. |
| `secgen_db.dbo.sg_eta2` | Validar las transiciones del flujo. |
| `secgen_db.dbo.sg_soli` | Resolver al solicitante. |
| `secgen_db.dbo.sg_prse` | Resolver al jefe de proyecto y el contexto de la solicitud. |
| `secgen_db.dbo.sg_fups` | Identificar funcionarios sujetos a jefatura directa. |
| `ufro_db..es_orga` | Identificar las organizaciones institucionales. |
| `sisper_db.dbo.sp_orco` | Obtener el titular vigente de una organización. |
| `sisper_db.dbo.sp_orde` | Obtener el delegado o subrogante vigente. |
| `sisper_db.dbo.sp_aufi` | Escalar a una organización superior cuando no existe ocupante directo. |

No se consulta `bd_pri2`.

## Selección del flujo

`sg_flusSecgen01` obtiene `cod_unidad` desde el Centro de Costo y aplica la codificación institucional que ya existe:

| Prefijo de unidad | Flujo |
|---|---|
| `06`, `07`, `08`, `09`, `17`, `18` | Facultad (`1`) |
| `10`, `14`, `15` | Instituto (`4`) |
| `03` | VRAF (`5`) |
| `02` | VRAC (`6`) |
| `19` | VIPRE (`7`) |
| `16` | VRIP (`8`) |

Investigación (`2`) y DITT (`3`) no pueden distinguirse de forma segura con el prefijo de `cod_unidad` disponible. Para habilitarlos sin crear tablas se debe identificar un atributo existente y estable del Centro de Costo o unidad; no corresponde inferirlos por descripción, nombre de persona o RUT.

## Resolución del responsable

`sg_etasSecgen01` interpreta el perfil ya registrado en `sg_eta1`:

| `cod_perfil` | Estrategia |
|---:|---|
| `6` | Solicitante desde `sg_soli.rut_solici`. |
| `25` | Jefe de proyecto desde `sg_prse.rut_jefpro`. |
| `26` | Jefatura directa por cada funcionario de `sg_fups`. |
| Otro | Autoridad de la organización indicada por `sg_eta1.cod_organi`. |

Cuando una etapa institucional existente no tiene `cod_organi` en `sg_eta1`, el PA completa el código usando el flujo y la unidad, pero siempre resuelve a la persona vigente en ORCO, ORDE o AUFI. No se codifican RUT.

### Organizaciones dependientes de la unidad

| Prefijo | Director/Encargado Facultad | Decanatura |
|---|---:|---:|
| `06` | `831` | `82` |
| `07` | `835` | `135` |
| `08` | `838` | `204` |
| `09` | `847` | `248` |
| `17` | `602` | `586` |
| `18` | `642` | `623` |

| Prefijo de Instituto | Dirección |
|---|---:|
| `10` | `268` |
| `14` | `297` |
| `15` | `457` |

### Organizaciones institucionales fijas

| Flujo/etapa | `cod_organi` existente |
|---|---:|
| Investigación / Director Investigación | `301` |
| Investigación / VRIP | `299` |
| DITT / Director DITT | `303` |
| DITT / VRIP | `299` |
| Instituto / VRIP | `299` |
| VRAC | `17` |
| VIPRE | `704` |
| VRIP | `299` |

## Regla de omisión

La política se deriva del `cod_perfil` existente. Los perfiles formales `6`, `25`, `12`, `13`, `14`, `16`, `17`, `18` y `23` no se omiten. Las demás etapas solo pueden omitirse cuando todos sus responsables reaparecen en una etapa posterior real del mismo flujo y la transición existe en `sg_eta2`.

El backend conserva la trazabilidad y muestra `skippedStages`, la etapa efectiva siguiente y el resumen antes de confirmar.

## Despliegue

1. Instalar `solicitante/sg_flusSecgen01.sql`.
2. Instalar `solicitante/sg_etasSecgen01.sql`.
3. Desplegar backend y frontend.
4. Probar cada prefijo soportado, los responsables ORCO/ORDE/AUFI y los casos con omisión.

No debe ejecutarse ningún instalador de tablas nuevas.
