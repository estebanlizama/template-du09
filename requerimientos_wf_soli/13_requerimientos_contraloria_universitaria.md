# PDS Normativo D9 / DU288 / DU09

## Pantalla 13 — Revisión Profesional de Contraloría para Toma de Razón

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 13: Revisión Profesional de Contraloría para Toma de Razón — Perfil Profesional de Contraloría** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a una etapa de **revisión jurídica, formal y documental posterior a la firma del acto administrativo por Rectoría**, en la que el Profesional de Contraloría revisa el expediente y la resolución emitida para determinar si se encuentra en condiciones de avanzar a la **visación final del Contralor/a**.

En esta etapa, el Profesional de Contraloría recibe el **acto administrativo ya generado en Decretación, revisado por Secretaría General y firmado por Rectoría**, visualiza su contenido en formato **PDF** y revisa la trazabilidad completa del expediente.

La pantalla debe permitir:

- Visualizar el acto administrativo firmado que ingresa a Toma de Razón.
- Revisar el documento en formato PDF.
- Consultar la trazabilidad de todas las etapas previas del flujo.
- Identificar el número o código de la resolución.
- Visualizar el estado actual de revisión profesional en Contraloría.
- Visar el documento y derivarlo a la etapa de **Contralor/a Final**.
- Devolver el expediente con reparos a **Decretación**, incorporando comentarios obligatorios.
- Registrar trazabilidad de la decisión del Profesional de Contraloría.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 13 — Contraloría Profesional**. No modifica la etapa de Rectoría ni la etapa posterior de Contralor/a Final. Su objetivo es definir qué documento se revisa, qué información debe visualizarse y qué decisiones puede ejecutar el Profesional de Contraloría antes de derivar o devolver el expediente.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P13 |
| **Nombre** | Revisión Profesional de Contraloría para Toma de Razón |
| **Perfil principal** | Profesional de Contraloría |
| **Etapa del flujo** | Etapa 13 — Toma de Razón Profesional |
| **Estado de entrada esperado** | Resolución/decreto generado, visado previamente y firmado por Rectoría |
| **Objetivo principal** | Permitir que el Profesional de Contraloría revise formal y jurídicamente el acto administrativo firmado, y determine si puede continuar hacia la revisión final del Contralor/a o si debe devolverse a Decretación con reparos. |
| **Resultado posible** | Expediente visado y enviado a Contralor/a Final; o expediente devuelto con reparos a Decretación. |

---

# 3. Principio funcional de la Pantalla 13

La Pantalla 13 debe operar como una **vista de análisis profesional para Toma de Razón**, enfocada en la revisión del acto administrativo ya formalizado y firmado.

A diferencia de las pantallas de:

- **Decretación**, donde se genera y edita el documento.
- **Secretaría General**, donde se firma físicamente y se carga el documento firmado.
- **Rectoría**, donde se completa la firma rectoral.

En esta etapa, el Profesional de Contraloría:

1. Recibe el documento ya firmado.
2. Lo revisa desde un visor PDF.
3. Consulta la trazabilidad completa.
4. Determina si:
   - Se **visa y envía a Contralor/a Final**, o
   - Se **devuelve con reparos a Decretación**.

El documento visualizado en esta pantalla debe corresponder a la **versión vigente posterior a la firma de Rectoría**, sin permitir edición ni alteración desde Contraloría Profesional.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 13 debe permitir que el Profesional de Contraloría:

- Visualice la identificación del expediente sometido a Toma de Razón.
- Visualice el número o identificador de la resolución/decreto.
- Visualice el estado actual:
  - **Revisión Profesional de Contraloría**.
- Revise la trazabilidad documental completa del expediente.
- Visualice que el expediente ya fue:
  - Generado en Decretación.
  - Firmado por Secretaría General.
  - Firmado y decretado por Rectoría.
- Visualice el acto administrativo en formato PDF embebido.
- Revise el documento completo desde el visor.
- Visualice el contenido formal del acto administrativo, incluyendo:
  - Encabezado institucional.
  - Identificación de la resolución.
  - Texto resolutivo.
  - Elementos asociados a la Toma de Razón, cuando corresponda.
- Visualice la trazabilidad del ingreso a Contraloría Profesional.
- Ejecute la acción **VISAR Y ENVIAR A CONTRALOR**, cuando el expediente pueda continuar.
- Devuelva el expediente a **Decretación** mediante la acción **DEVOLVER CON REPAROS**.
- Registre comentario obligatorio al devolver con reparos.
- Confirme la decisión de devolución antes de modificar el estado del expediente.
- Registre trazabilidad de:
  - Visación profesional.
  - Envío a Contralor/a Final.
  - Devolución con reparos.
  - Comentarios asociados.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 13 no debe:

- Editar el contenido del acto administrativo.
- Modificar los textos de VISTOS, CONSIDERANDOS, RESUELVO o cualquier sección del documento.
- Modificar el documento firmado por Rectoría.
- Cargar una nueva versión del acto administrativo.
- Reemplazar el PDF recibido desde Rectoría.
- Alterar los antecedentes técnicos, financieros o normativos del expediente.
- Incorporar nuevos funcionarios.
- Excluir o reponer funcionarios.
- Modificar firmas previas de Secretaría General o Rectoría.
- Enviar el expediente directamente a cierre o registro, omitiendo la revisión del Contralor/a Final.
- Devolver el expediente a una etapa distinta de Decretación, salvo definición posterior del flujo.
- Rechazar definitivamente la solicitud si esta acción no ha sido formalmente asignada al rol.
- Incorporar la acción **Salir sin guardar** como acción de proceso.

---

# 4. Objetivo funcional de la Pantalla 13

La pantalla debe permitir que el Profesional de Contraloría:

1. Identifique el expediente que ingresa a revisión profesional.
2. Visualice el número o identificador de la resolución.
3. Confirme que el acto administrativo proviene de Rectoría.
4. Revise el estado actual del expediente en Toma de Razón Profesional.
5. Visualice el documento en formato PDF.
6. Revise el contenido formal del acto administrativo.
7. Consulte la trazabilidad completa de etapas anteriores.
8. Verifique que Secretaría General y Rectoría registraron sus decisiones previas.
9. Determine si el expediente se encuentra en condiciones de avanzar.
10. Vise el expediente y lo envíe a Contralor/a Final.
11. Devuelva con reparos a Decretación cuando detecte observaciones corregibles.
12. Ingrese comentarios obligatorios al devolver.
13. Confirme la acción antes de ejecutarla.
14. Registre trazabilidad completa de su decisión.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 13 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P13-B01** | Encabezado del expediente y estado de revisión profesional | Identificar la resolución, el expediente y la etapa actual. |
| **P13-B02** | Visor PDF del acto administrativo | Permitir revisar el documento firmado en pantalla. |
| **P13-B03** | Trazabilidad documental del expediente | Mostrar el historial de etapas previas hasta Rectoría. |
| **P13-B04** | Estado actual de revisión profesional | Mostrar que el expediente se encuentra en análisis por Contraloría Profesional. |
| **P13-B05** | Decisión global del Profesional de Contraloría | Visar y enviar a Contralor/a Final o devolver con reparos. |
| **P13-B06** | Modal de devolución con reparos | Capturar comentarios obligatorios y confirmar devolución. |
| **P13-B07** | Confirmación, transición de estado y trazabilidad | Registrar la visación profesional o la devolución con reparos. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P13-B01 — Encabezado del expediente y estado de revisión profesional

## Funcionalidad P13-F01 — Visualizar identificación del expediente y resolución

### A. Descripción funcional

El sistema debe mostrar la identificación de la solicitud y del acto administrativo que se encuentra bajo revisión profesional de Contraloría.

### B. Actor principal

Profesional de Contraloría.

### C. Datos que debe mostrar el sistema

- Código único de solicitud.
- Número o identificador de resolución/decreto.
- Título de la etapa:
  - **Toma de Razón — Profesional**.
- Estado actual:
  - **Revisión Profesional**.
- Tipo de documento sometido a revisión.

### D. Reglas de negocio

- El número de resolución debe corresponder al acto administrativo vigente.
- El expediente visualizado debe ser el mismo que avanzó desde Rectoría.

### E. Historia de usuario preliminar

**HU-P13-01:** Como **Profesional de Contraloría**, quiero visualizar la identificación del expediente y de la resolución asociada, para revisar el documento correcto dentro del proceso de Toma de Razón.

### F. Requerimientos funcionales preliminares

- **RF-P13-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-P13-002:** El sistema debe mostrar el número o identificador de la resolución/decreto.
- **RF-P13-003:** El sistema debe mostrar que el expediente se encuentra en etapa de revisión profesional de Contraloría.

---

# P13-B02 — Visor PDF del acto administrativo

## Funcionalidad P13-F02 — Visualizar el acto administrativo firmado como PDF

### A. Descripción funcional

El sistema debe mostrar el acto administrativo recibido desde la etapa anterior mediante un visor PDF embebido.

### B. Actor principal

Profesional de Contraloría.

### C. Contenido visible del documento

El visor debe permitir revisar:

- Encabezado institucional.
- Número de resolución/decreto.
- Texto del acto administrativo.
- Firma o constancia de firma de Secretaría General.
- Firma o constancia de firma de Rectoría.
- Sección o referencia asociada a la Toma de Razón, cuando forme parte del formato documental.
- Cualquier anexo incorporado al documento, si corresponde.

### D. Reglas de negocio

- El PDF debe corresponder a la versión documental recibida desde Rectoría.
- El documento debe mostrarse en modo solo lectura.
- La pantalla no debe permitir edición, reemplazo ni regeneración del documento.

### E. Historia de usuario preliminar

**HU-P13-02:** Como **Profesional de Contraloría**, quiero revisar en pantalla el acto administrativo firmado, para analizar su procedencia antes de visarlo o devolverlo.

### F. Requerimientos funcionales preliminares

- **RF-P13-004:** El sistema debe mostrar el documento recibido desde Rectoría mediante un visor PDF.
- **RF-P13-005:** El visor debe permitir revisar el acto administrativo completo.
- **RF-P13-006:** El sistema debe mostrar el PDF en modo solo lectura.
- **RF-P13-007:** El sistema no debe permitir modificar ni reemplazar el documento desde esta pantalla.

---

# P13-B03 — Trazabilidad documental del expediente

## Funcionalidad P13-F03 — Visualizar historial completo del expediente

### A. Descripción funcional

El sistema debe mostrar el historial de avance de la solicitud desde su creación hasta su ingreso a Contraloría Profesional.

### B. Actor principal

Profesional de Contraloría.

### C. Etapas mínimas a mostrar

- Creación y envío de la solicitud.
- Aprobación por Jefe de Proyecto.
- Aprobación por Jefatura Directa / Dirección de Departamento.
- Revisión y aprobación DGDP.
- Revisión y aprobación Finanzas de Facultad.
- Aprobación Decanato.
- Aprobación Dirección de Finanzas.
- Generación documental en Decretación.
- Firma de Secretaría General.
- Firma y aprobación de Rectoría.
- Ingreso a Contraloría Profesional.

### D. Datos por etapa

- Fecha y hora.
- Rol.
- Usuario.
- Acción ejecutada.
- Comentario asociado, si existe.

### E. Historia de usuario preliminar

**HU-P13-03:** Como **Profesional de Contraloría**, quiero revisar la trazabilidad documental completa del expediente, para verificar el recorrido institucional previo antes de emitir mi decisión.

### F. Requerimientos funcionales preliminares

- **RF-P13-008:** El sistema debe mostrar cronológicamente las etapas previas del expediente.
- **RF-P13-009:** El sistema debe mostrar usuario, rol, acción, fecha y hora en cada hito.
- **RF-P13-010:** El sistema debe mostrar el ingreso del expediente a Contraloría Profesional como último evento vigente.

---

# P13-B04 — Estado actual de revisión profesional

## Funcionalidad P13-F04 — Visualizar estado de revisión en Contraloría Profesional

### A. Descripción funcional

El sistema debe mostrar de forma clara que el expediente está siendo analizado por el rol Profesional de Contraloría.

### B. Actor principal

Profesional de Contraloría.

### C. Estados posibles

- Pendiente de revisión profesional.
- En revisión profesional.
- Visado y enviado a Contralor/a Final.
- Devuelto con reparos a Decretación.

### D. Reglas de negocio

- El estado debe reflejar el avance real de la revisión.
- Una vez enviado a Contralor/a Final, el expediente no debe permanecer disponible como pendiente en la bandeja activa del Profesional de Contraloría.

### E. Historia de usuario preliminar

**HU-P13-04:** Como **Profesional de Contraloría**, quiero visualizar el estado actual de revisión del expediente, para saber si aún requiere análisis o ya fue derivado/devolvido.

### F. Requerimientos funcionales preliminares

- **RF-P13-011:** El sistema debe mostrar el estado actual de revisión profesional.
- **RF-P13-012:** El sistema debe actualizar el estado tras visar o devolver con reparos.
- **RF-P13-013:** El sistema debe dejar de mostrar el expediente como pendiente una vez derivado o devuelto.

---

# P13-B05 — Decisión global del Profesional de Contraloría

## Funcionalidad P13-F05 — Visar y enviar a Contralor/a Final

### A. Descripción funcional

El Profesional de Contraloría debe poder visar el expediente y derivarlo a la etapa de revisión final por Contralor/a.

### B. Actor principal

Profesional de Contraloría.

### C. Acción disponible

- Botón: **VISAR Y ENVIAR A CONTRALOR**.

### D. Resultado esperado

- El expediente avanza a la etapa **Contralor/a Final**.
- Se registra la visación profesional.
- Se conserva la trazabilidad del envío.

### E. Reglas de negocio

- La visación debe registrar:
  - Usuario.
  - Rol.
  - Fecha.
  - Hora.
  - Estado resultante.
- La acción debe derivar el expediente a la etapa 14 del flujo, correspondiente a Contralor/a Final.

### F. Historia de usuario preliminar

**HU-P13-05:** Como **Profesional de Contraloría**, quiero visar el expediente y enviarlo al Contralor/a Final, para continuar el proceso de Toma de Razón.

### G. Requerimientos funcionales preliminares

- **RF-P13-014:** El sistema debe permitir visar el expediente.
- **RF-P13-015:** El sistema debe derivar el expediente a la etapa de Contralor/a Final.
- **RF-P13-016:** El sistema debe registrar la visación profesional con usuario, rol, fecha y hora.
- **RF-P13-017:** El sistema debe actualizar el estado del expediente a visado por Profesional de Contraloría.

---

## Funcionalidad P13-F06 — Devolver con reparos a Decretación

### A. Descripción funcional

El Profesional de Contraloría debe poder devolver el expediente a **Decretación** cuando detecte observaciones, inconsistencias o reparos que impidan su avance inmediato hacia la revisión final.

### B. Actor principal

Profesional de Contraloría.

### C. Acción disponible

- Botón: **DEVOLVER CON REPAROS**.

### D. Datos de entrada requeridos

- Motivo o causal del reparo.
- Comentario obligatorio.

### E. Reglas de negocio

- La devolución debe retornar el expediente a **Decretación**.
- El comentario debe quedar visible para el rol de Decretación.
- La devolución debe registrar:
  - Usuario.
  - Rol.
  - Fecha.
  - Hora.
  - Motivo.
  - Comentario.
- La devolución debe generar trazabilidad formal.
- La devolución puede ejecutarse sin necesidad de derivar previamente al Contralor/a Final.

> **TODO:** Definir si la devolución con reparos debe generar una notificación automática al Solicitante, a Decretación o a ambos.

### F. Historia de usuario preliminar

**HU-P13-06:** Como **Profesional de Contraloría**, quiero devolver con reparos el expediente a Decretación cuando detecte observaciones, para que se subsanen antes de continuar con la Toma de Razón.

### G. Requerimientos funcionales preliminares

- **RF-P13-018:** El sistema debe permitir devolver con reparos el expediente a Decretación.
- **RF-P13-019:** El sistema debe exigir motivo y comentario obligatorio para devolver.
- **RF-P13-020:** El sistema debe registrar la devolución con usuario, rol, fecha y hora.
- **RF-P13-021:** El sistema debe dejar visibles los reparos ingresados para Decretación.
- **RF-P13-022:** El sistema debe actualizar el estado del expediente a devuelto con reparos.

---

# P13-B06 — Modal de devolución con reparos

## Funcionalidad P13-F07 — Gestionar devolución con reparos mediante modal

### A. Descripción funcional

El sistema debe desplegar un modal específico para registrar la devolución con reparos antes de modificar el estado del expediente.

### B. Actor principal

Profesional de Contraloría.

### C. Información que debe contener el modal

- Tipo de acción:
  - Devolver con reparos.
- Motivo o causal.
- Comentario obligatorio.
- Mensaje de advertencia indicando que el expediente retornará a Decretación.
- Botón confirmar.
- Botón cancelar.

### D. Reglas de negocio

- El sistema no debe permitir confirmar la devolución sin comentario obligatorio.
- Debe permitir cancelar sin modificar el expediente.
- Al confirmar, debe registrarse la devolución y cambiar el estado del expediente.

### E. Historia de usuario preliminar

**HU-P13-07:** Como **Profesional de Contraloría**, quiero registrar los reparos en un modal de devolución, para dejar constancia clara antes de enviar el expediente de vuelta a Decretación.

### F. Requerimientos funcionales preliminares

- **RF-P13-023:** El sistema debe desplegar un modal para la acción de devolución con reparos.
- **RF-P13-024:** El modal debe exigir motivo y comentario obligatorio.
- **RF-P13-025:** El sistema debe permitir cancelar la devolución sin modificar el estado.
- **RF-P13-026:** El sistema debe confirmar visualmente que el expediente retornará a Decretación.

---

# P13-B07 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P13-F08 — Confirmar visación y envío a Contralor/a Final

### A. Descripción funcional

Antes de derivar el expediente a la etapa de Contralor/a Final, el sistema debe solicitar confirmación explícita al Profesional de Contraloría.

### B. Actor principal

Profesional de Contraloría.

### C. Contenido mínimo de la confirmación

- Se registrará la visación profesional.
- El expediente avanzará a Contralor/a Final.
- La acción quedará registrada en trazabilidad.

### D. Reglas de negocio

- Debe permitirse cancelar la acción antes de aplicarla.
- La confirmación no debe solicitar comentarios obligatorios, salvo que el diseño funcional futuro lo requiera.

### E. Historia de usuario preliminar

**HU-P13-08:** Como **Profesional de Contraloría**, quiero confirmar la visación antes de enviar el expediente al Contralor/a Final, para evitar derivaciones accidentales.

### F. Requerimientos funcionales preliminares

- **RF-P13-027:** El sistema debe solicitar confirmación antes de visar y enviar a Contralor/a Final.
- **RF-P13-028:** El sistema debe permitir cancelar la visación antes de aplicarla.
- **RF-P13-029:** El sistema debe registrar la confirmación de envío cuando la acción se ejecuta.

---

## Funcionalidad P13-F09 — Registrar trazabilidad de revisión profesional

### A. Descripción funcional

El sistema debe registrar de forma auditable las acciones ejecutadas por el Profesional de Contraloría.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Ingreso del expediente a Contraloría Profesional.
- Visualización o apertura del expediente, si se decide registrar.
- Visación profesional.
- Envío a Contralor/a Final.
- Devolución con reparos a Decretación.
- Motivos y comentarios asociados a devolución.

### D. Datos mínimos de trazabilidad

- Código de solicitud.
- Número de resolución/decreto.
- Usuario.
- Rol.
- Acción ejecutada.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Motivo y comentario, cuando corresponda.

### E. Historia de usuario preliminar

**HU-P13-09:** Como **sistema**, debo registrar las acciones de visación y devolución ejecutadas por Contraloría Profesional, para mantener trazabilidad completa del proceso de Toma de Razón.

### F. Requerimientos funcionales preliminares

- **RF-P13-030:** El sistema debe registrar toda acción ejecutada por el Profesional de Contraloría.
- **RF-P13-031:** El sistema debe registrar el envío a Contralor/a Final.
- **RF-P13-032:** El sistema debe registrar la devolución con reparos y sus comentarios.
- **RF-P13-033:** El sistema debe conservar el estado previo y el estado resultante de cada acción.

---

# 7. Estados de salida de la Pantalla 13

| Acción del Profesional de Contraloría | Estado resultante | Destino |
|---|---|---|
| **VISAR Y ENVIAR A CONTRALOR** | Visado por Profesional de Contraloría | Avanza a Contralor/a Final |
| **DEVOLVER CON REPAROS** | Devuelto con reparos por Contraloría Profesional | Retorna a Decretación |

---

# 8. Estados posibles del expediente en Contraloría Profesional

| Estado | Descripción |
|---|---|
| **Pendiente de revisión profesional** | El expediente ingresó desde Rectoría y espera análisis. |
| **En revisión profesional** | El Profesional de Contraloría está analizando el documento. |
| **Visado y enviado a Contralor/a Final** | El expediente fue revisado favorablemente y avanza a la siguiente etapa. |
| **Devuelto con reparos** | El expediente fue retornado a Decretación con observaciones registradas. |

---

# 9. Reglas globales de comportamiento de la Pantalla 13

| Código | Regla |
|---|---|
| **RG-P13-001** | Contraloría Profesional debe recibir el acto administrativo firmado por Rectoría. |
| **RG-P13-002** | El documento visualizado debe corresponder a la versión vigente que ingresó a Toma de Razón. |
| **RG-P13-003** | La pantalla debe mostrar el acto administrativo mediante visor PDF en modo solo lectura. |
| **RG-P13-004** | El Profesional de Contraloría no debe editar ni reemplazar el documento desde esta pantalla. |
| **RG-P13-005** | La pantalla debe mostrar la trazabilidad completa del expediente hasta su ingreso a Contraloría Profesional. |
| **RG-P13-006** | El sistema debe permitir visar y enviar el expediente a Contralor/a Final. |
| **RG-P13-007** | La devolución con reparos debe retornar el expediente a Decretación. |
| **RG-P13-008** | La devolución con reparos debe exigir motivo y comentario obligatorio. |
| **RG-P13-009** | La devolución con reparos debe gestionarse mediante un modal de confirmación. |
| **RG-P13-010** | La visación y envío a Contralor/a Final debe requerir confirmación previa. |
| **RG-P13-011** | Toda decisión del Profesional de Contraloría debe quedar registrada en trazabilidad. |
| **RG-P13-012** | La pantalla no debe incorporar acciones de firma, carga de documentos o edición documental. |
| **RG-P13-013** | La pantalla no debe incorporar una acción de rechazo definitivo mientras esta atribución no sea definida formalmente para el rol. |
| **RG-P13-014** | La pantalla no debe incorporar la acción Salir sin guardar. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 13

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P13-001** | Legibilidad documental | El visor PDF debe permitir revisar adecuadamente el acto administrativo recibido. |
| **RNF-P13-002** | Integridad documental | El documento visualizado debe corresponder a la versión vigente posterior a la firma de Rectoría. |
| **RNF-P13-003** | Seguridad por rol | Solo usuarios autorizados como Profesional de Contraloría deben acceder y ejecutar acciones en esta pantalla. |
| **RNF-P13-004** | Trazabilidad | La visación profesional y la devolución con reparos deben quedar registradas de forma auditable. |
| **RNF-P13-005** | Comentarios obligatorios | El sistema debe impedir devolver con reparos si no se registra un comentario. |
| **RNF-P13-006** | Confirmación de acciones | La visación y la devolución deben requerir confirmación previa antes de modificar el estado. |
| **RNF-P13-007** | Coherencia del flujo | La visación debe derivar a Contralor/a Final y la devolución debe retornar a Decretación. |
| **RNF-P13-008** | Modo solo lectura | La pantalla no debe habilitar edición de documentos ni datos del expediente. |
| **RNF-P13-009** | Claridad de estado | El usuario debe identificar si el expediente está en revisión, visado o devuelto con reparos. |
| **RNF-P13-010** | Consistencia con etapas previas | La pantalla debe mantener coherencia con el documento y trazabilidad recibidos desde Rectoría. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 13

| Código | Funcionalidad |
|---|---|
| **P13-F01** | Visualizar identificación del expediente y resolución. |
| **P13-F02** | Visualizar el acto administrativo firmado como PDF. |
| **P13-F03** | Visualizar historial completo del expediente. |
| **P13-F04** | Visualizar estado de revisión en Contraloría Profesional. |
| **P13-F05** | Visar y enviar a Contralor/a Final. |
| **P13-F06** | Devolver con reparos a Decretación. |
| **P13-F07** | Gestionar devolución con reparos mediante modal. |
| **P13-F08** | Confirmar visación y envío a Contralor/a Final. |
| **P13-F09** | Registrar trazabilidad de revisión profesional. |