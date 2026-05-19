# PDS Normativo D9 / DU288 / DU09

## Pantalla 14 — Toma de Razón Final por Contralor Universitario

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 14: Toma de Razón Final — Perfil Contralor Universitario** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a la etapa de **decisión final de Contraloría Universitaria** sobre el acto administrativo que ya fue:

- Generado en Decretación.
- Firmado por Secretaría General.
- Firmado por Rectoría.
- Revisado favorablemente por el Profesional de Contraloría.

En esta etapa, el Contralor Universitario visualiza el acto administrativo en formato **PDF**, revisa la trazabilidad completa del expediente y determina si corresponde:

- **Proceder con la Toma de Razón**, derivando el expediente a **Archivo Universitario**.
- **Devolver / Representar** el acto administrativo, retornándolo a **Decretación** con observaciones.

La pantalla debe permitir:

- Visualizar el documento sometido a Toma de Razón Final.
- Revisar el documento como PDF en modo solo lectura.
- Consultar la trazabilidad de todas las etapas previas del flujo.
- Verificar que el Profesional de Contraloría emitió su visación favorable.
- Registrar la Toma de Razón definitiva.
- Devolver o representar el documento cuando existan reparos.
- Registrar comentarios obligatorios cuando el documento no sea aprobado.
- Mantener trazabilidad completa de la decisión del Contralor Universitario.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 14 — Contralor Universitario**. No modifica la revisión profesional previa ni la etapa posterior de Archivo Universitario. Su objetivo es definir qué documento debe revisarse, qué información debe visualizarse y qué decisiones puede ejecutar el Contralor Universitario dentro del flujo de Toma de Razón.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P14 |
| **Nombre** | Toma de Razón Final por Contralor Universitario |
| **Perfil principal** | Contralor Universitario |
| **Etapa del flujo** | Etapa 14 — Toma de Razón Final |
| **Estado de entrada esperado** | Expediente visado favorablemente por Profesional de Contraloría |
| **Objetivo principal** | Permitir que el Contralor Universitario revise el acto administrativo y decida si procede la Toma de Razón definitiva o si el documento debe devolverse / representarse con observaciones. |
| **Resultado posible** | Toma de Razón realizada y expediente derivado a Archivo Universitario; o expediente devuelto / representado y retornado a Decretación. |

---

# 3. Principio funcional de la Pantalla 14

La Pantalla 14 debe operar como una **vista de decisión contralora final**, enfocada en el acto administrativo que ya superó todas las etapas previas del flujo.

A diferencia de la Pantalla 13, donde el Profesional de Contraloría realiza una revisión preliminar y deriva el expediente, en esta etapa el Contralor Universitario emite la **decisión definitiva de Toma de Razón**.

El documento visualizado en esta pantalla debe corresponder a la **versión vigente posterior a la firma de Rectoría y a la visación favorable de Contraloría Profesional**, sin permitir edición ni alteración desde esta vista.

La labor del Contralor Universitario consiste en:

1. Revisar el acto administrativo.
2. Consultar la trazabilidad completa.
3. Confirmar que existe visación previa del Profesional de Contraloría.
4. Proceder con la Toma de Razón o devolver / representar el documento.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 14 debe permitir que el Contralor Universitario:

- Visualice la identificación del expediente sometido a Toma de Razón Final.
- Visualice el número o identificador de la resolución/decreto.
- Visualice el estado actual:
  - **Pendiente de Toma de Razón Final**.
- Revise la trazabilidad documental completa del expediente.
- Visualice que el expediente ya fue:
  - Generado en Decretación.
  - Firmado por Secretaría General.
  - Firmado por Rectoría.
  - Visado favorablemente por Profesional de Contraloría.
- Visualice el acto administrativo en formato PDF embebido.
- Revise el documento completo desde el visor.
- Visualice el contenido formal del acto administrativo, incluyendo:
  - Encabezado institucional.
  - Identificación de la resolución.
  - Texto del acto administrativo.
  - Sección o referencia de Toma de Razón, cuando corresponda.
  - Identificación del Contralor Universitario.
- Visualice la trazabilidad del ingreso a Contraloría Final.
- Ejecute la acción **PROCEDER TOMA DE RAZÓN**, cuando el expediente pueda continuar.
- Derive el expediente a **Archivo Universitario** una vez registrada la Toma de Razón.
- Ejecute la acción **DEVOLVER / REPRESENTAR** cuando existan reparos u observaciones.
- Retorne el expediente a **Decretación** cuando se ejecute la devolución / representación.
- Registre comentario obligatorio al devolver o representar.
- Confirme la decisión antes de modificar el estado del expediente.
- Registre trazabilidad de:
  - Toma de Razón final.
  - Derivación a Archivo Universitario.
  - Devolución / Representación.
  - Comentarios asociados.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 14 no debe:

- Editar el contenido del acto administrativo.
- Modificar VISTOS, CONSIDERANDOS, RESUELVO o cualquier sección documental.
- Alterar el documento firmado por Rectoría.
- Reemplazar el PDF recibido.
- Cargar una nueva versión del acto administrativo.
- Modificar la visación previa realizada por Profesional de Contraloría.
- Alterar antecedentes técnicos, financieros o normativos del expediente.
- Incorporar nuevos funcionarios.
- Excluir o reponer funcionarios.
- Modificar firmas previas de Secretaría General o Rectoría.
- Enviar el expediente a una etapa distinta de Archivo Universitario cuando se proceda con la Toma de Razón.
- Devolver el expediente a una etapa distinta de Decretación, salvo definición posterior del flujo.
- Incorporar acciones de edición documental, carga de archivos o modificación de firmas.
- Incorporar la acción **Salir sin guardar** como acción de proceso.

---

# 4. Objetivo funcional de la Pantalla 14

La pantalla debe permitir que el Contralor Universitario:

1. Identifique el expediente que ingresa a Toma de Razón Final.
2. Visualice el número o identificador de la resolución.
3. Confirme que el expediente fue visado por Profesional de Contraloría.
4. Revise el estado actual del expediente.
5. Visualice el documento en formato PDF.
6. Revise el contenido formal del acto administrativo.
7. Consulte la trazabilidad completa de las etapas anteriores.
8. Verifique que Secretaría General, Rectoría y Contraloría Profesional registraron sus actuaciones previas.
9. Determine si corresponde proceder con la Toma de Razón.
10. Registre la Toma de Razón definitiva.
11. Derive el expediente a Archivo Universitario.
12. Devuelva o represente el acto administrativo cuando detecte reparos.
13. Ingrese comentarios obligatorios al devolver / representar.
14. Confirme la acción antes de ejecutarla.
15. Registre trazabilidad completa de su decisión.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 14 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P14-B01** | Encabezado del expediente y estado de Toma de Razón Final | Identificar la resolución, el expediente y la etapa actual. |
| **P14-B02** | Visor PDF del acto administrativo | Permitir revisar el documento sometido a decisión final. |
| **P14-B03** | Trazabilidad documental del expediente | Mostrar el historial completo hasta Contraloría Profesional. |
| **P14-B04** | Estado actual de Toma de Razón Final | Mostrar que el expediente se encuentra pendiente de decisión del Contralor Universitario. |
| **P14-B05** | Decisión global del Contralor Universitario | Proceder Toma de Razón o Devolver / Representar. |
| **P14-B06** | Modal de devolución / representación | Capturar motivo, comentario y confirmación de retorno a Decretación. |
| **P14-B07** | Confirmación, transición de estado y trazabilidad | Registrar Toma de Razón o devolución / representación. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P14-B01 — Encabezado del expediente y estado de Toma de Razón Final

## Funcionalidad P14-F01 — Visualizar identificación del expediente y resolución

### A. Descripción funcional

El sistema debe mostrar la identificación de la solicitud y del acto administrativo sometido a decisión final por el Contralor Universitario.

### B. Actor principal

Contralor Universitario.

### C. Datos que debe mostrar el sistema

- Código único de solicitud.
- Número o identificador de resolución/decreto.
- Título de la etapa:
  - **Contralor Universitario**.
  - **Toma de Razón Final**.
- Estado actual:
  - **Pendiente de decisión final**.
- Tipo de documento sometido a revisión.

### D. Reglas de negocio

- El número de resolución debe corresponder al acto administrativo vigente.
- El expediente visualizado debe ser el mismo derivado desde Contraloría Profesional.

### E. Historia de usuario preliminar

**HU-P14-01:** Como **Contralor Universitario**, quiero visualizar la identificación del expediente y de la resolución asociada, para revisar el documento correcto dentro de la Toma de Razón Final.

### F. Requerimientos funcionales preliminares

- **RF-P14-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-P14-002:** El sistema debe mostrar el número o identificador de la resolución/decreto.
- **RF-P14-003:** El sistema debe mostrar que el expediente se encuentra en etapa de Toma de Razón Final.

---

# P14-B02 — Visor PDF del acto administrativo

## Funcionalidad P14-F02 — Visualizar el acto administrativo como PDF

### A. Descripción funcional

El sistema debe mostrar el acto administrativo recibido desde Contraloría Profesional mediante un visor PDF embebido.

### B. Actor principal

Contralor Universitario.

### C. Contenido visible del documento

El visor debe permitir revisar:

- Encabezado institucional.
- Número de resolución/decreto.
- Texto del acto administrativo.
- Firma o constancia de firma de Secretaría General.
- Firma o constancia de firma de Rectoría.
- Referencia a Toma de Razón, cuando forme parte del formato documental.
- Identificación del Contralor Universitario, si la plantilla la contempla.
- Anexos incorporados, si corresponde.

### D. Reglas de negocio

- El PDF debe corresponder a la versión documental vigente derivada desde Contraloría Profesional.
- El documento debe mostrarse en modo solo lectura.
- La pantalla no debe permitir edición, reemplazo ni regeneración del documento.

### E. Historia de usuario preliminar

**HU-P14-02:** Como **Contralor Universitario**, quiero revisar en pantalla el acto administrativo sometido a Toma de Razón Final, para decidir si procede o si debe devolverse con observaciones.

### F. Requerimientos funcionales preliminares

- **RF-P14-004:** El sistema debe mostrar el documento recibido mediante un visor PDF.
- **RF-P14-005:** El visor debe permitir revisar el acto administrativo completo.
- **RF-P14-006:** El sistema debe mostrar el PDF en modo solo lectura.
- **RF-P14-007:** El sistema no debe permitir modificar ni reemplazar el documento desde esta pantalla.

---

# P14-B03 — Trazabilidad documental del expediente

## Funcionalidad P14-F03 — Visualizar historial completo del expediente

### A. Descripción funcional

El sistema debe mostrar el historial de avance de la solicitud desde su creación hasta su ingreso a Contraloría Final.

### B. Actor principal

Contralor Universitario.

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
- Visación favorable por Profesional de Contraloría.
- Ingreso a Contraloría Final.

### D. Datos por etapa

- Fecha y hora.
- Rol.
- Usuario.
- Acción ejecutada.
- Comentario asociado, si existe.

### E. Historia de usuario preliminar

**HU-P14-03:** Como **Contralor Universitario**, quiero revisar la trazabilidad documental completa del expediente, para verificar el recorrido institucional previo antes de emitir la Toma de Razón Final.

### F. Requerimientos funcionales preliminares

- **RF-P14-008:** El sistema debe mostrar cronológicamente las etapas previas del expediente.
- **RF-P14-009:** El sistema debe mostrar usuario, rol, acción, fecha y hora en cada hito.
- **RF-P14-010:** El sistema debe mostrar la visación favorable del Profesional de Contraloría como antecedente previo.
- **RF-P14-011:** El sistema debe mostrar el ingreso del expediente a Contraloría Final como último evento vigente.

---

# P14-B04 — Estado actual de Toma de Razón Final

## Funcionalidad P14-F04 — Visualizar estado de decisión final del Contralor Universitario

### A. Descripción funcional

El sistema debe mostrar de forma clara que el expediente está pendiente de decisión final por parte del Contralor Universitario.

### B. Actor principal

Contralor Universitario.

### C. Estados posibles

- Pendiente de Toma de Razón Final.
- En revisión por Contralor Universitario.
- Toma de Razón realizada.
- Devuelto / Representado a Decretación.

### D. Reglas de negocio

- El estado debe reflejar el avance real de la revisión.
- Una vez ejecutada la Toma de Razón o la devolución / representación, el expediente no debe permanecer visible como pendiente en la bandeja activa del Contralor Universitario.

### E. Historia de usuario preliminar

**HU-P14-04:** Como **Contralor Universitario**, quiero visualizar el estado actual del expediente, para saber si se encuentra pendiente de mi decisión o si ya fue resuelto.

### F. Requerimientos funcionales preliminares

- **RF-P14-012:** El sistema debe mostrar el estado actual de Toma de Razón Final.
- **RF-P14-013:** El sistema debe actualizar el estado tras proceder con la Toma de Razón o devolver / representar.
- **RF-P14-014:** El sistema debe dejar de mostrar el expediente como pendiente una vez resuelto.

---

# P14-B05 — Decisión global del Contralor Universitario

## Funcionalidad P14-F05 — Proceder con la Toma de Razón

### A. Descripción funcional

El Contralor Universitario debe poder registrar la Toma de Razón definitiva del acto administrativo y derivar el expediente a la etapa de Archivo Universitario.

### B. Actor principal

Contralor Universitario.

### C. Acción disponible

- Botón: **PROCEDER TOMA DE RAZÓN**.

### D. Resultado esperado

- Se registra la Toma de Razón final.
- El expediente avanza a **Archivo Universitario**.
- Se conserva trazabilidad del acto contralor.

### E. Reglas de negocio

- La acción debe registrar:
  - Usuario.
  - Rol.
  - Fecha.
  - Hora.
  - Estado resultante.
- La acción debe derivar el expediente a la etapa 15 del flujo:
  - **Archivo Universitario**.

### F. Historia de usuario preliminar

**HU-P14-05:** Como **Contralor Universitario**, quiero proceder con la Toma de Razón del acto administrativo, para cerrar la revisión contralora y derivar el expediente a Archivo Universitario.

### G. Requerimientos funcionales preliminares

- **RF-P14-015:** El sistema debe permitir proceder con la Toma de Razón Final.
- **RF-P14-016:** El sistema debe derivar el expediente a Archivo Universitario.
- **RF-P14-017:** El sistema debe registrar la decisión con usuario, rol, fecha y hora.
- **RF-P14-018:** El sistema debe actualizar el estado del expediente a **Toma de Razón realizada**.

---

## Funcionalidad P14-F06 — Devolver / Representar expediente a Decretación

### A. Descripción funcional

El Contralor Universitario debe poder devolver o representar el expediente cuando detecte reparos que impidan la Toma de Razón definitiva.

### B. Actor principal

Contralor Universitario.

### C. Acción disponible

- Botón: **DEVOLVER / REPRESENTAR**.

### D. Datos de entrada requeridos

- Motivo o causal.
- Comentario obligatorio.
- Tipo de acción, si el flujo distingue entre:
  - Devolución.
  - Representación.

### E. Reglas de negocio

- La acción debe retornar el expediente a **Decretación**.
- El comentario debe quedar visible para el rol de Decretación.
- La acción debe registrar:
  - Usuario.
  - Rol.
  - Fecha.
  - Hora.
  - Motivo.
  - Comentario.
- La decisión debe generar trazabilidad formal.
- La devolución / representación puede ejecutarse sin proceder previamente con la Toma de Razón.

> **TODO:** Definir si **DEVOLVER** y **REPRESENTAR** tendrán comportamientos diferenciados o si se mantendrán como una acción única de retorno a Decretación.

### F. Historia de usuario preliminar

**HU-P14-06:** Como **Contralor Universitario**, quiero devolver o representar el expediente cuando detecte reparos, para que Decretación revise y subsane lo observado antes de una eventual Toma de Razón.

### G. Requerimientos funcionales preliminares

- **RF-P14-019:** El sistema debe permitir devolver o representar el expediente.
- **RF-P14-020:** El sistema debe retornar el expediente a Decretación.
- **RF-P14-021:** El sistema debe exigir motivo y comentario obligatorio.
- **RF-P14-022:** El sistema debe registrar usuario, rol, fecha y hora de la acción.
- **RF-P14-023:** El sistema debe dejar visibles los reparos para Decretación.
- **RF-P14-024:** El sistema debe actualizar el estado del expediente a **Devuelto / Representado por Contralor Universitario**.

---

# P14-B06 — Modal de devolución / representación

## Funcionalidad P14-F07 — Gestionar devolución / representación mediante modal

### A. Descripción funcional

El sistema debe desplegar un modal para registrar la devolución o representación antes de modificar el estado del expediente.

### B. Actor principal

Contralor Universitario.

### C. Información que debe contener el modal

- Tipo de acción:
  - Devolver / Representar.
- Motivo o causal.
- Comentario obligatorio.
- Mensaje de advertencia indicando que el expediente retornará a Decretación.
- Botón confirmar.
- Botón cancelar.

### D. Reglas de negocio

- El sistema no debe permitir confirmar sin comentario obligatorio.
- Debe permitir cancelar sin modificar el expediente.
- Al confirmar, debe registrarse la acción y cambiar el estado del expediente.

### E. Historia de usuario preliminar

**HU-P14-07:** Como **Contralor Universitario**, quiero registrar la devolución o representación mediante un modal, para dejar constancia clara del reparo antes de retornar el expediente a Decretación.

### F. Requerimientos funcionales preliminares

- **RF-P14-025:** El sistema debe desplegar un modal para la acción **DEVOLVER / REPRESENTAR**.
- **RF-P14-026:** El modal debe exigir motivo y comentario obligatorio.
- **RF-P14-027:** El sistema debe permitir cancelar la acción sin modificar el estado.
- **RF-P14-028:** El sistema debe mostrar que el expediente retornará a Decretación.

---

# P14-B07 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P14-F08 — Confirmar Toma de Razón y derivación a Archivo Universitario

### A. Descripción funcional

Antes de registrar la Toma de Razón Final, el sistema debe solicitar confirmación explícita al Contralor Universitario.

### B. Actor principal

Contralor Universitario.

### C. Contenido mínimo de la confirmación

- Se registrará la Toma de Razón Final.
- El expediente avanzará a Archivo Universitario.
- La acción quedará registrada en trazabilidad.

### D. Reglas de negocio

- Debe permitirse cancelar la acción antes de aplicarla.
- La confirmación no requiere comentario obligatorio, salvo definición posterior del proceso.

### E. Historia de usuario preliminar

**HU-P14-08:** Como **Contralor Universitario**, quiero confirmar la Toma de Razón antes de ejecutarla, para evitar cerrar accidentalmente una revisión que aún no corresponde finalizar.

### F. Requerimientos funcionales preliminares

- **RF-P14-029:** El sistema debe solicitar confirmación antes de proceder con la Toma de Razón.
- **RF-P14-030:** El sistema debe permitir cancelar la acción antes de aplicarla.
- **RF-P14-031:** El sistema debe registrar la confirmación cuando la acción se ejecuta.

---

## Funcionalidad P14-F09 — Registrar trazabilidad de decisión final contralora

### A. Descripción funcional

El sistema debe registrar de forma auditable las acciones ejecutadas por el Contralor Universitario.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Ingreso del expediente a Contraloría Final.
- Apertura o visualización del expediente, si se decide registrar.
- Toma de Razón Final.
- Derivación a Archivo Universitario.
- Devolución / Representación a Decretación.
- Motivos y comentarios asociados.

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

**HU-P14-09:** Como **sistema**, debo registrar las acciones de Toma de Razón y devolución / representación ejecutadas por el Contralor Universitario, para mantener trazabilidad completa de la decisión final de Contraloría.

### F. Requerimientos funcionales preliminares

- **RF-P14-032:** El sistema debe registrar toda acción ejecutada por el Contralor Universitario.
- **RF-P14-033:** El sistema debe registrar la Toma de Razón y la derivación a Archivo Universitario.
- **RF-P14-034:** El sistema debe registrar la devolución / representación y sus comentarios.
- **RF-P14-035:** El sistema debe conservar el estado previo y el estado resultante de cada acción.

---

# 7. Estados de salida de la Pantalla 14

| Acción del Contralor Universitario | Estado resultante | Destino |
|---|---|---|
| **PROCEDER TOMA DE RAZÓN** | Toma de Razón realizada | Avanza a Archivo Universitario |
| **DEVOLVER / REPRESENTAR** | Devuelto / Representado por Contralor Universitario | Retorna a Decretación |

---

# 8. Estados posibles del expediente en Contraloría Final

| Estado | Descripción |
|---|---|
| **Pendiente de Toma de Razón Final** | El expediente ingresó desde Contraloría Profesional y espera decisión del Contralor Universitario. |
| **En revisión por Contralor Universitario** | El expediente se encuentra en análisis final. |
| **Toma de Razón realizada** | El acto administrativo fue aprobado contraloramente y avanza a Archivo Universitario. |
| **Devuelto / Representado** | El expediente fue retornado a Decretación con observaciones. |

---

# 9. Reglas globales de comportamiento de la Pantalla 14

| Código | Regla |
|---|---|
| **RG-P14-001** | El Contralor Universitario debe recibir el expediente visado favorablemente por Profesional de Contraloría. |
| **RG-P14-002** | El documento visualizado debe corresponder a la versión vigente sometida a Toma de Razón Final. |
| **RG-P14-003** | La pantalla debe mostrar el acto administrativo mediante visor PDF en modo solo lectura. |
| **RG-P14-004** | El Contralor Universitario no debe editar ni reemplazar el documento desde esta pantalla. |
| **RG-P14-005** | La pantalla debe mostrar la trazabilidad completa del expediente hasta su ingreso a Contraloría Final. |
| **RG-P14-006** | El sistema debe mostrar la visación favorable previa del Profesional de Contraloría. |
| **RG-P14-007** | El sistema debe permitir proceder con la Toma de Razón Final. |
| **RG-P14-008** | La Toma de Razón debe derivar el expediente a Archivo Universitario. |
| **RG-P14-009** | La devolución / representación debe retornar el expediente a Decretación. |
| **RG-P14-010** | La devolución / representación debe exigir motivo y comentario obligatorio. |
| **RG-P14-011** | La devolución / representación debe gestionarse mediante modal de confirmación. |
| **RG-P14-012** | La Toma de Razón debe requerir confirmación previa. |
| **RG-P14-013** | Toda decisión del Contralor Universitario debe quedar registrada en trazabilidad. |
| **RG-P14-014** | La pantalla no debe incorporar acciones de firma, carga de documentos ni edición documental. |
| **RG-P14-015** | La pantalla no debe incorporar la acción Salir sin guardar. |
| **RG-P14-016** | La diferencia funcional entre “Devolver” y “Representar” queda pendiente de definición si se requiere tratarlas como acciones distintas. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 14

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P14-001** | Legibilidad documental | El visor PDF debe permitir revisar adecuadamente el acto administrativo sometido a Toma de Razón Final. |
| **RNF-P14-002** | Integridad documental | El documento visualizado debe corresponder a la versión vigente posterior a la revisión profesional de Contraloría. |
| **RNF-P14-003** | Seguridad por rol | Solo usuarios autorizados como Contralor Universitario deben acceder y ejecutar acciones en esta pantalla. |
| **RNF-P14-004** | Trazabilidad | La Toma de Razón y la devolución / representación deben quedar registradas de forma auditable. |
| **RNF-P14-005** | Comentarios obligatorios | El sistema debe impedir devolver / representar si no se registra un comentario. |
| **RNF-P14-006** | Confirmación de acciones | La Toma de Razón y la devolución / representación deben requerir confirmación previa antes de modificar el estado. |
| **RNF-P14-007** | Coherencia del flujo | La Toma de Razón debe derivar a Archivo Universitario y la devolución / representación debe retornar a Decretación. |
| **RNF-P14-008** | Modo solo lectura | La pantalla no debe habilitar edición de documentos ni datos del expediente. |
| **RNF-P14-009** | Claridad de estado | El usuario debe identificar si el expediente está pendiente, resuelto o devuelto / representado. |
| **RNF-P14-010** | Consistencia con Contraloría Profesional | La pantalla debe mantener coherencia con la revisión profesional favorable registrada en la etapa anterior. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 14

| Código | Funcionalidad |
|---|---|
| **P14-F01** | Visualizar identificación del expediente y resolución. |
| **P14-F02** | Visualizar el acto administrativo como PDF. |
| **P14-F03** | Visualizar historial completo del expediente. |
| **P14-F04** | Visualizar estado de decisión final del Contralor Universitario. |
| **P14-F05** | Proceder con la Toma de Razón. |
| **P14-F06** | Devolver / Representar expediente a Decretación. |
| **P14-F07** | Gestionar devolución / representación mediante modal. |
| **P14-F08** | Confirmar Toma de Razón y derivación a Archivo Universitario. |
| **P14-F09** | Registrar trazabilidad de decisión final contralora. |