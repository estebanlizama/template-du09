# PDS Normativo D9 / DU288 / DU09

## Pantalla 11 — Visación y Firma Física por Secretario General

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 11: Visación y Firma Física — Perfil Secretario General** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a una etapa de **revisión formal, firma física y continuidad del acto administrativo**, posterior a la generación documental realizada en **Decretación**.

En esta etapa, el Secretario General recibe el **documento administrativo ya generado en Decretación**, visualiza la resolución o decreto en formato **PDF**, lo descarga para gestionar su **firma física**, carga nuevamente el archivo firmado y registra una decisión sobre la continuidad del expediente.

La pantalla debe permitir:

- Visualizar el acto administrativo generado por Decretación como documento PDF.
- Confirmar que el documento corresponde al expediente PDS vigente.
- Descargar el archivo para firma física.
- Subir el documento firmado.
- Visualizar el estado de carga del documento firmado.
- Aprobar y continuar el flujo únicamente cuando el documento firmado se encuentre cargado.
- Devolver con corrección el expediente a Decretación cuando existan errores en el documento o antecedentes que deban corregirse.
- Rechazar la solicitud cuando no corresponda su continuidad.
- Registrar trazabilidad de la revisión, descarga, carga del documento y decisión del Secretario General.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 11 — Secretario General**. No modifica la etapa de Decretación ni las etapas posteriores de firma. Su objetivo es definir qué documento debe visualizarse, qué acciones puede ejecutar el Secretario General, cómo se gestiona la firma física y qué decisiones puede registrar sobre el expediente.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P11 |
| **Nombre** | Visación y Firma Física por Secretario General |
| **Perfil principal** | Secretario General o usuario autorizado para la firma física del acto administrativo |
| **Etapa del flujo** | Etapa 11 — Firma física y visación del acto administrativo |
| **Estado de entrada esperado** | Documento administrativo generado y enviado desde Decretación |
| **Objetivo principal** | Permitir que el Secretario General visualice el PDF generado en Decretación, lo descargue para firma física, cargue el documento firmado y decida si aprueba su continuidad, lo devuelve con corrección a Decretación o rechaza la solicitud. |
| **Resultado posible** | Documento firmado cargado y aprobado para continuar; expediente devuelto con corrección a Decretación; o solicitud rechazada. |

---

# 3. Principio funcional de la Pantalla 11

La Pantalla 11 debe operar como una **vista de firma física y visación documental**, centrada en el acto administrativo generado previamente por Decretación.

El documento que se muestra en esta etapa no debe ser reconstruido, recalculado ni editable desde Secretaría General. Debe corresponder a la **versión documental formal enviada desde Decretación**, incluyendo:

- VISTOS.
- CONSIDERANDOS.
- RESUELVO / DISPÓNESE.
- Tabla documental de prestaciones.
- Firmantes definidos.
- Distribución.
- Cierre documental.

La labor del Secretario General consiste en:

1. Revisar el documento PDF.
2. Descargarlo para firma física.
3. Cargar la versión firmada.
4. Aprobar la continuidad del flujo o devolver/rechazar según corresponda.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 11 debe permitir que el Secretario General:

- Visualice la identificación del expediente asociado al documento.
- Visualice el estado actual del proceso de firma.
- Revise la trazabilidad previa del expediente hasta la etapa de Decretación.
- Visualice que el documento proviene de Decretación y que corresponde a la versión enviada a firma.
- Visualice el acto administrativo en formato PDF embebido en la pantalla.
- Revise el documento completo desde el visor PDF.
- Visualice los metadatos del documento:
  - Código de solicitud.
  - Tipo de acto administrativo.
  - Fecha de envío desde Decretación.
  - Versión documental enviada.
  - Firmantes definidos en Decretación.
  - Estado de firma.
- Descargue el PDF para gestionar su firma física.
- Suba el documento firmado por el Secretario General.
- Asocie el archivo firmado al expediente correspondiente.
- Visualice el estado de carga del documento firmado:
  - Pendiente de carga.
  - Documento firmado cargado.
- Visualice datos del archivo firmado cargado:
  - Nombre del archivo.
  - Fecha de carga.
  - Usuario que realizó la carga.
  - Estado de validación de carga.
- Apruebe y continúe el flujo mediante la acción **APROBAR Y CONTINUAR**, una vez cargado el documento firmado.
- Devuelva con corrección el expediente a **Decretación** mediante la acción **DEVOLVER CON CORRECCIÓN**.
- Rechace la solicitud mediante la acción **RECHAZAR SOLICITUD**.
- Ingrese comentario obligatorio cuando devuelve o rechaza.
- Gestione devolución y rechazo mediante un **modal global único**.
- Confirme la aprobación antes de derivar el documento a la etapa siguiente.
- Registre trazabilidad de:
  - Visualización del documento, si se decide registrar.
  - Descarga del documento.
  - Carga del documento firmado.
  - Aprobación.
  - Devolución con corrección.
  - Rechazo.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 11 no debe:

- Editar los textos del acto administrativo.
- Modificar VISTOS, CONSIDERANDOS, RESUELVO o cualquier sección textual del documento.
- Alterar la tabla de prestaciones incluida en el documento.
- Modificar firmantes seleccionados en Decretación.
- Modificar la distribución del documento.
- Regenerar el acto administrativo desde esta etapa.
- Sustituir el documento enviado por Decretación antes de su firma, salvo mediante el mecanismo formal de devolución con corrección.
- Modificar los antecedentes técnicos, financieros o normativos de la solicitud.
- Incorporar nuevos funcionarios.
- Excluir o reponer funcionarios.
- Aprobar la continuidad del flujo si no existe un documento firmado cargado.
- Enviar a la siguiente etapa una versión distinta del archivo firmado cargado.
- Reemplazar silenciosamente un archivo firmado sin dejar trazabilidad.
- Devolver la solicitud a etapas distintas de Decretación desde esta pantalla, salvo definición posterior del flujo.
- Incorporar la acción **Salir sin guardar** como acción del proceso.

---

# 4. Objetivo funcional de la Pantalla 11

La pantalla debe permitir que el Secretario General:

1. Identifique el expediente que ingresa a revisión y firma física.
2. Visualice el estado actual de firma del acto administrativo.
3. Revise la trazabilidad completa hasta Decretación.
4. Confirme que el documento proviene de la etapa de Decretación.
5. Visualice el PDF generado y enviado desde Decretación.
6. Revise en pantalla el contenido completo del acto administrativo.
7. Consulte los metadatos de versión, envío y firmantes del documento.
8. Descargue el PDF para gestionar su firma física.
9. Suba el documento ya firmado.
10. Visualice si el documento firmado fue cargado correctamente.
11. Consulte los datos del archivo firmado cargado.
12. Apruebe y continúe el flujo cuando el documento firmado esté disponible.
13. Devuelva con corrección a Decretación cuando detecte errores subsanables en el documento.
14. Rechace la solicitud cuando estime que no corresponde continuar.
15. Ingrese comentarios obligatorios para devolución y rechazo.
16. Confirme las decisiones que cambien el estado del expediente.
17. Registre trazabilidad de la etapa de firma física.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 11 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P11-B01** | Encabezado del expediente y estado de firma | Identificar la solicitud, la etapa y el estado documental. |
| **P11-B02** | Trazabilidad previa del expediente | Mostrar el recorrido de la solicitud hasta Decretación. |
| **P11-B03** | Resumen del acto administrativo recibido | Mostrar metadatos del documento generado en Decretación. |
| **P11-B04** | Visor PDF del documento | Permitir revisar el acto administrativo completo en pantalla. |
| **P11-B05** | Descarga del documento para firma física | Permitir obtener el PDF para impresión y firma. |
| **P11-B06** | Carga del documento firmado | Permitir subir el archivo firmado físicamente. |
| **P11-B07** | Estado y metadatos del documento firmado | Mostrar si fue cargado, cuándo y por quién. |
| **P11-B08** | Decisión global del Secretario General | Aprobar y continuar, devolver con corrección o rechazar. |
| **P11-B09** | Modal global de devolución/rechazo | Registrar motivo, comentario y confirmación. |
| **P11-B10** | Confirmación, transición de estado y trazabilidad | Confirmar aprobación, aplicar cambios de estado y registrar auditoría. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P11-B01 — Encabezado del expediente y estado de firma

## Funcionalidad P11-F01 — Visualizar identificación del expediente

### A. Descripción funcional

El sistema debe mostrar claramente la identificación de la solicitud y del documento administrativo que se encuentra en etapa de firma por Secretario General.

### B. Actor principal

Secretario General.

### C. Datos que debe mostrar el sistema

- Código único de solicitud.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Título de la etapa: Firma de Acto Administrativo.
- Tipo de documento:
  - Resolución.
  - Decreto.
  - Otro, si se define.
- Identificador documental, si existe.

### D. Reglas de negocio

- El identificador de solicitud debe mantenerse inalterable.
- El documento mostrado debe estar asociado al expediente correcto.

### E. Historia de usuario preliminar

**HU-P11-01:** Como **Secretario General**, quiero visualizar claramente el expediente y el acto administrativo en firma, para asegurar que estoy revisando el documento correcto.

### F. Requerimientos funcionales preliminares

- **RF-PP11-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-PP11-002:** El sistema debe mostrar el tipo de acto administrativo asociado.
- **RF-PP11-003:** El sistema debe mostrar el identificador documental cuando exista.

---

## Funcionalidad P11-F02 — Visualizar estado de la etapa de firma

### A. Descripción funcional

El sistema debe mostrar el estado actual del proceso de firma física del documento.

### B. Actor principal

Secretario General.

### C. Estados posibles

- Pendiente de revisión documental.
- Disponible para descarga.
- Documento descargado para firma, si se registra este evento.
- Pendiente de carga de documento firmado.
- Documento firmado cargado.
- Aprobado por Secretario General.
- Devuelto con corrección.
- Rechazado.

### D. Reglas de negocio

- El estado debe reflejar la condición real del documento en la etapa.
- La opción **APROBAR Y CONTINUAR** solo debe habilitarse cuando exista un documento firmado cargado.

### E. Historia de usuario preliminar

**HU-P11-02:** Como **Secretario General**, quiero visualizar el estado de firma del documento, para saber si está pendiente de revisión, pendiente de carga o listo para avanzar.

### F. Requerimientos funcionales preliminares

- **RF-PP11-004:** El sistema debe mostrar el estado actual de la firma física.
- **RF-PP11-005:** El sistema debe distinguir si el documento firmado se encuentra pendiente o cargado.
- **RF-PP11-006:** El sistema debe condicionar la aprobación a la existencia de un documento firmado cargado.

---

# P11-B02 — Trazabilidad previa del expediente

## Funcionalidad P11-F03 — Visualizar trazabilidad del expediente hasta Decretación

### A. Descripción funcional

El sistema debe mostrar el historial de avance del expediente hasta el momento en que Decretación envió el documento a firma.

### B. Actor principal

Secretario General.

### C. Etapas mínimas a mostrar

- Creación y envío por Solicitante.
- Aprobación por Jefe de Proyecto.
- Aprobación por Jefatura Directa / Dirección de Departamento.
- Revisión DGDP.
- Revisión Finanzas de Facultad.
- Aprobación Decano/a.
- Revisión Dirección de Finanzas.
- Generación documental en Decretación.
- Envío del acto administrativo a firma.

### D. Datos por etapa

- Etapa.
- Usuario.
- Rol.
- Acción ejecutada.
- Fecha.
- Hora.
- Comentarios asociados, si existen.

### E. Historia de usuario preliminar

**HU-P11-03:** Como **Secretario General**, quiero revisar la trazabilidad previa del expediente, para conocer el respaldo de aprobación y generación documental antes de firmarlo.

### F. Requerimientos funcionales preliminares

- **RF-PP11-007:** El sistema debe mostrar cronológicamente las etapas previas del expediente.
- **RF-PP11-008:** El sistema debe mostrar usuario, rol, acción, fecha y hora por etapa.
- **RF-PP11-009:** El sistema debe registrar y mostrar el envío desde Decretación hacia Secretario General.

---

# P11-B03 — Resumen del acto administrativo recibido

## Funcionalidad P11-F04 — Visualizar metadatos del documento enviado desde Decretación

### A. Descripción funcional

El sistema debe mostrar un resumen del acto administrativo recibido desde Decretación, con información suficiente para confirmar la versión documental que será firmada.

### B. Actor principal

Secretario General.

### C. Datos que debe mostrar el sistema

- Código de solicitud.
- Tipo de documento.
- Número o identificador de resolución/decreto, si existe.
- Fecha de generación o envío desde Decretación.
- Usuario responsable del envío.
- Versión documental.
- Estado:
  - Enviado a firma.
  - Firmado cargado.
- Firmantes definidos en Decretación.
- Distribución definida en Decretación, como antecedente.

### D. Reglas de negocio

- La información debe provenir del documento generado en Decretación.
- El Secretario General no puede modificar estos datos desde esta pantalla.

### E. Historia de usuario preliminar

**HU-P11-04:** Como **Secretario General**, quiero visualizar los metadatos del documento enviado desde Decretación, para confirmar que corresponde a la versión correcta antes de firmarlo.

### F. Requerimientos funcionales preliminares

- **RF-PP11-010:** El sistema debe mostrar los metadatos del acto administrativo enviado desde Decretación.
- **RF-PP11-011:** El sistema debe mostrar la versión documental vigente.
- **RF-PP11-012:** El sistema debe mostrar los firmantes definidos y la distribución configurada como antecedentes informativos.

---

# P11-B04 — Visor PDF del documento

## Funcionalidad P11-F05 — Visualizar el acto administrativo como PDF

### A. Descripción funcional

El sistema debe mostrar en pantalla el documento generado en Decretación mediante un visor PDF embebido.

### B. Actor principal

Secretario General.

### C. Contenido visible del documento

El visor debe permitir revisar el documento completo, incluyendo:

- Encabezado institucional.
- Número o identificador de resolución/decreto, si existe.
- VISTOS.
- CONSIDERANDOS.
- RESUELVO / DISPÓNESE.
- Tabla documental de prestaciones.
- Firmantes definidos.
- Distribución incorporada.
- Cierre documental.

### D. Reglas de negocio

- El PDF visualizado debe corresponder a la versión enviada desde Decretación.
- El documento debe mostrarse en modo solo lectura.
- No deben existir controles de edición textual en esta etapa.

### E. Historia de usuario preliminar

**HU-P11-05:** Como **Secretario General**, quiero visualizar en PDF el acto administrativo generado en Decretación, para revisarlo antes de firmarlo físicamente.

### F. Requerimientos funcionales preliminares

- **RF-PP11-013:** El sistema debe mostrar el documento generado en Decretación mediante un visor PDF.
- **RF-PP11-014:** El visor debe permitir revisar el documento completo.
- **RF-PP11-015:** El documento visualizado debe corresponder a la versión vigente enviada a firma.
- **RF-PP11-016:** El sistema no debe permitir editar el contenido del PDF desde esta pantalla.

---

# P11-B05 — Descarga del documento para firma física

## Funcionalidad P11-F06 — Descargar documento para firma

### A. Descripción funcional

El sistema debe permitir descargar el PDF enviado desde Decretación para gestionar su impresión y firma física.

### B. Actor principal

Secretario General.

### C. Acción disponible

- Botón: **DESCARGAR DOCUMENTO PARA FIRMA**.

### D. Reglas de negocio

- La descarga debe corresponder exactamente al PDF visualizado.
- El sistema puede registrar la descarga como evento de trazabilidad, si se define.
- La descarga no debe alterar el estado del expediente por sí sola, salvo que se formalice un estado intermedio.

### E. Historia de usuario preliminar

**HU-P11-06:** Como **Secretario General**, quiero descargar el PDF del acto administrativo, para firmarlo físicamente fuera del sistema.

### F. Requerimientos funcionales preliminares

- **RF-PP11-017:** El sistema debe permitir descargar el PDF recibido desde Decretación.
- **RF-PP11-018:** El archivo descargado debe coincidir con la versión visualizada en pantalla.
- **RF-PP11-019:** El sistema debe poder registrar el evento de descarga cuando esta trazabilidad se habilite.

---

# P11-B06 — Carga del documento firmado

## Funcionalidad P11-F07 — Subir documento firmado físicamente

### A. Descripción funcional

El sistema debe permitir cargar el documento firmado por el Secretario General y asociarlo al expediente correspondiente.

### B. Actor principal

Secretario General.

### C. Acción disponible

- Botón: **SUBIR DOCUMENTO FIRMADO**.

### D. Datos o validaciones esperadas

- Archivo PDF firmado.
- Nombre del archivo.
- Fecha y hora de carga.
- Usuario que realiza la carga.

### E. Reglas de negocio

- El documento firmado cargado debe asociarse al expediente vigente.
- La carga debe ocurrir antes de aprobar y continuar.
- El sistema debe mostrar confirmación visible de que el archivo fue cargado correctamente.
- Si se permite reemplazar un documento firmado, debe quedar trazabilidad de la sustitución.

> **TODO:** Definir si solo se aceptará formato PDF o si existirán otros formatos permitidos.

### F. Historia de usuario preliminar

**HU-P11-07:** Como **Secretario General**, quiero subir el documento ya firmado físicamente, para dejar el respaldo formal en el expediente y continuar con el flujo.

### G. Requerimientos funcionales preliminares

- **RF-PP11-020:** El sistema debe permitir cargar el documento firmado.
- **RF-PP11-021:** El sistema debe asociar el archivo cargado al expediente correspondiente.
- **RF-PP11-022:** El sistema debe registrar fecha, hora y usuario de carga.
- **RF-PP11-023:** El sistema debe mostrar confirmación visible de carga exitosa.
- **RF-PP11-024:** El sistema debe impedir aprobar y continuar si no existe documento firmado cargado.

---

# P11-B07 — Estado y metadatos del documento firmado

## Funcionalidad P11-F08 — Visualizar estado del documento firmado cargado

### A. Descripción funcional

El sistema debe mostrar si el documento firmado ya fue cargado y los antecedentes básicos del archivo asociado.

### B. Actor principal

Secretario General.

### C. Datos que debe mostrar el sistema

- Estado:
  - Pendiente de carga.
  - Documento firmado cargado.
- Nombre del archivo.
- Fecha de carga.
- Hora de carga.
- Usuario que realizó la carga.
- Versión o identificador del archivo, si se define.
- Opción de visualizar o descargar el archivo firmado, si se incorpora.

### D. Reglas de negocio

- Esta sección debe actualizarse después de una carga exitosa.
- Debe existir una diferenciación clara entre:
  - PDF original enviado desde Decretación.
  - PDF firmado cargado por Secretario General.

### E. Historia de usuario preliminar

**HU-P11-08:** Como **Secretario General**, quiero visualizar el estado y datos del documento firmado cargado, para confirmar que el respaldo correcto quedó asociado al expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP11-025:** El sistema debe mostrar el estado de carga del documento firmado.
- **RF-PP11-026:** El sistema debe mostrar nombre del archivo, fecha, hora y usuario de carga.
- **RF-PP11-027:** El sistema debe distinguir visualmente el documento original enviado desde Decretación del documento firmado cargado.

---

# P11-B08 — Decisión global del Secretario General

## Funcionalidad P11-F09 — Aprobar y continuar con documento firmado

### A. Descripción funcional

El Secretario General debe poder aprobar la continuidad del expediente una vez que el documento firmado se encuentre cargado correctamente.

### B. Actor principal

Secretario General.

### C. Acción disponible

- Botón: **APROBAR Y CONTINUAR**.

### D. Resultado esperado

- El expediente avanza a la siguiente etapa del flujo de firma.
- Se conserva el documento firmado como respaldo de esta etapa.
- Se registra la decisión aprobatoria.

### E. Reglas de negocio

- La aprobación debe estar bloqueada si no existe documento firmado cargado.
- La aprobación debe quedar asociada a la versión del archivo firmado disponible al momento de decidir.
- La aprobación debe registrar usuario, rol, fecha y hora.

> **TODO:** Confirmar la etapa siguiente exacta del flujo posterior a Secretaría General.

### F. Historia de usuario preliminar

**HU-P11-09:** Como **Secretario General**, quiero aprobar y continuar el expediente una vez cargado el documento firmado, para remitirlo a la siguiente etapa del proceso institucional.

### G. Requerimientos funcionales preliminares

- **RF-PP11-028:** El sistema debe permitir aprobar y continuar cuando exista documento firmado cargado.
- **RF-PP11-029:** El sistema debe bloquear la aprobación cuando no exista documento firmado cargado.
- **RF-PP11-030:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
- **RF-PP11-031:** El sistema debe derivar el expediente a la etapa siguiente definida en el flujo.

---

## Funcionalidad P11-F10 — Devolver con corrección a Decretación

### A. Descripción funcional

El Secretario General debe poder devolver el expediente a **Decretación** cuando detecte errores o inconsistencias en el acto administrativo que puedan ser corregidas.

### B. Actor principal

Secretario General.

### C. Acción disponible

- Botón: **DEVOLVER CON CORRECCIÓN**.

### D. Datos de entrada requeridos

- Motivo de devolución.
- Comentario obligatorio.

### E. Reglas de negocio

- La devolución debe retornar a la etapa **Decretación**.
- El comentario debe quedar visible para el rol de Decretación.
- La devolución debe mantener trazabilidad del motivo y usuario.
- La devolución puede ejecutarse sin necesidad de cargar previamente un documento firmado.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Secretario General), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P11-10:** Como **Secretario General**, quiero devolver con corrección el documento a Decretación, para que se subsanen errores antes de continuar el proceso de firma.

### G. Requerimientos funcionales preliminares

- **RF-PP11-032:** El sistema debe permitir devolver con corrección el expediente a Decretación.
- **RF-PP11-033:** El sistema debe exigir motivo y comentario obligatorio.
- **RF-PP11-034:** El sistema debe registrar la devolución con usuario, rol, fecha y hora.
- **RF-PP11-035:** El sistema debe dejar visible la observación para Decretación.
- **RF-PP11-036:** El sistema debe permitir devolver con corrección aun cuando no se haya cargado un documento firmado.
* **RF-PP11-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de legalidad formal o reparos del acto y comentarios correspondientes.
* **RF-PP11-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P11-F11 — Rechazar solicitud

### A. Descripción funcional

El Secretario General debe poder rechazar la solicitud cuando determine que no corresponde continuar con el acto administrativo.

### B. Actor principal

Secretario General.

### C. Acción disponible

- Botón: **RECHAZAR SOLICITUD**.

### D. Datos de entrada requeridos

- Motivo de rechazo.
- Comentario obligatorio.

### E. Reglas de negocio

- El rechazo debe cerrar la continuidad del expediente.
- El rechazo debe quedar registrado en trazabilidad.
- El rechazo puede ejecutarse antes o después de la carga del documento firmado.
* **Notificación de Rechazo**: Todo rechazo definitivo debe generar la notificación automática por correo electrónico al Solicitante y al rol Archivo Universitario de forma simultánea.
* **Contenido mínimo del correo**: Código de la solicitud, etapa origen (Secretario General), acción ejecutada (Rechazo definitivo), causal o reparo formal (observaciones de legalidad formal o reparos del acto), comentarios detallados, fecha/hora y la instrucción correspondiente.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P11-11:** Como **Secretario General**, quiero rechazar la solicitud cuando no corresponda continuar con el acto administrativo, para cerrar el proceso con trazabilidad del motivo.

### G. Requerimientos funcionales preliminares

- **RF-PP11-037:** El sistema debe permitir rechazar la solicitud.
- **RF-PP11-038:** El sistema debe exigir motivo y comentario obligatorio.
- **RF-PP11-039:** El sistema debe registrar usuario, rol, fecha, hora y motivo del rechazo.
- **RF-PP11-040:** El sistema debe impedir que una solicitud rechazada continúe a etapas posteriores.
* **RF-PP11-TEMP_REJ1**: El sistema debe enviar de forma automática un correo electrónico de notificación tanto al Solicitante como al rol de Archivo Universitario al registrar el rechazo definitivo de la solicitud.

---

# P11-B09 — Modal global de devolución/rechazo

## Funcionalidad P11-F12 — Gestionar devolución y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un modal global único para gestionar las acciones de:

- **DEVOLVER CON CORRECCIÓN**.
- **RECHAZAR SOLICITUD**.

### B. Actor principal

Secretario General.

### C. Información que debe contener el modal

- Tipo de acción seleccionada.
- Motivo.
- Comentario obligatorio.
- Mensaje de advertencia del impacto.
- Botón confirmar.
- Botón cancelar.

### D. Reglas de negocio

- No debe permitir confirmar sin comentario obligatorio.
- Debe permitir cancelar sin modificar el estado del expediente.
- La devolución debe indicar expresamente que retorna a **Decretación**.
- La acción confirmada debe generar trazabilidad.

### E. Historia de usuario preliminar

**HU-P11-12:** Como **Secretario General**, quiero gestionar la devolución o rechazo mediante un modal único, para registrar claramente el motivo antes de modificar el estado del expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP11-041:** El sistema debe usar un modal global único para devolución con corrección y rechazo.
- **RF-PP11-042:** El sistema debe exigir comentario obligatorio.
- **RF-PP11-043:** El sistema debe permitir cancelar la acción sin modificar el expediente.
- **RF-PP11-044:** El sistema debe mostrar que la devolución con corrección retorna a Decretación.

---

# P11-B10 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P11-F13 — Confirmar aprobación y continuidad

### A. Descripción funcional

Antes de aprobar y continuar, el sistema debe solicitar confirmación explícita al Secretario General.

### B. Actor principal

Secretario General.

### C. Contenido de la confirmación

- Se aprobará el documento firmado cargado.
- El expediente avanzará a la siguiente etapa.
- Se utilizará el archivo firmado actualmente asociado.
- La acción quedará registrada.

### D. Reglas de negocio

- La confirmación debe estar disponible solo cuando exista documento firmado cargado.
- Debe poder cancelarse sin modificar el estado.

### E. Historia de usuario preliminar

**HU-P11-13:** Como **Secretario General**, quiero confirmar la aprobación antes de ejecutarla, para evitar avanzar por error con un documento incorrecto.

### F. Requerimientos funcionales preliminares

- **RF-PP11-045:** El sistema debe solicitar confirmación antes de aprobar y continuar.
- **RF-PP11-046:** El sistema debe validar la existencia de documento firmado cargado antes de confirmar.
- **RF-PP11-047:** El sistema debe permitir cancelar la aprobación antes de aplicarla.

---

## Funcionalidad P11-F14 — Registrar trazabilidad de firma física y decisión

### A. Descripción funcional

El sistema debe registrar de forma auditable las acciones ejecutadas por el Secretario General durante la etapa.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Ingreso a revisión, si se define.
- Descarga del PDF para firma.
- Carga del documento firmado.
- Reemplazo del documento firmado, si se permite.
- Aprobación y continuidad.
- Devolución con corrección.
- Rechazo de solicitud.

### D. Datos mínimos de trazabilidad

- Código de solicitud.
- Documento asociado.
- Usuario.
- Rol.
- Acción ejecutada.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Comentario y motivo, cuando corresponda.
- Identificador del archivo firmado, cuando aplique.

### E. Historia de usuario preliminar

**HU-P11-14:** Como **sistema**, debo registrar las acciones de descarga, carga, aprobación, devolución y rechazo realizadas por Secretaría General, para mantener trazabilidad completa del proceso de firma física.

### F. Requerimientos funcionales preliminares

- **RF-PP11-048:** El sistema debe registrar las acciones relevantes de la etapa.
- **RF-PP11-049:** El sistema debe registrar la carga del documento firmado con fecha, hora y usuario.
- **RF-PP11-050:** El sistema debe registrar las decisiones de aprobación, devolución y rechazo.
- **RF-PP11-051:** El sistema debe conservar la relación entre el expediente y el archivo firmado cargado.
* **RF-PP11-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

# 7. Estados de salida de la Pantalla 11

| Acción del Secretario General | Estado resultante | Destino |
|---|---|---|
| Descargar documento | Documento disponible para firma física | Permanece en Secretario General |
| Subir documento firmado | Documento firmado cargado | Permanece en Secretario General |
| **APROBAR Y CONTINUAR** | Aprobado por Secretario General | Continúa a la siguiente etapa del flujo |
| **DEVOLVER CON CORRECCIÓN** | Devuelto por Secretario General | Retorna a Decretación |
| **RECHAZAR SOLICITUD** | Rechazado por Secretario General | Cierre definitivo del expediente |

---

# 8. Estados posibles del documento en Secretaría General

| Estado | Descripción |
|---|---|
| **Pendiente de revisión** | El documento llegó desde Decretación y está disponible para visualización. |
| **Disponible para descarga** | El PDF puede descargarse para firma física. |
| **Pendiente de firma/carga** | El documento fue revisado, pero aún no existe archivo firmado cargado. |
| **Documento firmado cargado** | Se cargó el PDF firmado y quedó asociado al expediente. |
| **Aprobado por Secretario General** | El documento firmado fue aprobado para continuar. |
| **Devuelto con corrección** | El documento fue retornado a Decretación con comentarios. |
| **Rechazado** | El expediente fue cerrado desde esta etapa. |

---

# 9. Reglas globales de comportamiento de la Pantalla 11

| Código | Regla |
|---|---|
| **RG-P11-001** | El Secretario General debe recibir el documento generado y enviado desde Decretación. |
| **RG-P11-002** | El PDF visualizado debe corresponder a la versión documental vigente enviada a firma. |
| **RG-P11-003** | La pantalla debe mostrar el documento en modo solo lectura. |
| **RG-P11-004** | El Secretario General no debe editar el contenido del acto administrativo desde esta pantalla. |
| **RG-P11-005** | La pantalla debe permitir descargar el PDF para firma física. |
| **RG-P11-006** | La pantalla debe permitir subir el documento firmado y asociarlo al expediente. |
| **RG-P11-007** | La pantalla debe mostrar confirmación visible de carga exitosa del documento firmado. |
| **RG-P11-008** | La aprobación y continuidad del flujo debe bloquearse mientras no exista documento firmado cargado. |
| **RG-P11-009** | La devolución con corrección debe retornar el expediente a Decretación. |
| **RG-P11-010** | La devolución con corrección debe exigir comentario obligatorio. |
| **RG-P11-011** | El rechazo debe exigir comentario obligatorio. |
| **RG-P11-012** | La devolución y el rechazo deben gestionarse mediante un modal global único. |
| **RG-P11-013** | La aprobación debe solicitar confirmación explícita antes de avanzar. |
| **RG-P11-014** | Toda decisión de Secretario General debe quedar registrada en trazabilidad. |
| **RG-P11-015** | La carga del documento firmado debe registrar fecha, hora y usuario. |
| **RG-P11-016** | El documento firmado cargado debe conservarse como respaldo del expediente. |
| **RG-P11-017** | La pantalla debe diferenciar entre el PDF original enviado desde Decretación y el archivo firmado cargado. |
| **RG-P11-018** | La pantalla no debe modificar firmantes, distribución ni contenido documental definido en Decretación. |
| **RG-P11-019** | La pantalla no debe incorporar la acción Salir sin guardar. |
| **RG-PP11-020** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 11

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P11-001** | Legibilidad documental | El visor PDF debe permitir revisar adecuadamente el acto administrativo enviado desde Decretación. |
| **RNF-P11-002** | Integridad documental | El documento mostrado debe corresponder a la versión vigente enviada por Decretación. |
| **RNF-P11-003** | Seguridad por rol | Solo usuarios autorizados como Secretario General deben ejecutar las acciones de esta etapa. |
| **RNF-P11-004** | Control de carga | El sistema debe conservar y asociar correctamente el archivo firmado cargado. |
| **RNF-P11-005** | Trazabilidad | La descarga, carga y decisiones del Secretario General deben quedar registradas. |
| **RNF-P11-006** | Confirmación de acciones | La aprobación, devolución y rechazo deben requerir confirmación según corresponda. |
| **RNF-P11-007** | Bloqueo condicional | El sistema debe bloquear la aprobación si no existe documento firmado cargado. |
| **RNF-P11-008** | Diferenciación de archivos | La pantalla debe distinguir claramente el PDF original del documento firmado cargado. |
| **RNF-P11-009** | Comentarios obligatorios | El sistema debe impedir devolver o rechazar sin comentario. |
| **RNF-P11-010** | Persistencia del respaldo | El documento firmado debe quedar almacenado como respaldo asociado al expediente. |
| **RNF-P11-011** | Continuidad del flujo | La devolución debe retornar a Decretación y la aprobación debe avanzar a la etapa siguiente definida. |
| **RNF-P11-012** | Coherencia con Decretación | La pantalla debe operar sobre la resolución generada en la etapa anterior, sin reconstruirla ni editarla. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 11

| Código | Funcionalidad |
|---|---|
| **P11-F01** | Visualizar identificación del expediente. |
| **P11-F02** | Visualizar estado de la etapa de firma. |
| **P11-F03** | Visualizar trazabilidad del expediente hasta Decretación. |
| **P11-F04** | Visualizar metadatos del documento enviado desde Decretación. |
| **P11-F05** | Visualizar el acto administrativo como PDF. |
| **P11-F06** | Descargar documento para firma. |
| **P11-F07** | Subir documento firmado físicamente. |
| **P11-F08** | Visualizar estado del documento firmado cargado. |
| **P11-F09** | Aprobar y continuar con documento firmado. |
| **P11-F10** | Devolver con corrección a Decretación. |
| **P11-F11** | Rechazar solicitud. |
| **P11-F12** | Gestionar devolución y rechazo mediante modal global único. |
| **P11-F13** | Confirmar aprobación y continuidad. |
| **P11-F14** | Registrar trazabilidad de firma física y decisión. |