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

---

## 12. Implementación acordada: número digitado, sin registrar en `ar_doc1`

Decisión tomada: la emisión y el registro del número son **externos a este
sistema**. Acá solo se **ingresa el número ya generado** y se **asocia antes de
aprobar**. `ar_doc1iSecgen10` deja de usarse en PDS; `sg_rslc` queda como la
única tabla donde el sistema guarda la resolución y su número externo.

**Estado: aplicado el 23-10-2026.** Backend compila, 206 pruebas pasan; frontend
13 pruebas / 14 archivos, eslint sin hallazgos nuevos en lo tocado.

### Reglas que se siguieron

1. **Nada se elimina.** Cada línea que deja de aplicar se comenta dejando el
   original a la vista, para volver atrás sin reconstruir nada.
2. **Solo código de PDS.** Ningún archivo compartido con los otros cinco flujos
   que emiten resoluciones exentas. En particular `resolution.repository.ts`,
   `resolution-approval.repository.ts`, `ar_doc1iSecgen10` y
   `generateResolutionNumber` quedan **intactos**.
3. **Ningún PA nuevo ni modificado.** `sg_rslcuSecgen01` ya acepta `@num_resolu`;
   la única consulta agregada es un `select` de lectura, con el mismo criterio
   que los `select` directos que ya existían en el archivo de queries.
4. **Nada de alcance extra.** No se tocó el flujo de pagos, ni la creación de
   cuotas, ni la cadena de firmas más allá de la condición del número.

### 12.1 El modelo que queda

| Campo | Qué es | Después del cambio |
| :--- | :--- | :--- |
| `sg_rslc.nro_resolu` | Correlativo interno de la resolución (ej. 205) | Igual: sigue saliendo de `sg_parm` |
| `sg_rslc.num_resolu` | **El número externo digitado** | Lo escribe el guardado de decretación |
| `sg_rslc.id_docum` | FK al documento en `ar_doc1` | **Queda nulo.** El documento se gestiona fuera |

### 12.2 Un hallazgo que juega a favor

`sg_rslcuSecgen01` exige `@num_resolu` no nulo: si llega nulo devuelve
*"Falta campo numero de resolucion"* como `msg` y **no escribe nada**. Y hoy el
guardado de decretación manda `num_resolu = NULL` mientras no exista folio
(`updateResolutionData` relee el valor guardado, que es nulo).

O sea que **hoy, guardar CSGD y fecha antes de que exista el folio no persiste
nada**: falla en silencio. Con el input, ese mismo guardado pasa a ser el que
persiste las tres cosas. El camino que necesitamos ya existe y ya apunta a la
columna correcta.

> Inferido del PA que está en el repositorio. La copia versionada **no tiene**
> `@id_docum` aunque la query del backend lo manda, así que el desplegado es otra
> versión: conviene confirmar contra el servidor antes de dar esto por cierto.

### 12.3 Frontend — el input en decretación

`pages/services-provision/_id/resolution-format-normative.vue`

Estado inicial, agregar el campo:

```js
      resolutionUpdateData: {
        sdgCode: '',
        resolutionDate: '',
        resolutionExternalNumber: null,
        resolutionNumber: Number(this.$route.params.resId),
        resolutionYear: 0,
      },
```

Template, tira **"Cierre de edición"**, como tercer campo antes del botón de
guardar:

```html
            <div class="pds-ui-field-medium">
              <input-root
                v-model="resolutionUpdateData.resolutionExternalNumber"
                type="number"
                :label="$pdsText.resolution.fields.externalResolution"
                :placeholder="$pdsText.resolution.placeholders.externalResolution"
                name="resolución exenta"
                rules="required|numeric|min_value:1"
              />
            </div>
```

Y en la carga (`formDetail`), restaurar lo guardado igual que los otros dos:

```js
      this.resolutionUpdateData.resolutionExternalNumber = formDetail[0]?.resolutionExternalNumber ?? null
```

La validación de `openViewFile` ya exige CSGD y fecha; se le suma el número:

```js
      // if (!this.resolutionUpdateData?.sdgCode || !this.resolutionUpdateData?.resolutionDate) {
      if (
        !this.resolutionUpdateData?.sdgCode ||
        !this.resolutionUpdateData?.resolutionDate ||
        !(Number(this.resolutionUpdateData?.resolutionExternalNumber) > 0)
      ) {
```

### 12.4 Frontend — no llamar a la emisión automática

`components/services-provision/resolution-format/ChangeStateResolutionModal.vue`,
`handleApproveOrSignRequest`. La guarda se mantiene, solo cambia de dónde lee el
número:

```js
      if (this.modalType === 'approve') {
        /* El numero externo se gestiona fuera del sistema: llega digitado desde
           decretacion y ya quedo en sg_rslc. La emision automatica no aplica. */
        // const externalResolution = await this.createResolutionNumber({
        //   ...this.payload,
        //   resolutionNumber: resId,
        //   resolutionYear: Number(this.payload?.resolutionYear) || new Date().getFullYear(),
        //   requestsIds: [reqId],
        //   resolutionMessage: this.payload?.resolutionMessage || `Resolución de prestación de servicios - Solicitud N° ${reqId}`,
        //   dni: this.$auth?.user?.dni,
        // })
        // if (Number(externalResolution?.resolutionExternalNumber || 0) <= 0) {
        if (Number(this.payload?.resolutionExternalNumber || 0) <= 0) {
          throw new Error(
            this.$pdsText.resolution.messages.externalResolutionNumberUnavailable
          )
        }

        await this.generateFinalResolutionDocument(reqId, resId)
      }
```

El `mapActions` de `createResolutionNumber` **se deja**: no molesta y evita tocar
el bloque de acciones.

### 12.5 Backend — dejar que el guardado acepte el número

`src/repositories/service-provision-request-approval.repository.ts`,
`updateResolutionData`. Hoy relee el guardado y lo reescribe igual. Se le agrega
el número del request **conservando el comportamiento anterior como respaldo**:

```ts
    const payload = new ResolutionEditRequest({
      resolutionNumber: request.resolutionNumber,
      /* El numero externo llega digitado desde decretacion. Si no viene, se
         conserva el que ya estaba, que era el comportamiento anterior. */
      resolutionExternalNumber:
        Number(request.resolutionExternalNumber) > 0
          ? Number(request.resolutionExternalNumber)
          : (resolutionData[0]?.resolutionExternalNumber ?? null),
      sdgCode: request.sdgCode,
      resolutionDate: request.resolutionDate,
      requestsIds: request.requestsIds,
      resolutionYear: request.resolutionYear,
    });
```

Conviene además rechazar un número ya usado por **otra** resolución del mismo
año, porque la unicidad ya no la da `ar_doc1`. Ver 12.9.

### 12.6 Backend — la compuerta de aprobación, **solo en PDS**

Acá había que tener cuidado. `officialAssigned` se calcula en
`resolution.repository.ts`, que es **compartido**: lo consumen los otros flujos.
Tocarlo ahí relajaría la compuerta para todos.

No hace falta. La compuerta de PDS **ya está aislada**:
`service-provision-request-approval.repository.ts` tiene su propia copia de
`signResolution` —hecha precisamente para no modificar la de
`resolution-approval.repository.ts`, que también usa cost-center-close— y calcula
su propio `officialAssigned` con la lectura directa a `sg_rslc`:

```ts
        const link = await this.getResolutionLinkDirect(Number(nro_resolu), false, false);
        // const officialAssigned = link.externalNumber > 0 && link.documentId > 0;
        const officialAssigned = link.externalNumber > 0;
```

**`resolution.repository.ts` no se toca.** Los otros cinco flujos quedan
exactamente como estaban.

### 12.7 Backend — la compuerta del PDF

`src/controllers/resolution.controller.ts`, en `signatures-document-base` (y en
su gemelo `-prev-view`, que tiene el mismo bloque):

```ts
    // const { documentId: externalDocumentId } =
    //   await this.serviceProvisionRequestApprovalRepository.getResolutionLinkDirect(
    //     Number(internalResId), true, true,
    //   );

    // if (externalResolutionNumber <= 0 || externalDocumentId <= 0) {
    if (externalResolutionNumber <= 0) {
      throw new HttpErrors.Conflict(
        'La resolución todavía no tiene un número externo oficial asignado.',
      );
    }
```

La lectura directa se comenta junto con la condición: si se deja declarada sin
usar, eslint la marca.

### 12.8 Backend — la protección contra rechazo posterior

`src/controllers/service-provision/service-provision-request-approval.controller.ts`,
`officialAssignedDirect`. Un cambio de palabra: el mismo `getResolutionLinkDirect`
ya devuelve `externalNumber`.

```ts
    const officialAssignedDirect =
      Number.isFinite(existingResolutionNumber) && existingResolutionNumber > 0
        ? (await this.serviceProvisionRequestApprovalRepository.getResolutionLinkDirect(
            existingResolutionNumber,
            true,
            true,
          // )).documentId > 0
          )).externalNumber > 0
        : false;
```

Sin esto, la regla *"una vez decretada, los roles posteriores solo pueden devolver
a corrección"* queda apagada y el rechazo volvería a ser posible.

### 12.9 Lo único realmente nuevo: la unicidad

La validación de número repetido vivía en `ar_doc1`. Al no escribir ahí, hay que
ponerla en `sg_rslc`. Lo más simple, sin PA nuevo: una consulta en el guardado de
decretación que busque otra resolución del mismo año con ese `num_resolu`, y un
error claro si existe.

Es la única pieza que no se resuelve comentando: sin ella, dos resoluciones
pueden quedar con el mismo número exento y nada lo detecta.

### 12.10 Lo que queda intacto y sin uso

| Qué | Por qué no se borra |
| :--- | :--- |
| `ar_doc1iSecgen10` y `generateResolutionNumber` | Los usan los otros cinco flujos (saldos, apertura y cierre de centro de costo, incentivos, bases de concurso) |
| El endpoint `create-number-resolution` de PDS y `createNumberResolutionExclusive` | Quedan publicados y sin llamador desde el frontend. Volver atrás es descomentar |
| Los tres rescates (candado, reutilización, folios huérfanos) | Siguen sirviendo para las resoluciones que ya tienen folio emitido por el camino viejo |
| `ar_doc1sSecgen01` / `ar_doc1sSecgen02` | Son de lectura y los usa el Archivo Universitario |

### 12.11 Lo que se pierde, para que esté dicho

- **El documento del Archivo Universitario**: sin `id_docum` no hay llave bajo la
  cual guardarlo ni recuperarlo desde `MyArchivo`. El PDF que genera el sistema
  **no** se afecta: se guarda por el número interno.
- **`ar_doc6`**: no queda registro en el archivo de quién asignó el número.
- **El correlativo compartido** (`ar_prm2`/`ar_prm3`) no se entera de los números
  usados por PDS. Si la gestión externa es la misma oficina que emite para los
  otros flujos, el problema no existe; si no, hay que confirmarlo.

### 12.12 Pruebas

| # | Caso | Esperado |
| :-- | :--- | :--- |
| 1 | Guardar decretación con CSGD, fecha y número | Las tres columnas quedan en `sg_rslc` (hoy no guarda nada sin folio) |
| 2 | Reabrir la pantalla | El número se muestra, no vuelve vacío |
| 3 | Enviar a firma sin número | Bloqueado en el frontend, sin llamada al backend |
| 4 | Enviar a firma con número | Genera el PDF con el número en el título y avanza al firmante |
| 5 | Aprobar como firmante | Pasa la compuerta sin `id_docum` |
| 6 | Número repetido en el mismo año | Rechazado con mensaje claro (12.9) |
| 7 | Rechazar como rol posterior a decretación | Sigue bloqueado: solo devolver a corrección |
| 8 | Resolución vieja, con folio ya emitido | Sigue funcionando: el número se lee de `sg_rslc` igual |

---

## 13. Las validaciones que reemplazan al PA

El PA validaba seis cosas. Al dejar de llamarlo, cada una tenía que encontrar
otro lugar o quedar explícitamente descartada.

| Lo que validaba `ar_doc1iSecgen10` | Dónde quedó |
| :--- | :--- |
| Parámetros obligatorios | **Front**: `rules="required|integer|min_value:1"`, validado por el `ValidationObserver` que ya corre al guardar y al enviar a firma. **Back**: formato y rango |
| El año del documento coincide con su fecha | **Back**: la fecha de decretación debe caer en el año de la resolución |
| Número no repetido | **Back**: `assertExternalNumberIsFree` sobre `sg_rslc`, por año |
| RUT administrador de documentos vigente (`ar_adm1`) | **Perdido.** Decisión pendiente, ver 13.3 |
| `cod_tipdoc = 3` y `cod_emisor = 1` | No aplica: ya no se registra documento |
| Existen parámetros de correlativo | No aplica: ya no se consume correlativo |
| Integridad transaccional (4 tablas) | No aplica: queda una sola escritura, en `sg_rslc` |

### 13.1 Backend — lo aplicado

Todo en `service-provision-request-approval.repository.ts → updateResolutionData`,
en este orden:

1. **Resolución inmutable** → 422. Ya existía.
2. **Formato y rango**: un valor presente pero inválido se **rechaza**, no se
   ignora. Entero, mayor que cero, hasta `2147483647` (el `int` de Sybase). Sin
   esto el guardado "funcionaba" conservando el número anterior y nadie se
   enteraba de que el digitado se perdió.
3. **Congelado solo con documento firmado** (corregido el 23-10-2026): si ya hay
   un documento **firmado** cargado y el número cambia, se rechaza.

   La primera versión congelaba con el documento **base** generado, y estaba
   mal: una resolución **devuelta a corrección** vuelve a decretación con el
   base ya creado, y así no se podía corregir el número —que es justamente para
   lo que la devolvieron—. El mensaje incluso decía "devuelva la resolución a
   corrección", cosa que ya se había hecho.

   El base no necesita congelar nada porque **se regenera en cada envío a
   firma** a partir de `sg_rslc`, y esa regeneración además borra la firma
   anterior: la corrección se propaga sola. Lo que no se puede rehacer desde
   acá es un documento ya firmado, que lleva el número anterior.

   **Ventana conocida:** entre que se cambia el número y se vuelve a enviar a
   firma, el documento base almacenado sigue teniendo el número viejo y se
   puede descargar. Se corrige solo al enviar a firma.
4. **Coherencia año/fecha**: si la fecha de decretación cae en otro año que la
   resolución, se rechaza. Importa porque la unicidad se verifica **por año**:
   con el año mal, el número se compara contra el período equivocado. Solo se
   compara cuando se puede extraer un año de cuatro dígitos, porque la fecha
   llega en más de un formato según la pantalla y un formato no reconocido no
   debe hacer fallar un guardado válido.
5. **Unicidad** por `(num_resolu, ano_resolu)` en `sg_rslc`, excluyendo la propia
   resolución.

Y las tres compuertas del número que ya estaban, ahora sin `id_docum`: generar el
documento, aprobar como firmante, y la protección contra rechazo posterior.

Cubierto por `src/__tests__/unit/service-provision-external-resolution-number.unit.ts`
(9 casos). Total del backend: 215 pruebas.

### 13.2 Frontend — lo aplicado

- `required|integer|min_value:1` más `type="number"` y `min="1"`. El
  `ValidationObserver` ya se valida en el guardado (`triggerSaveConfirmation`) y
  en el envío a firma (`submitResolutionForm('approve')`), así que el mismo campo
  cubre los dos sin código nuevo.
- La guarda antes de enviar a firma lee el número del payload y corta con un
  mensaje que ahora dice lo que corresponde: *"Debe ingresar el N° de resolución
  exenta en el formato antes de enviar a firma."*
- **La confirmación muestra el número.** El modal ya tenía el bloque de resumen
  pero las pantallas de formato no le pasaban `:resolution-summary`, así que no
  se veía. Con numeración digitada el error de tipeo es el riesgo principal y ese
  es el último momento para verlo.
- Las dos pantallas de decretación (`resolution-format-normative.vue` y
  `resolution-format.vue`) recibieron lo mismo: ambas están vivas para DU288.

### 13.3 Decisiones pendientes

**a) Autorización.** El PA exigía ser administrador de documentos vigente en
`ar_adm1`. Hoy `PATCH /requests/service-provision/update-resolution-data` tiene
solo `@authenticate('jwt')`: ningún privilegio ni rol. Antes eso cambiaba la
sigla y la fecha; ahora cambia **el número oficial de la resolución**. Si
corresponde restringirlo, el patrón es el de los otros endpoints PDS: un
privilegio verificado en el backend, no solo el `getRolePermission` del
frontend, que es presentación.

**b) Unicidad contra el Archivo Universitario.** La unicidad que se validó es
dentro de `sg_rslc`. Si el número exento es un correlativo único de toda la
Universidad, un número digitado en PDS podría chocar con uno emitido
automáticamente por otro de los cinco flujos, y eso no se detecta.

Se puede consultar `ar_doc1` en modo lectura (`ar_doc1sSecgen01` ya existe), pero
el resultado es **ambiguo**: encontrar el número puede significar que Secretaría
General ya lo registró —que es lo esperado— o que pertenece a otro documento. No
se puede distinguir con certeza, así que serviría para **avisar**, no para
bloquear. No se implementó: hace falta definir primero si la numeración externa y
la automática comparten el mismo universo.

**c) ¿Se puede corregir el número antes de generar el documento?** Hoy sí, y
después queda congelado (13.1 punto 3). Si debiera congelarse antes —por ejemplo
al enviar a firma— es un cambio de una línea en la misma validación.

---

## 14. El paso de Finanzas a Decretación

### 14.1 Qué se guarda en ese traspaso

Cuando **Finanzas** (`FinanceDirector`) aprueba, el avance a Decretación crea la
resolución, en `service-provision-request-approval.controller.ts`:

```ts
if (currentRoleName === FinanceDirector) {
  const resolutionRequest = new Resolution({
    requestId: request.requestNumber,
    resolutionYear: mysqlTableYear,
    templateId,
    documentId: undefined,        // id_docum nace NULO
    codEstres: ServiceProvisionResolutionStatusCode.CREATED,
  });
  const createdResolution = await this.resolutionRepository.createResolution(...);
  if (!createdResolution?.resolutionNumber) throw 409 'No fue posible crear la resolución. La solicitud no avanzará de etapa.'
}
```

Eso escribe tres cosas, ninguna documental:

| Tabla | Qué queda | PA |
| :--- | :--- | :--- |
| `sg_rslc` | la resolución: `nro_resolu` desde `sg_parm`, plantilla, estado CREADA, **`id_docum` nulo** y `num_resolu` nulo | `sg_rslciSecgen01` |
| `sg_rede` | las secciones de texto editables que copia la plantilla | `sg_redeiSecgen01` |
| `sg_soli` | el vínculo solicitud ↔ resolución (`nro_resolu`, `ano_resolu`) | `sg_soliuSecgen03` |

**No se genera ningún documento en ese paso**: ni PDF, ni fila en `ar_doc1`. El
PDF aparece recién al enviar a firma, y `ar_doc1` ya no se escribe.

### 14.2 ¿Afecta al cambio? No — al contrario

`id_docum` **ya nacía nulo** en ese traspaso (`documentId: undefined`
explícito). El cambio no altera nada de ese paso; lo que hace es volver
coherente el resto del flujo con algo que ya era así: `id_docum` nace nulo y
ahora simplemente se queda nulo.

### 14.3 Pero las etapas **posteriores** sí dependían de `id_docum`

Revisando este traspaso aparecieron **cinco guardas más** que exigían
`id_docum > 0` y que el cambio habría roto o apagado en silencio. Todas
corregidas con el mismo criterio —exigir el número externo en vez del
documento— y todas en rutas `/requests/service-provision/...`:

| # | Dónde | Qué pasaba sin corregir |
| :-- | :--- | :--- |
| 1 | `service-provision-workflow.service.ts`, `officialAssignedDirect` → `validateSecretaryStageSignedDocuments` | **Toda aprobación en Secretario General o posterior quedaba bloqueada**: *"Debe generar el documento oficial antes de continuar con las firmas."* |
| 2 | el mismo valor → `validateReturnConstraints` | La regla *"la devolución posterior a Decretación debe tener como destino Decretación"* **dejaba de aplicarse en silencio** |
| 3 | `PATCH /requests/service-provision/resolution/archive` | **Archivar era imposible**: *"No se puede archivar una resolucion sin documento oficial generado."* Y sin archivar (`cod_estsol = 11`) **no empiezan los pagos** |
| 4 | `POST /requests/service-provision/resolution/signatures-document` | Cargar el documento firmado quedaba bloqueado |
| 5 | el `GET` de estado documental | Devolvía `officialAssigned: false` al frontend, que apaga acciones por ese dato |

La 1 y la 3 eran bloqueos duros de todo el flujo; la 2 era peor por ser
silenciosa.

### 14.4 Lo que **no** se tocó, a propósito

| Dónde sigue exigiéndose `id_docum` | Por qué está bien |
| :--- | :--- |
| `resolution.repository.ts`, `officialAssigned` | Es compartido. Lo consume `resolution-approval.repository.ts` (cost-center-close), que **sí** sigue emitiendo folio y tiene `id_docum` real |
| `findOfficialDocumentByCorrelative` y `findOrphanedDocumentsByMessage` | Son los rescates para resoluciones que ya tienen folio del camino anterior |

### 14.5 Pruebas que agrega esta revisión

| # | Caso | Esperado |
| :-- | :--- | :--- |
| 9 | Finanzas aprueba y pasa a Decretación | Se crea `sg_rslc` con número interno, `sg_rede` con el texto, y el vínculo en `sg_soli`. Sin número externo todavía |
| 10 | Firmar en Secretario General | Pasa, con el número digitado y el documento base generado |
| 11 | Devolver a corrección desde una etapa posterior a Decretación | El destino sigue forzado a Decretación |
| 12 | Cargar el documento firmado | Permitido con número digitado y base generada |
| 13 | Archivar la resolución | Permitido; habilita el flujo de pagos (`cod_estsol = 11`) |
