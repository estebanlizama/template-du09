# Deuda técnica: la previsualización del envío depende del estado persistido

**Fecha:** 2026-09-08  
**Ámbito:** Workflow de solicitud PDS DU288 — envío a validación  
**Estado:** Deuda técnica registrada. Mitigada en el frontend; la solución de fondo queda pendiente.

## 1. El problema

Al presionar «Enviar a validación», el modal muestra quién recibirá la solicitud. Ese cálculo lo hace el backend leyendo la **base de datos**, no el formulario que el usuario tiene en pantalla.

`previewSubmissionAssignments(requestId, workflowId)` resuelve por `nro_solici`: lee `sg_prse`, `sg_soli` y `sg_fups`. En consecuencia, si el usuario editó datos que determinan el recorrido y todavía no guardó, la previsualización **muestra un destinatario que no corresponde**.

## 2. Qué datos determinan el recorrido

Son exactamente los que `sg_etasSecgen01` lee para resolver los responsables:

| Dato | Origen | Determina |
| :--- | :--- | :--- |
| `rut_jefpro` | `sg_prse` | Actor «Jefe de Proyecto» |
| `ctx_unifin`, `ctx_ccto`, `cod_unidad` | Centro de costo, vía `sg_prsesSecgen20` | **Decano / Director de Facultad** |
| `rut_person` | `sg_fups` | Jefatura directa y detección de beneficiarios |
| `dentro_jor` | `sg_fups` | Etapas que aplican según jornada |
| Contrato | Vía `sg_fupssSecgen16` | Jefatura directa del funcionario |

**No influyen** en el recorrido: monto, fechas de ejecución, cargo, actividad ni compensaciones. Verificado sobre el código de `sg_etasSecgen01`, que no referencia ninguno de esos campos.

## 3. Mitigación aplicada (frontend)

`PdsDu288RequestForm.vue` mantiene una huella (`buildFlowFingerprint`) con esos cinco insumos, capturada al cargar la solicitud y después de cada guardado. Si alguno cambió, antes de abrir el modal se ofrece guardar, nombrando qué cambió y por qué importa (`getFlowChanges`).

Es una mitigación, no una solución: depende de que la huella del frontend se mantenga sincronizada con lo que el PA lee. Si mañana `sg_etasSecgen01` incorpora otro insumo y nadie actualiza `buildFlowFingerprint`, la previsualización vuelve a mentir en silencio.

Antes de esta mitigación la huella omitía el centro de costo, de modo que cambiarlo y enviar mostraba el Decano del centro de costo anterior sin ningún aviso.

## 4. Solución de fondo pendiente

Que `previewSubmissionAssignments` reciba los datos del **formulario**, como ya hace `previewDraftSkips` — que resuelve la jefatura directa con `(rut, contrato)` recibidos por parámetro y por eso funciona sin persistencia.

Con eso:

- La previsualización deja de depender del estado guardado y nunca puede mentir.
- No hace falta pedir que se guarde antes de enviar: todo el mecanismo de huella y aviso desaparece.
- Se elimina la posibilidad de que frontend y PA queden desincronizados.

El costo es rehacer la resolución de actores para que acepte el contexto por parámetro en vez de leerlo por `nro_solici`, incluida la cadena `sg_etasSecgen01` → `sg_prsesSecgen20`. Por eso se difiere hasta que se toque el backend de workflow por otra razón.

## 5. Nota sobre pérdida de datos

Este documento trata solo de la **veracidad de la previsualización**. El envío en sí (`sendRequest` → `persistRequest`) arma el payload desde el formulario actual, así que **ningún dato se pierde al enviar sin haber guardado**.

La pérdida real de datos ocurre al **salir de la página** sin guardar, y se cubre con un mecanismo distinto y deliberadamente más amplio (`buildFormFingerprint` + `beforeRouteLeave` + `beforeunload`), que sí compara todo el formulario, monto y fechas incluidos.
