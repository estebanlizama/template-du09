# Número de resolución exenta: cómo se genera hoy y qué implica digitarlo

Pregunta a responder: hoy el número de resolución exenta se genera automático.
Se quiere **digitarlo en un input en decretación**. Qué hay que cambiar, a qué
afecta, y cómo no confundir las variables que ya existen.

Fecha: 22-10-2026. Repositorios revisados: `sg-solicitudes-backend`,
`sg-solicitudes-frontend`, y los PA de `nuevo_workflow_fase_2` y
`contexto_prestacion_servicios`.

---

## 1. Glosario: hay **tres** números distintos y se parecen

Esto es lo primero, porque los tres aparecen como "número de resolución" en
pantalla y en el código, y confundirlos es el riesgo principal del cambio.

| Nombre en el código | Columna | Qué es | Quién lo genera |
| :--- | :--- | :--- | :--- |
| `resolutionNumber` | `sg_rslc.nro_resolu` | **Identificador interno** de la resolución en el sistema. Es la PK: todo el flujo (firmas, detalle, documentos, pagos) la referencia por este número | `sg_rslciSecgen01` al crear la resolución |
| `resolutionExternalNumber` | `sg_rslc.num_resolu` | **El número de la resolución exenta**: el folio oficial que se imprime en el documento y con el que la institución la identifica | se copia desde `ar_doc1.nro_docum` |
| `documentId` | `sg_rslc.id_docum` | FK al **documento oficial** en el archivo documental institucional (`archivo_db..ar_doc1`) | `ar_doc1iSecgen10` |

Dos trampas de nomenclatura, ya presentes en el código:

- **`nro_resolu` (interno) vs `num_resolu` (exenta)** difieren en tres letras y
  son columnas de la misma tabla. En el modelo `ResolutionEditRequest` el mapeo
  es `resolutionNumber → nro_resolu` y `resolutionExternalNumber → num_resolu`.
- **`nro_docum` (folio) vs `id_docum` (id del documento)** son dos columnas de
  `ar_doc1`, y el PA de generación devuelve ambas. Hay al menos un lugar en el
  backend que usa `id_docum` donde correspondía `nro_docum`
  (`balances-return.controller.ts:1715`: `resolutionExternalNumber:
  resolutionNumber?.id_docum`, mientras los demás controladores usan
  `?.nro_docum`). Es un bug preexistente de otro flujo, no de PDS, pero conviene
  saber que existe antes de tocar algo acá.

Además, `sg_soli.nro_resolu` + `ano_resolu` guardan el **interno**, no el exento:
el vínculo solicitud ↔ resolución no depende del número de la exenta.

---

## 2. Cómo se genera hoy, paso a paso

### 2.1 Dónde se dispara

En el frontend, `ChangeStateResolutionModal.vue`, método
`handleApproveOrSignRequest`, **solo cuando `modalType === 'approve'`** — es
decir, al aprobar/firmar para enviar la resolución a firma, no al guardar el
formato de decretación:

```js
const externalResolution = await this.createResolutionNumber({ ...this.payload, resolutionNumber: resId, resolutionYear, requestsIds: [reqId], resolutionMessage, dni })
if (Number(externalResolution?.resolutionExternalNumber || 0) <= 0) throw new Error(...)
await this.generateFinalResolutionDocument(reqId, resId)
```

### 2.2 El endpoint

`POST /requests/service-provision/create-number-resolution` →
`createNumberResolution` → `createNumberResolutionExclusive`, bajo un lock
exclusivo por resolución (`criticalOperationLock`), porque el folio es un
recurso que no se puede gastar dos veces.

El método hace tres cosas antes de emitir, todas para **no gastar un folio de
más** (es idempotente a propósito):

1. Si `sg_rslc` ya tiene `num_resolu > 0`, lo reutiliza. Si además le falta el
   `id_docum`, lo busca en `ar_doc1` por correlativo
   (`findOfficialDocumentByCorrelative`) y lo reenlaza.
2. Si no hay `num_resolu`, busca folios **huérfanos** en `ar_doc1` emitidos para
   esa solicitud (por el texto del mensaje, `%Solicitud N° X%`) y adopta el
   único que encuentre; si hay más de uno, corta pidiendo revisión manual.
3. Solo si no hay nada, emite uno nuevo.

Luego escribe en `sg_rslc` (`sg_rslcuSecgen01`) y verifica el enlace con
`ensureResolutionLinkPersisted`, que incluso repara con un `UPDATE` directo el
caso conocido en que el PA escribe `num_resolu` pero nunca `id_docum`.

### 2.3 El PA que emite el folio

`secgen_db.Analisis2.ar_doc1iSecgen10`, llamado con `cod_tipdoc = 3`
(resolución exenta) y `cod_emisor = 1` (Secretaría General):

- exige que el RUT sea **administrador de documentos** (`archivo_db..ar_adm1`);
- **rechaza** cualquier combinación que no sea exenta de Secretaría General:
  `if @cod_tipdoc != 3 OR @cod_emisor != 1 → error`;
- toma el último correlativo de `ar_prm2` (tipo + año) o `ar_prm3` (tipo + año +
  emisor) con `holdlock`, lo incrementa, lo actualiza, e inserta en `ar_doc1`,
  `ar_doc6` (historial de estados) y `ar_parm` (último `id_docum`), todo en una
  transacción;
- devuelve `id_docum` y `nro_docum`.

**El dato decisivo para este requerimiento** está en la cabecera del PA:

> Modificación, JLRS, 07/03/2019: LEY, DFL, DL, DS, Oficio (cod_tipdoc =
> 6,7,8,9,14), permiten numeración manual, solo se valida que no exista el
> archivo.
> **Modificación, JLRS, 05/07/2024: Solo dejamos numeración automática y
> restringimos al uso de resoluciones exentas emitidas por secretaría general.**

Y en la firma del PA el parámetro está **comentado**:

```sql
--@nro_docum   int          = null,
```

El cuerpo todavía tiene las ramas `if @nro_docum is null` y declara
`@nro_docum` como variable local, así que la numeración manual es **código
muerto**: `@nro_docum` siempre es NULL y siempre se toma el camino automático.

O sea: la numeración manual de exentas **existía y se quitó a propósito en
julio de 2024**.

### 2.4 Quién más usa el mismo PA

`ar_doc1iSecgen10` no es de PDS. Lo llaman, con el mismo `cod_tipdoc = 3`:

- `balances-return.controller.ts`
- `cost-center/cost-center-opening.controller.ts`
- `cost-center-close/cost-center-close.controller.ts`
- `incentives-production-scientific.controller.ts`
- `tendering-rules/tendering-rules.controller.ts`
- `service-provision/service-provision-request-approval.controller.ts`

Todos consumen el **mismo correlativo** de `ar_prm2`/`ar_prm3`. El folio es un
recurso institucional compartido, no una secuencia de este módulo.

---

## 3. Dónde se guarda y dónde se modifica

| Operación | Vía | Escribe |
| :--- | :--- | :--- |
| Emitir folio | `ar_doc1iSecgen10` | `ar_doc1`, `ar_doc6`, `ar_prm2`/`ar_prm3`, `ar_parm` |
| Enlazar a la resolución | `sg_rslcuSecgen01` (`updateResolutionData`) | `sg_rslc.num_resolu`, `codigo_sdg`, `f_resolucio`, `id_docum` |
| Reparar enlace roto | `UPDATE sg_rslc SET id_docum` (`forceSetResolutionDocumentId`) | `sg_rslc.id_docum` |
| Guardar decretación (CSGD + fecha) | `PATCH /requests/service-provision/update-resolution-data` | las mismas columnas, **pero preservando el `num_resolu` ya guardado** |

Ese último punto importa: `service-provision-request-approval.repository.ts`
→ `updateResolutionData` **no toma el número externo del request**, lo relee de
la base y lo reescribe igual:

```ts
resolutionExternalNumber: resolutionData[0]?.resolutionExternalNumber ?? null,
```

Es decir, hoy **el número exento no es editable por el usuario en ningún
endpoint**. La única forma de que cambie es emitir un folio nuevo.

Y hay una ventana: si `getResolutionDocumentState` devuelve `immutable`
(resolución archivada, o solicitud terminada/archivada/rechazada), tanto la
generación como la actualización se rechazan con 422.

---

## 4. Quién lee el número exento (a qué afecta el cambio)

El número exento es **de sólo lectura en todo el resto del sistema**, lo cual es
una buena noticia: nadie calcula con él, se muestra y se busca.

**Backend**
- El título del PDF: `` `Resolución exenta N° ${...}` `` en
  `resolution-document.controller.ts`, `cost-center-opening`, `balances-return`.
- `getResolutionDocumentState.officialAssigned = externalNumber > 0 &&
  documentId > 0` — la condición de "ya tiene número oficial".
- La generación del documento definitivo y su vista previa
  (`resolution.controller.ts:1672, 1926`).

**Frontend**
- `pages/services-provision/_id/index.vue:47` — el encabezado de la solicitud
  (`|| 'Sin asignar'`).
- `ChangeStateResolutionModal.vue:61` — el resumen antes de firmar.
- Las vistas de **pago**: `payments/index.vue`, `payments/_nroSolici/index.vue`,
  `payments/review/.../_installmentNumber.vue`, que lo usan para rotular la
  resolución de cada cuota.
- Los **filtros de búsqueda**: `servicesProvisionPaymentsFilter.js` y
  `servicesProvisionDgdpReviewFilter.js` buscan por este número.
- `Du288StaffPreviousProvisionsModal.vue` lo usa para **ordenar** prestaciones
  previas (`Number(resolutionExternalNumber || resolutionId)`).
- `textSimilarityUtil.js:802` lo formatea como `N° X/año`.

Consecuencia práctica: si el número pasa a ser digitado, todos estos lugares
siguen funcionando **siempre que el número siga siendo numérico**. El orden de
`Du288StaffPreviousProvisionsModal` y los filtros asumen eso.

---

## 5. El precedente: ya se intentó y está comentado

`pages/tendering-rules/_id/resolution-format.vue:44-51` tiene exactamente el
input que se pide, **comentado**:

```html
<!-- <input-root
  type="number"
  rules="required"
  name="resolución exenta"
  label="Resolución exenta"
  placeholder="JPS/PDG/CMI/jth"
  v-model="resolutionUpdateData.resolutionExternalNumber"
/> -->
```

Encaja con la fecha del cambio del PA: el input quedó inerte cuando la
numeración manual se cerró en el PA en julio de 2024. Conviene confirmar con
Secretaría General si la decisión de 2024 sigue vigente antes de reabrirla.

---

## 6. Qué habría que cambiar

El número exento no puede quedar solo en `sg_rslc`: el documento oficial
(`ar_doc1` / `id_docum`) es lo que sostiene el PDF, el archivo universitario y la
condición `officialAssigned`. Así que hay que decidir **qué pasa con la fila de
`ar_doc1`**. Tres caminos, con sus consecuencias.

### Opción A — Reabrir la numeración manual en el PA (lo correcto si la decisión de 2024 se revierte)

Descomentar `@nro_docum` en `ar_doc1iSecgen10` y reponer la validación de
duplicado que la cabecera de 2016 menciona, acotada a exentas:

- si `@nro_docum` viene: validar que no exista ya ese `(cod_tipdoc, cod_emisor,
  ano, nro_docum)` y **no** tocar `ar_prm2`/`ar_prm3`;
- si viene NULL: comportamiento actual, intacto.

| | |
| :--- | :--- |
| A favor | un solo lugar decide; el documento oficial se crea igual; los otros cinco flujos no cambian |
| En contra | es un PA de Secretaría General, compartido, y revierte una decisión institucional explícita. **No está en `cambios_pa`** |
| Riesgo | si el número digitado no actualiza el correlativo, el siguiente automático puede chocar con el digitado |

### Opción B — Un PA propio de inserción con número dado

Un `ar_doc1iSecgen11` (o equivalente en `cambios_pa`) que inserte en `ar_doc1`
con el `nro_docum` recibido, validando duplicado, sin tocar los correlativos.

| | |
| :--- | :--- |
| A favor | no modifica el PA de Secretaría General |
| En contra | duplica lógica de una tabla que no es nuestra; dos caminos de escritura sobre `ar_doc1` |
| Riesgo | el mismo del correlativo, más el de divergir del PA original cuando éste cambie |

### Opción C — Digitar solo en `sg_rslc`, sin documento oficial

Guardar `num_resolu` desde el input y dejar `id_docum` nulo.

| | |
| :--- | :--- |
| A favor | no toca ningún PA; es solo el input + levantar la preservación del campo en `updateResolutionData` |
| En contra | **rompe `officialAssigned`** y, con él, el documento definitivo y el archivo universitario. La resolución tendría número pero no documento |
| Veredicto | no sirve como solución final; solo como paso intermedio si se decide que el documento oficial se registra aparte |

**Recomendación:** la **A**, si Secretaría General confirma que la numeración
manual de exentas vuelve a estar permitida. Si no lo confirma, el requerimiento
no es implementable sin romper el documento oficial, y la conversación es con
ellos antes que con el código.

---

## 7. Lo que hay que tocar en cada capa (asumiendo A o B)

### 7.1 Base de datos
- `ar_doc1iSecgen10` (A) o un PA nuevo (B), con validación de duplicado.
- `sg_rslcuSecgen01` ya acepta `@num_resolu`: **no requiere cambios**. Ojo: la
  copia en `nuevo_workflow_fase_2/template-du09/.../sg_rslcuSecgen01.sql` **no
  tiene `@id_docum`** aunque la query del backend lo manda — el PA desplegado
  debe ser otra versión, y eso explica el bug conocido de `id_docum` que el
  backend repara a mano. Conviene alinear la copia con lo desplegado antes de
  tocar nada acá.

### 7.2 Backend
- `ResolutionNumberEditMultipleRequests` / `ResolutionNumber`: aceptar el
  `resolutionExternalNumber` digitado.
- `createNumberResolutionExclusive`: cuando venga número digitado, **validar que
  no exista** (ya hay `selectDocumentByCorrelative` = `ar_doc1sSecgen01` para
  eso) y pasarlo al PA en vez de dejar que lo calcule. Los tres self-heals de
  §2.2 siguen siendo necesarios: el lock, la reutilización y la adopción de
  huérfanos no sobran porque el número sea manual.
- `service-provision-request-approval.repository.ts → updateResolutionData`:
  dejar de preservar ciegamente el número guardado **solo** si se decide que la
  decretación puede corregirlo; si no, dejarlo como está.
- Un error claro y distinto para "ese número ya está usado", porque pasa a ser
  el error más frecuente de la pantalla.

### 7.3 Frontend
- El input va en `pages/services-provision/_id/resolution-format-normative.vue`,
  en la tira **"Cierre de edición"** (líneas ~165-185), como tercer campo junto
  a **CSGD** (`sdgCode`) y **Fecha de decretación** (`resolutionDate`), que ya se
  guardan juntos con `triggerSaveConfirmation`.
- `ChangeStateResolutionModal.handleApproveOrSignRequest` debe **mandar** el
  número digitado en el payload de `createResolutionNumber` y **bloquear la
  firma** si falta, en vez de descubrirlo con el `throw` posterior.
- Textos en `lang/es/pds.js` (`resolution.fields` / `placeholders` /
  `messages`), siguiendo el estándar del módulo.

---

## 8. Riesgos a vigilar

1. **Choque de correlativos.** Si el número digitado no avanza
   `ar_prm2`/`ar_prm3`, el próximo folio automático de **cualquiera** de los seis
   flujos puede caer sobre un número ya digitado. Es el riesgo central y hay que
   decidirlo explícitamente: ¿el número manual reserva el correlativo o no?
2. **Idempotencia.** Los tres self-heals existen porque en producción se
   gastaron folios huérfanos (resolución 189, folio 37, documento 6092, está
   documentado en el código). Con número manual el problema cambia de forma pero
   no desaparece: un reintento con el mismo número debe reutilizar, no duplicar.
3. **Confusión de variables.** El riesgo de redactar `resolutionNumber` donde va
   `resolutionExternalNumber`. En la vista de decretación conviven el interno
   (en la URL, `params.resId`) y el exento (el input nuevo).
4. **Formato.** Hoy es `int`. El `placeholder` del input comentado en
   tendering-rules dice `JPS/PDG/CMI/jth`, que es una **sigla**, no un número —
   seguramente un copiar-pegar del campo CSGD, pero vale confirmar que lo que se
   quiere digitar es un entero y no un texto. Si fuera texto, se rompen el orden
   y los filtros de §4.
5. **La ventana de edición.** Si el número se digita en decretación pero el folio
   se emite al firmar, entre los dos momentos el número está "prometido" y no
   reservado: dos resoluciones en decretación podrían llevar el mismo número
   hasta que una firme.

---

## 9. Decisiones necesarias antes de implementar

1. **¿Secretaría General autoriza volver a la numeración manual de exentas?** La
   decisión de julio de 2024 fue explícita y el PA es suyo. Sin esto, no hay
   implementación posible que conserve el documento oficial.
2. **¿El número digitado reserva correlativo** (avanza `ar_prm2`/`ar_prm3`) **o
   queda fuera de la secuencia?** De esto depende si los otros cinco flujos
   pueden chocar con él.
3. **¿Es entero o texto?** Hoy `int`, y varias vistas ordenan y filtran por él
   como número.
4. **¿Se digita en decretación o al firmar?** Digitarlo en decretación es lo que
   se pide, pero abre la ventana del riesgo 5. Lo más seguro es **digitarlo en
   decretación y validar la unicidad dos veces**: al guardar y al firmar.
5. **¿Se puede corregir un número ya guardado,** y hasta qué estado? Hoy
   `updateResolutionData` lo preserva a propósito.

---

## 10. Mapa simple de tablas y PA

### `secgen_db` — la resolución y la solicitud

| Tabla | Qué guarda | Quién escribe | Quién lee |
| :--- | :--- | :--- | :--- |
| `sg_rslc` | La resolución: `nro_resolu` (interno), **`num_resolu` (el externo)**, `id_docum`, `codigo_sdg`, `f_resolucio` | `sg_rslciSecgen01` (alta), `sg_rslcuSecgen01` (número + CSGD + fecha), `sg_rslcuSecgen03` (estado), `sg_rslcuSecgen04` (marca ingresada) | `sg_rslcsSecgen01` |
| `sg_parm` | El contador del `nro_resolu` interno | `sg_rslciSecgen01` | — |
| `sg_soli` | La solicitud. Guarda `nro_resolu` + `ano_resolu`, el **interno** | `sg_soliuSecgen03` | varios |
| `sg_rede` | El texto y detalle de la resolución | `sg_redeiSecgen01` | `sg_redesSecgen01` |
| `sg_apre` | Los firmantes y sus decisiones | `sg_apreiSecgen01`, `sg_apreuSecgen01` | `sg_apresSecgen01/02/03` |

### `archivo_db` — el Archivo Universitario

| Tabla | Qué guarda | Quién escribe | Quién lee |
| :--- | :--- | :--- | :--- |
| `ar_doc1` | El documento: `id_docum`, **`nro_docum` (el número exento)**, `ano`, `cod_tipdoc`, `cod_emisor`, `tab_mysql` | `ar_doc1iSecgen10` | `ar_doc1sSecgen01` (por número), `ar_doc1sSecgen02` (por id) |
| `ar_doc6` | Historial de estados del documento y RUT de quien lo registró | `ar_doc1iSecgen10` | — |
| `ar_parm` | Contador global de `id_docum` | `ar_doc1iSecgen10` | — |
| `ar_prm2` / `ar_prm3` | Contador del número exento (tipo+año / tipo+año+emisor) | `ar_doc1iSecgen10` | — |
| `ar_adm1` | Quiénes son administradores de documentos | — | `ar_doc1iSecgen10`, que lo valida |
| `ar_edoc` | Catálogo de estados de documento | — | `ar_doc1sSecgen01` |

### MySQL — los archivos

| Almacén | Qué guarda | Clave |
| :--- | :--- | :--- |
| `MyArchivo.<tab_mysql>` | El documento del Archivo Universitario | `id_docum` |
| MySQL secgen, tabla por año | **El PDF que genera el sistema** | `(ano_resolu, nro_resolu interno, correlativ)` |

### El número externo vive en **dos** lugares

| Lugar | Para qué |
| :--- | :--- |
| `archivo_db..ar_doc1.nro_docum` | El registro institucional. Da la unicidad y la llave (`id_docum`) del documento |
| `secgen_db..sg_rslc.num_resolu` | La copia que usa el sistema para mostrar, buscar y titular el PDF |

---

## 11. Si el número lo emiten **externamente**: qué cambia

Premisa: Secretaría General registra el documento en el Archivo Universitario
**fuera** de este sistema, y decretación solo digita el número que le
entregaron. Entonces este sistema **no inserta en `ar_doc1`**.

La diferencia está en si la fila de `ar_doc1` existe o no.

### Variante A — La fila existe, la creó Archivo (**recomendada**)

No insertamos: **buscamos y enlazamos**. El paso de emisión cambia de *insertar*
a *consultar*:

| | Antes | Ahora |
| :--- | :--- | :--- |
| PA | `ar_doc1iSecgen10` (emite) | `ar_doc1sSecgen01` (busca por tipo+emisor+año+número) |
| Qué obtiene | `id_docum` + `nro_docum` nuevos | el `id_docum` de la fila que ya existe |
| Escribe en `archivo_db` | `ar_doc1`, `ar_doc6`, `ar_parm`, `ar_prm2/3` | **nada** |

**Lo mejor: ya está implementado.** El método
`findOfficialDocumentByCorrelative(años, número)` existe en
`service-provision-request-approval.repository.ts` y hace exactamente esto —
hoy se usa como rescate cuando `sg_rslc` perdió el `id_docum`. Solo hay que
llamarlo como camino principal.

Lo que hay que cambiar:

1. **Backend, `createNumberResolutionExclusive`**: en vez de `createResolutionNumber`
   (el PA que emite), llamar a `findOfficialDocumentByCorrelative` con el número
   digitado. Si devuelve `id_docum`, el resto del paso sigue igual.
2. **Un error nuevo y claro** cuando el número no está en `ar_doc1`: *"El número
   de resolución exenta no está registrado en el Archivo Universitario. Verifique
   el número o espere a que Secretaría General lo registre."* Va a ser el error
   más frecuente de la pantalla y hoy no existe.
3. **`updateResolutionData`**: dejar que acepte el número digitado mientras la
   resolución no tenga `id_docum` ni sea inmutable. Hoy lo preserva siempre.
4. **Frontend**: el input en la tira "Cierre de edición" de
   `resolution-format-normative.vue`, junto a CSGD y fecha de decretación, y
   bloquear el envío a firma si el número falta.
5. **No se necesita ningún PA nuevo.** La idea de un PA de inserción con número
   dado queda descartada: no hay nada que insertar.

Lo que **no** cambia: el candado por resolución, los rescates, la escritura de
`sg_rslc` y `sg_soli`, las tres compuertas del número, la generación del PDF y el
Archivo Universitario. Todo sigue funcionando porque `id_docum` sigue llegando.

**La pregunta operativa:** ¿decretación digita el número **después** de que
Archivo lo registró? Si lo digita antes, la búsqueda no lo encuentra y el envío a
firma se bloquea hasta que el registro exista. El flujo actual ya acomoda las dos
cosas: el número se guarda en decretación y se resuelve el `id_docum` recién al
enviar a firma.

### Variante B — No hay fila de `ar_doc1` en ninguna parte

Solo se guarda `num_resolu` y `id_docum` queda nulo. Hay que cambiar **tres
compuertas**:

| # | Dónde | Qué exige hoy | Qué tendría que exigir |
| :-- | :--- | :--- | :--- |
| 1 | `resolution-approval.repository.ts:434` | `officialAssigned` = `num_resolu > 0 && id_docum > 0`, con el mensaje *"Debe generar el documento oficial antes de aprobar"* | solo `num_resolu > 0` |
| 2 | `resolution.controller.ts`, `signatures-document-base` | `externalResolutionNumber > 0 && externalDocumentId > 0` | solo el número |
| 3 | `service-provision-request-approval.controller.ts:474` | `hasGeneratedResolution` por `documentId > 0`, que impide el rechazo posterior | por `num_resolu > 0` |

Y se pierde, sin reemplazo dentro del sistema: el documento del Archivo
Universitario (no hay `id_docum` bajo el cual guardarlo ni recuperarlo), la
unicidad del número y el registro de `ar_doc6`.

**Recomendación: la A.** Cuesta menos —reutiliza un método que ya existe y no
necesita PA nuevo—, no mueve ningún control y deja el documento donde el resto
del sistema lo espera. La B solo se justifica si el Archivo Universitario queda
definitivamente fuera del alcance de este flujo, y conviene dejar esa decisión
por escrito antes de tocar las tres compuertas.
