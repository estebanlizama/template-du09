# Catastro de tablas para certificación PDS DU288

## 1. Objetivo y alcance

Este documento identifica las tablas que participan en la implementación vigente de solicitudes PDS DU288, sus dependencias y el orden que debe respetarse al actualizar el ambiente de certificación.

El objetivo práctico es responder: **si se agrega o modifica un dato, qué otros datos relacionados deben existir o actualizarse para que el sistema funcione de extremo a extremo**.

El catastro se construyó contrastando:

- el modelo físico disponible en `diagrama_secgen_actualizado.md`;
- los PA Sybase ASE 12.5 ubicados en `cambios_pa_solicitud_wf/solicitante`;
- las consultas actualmente invocadas por el backend;
- la implementación vigente del workflow DU288.

### Decisión de alcance

Este catastro se refiere al **ambiente de certificación** del módulo PDS DU288. No corresponde al módulo histórico llamado “Cert VRAC”.

La implementación vigente **no utiliza** las tablas propuestas `sg_wflu`, `sg_wfet`, `sg_wfin`, `sg_wfei`, `sg_apsa`, `sg_apsf` ni `sg_hiap`. El flujo implementado usa:

```text
sg_tfls -> sg_eta1 -> sg_eta2 -> sg_prse -> sg_apso
```

Tampoco se consulta `bd_pri2`. Los permisos se resuelven con `sistema_db.dbo.bd_per1`, `bd_prvg` y `bd_pepr`.

## 2. Qué hacer según lo que necesite actualizar

Esta sección responde las preguntas más frecuentes. Cada tarea indica **qué tablas tocar y en qué orden**, y cómo confirmar que quedó bien.

Antes de empezar, una advertencia que explica casi todos los problemas de certificación:

> **Estas tablas no tienen FK entre bases.** La base lo deja cargar en cualquier orden sin reclamar nada. Pero los procedimientos las cruzan con `INNER JOIN`, y si falta la fila padre **el registro completo desaparece de la pantalla**, no solo ese campo. Por eso un dato puede estar bien cargado y aun así no aparecer.

| Necesito... | Vaya a |
|---|---|
| Habilitar o corregir un funcionario | §2.1 |
| Crear o corregir un centro de costo | §2.2 |
| Dejar ítems y saldos al día | §2.3 |
| Que las etapas tengan quién apruebe | §2.4 |
| Saber qué NO se carga a mano | §2.5 |

---

### 2.1 Actualizar un funcionario

| Paso | Tabla | Qué debe quedar |
|---|---|---|
| 1 | `sisper_db.sp_pers` | La persona existe con su RUT. Si no está acá, nada más va a resolver. |
| 2 | `sisper_db`: `sp_carg`, `sp_cali`, `sp_estm`, `sp_jorn`, `sp_jpfu`, `sp_nigr`, `sp_sede`, `sp_vigc` | Existen el cargo, calidad, estamento, jornada, jerarquía, nivel, sede y vigencia que va a usar el contrato. |
| 3 | `ufro_db.es_unid` | Existe la unidad donde trabaja. |
| 4 | `sisper_db.sp_cont` | El contrato, **vigente y cubriendo el período** de la solicitud de prueba. Si no cubre las fechas, el contrato no aparece como elegible. |
| 5 | `sisper_db.ss_habe` y `ss_hrem` | Haberes del **mes inmediatamente anterior** a la fecha de la solicitud. Sin ese mes exacto, el tope falla con `REMUNERACION_MES_NO_DISPONIBLE`. |
| 6 | `sisper_db.sp_par1`, `sp_par2` | Parentesco, solo si va a probar esa validación. Vacías no rompen nada, pero tampoco prueban nada. |
| 7 | `sisper_db.sp_asng`, `sp_orde`, `sp_desg` | Asignaciones y designaciones, si va a probar carga horaria o inhabilidades por cargo. |

**Cómo saber si quedó bien:** busque el funcionario en el formulario de solicitud. Debe aparecer con su contrato, cargo y un tope mensual calculado, no en blanco ni con error.

---

### 2.2 Actualizar un centro de costo

El orden acá es estricto: los tres primeros entran por `INNER JOIN`, así que sin ellos **el centro no aparece** aunque esté cargado.

| Paso | Tabla | Qué debe quedar |
|---|---|---|
| 1 | `fin21_db.es_ufin` | La unidad financiera. Obligatoria. |
| 2 | `fin21_db.es_ecct` | El estado del centro. Obligatoria. |
| 3 | `fin21_db.es_tfin` | El tipo de financiamiento. Obligatoria. |
| 4 | `fin21_db.sf_ftfn`, `sf_deaf` | Fuente de financiamiento y decreto. Opcionales: si faltan, el centro aparece igual pero esos campos salen vacíos. |
| 5 | `sisper_db.sp_pers` + `ufro_db.es_unid` | El responsable del centro y su unidad deben existir. |
| 6 | `fin21_db.es_ccto` | El centro de costo. Su unidad debe permitir determinar un flujo vigente, o la solicitud no encuentra workflow. |

**Cómo saber si quedó bien:** el centro aparece en el selector de la solicitud, con nombre, proyecto y jefe de proyecto resueltos.

---

### 2.3 Actualizar ítems y saldos

Va **después** de §2.2: todo acá depende de que el centro ya exista.

Los ítems son una jerarquía de cuatro niveles. Cárguelos de arriba hacia abajo: si falta un nivel, la validación de saldo no encuentra la cuenta y **no devuelve nada**, sin avisar.

| Paso | Tabla | Qué debe quedar |
|---|---|---|
| 1 | `fin21_db.pt_ticp` | Tipo de cuenta. Es la raíz de la jerarquía. |
| 2 | `fin21_db.pt_titl` | Subtítulos. Se enlazan a `pt_ticp` por `cod_cuenta`. |
| 3 | `fin21_db.pt_item` | Los ítems presupuestarios. Se enlazan a `pt_titl` por `cod_subtitulo`. |
| 4 | `fin21_db.pt_sitm` | Los subítems. Se enlazan a `pt_item` por `cod_item`. |
| 5 | `fin21_db.pt_depr` | Los movimientos presupuestarios. |
| 6 | `fin21_db.sf_docf` | Los documentos financieros. |
| 7 | `fin21_db.sf_pfoc` | El enlace entre documento y movimiento. |
| 8 | `sisper_db.wf_sol2` y `wf_tra1` | Los compromisos de personal del centro. **Descuentan saldo**: si faltan, el centro muestra más plata disponible de la que realmente tiene. |

La cadena completa de la jerarquía es:

```text
pt_sitm.cod_item      -> pt_item.cod_item
pt_item.cod_subtitulo -> pt_titl.cod_subtitulo
pt_titl.cod_cuenta    -> pt_ticp.cod_cuenta
```

`valida_saldo_cc_cs` recorre esa cadena completa para obtener el tipo de cuenta y el subtítulo del ítem. Usa el cruce antiguo por comas, que se comporta como `INNER JOIN`: **si falta cualquiera de los cuatro niveles, la consulta no devuelve fila** y la validación de saldo queda sin datos.

`pt_depr`, `sf_docf` y `sf_pfoc` se cruzan entre sí por `pt_depr.numero` ↔ `sf_docf.numero` ↔ `sf_pfoc.sf_numero`. Si carga movimientos sin su documento, o al revés, **el saldo sale incompleto sin dar ningún error**.

`wf_sol2` y `wf_tra1` no son solo dato laboral: `valida_saldo_cc_cs` las suma al saldo del centro como gasto comprometido de personal (ítem `30700`). Van siempre juntas, enlazadas por `ano` + `nro_folio`, y filtradas por `cod_est_cc in (0,1,3)`. Si carga una sin la otra, el compromiso no se descuenta.

**Cómo saber si quedó bien:** al elegir el centro en la solicitud, la tabla de saldos muestra montos reales, no ceros ni "sin información". Si el saldo disponible se ve más alto de lo esperado, revise `wf_sol2`/`wf_tra1`: probablemente falten los compromisos de personal.

---

### 2.4 Actualizar los aprobadores de las etapas

Este es el caso que más veces deja una solicitud detenida sin explicación aparente.

| Paso | Tabla | Qué debe quedar |
|---|---|---|
| 1 | `ufro_db.es_unid` | Las unidades. |
| 2 | `ufro_db.es_orga` | El árbol organizacional. **Cargue las unidades padre antes que las hijas**: la búsqueda de jefatura sube por `cod_orgjef` y se corta si falta un eslabón. |
| 3 | `sisper_db.sp_orco` | Ocupantes de cargos organizacionales. |
| 4 | `sisper_db.sp_aufi` | Autoridades y subrogancias, para cuando no hay ocupante en ORCO. |

**Cómo saber si quedó bien:** envíe una solicitud de prueba y confirme que la tarea le llega al RUT esperado en cada etapa. Si una etapa queda sin actor, el problema está acá, no en `sg_eta1`.

---

### 2.5 Qué NO se carga a mano

Estas tablas aparecen más adelante en el documento porque forman parte del módulo, pero **no se cargan manualmente**. Si las llena a mano, en el mejor caso el trabajo se pierde y en el peor deja IDs duplicados.

**Se crean solas al usar la aplicación.** No las copie desde desarrollo: genere una solicitud de prueba real y el sistema las escribe en el orden correcto.

```text
sg_soli    la solicitud
sg_prse    la prestación
sg_fups    los funcionarios de la solicitud
sg_fuho    el horario de ejecución
sg_fuco    las compensaciones
sg_apso    las tareas de cada etapa
sg_hist    la trazabilidad
sg_his2    el historial por funcionario
sg_rslc    la resolución
sg_rede    el detalle de la resolución
sg_apre    los firmantes
```

Los procedimientos calculan el siguiente ID desde `sg_parm`. Una carga manual que no actualice ese correlativo provoca claves duplicadas más adelante.

**No pertenecen a este flujo.** No las toque aunque existan:

```text
sg_fume, sg_ecuo    solo pagos, no se usan al crear una solicitud DU288
bd_pri2             reemplazada; el flujo vigente no la consulta
sg_wflu, sg_wfet, sg_wfin, sg_wfei, sg_apsa, sg_apsf, sg_hiap
                    propuestas que nunca se implementaron
```

**Lo único que sí se revisa a mano en `secgen_db`** son los catálogos y la configuración del flujo, y solo para confirmar que existan los códigos que va a usar: `sg_tsol`, `sg_esol`, `sg_tmod`, `sg_efun`, `sg_eapr`, `sg_tacc`, `sg_tpps`, `sg_ersl`, más `sg_tfls` → `sg_eta1` → `sg_eta2` en ese orden, `sg_toca` para topes y `sg_plre` → `sg_plde` para la plantilla. El detalle está en §5 y §11.

---

## 3. Clasificación de tablas

| Grupo | Acción en certificación |
|---|---|
| Maestros y configuración | Comparar y cargar los registros faltantes antes de probar solicitudes. |
| Estructura transaccional | Verificar columnas, PK, FK e índices. No copiar transacciones de desarrollo como carga maestra. |
| Transacciones de prueba | Deben generarse mediante la aplicación o PA, respetando el orden definido en este documento. |
| Fuentes externas | No son propiedad del módulo PDS. Deben contener datos de prueba coherentes o las validaciones fallarán. |
| Compatibilidad/pagos | No se deben poblar al crear una solicitud DU288, salvo que el flujo de pago lo requiera posteriormente. |

## 4. Tablas maestras y de configuración obligatorias

### 4.1 Catálogos base de solicitud

| Tabla | PK | Uso | Depende de | Si se agrega un registro |
|---|---|---|---|---|
| `secgen_db.dbo.sg_tsol` | `cod_tipsol` | Tipo de solicitud PDS. | Ninguna. | Debe existir antes de `sg_soli`, `sg_plre` y `sg_hist`. Validar permisos y plantillas asociados al tipo. |
| `secgen_db.dbo.sg_esol` | `cod_estsol` | Estados generales: borrador, trámite, corrección, rechazo, archivo, etc. | Ninguna. | Revisar las transiciones `sg_eta2` que producirán el nuevo estado y la lógica del backend. |
| `secgen_db.dbo.sg_tmod` | `cod_modprs` | Modalidad de prestación. DU288 normativa utiliza modalidad `2`. | Ninguna. | Debe existir antes de guardar `sg_prse`. Actualizar las reglas/PA que discriminan por modalidad. |
| `secgen_db.dbo.sg_efun` | `cod_estfun` | Estado del funcionario en la PDS. | Ninguna. | Debe existir antes de referenciarlo desde `sg_fups`; revisar cambios de estado y `sg_his2`. |
| `secgen_db.dbo.sg_eapr` | `cod_estapr` | Estado de tareas y firmas. | Ninguna. | Debe existir antes de `sg_apso` y `sg_apre`; actualizar constantes del backend si el código es nuevo. |
| `secgen_db.dbo.sg_tacc` | `id_tipacc` | Acciones de workflow e historial. | Ninguna. | Agregar las transiciones correspondientes en `sg_eta2` y revisar el mapeo de acciones del backend. |
| `secgen_db.dbo.sg_tpps` | `cod_tpps` | Tipo de prestación del funcionario. | Ninguna. | Debe existir antes de registrar `sg_fups`. |

### 4.2 Configuración de workflow

| Tabla | PK | Uso | Depende de | Si se agrega un registro |
|---|---|---|---|---|
| `secgen_db.dbo.sg_tfls` | `cod_flusol` | Define cada rama: Facultad, Investigación, DITT, Instituto, VRAF, VRAC, VIPRE o VRIP. | Ninguna física. | Agregar etapas en `sg_eta1`, transiciones en `sg_eta2` y actualizar la correspondencia del PA únicamente si los datos existentes permiten identificar el flujo. |
| `secgen_db.dbo.sg_eta1` | `cod_flusol + cod_etapa` | Define etapa, perfil, módulo y cargo organizacional. | `sg_tfls`; lógicamente `sistema_db.dbo.bd_per1` y `ufro_db.dbo.es_orga`. | Agregar transiciones de entrada/salida en `sg_eta2`, permiso en `bd_pepr` y confirmar que el actor pueda resolverse en ORCO/ORDE/AUFI. |
| `secgen_db.dbo.sg_eta2` | `cod_flusol + cod_etapa1 + cod_etapa2` | Define acciones permitidas, destino y estado resultante. | `sg_eta1`, `sg_tacc`, `sg_esol`. | Debe existir una transición única por flujo, etapa origen y acción. Validar retorno a corrección y etapa final. |

Relaciones lógicas correctas de `sg_eta2`:

```text
(cod_flusol, cod_etapa1) -> sg_eta1(cod_flusol, cod_etapa)
(cod_flusol, cod_etapa2) -> sg_eta1(cod_flusol, cod_etapa)
id_tipacc                 -> sg_tacc.id_tipacc
cod_estsol                -> sg_esol.cod_estsol
```

La definición extraída del esquema contiene nombres de FK confusos para `sg_eta2`; antes de desplegar se debe validar la restricción real mediante `sp_helpconstraint sg_eta2`.

### 4.3 Reglas normativas

| Tabla | PK | Uso | Depende de | Si se agrega un registro |
|---|---|---|---|---|
| `secgen_db.dbo.sg_toca` | `cod_cargo + cod_unidad + f_inicio` | Tope mensual por cargo/unidad y vigencia. | Lógicamente `sisper_db.dbo.sp_carg` y `ufro_db.dbo.es_unid`. | Confirmar cargo, unidad, rango de vigencia, ausencia de solapamientos y resultado de `sg_tocasSecgen01`. |

`sg_toca` no reemplaza las fuentes laborales. El PA primero obtiene contrato/cargo/unidad desde SISPER y luego busca la regla vigente.

### 4.4 Configuración de resolución

| Tabla | PK | Uso | Depende de | Si se agrega un registro |
|---|---|---|---|---|
| `secgen_db.dbo.sg_plse` | `cod_tipsec` | Catálogo de secciones de resolución. | Ninguna. | Debe existir antes de `sg_plde` y `sg_rede`. |
| `secgen_db.dbo.sg_plre` | `id_planti` | Cabecera de plantilla de resolución. | `sg_tsol`. | Agregar sus detalles en `sg_plde` y confirmar que el backend utiliza el nuevo `id_planti`. |
| `secgen_db.dbo.sg_plde` | `id_pladet` | Textos/variables ordenados de la plantilla. | `sg_plre`, `sg_plse`. | Cargar todos los campos obligatorios; comprobar variables contra el generador de resolución. |
| `secgen_db.dbo.sg_ersl` | `cod_estres` | Estados de resolución. | Ninguna. | Actualizar constantes y transiciones de firma/archivo cuando se incorpore un estado. |

### 4.5 Perfiles y permisos

| Tabla | Uso | Regla de actualización |
|---|---|---|
| `sistema_db.dbo.bd_per1` | Catálogo de perfiles del sistema/módulo. | El `cod_perfil` utilizado por `sg_eta1` debe existir para `SG/SISSOLIC`. |
| `sistema_db.dbo.bd_prvg` | Catálogo de privilegios. | Debe existir `provision-request-approve` y los privilegios documentales correspondientes. |
| `sistema_db.dbo.bd_pepr` | Relación perfil-privilegio. | Cada perfil revisor de `sg_eta1` debe tener el privilegio requerido. Usar el script idempotente de carga. |
| `secgen_db.dbo.sg_perf` | Catálogo legacy/institucional usado en trazabilidad. | Mantener códigos requeridos por historial y consultas antiguas. No determina por sí solo al actor dinámico. |
| `secgen_db.dbo.sg_uspe` | Perfil global por RUT. | Solo usar para roles globales reales. No agregar solicitantes, jefes de proyecto ni jefes directos dinámicos. |

Regla obligatoria:

```text
Rol dinámico = etapa + tarea sg_apso + RUT resuelto
Rol estático  = perfil institucional + privilegio
```

No se deben crear filas personales en `sg_uspe` ni perfiles duplicados solo para que un actor dinámico pueda aprobar una solicitud.

### 4.6 Control de correlativos

| Tabla | PK | Uso |
|---|---|---|
| `secgen_db.dbo.sg_parm` | `nom_tabla` | Conserva el último identificador utilizado por PA legacy. |

Como mínimo deben existir filas coherentes para:

```text
sg_soli
sg_fups
sg_apso
sg_hist
sg_rslc
sg_rede
sg_apre
```

Para cada fila se debe cumplir:

```text
sg_parm.ultimo_id >= max(PK actual de la tabla)
```

No se debe calcular el siguiente ID en la aplicación. Los PA deben bloquear/actualizar `sg_parm` dentro de la misma transacción.

## 5. Tablas transaccionales PDS

### 5.1 Solicitud y prestación

| Tabla | Cardinalidad | FK/dependencia | Qué registra | Operación normal |
|---|---:|---|---|---|
| `sg_soli` | 1 por solicitud | `sg_tsol`, `sg_esol`; después puede apuntar a `sg_rslc`. | Solicitante, estado, tipo y resolución. | Insertar primero. |
| `sg_prse` | 1:1 con `sg_soli` | `nro_solici -> sg_soli`; `cod_modprs -> sg_tmod`; etapa -> `sg_eta1`. | Actividad, período general, jefe de proyecto, centro de costo y posición actual del flujo. | Insertar después de `sg_soli`. |
| `sg_fups` | 1:N con `sg_prse` | `nro_solici -> sg_prse`; estado -> `sg_efun`; tipo -> `sg_tpps`. | Funcionarios, contrato, período individual, monto y tope. | Insertar después de `sg_prse`. |

Al crear un funcionario no basta con `sg_fups`: deben revisarse horarios y compensaciones según modalidad/estamento.

### 5.2 Horario y compensación

| Tabla | Cardinalidad | FK/dependencia | Regla vigente |
|---|---:|---|---|
| `sg_fuho` | 0:N por funcionario | `id_funprse -> sg_fups`. | Guarda distribución semanal de ejecución. PK: funcionario + día + correlativo. Días permitidos por la aplicación: lunes a viernes. |
| `sg_fuco` | 0:N por funcionario | `id_funprse -> sg_fups`. | Guarda tramos reales de compensación. `fec_compro` contiene fecha y hora de inicio para permitir varios tramos el mismo día sin cambiar la PK. |

Para DU288:

- se exige al menos un tramo en `sg_fuho` para un funcionario incorporado;
- `sg_fuco` solo se crea cuando la prestación requiere compensación;
- un tramo nocturno puede terminar al día siguiente cuando `hora_ter < hora_ini`;
- no se permiten duplicados ni superposiciones;
- el inicio y término deben pertenecer al período autorizado;
- la eliminación de un funcionario debe limpiar primero `sg_fuho` y `sg_fuco`.

### 5.3 Workflow, decisiones e historial

| Tabla | Cardinalidad | FK/dependencia | Qué registra |
|---|---:|---|---|
| `sg_apso` | 0:N por solicitud | `sg_soli`, `sg_eapr`, `sg_eta1`; opcionalmente `sg_fups`. | Tarea concreta asignada a un RUT, etapa, actor efectivo, comentario y estado. |
| `sg_hist` | 0:N por solicitud/resolución | `sg_soli`, `sg_tsol`, `sg_tacc`; opcionalmente `sg_rslc`. | Trazabilidad general de envío, aprobación, devolución, rechazo y archivo. |
| `sg_his2` | 0:N por funcionario | `sg_fups`. | Cambio de estado individual del funcionario. No reemplaza `sg_hist`. |

Cada decisión de workflow debe tratarse como una unidad:

1. actualizar la tarea exacta en `sg_apso`;
2. actualizar `sg_prse.cod_etapa` cuando se completa la etapa;
3. actualizar `sg_soli.cod_estsol` según `sg_eta2`;
4. insertar la trazabilidad en `sg_hist`;
5. si la decisión afecta a un funcionario, actualizar `sg_fups.cod_estfun` e insertar `sg_his2`;
6. crear las nuevas tareas `sg_apso` para la etapa de destino.

No se deben eliminar tareas resueltas o canceladas: su estado y comentario constituyen trazabilidad.

## 6. Resolución y documentos

| Tabla | Cardinalidad | Depende de | Qué registra |
|---|---:|---|---|
| `sg_rslc` | 1 por resolución | `sg_plre`, `sg_ersl`. | Cabecera, estado, plantilla e identificador documental. |
| `sg_rede` | 1:N por resolución | `sg_rslc`, `sg_plse`. | Copia materializada de los textos de la plantilla. |
| `sg_apre` | 0:N por resolución | `sg_rslc`, `sg_eapr`; perfil lógico en `bd_per1`. | Firmantes, estado y observación/alcance. |
| `archivo_db..ar_doc1` | 1 por documento institucional | Parámetros de Archivo. | Metadata y número externo generado por `ar_doc1iSecgen10`. |
| `archivo_db..ar_doc6` | Según implementación documental | `ar_doc1`. | Información complementaria del documento. |
| `MySecGen.sg_rslc_<año>` | 0:N archivos por resolución | Año, número y correlativo de resolución. | Binario de borrador/documento firmado. La tabla física cambia por año. |

Tablas auxiliares de Archivo consultadas o actualizadas por la generación de número:

```text
archivo_db..ar_adm1
archivo_db..ar_parm
archivo_db..ar_prm2
archivo_db..ar_prm3
archivo_db..ar_edoc
```

`ar_edoc` (estado del documento) solo aparece en el PA base `ar_doc1sSecgen01.sql`. Verificar si el flujo DU288 vigente lo requiere antes de cargarlo.

Orden de creación de una resolución:

1. generar metadata/número documental en Archivo cuando corresponda;
2. insertar `sg_rslc`;
3. actualizar `sg_soli.ano_resolu + nro_resolu`;
4. copiar `sg_plde` a `sg_rede` y resolver variables;
5. crear firmantes en `sg_apre` cuando el flujo alcance las etapas de firma;
6. guardar/reemplazar el binario en `MySecGen.sg_rslc_<año>`;
7. insertar evento en `sg_hist`.

Cuando una solicitud vuelve a corrección después de generar resolución, se conserva `sg_rslc` y la trazabilidad; el documento firmado inválido debe eliminarse o reemplazarse en `MySecGen.sg_rslc_<año>` para evitar documentos fantasma.

## 7. Tablas de compatibilidad y pagos

| Tabla | Uso actual | Regla para certificación |
|---|---|---|
| `sg_fume` | Meses/cuotas del modelo anterior y futuro flujo de pagos. | **No crear filas al registrar o enviar una solicitud DU288.** Solo usar cuando el proceso de pago formalmente lo requiera. |
| `sg_ecuo` | Catálogo de estados de cuota. | Solo es dependencia cuando existen filas en `sg_fume` o se habilita el flujo de pagos. |

El backend mantiene métodos de lectura/borrado de `sg_fume` por compatibilidad, pero `updateInstallmentStatusesByRequest` está desactivado para DU288. Por lo tanto, `sg_fume` no debe utilizarse como requisito para agregar un funcionario ni para validar `MESES_NO_SELECCIONADOS`.

## 8. Fuentes externas de solo lectura

Estas tablas no deben replicarse como tablas PDS. Sin datos coherentes en certificación, los PA devolverán “no encontrado”, topes incorrectos o actores sin resolver.

### 8.1 Finanzas (`fin21_db`)

| Tabla | Uso |
|---|---|
| `es_ccto` | Centro de costo, responsable, unidad financiera y datos de proyecto. |
| `es_ufin` | Unidad financiera. |
| `es_ecct` | Estado del centro de costo. |
| `es_tfin` | Tipo de financiamiento. |
| `sf_ftfn` | Fuente de financiamiento (`cod_ftfn`/`des_ftfn`). Distinta de `es_tfin`: se muestra en el comparador de PDS previas y en el detalle del centro de costo. |
| `sf_deaf` | Decreto/afectación asociado al centro. |
| `pt_ticp`, `pt_titl`, `pt_item`, `pt_sitm` | Jerarquía presupuestaria completa: tipo de cuenta → subtítulo → ítem → subítem. `valida_saldo_cc_cs` la recorre entera para resolver el tipo de cuenta del ítem. |
| `pt_depr`, `sf_docf`, `sf_pfoc` | Movimientos y documentos usados para determinar saldo. |

### 8.2 Personas y contratos (`sisper_db`)

| Tabla | Uso |
|---|---|
| `sp_pers` | Identidad y nombre de persona. |
| `sp_cont` | Contratos vigentes, cargo, unidad, jornada y jerarquía. |
| `sp_carg` | Catálogo de cargos y tipo de cargo. |
| `sp_sede`, `sp_jpfu`, `sp_nigr`, `sp_cali`, `sp_estm`, `sp_jorn`, `sp_vigc` | Perfil laboral, planta, nivel, calidad, estamento, jornada y vigencia. |
| `sp_orde`, `sp_desg` | Funciones/designaciones vigentes usadas para inhabilidades y actores. |
| `sp_orco` | Ocupantes de cargos organizacionales. |
| `sp_aufi` | Autoridades y subrogancias. |
| `sp_par1`, `sp_par2` | Validación de parentesco. |
| `sp_asng`, `ss_habe`, `ss_hrem`, `sp_para` | Asignaciones, haberes y parámetros usados en carga/tope. |
| `sp_jpfu` y `sp_nigr` | Jerarquía/planta y nivel de grado. |
| `wf_sol2`, `wf_tra1` | Movimientos laborales considerados por consultas de saldo/carga. |

### 8.3 Organización (`ufro_db`)

| Tabla | Uso |
|---|---|
| `es_unid` | Catálogo de unidades institucionales. |
| `es_orga` | Árbol organizacional y `cod_orgjef` para escalar la búsqueda de jefatura. |

Resolución de jefe directo:

```text
contrato -> unidad -> es_orga.cod_organi
         -> ORCO por cod_organi
         -> si no existe, ORDE por cod_organi
         -> si no existe, subir por es_orga.cod_orgjef
         -> detener según límite organizacional definido
```

### 8.4 Referencia por tabla

Si ya sabe qué tabla va a tocar y solo necesita confirmar sus dependencias, use estas tablas. Para saber por dónde empezar según la tarea, vea §2.

#### `ufro_db` — organización

| Tabla | Qué carga | Antes necesita | Habilita | Ojo con |
|---|---|---|---|---|
| `es_unid` | Unidades institucionales. | Nada. Es de las primeras. | `es_orga`, `sp_cont`, responsable del centro de costo. | — |
| `es_orga` | Árbol organizacional y su jefatura (`cod_orgjef`). | `es_unid`. | `sp_orco`, `sp_aufi`, resolución de jefe directo. | Se apunta a sí misma: cargue las unidades padre antes que las hijas, o el escalamiento de jefatura se corta. |

#### `sisper_db` — personas y contratos

| Tabla | Qué carga | Antes necesita | Habilita | Ojo con |
|---|---|---|---|---|
| `sp_carg`, `sp_cali`, `sp_estm`, `sp_jorn`, `sp_jpfu`, `sp_nigr`, `sp_sede`, `sp_vigc`, `sp_para` | Catálogos laborales: cargo, calidad, estamento, jornada, jerarquía/planta, nivel de grado, sede, vigencia, parámetros. | Nada. | `sp_cont`. | `sp_carg` además lo necesita la regla de tope `sg_toca`. |
| `sp_pers` | Identidad y nombre de la persona. | Nada formal, pero es la base de todo lo laboral. | Contratos, parentesco, haberes, actores. | Si el RUT de prueba no está aquí, nada más de esta base va a resolver. |
| `sp_cont` | Contrato: cargo, unidad, jornada, jerarquía. | `sp_pers`, los catálogos laborales de arriba, `es_unid`. | Cálculo de tope, validación de jornada, jefe directo. | Debe estar **vigente y cubrir el período** de la solicitud de prueba, o el contrato no aparece como elegible. |
| `sp_orco` | Ocupantes de cargos organizacionales. | `sp_pers`, `es_orga`. | **Resuelve quién aprueba cada etapa.** | Si falta, la etapa queda sin actor y la solicitud se detiene aunque `sg_eta1` esté bien configurada. |
| `sp_aufi` | Autoridades y subrogancias. | `sp_pers`, `es_orga`. | Actores cuando no hay ocupante en ORCO. | Igual que `sp_orco`: sin datos, no hay a quién asignar la tarea. |
| `sp_par1`, `sp_par2` | Parentesco. | `sp_pers`. | Validación de parentesco con el jefe de proyecto. | Si están vacías, la validación pasa sin detectar nada — no falla, pero tampoco prueba nada. |
| `sp_orde`, `sp_desg` | Designaciones y funciones vigentes. | `sp_pers`, `sp_cont`. | Inhabilidades por cargo, actores alternativos. | — |
| `sp_asng` | Asignaciones. | `sp_cont`. | Carga horaria acumulada. | — |
| `ss_habe`, `ss_hrem` | Haberes y remuneración. | `sp_pers`, `sp_cont`. | Cálculo de tope por haber efectivo. | Debe existir el **mes inmediatamente anterior** a la fecha de la solicitud; si no, el tope devuelve `REMUNERACION_MES_NO_DISPONIBLE`. |
| `wf_sol2`, `wf_tra1` | Movimientos laborales. | `sp_pers`, `sp_cont`. | Consultas de saldo y carga. | — |

#### `fin21_db` — finanzas

| Tabla | Qué carga | Antes necesita | Habilita | Ojo con |
|---|---|---|---|---|
| `es_ufin` | Unidad financiera. | Nada. | `es_ccto`. | **INNER JOIN**: sin esta fila el centro de costo no aparece. |
| `es_ecct` | Estado del centro de costo. | Nada. | `es_ccto`. | **INNER JOIN**: mismo efecto. |
| `es_tfin` | Tipo de financiamiento. | Nada. | `es_ccto`. | **INNER JOIN**: mismo efecto. |
| `sf_ftfn` | Fuente de financiamiento (`cod_ftfn`/`des_ftfn`). | Nada. | Dato de financiamiento en el comparador de PDS previas. | LEFT JOIN: si falta, el centro igual aparece pero el financiamiento sale vacío. |
| `sf_deaf` | Decreto/afectación. | Nada. | Dato de decreto del centro. | LEFT JOIN: mismo caso. |
| `pt_item` | Ítems presupuestarios. | Nada. | `pt_sitm`, movimientos de saldo. | — |
| `pt_sitm` | Subítems presupuestarios. | `pt_item`. | Movimientos de saldo, ítem del funcionario. | — |
| `es_ccto` | Centro de costo, responsable y datos de proyecto. | `es_ufin`, `es_ecct`, `es_tfin` (obligatorios) + `sf_ftfn`, `sf_deaf` (opcionales) + `sp_pers` del responsable + `es_unid`. | Toda la solicitud: sin centro no hay dónde imputar. | Su unidad debe permitir determinar un flujo vigente (`sg_flusSecgen01`), o la solicitud no encuentra workflow. |
| `pt_depr`, `sf_docf`, `sf_pfoc` | Movimientos y documentos de saldo. | `es_ccto`, `pt_item`, `pt_sitm`. | Cálculo de saldo disponible. | Van al final: dependen de que el centro ya exista. |

Verificado en `sg_cctosSecgen05.sql`: `es_ecct`, `es_tfin` y `es_ufin` entran por `INNER JOIN`; `sf_ftfn` y `sf_deaf` por `LEFT JOIN`.

> Las dependencias de arriba están tomadas de los `JOIN` reales de los PA, no de FK declaradas en el esquema. Si va a cargar en producción o certificación, confirme la restricción real con `sp_helpconstraint <tabla>`, igual que se indica para `sg_eta2` en §4.2.

## 9. Matriz “si agrego X, qué más debo agregar”

| Cambio solicitado | Registros/objetos relacionados obligatorios | Validación final |
|---|---|---|
| Nuevo tipo de solicitud | `sg_tsol`; perfil/permisos; plantilla `sg_plre/sg_plde`; estados y PA que lo filtran. | Crear borrador y consultar bandeja. |
| Nueva modalidad PDS | `sg_tmod`; reglas de PA por modalidad; frontend/backend constants. | Crear solicitud y comprobar reglas específicas. |
| Nuevo flujo | `sg_tfls` -> `sg_eta1` -> `sg_eta2` -> `bd_pepr`; utilizar `es_ccto/es_ufin` para identificarlo y ORCO/ORDE/AUFI para resolver actores. | Resolver centro, actores, política de omisión, mostrar etapas y ejecutar cada acción. |
| Nueva etapa | `sg_eta1`; transiciones entrantes/salientes `sg_eta2`; perfil `bd_per1`; permiso `bd_pepr`; cargo/actor ORCO-ORDE-AUFI. | El PA de actores devuelve exactamente el responsable esperado. |
| Nueva acción | `sg_tacc`; una transición `sg_eta2` por etapa; mapeo de backend. | Acción visible, estado resultante correcto e historial creado. |
| Nuevo estado de solicitud | `sg_esol`; `sg_eta2`; constantes y filtros de bandeja. | La solicitud aparece únicamente en la bandeja correspondiente. |
| Nuevo estado de aprobación | `sg_eapr`; lógica de actualización/consulta de `sg_apso` y `sg_apre`. | Tareas y firmantes no quedan pendientes por un código desconocido. |
| Nuevo perfil estático | `bd_per1`; privilegio en `bd_pepr`; eventualmente `sg_perf/sg_uspe`. | El JWT entrega permiso y la etapa reconoce el perfil. |
| Nuevo actor dinámico | No crear perfil personal. Resolver RUT desde solicitud/organización y crear `sg_apso`. | La tarea aparece solo para el RUT resuelto. |
| Nuevo centro de costo de prueba | `fin21.es_ccto` y maestros financieros relacionados; responsable/persona/unidad existentes. Debe poseer una unidad cuya codificación permita determinar un flujo vigente. | Centro recuperado con nombre, proyecto, jefe y flujo correctos. |
| Nuevo cargo/tope | Cargo en `sp_carg`, unidad en `es_unid`, regla vigente en `sg_toca`. | `sg_tocasSecgen01` devuelve tope y condición correcta. |
| Nuevo funcionario en solicitud | `sg_fups`; `sg_fuho`; `sg_fuco` solo si compensa. Fuentes de persona/contrato deben existir. | Detalle y edición recargan horarios y compensaciones. |
| Nueva plantilla de resolución | `sg_plse` si falta sección; `sg_plre`; todos los `sg_plde`; configurar ID usado por backend. | Previsualización sin variables pendientes y resolución reproducible. |
| Nueva resolución | `sg_rslc`; vínculo en `sg_soli`; `sg_rede`; `sg_apre`; metadata Archivo; binario MySecGen; `sg_hist`. | No existe número/documento fantasma y todos los firmantes tienen tarea. |

## 10. Orden recomendado de despliegue en certificación

1. Respaldar datos y consultar códigos vigentes; no asumir IDs libres.
2. Verificar estructura de `sg_prse`, `sg_fups`, `sg_fuho`, `sg_fuco` y `sg_apso`.
3. Sincronizar catálogos: `sg_tsol`, `sg_esol`, `sg_tmod`, `sg_efun`, `sg_eapr`, `sg_tacc`, `sg_tpps`, `sg_ersl`, `sg_plse`.
4. Sincronizar perfiles y privilegios: `bd_per1`, `bd_prvg`, `bd_pepr`. No usar `bd_pri2`.
5. Sincronizar workflow: `sg_tfls`, luego `sg_eta1`, luego `sg_eta2`.
6. Sincronizar reglas normativas `sg_toca`.
7. Sincronizar plantilla `sg_plre` y después `sg_plde`.
8. Verificar filas de control en `sg_parm` contra máximos reales.
9. Instalar PA Sybase ASE 12.5 y otorgar `GRANT EXECUTE` al usuario de aplicación.
   La resolución de responsables quedó separada en tres procedimientos; instalarlos **antes** de `sg_etasSecgen01`, que los orquesta:
   - `sg_prsesSecgen20` — contexto de la solicitud (flujo, centro de costo, unidad y solicitante). Es el único que necesita `nro_solici`.
   - `sg_eta1sSecgen03` — política de la etapa (perfil, organización, estrategia y `permite_omision`). Solo lee configuración.
   - `sp_orcosSecgen01` — resolución del responsable por la cadena ORCO → ORDE → AUFI. Recibe los RUT a excluir como lista, no los lee de la solicitud.
10. Verificar datos externos de prueba en Finanzas, SISPER, UFRO, Sistema y Archivo.
11. Generar una solicitud nueva desde la aplicación; no copiar una solicitud transaccional de desarrollo como prueba principal.
12. Ejecutar el flujo completo hasta resolución, firma, corrección y archivo.

## 11. Orden transaccional de inserción

### 11.1 Borrador DU288

```text
sg_soli
  -> sg_prse
    -> sg_fups (uno por funcionario)
      -> sg_fuho (uno o más tramos semanales)
      -> sg_fuco (cero o más, solo si corresponde compensar)
```

### 11.2 Envío y aprobación

```text
actualizar sg_prse.cod_flusol/cod_etapa
actualizar sg_soli.cod_estsol
insertar sg_apso para actores de la etapa
insertar sg_hist
```

En cada avance:

```text
actualizar/cerrar sg_apso actual
actualizar sg_prse.cod_etapa
actualizar sg_soli.cod_estsol
insertar sg_hist
insertar nuevas tareas sg_apso
```

### 11.3 Eliminación de un funcionario en borrador

Orden inverso obligatorio:

```text
sg_fuco
sg_fuho
sg_fume, solo si existen datos legacy
sg_his2, si existen eventos eliminables según política
sg_fups
```

Si existen tareas `sg_apso` asociadas al funcionario, no corresponde una eliminación física simple: se debe cancelar la tarea o aplicar la política de corrección.

## 12. Controles previos y posteriores

### Antes de insertar configuración

- comprobar la PK y buscar el mismo significado con otro código;
- comprobar vigencias y fechas solapadas;
- validar que todos los padres existan;
- confirmar que `sg_parm` no quede por debajo del máximo real;
- comprobar que los perfiles de `sg_eta1` existan en `bd_per1`;
- comprobar que el cargo `cod_organi` pueda resolverse por ORCO, ORDE o AUFI;
- ejecutar scripts idempotentes con `NOT EXISTS`.

### Después del despliegue

- `sg_flusSecgen01` resuelve los ocho tipos de flujo esperados;
- todas las etapas vigentes poseen transiciones válidas;
- no existe más de una transición por flujo, etapa origen y acción;
- `sg_etasSecgen01` resuelve actores sin usar `bd_pri2`;
- una solicitud guarda `sg_soli`, `sg_prse`, `sg_fups`, `sg_fuho` y `sg_fuco` correctamente;
- detalle y edición recuperan los mismos horarios;
- `sg_apso` no genera tareas duplicadas;
- `sg_hist` distingue aprobación, alcance y corrección;
- la resolución usa la plantilla DU288 y no aparece antes de su creación real;
- volver a corrección invalida el documento firmado anterior;
- el ambiente no contiene filas DU288 nuevas en `sg_fume` por el solo hecho de crear la solicitud.

## 13. Objetos que no deben tratarse como tablas maestras PDS

- `sg_fume` y `sg_ecuo`: solo pagos/compatibilidad.
- tablas temporales `#...` de PA financieros: no se despliegan manualmente.
- tablas propuestas `sg_wflu`, `sg_wfet`, `sg_wfin`, `sg_wfei`, `sg_apsa`, `sg_apsf`, `sg_hiap`: no forman parte del runtime vigente.
- `bd_pri2`: no debe consultarse ni cargarse para esta implementación.
- filas transaccionales de `sg_soli`, `sg_prse`, `sg_fups`, `sg_apso`, `sg_hist`, `sg_rslc`, `sg_rede` y `sg_apre`: se generan por pruebas funcionales, no como carga maestra.

## 14. Riesgos detectados

1. `sg_flusSecgen01` usa la unidad institucional existente. Investigación y DITT requieren un atributo actual, estable y diferenciador; no deben inferirse por nombre o RUT.
2. `sg_etasSecgen01` usa `sg_eta1.cod_perfil` y `sg_eta1.cod_organi`. Cuando `cod_organi` está vacío para una etapa institucional, el PA utiliza el código existente de `es_orga` según flujo y unidad.
3. `sg_fuco` permite varios tramos diarios porque `fec_compro` guarda fecha y hora de inicio; normalizarlo a medianoche volvería a producir colisiones de PK.
4. El backend conserva consultas legacy a `sg_fume`; una validación antigua puede reactivar erróneamente `MESES_NO_SELECCIONADOS`.
5. Los roles dinámicos dependen de datos externos vigentes. Una etapa bien configurada puede quedar sin actor si ORCO, ORDE, AUFI u ORGA no tienen correspondencia.
6. Los documentos firmados se guardan en una tabla MySQL anual. Al cambiar de año debe existir `MySecGen.sg_rslc_<año>` con la misma estructura y permisos.
7. Los PA legacy usan `sg_parm`; una carga manual que no actualice el correlativo puede provocar claves duplicadas.
8. La definición documental de algunas FK de `sg_eta2` es inconsistente; se debe validar el esquema real de certificación antes de aplicar DDL.
