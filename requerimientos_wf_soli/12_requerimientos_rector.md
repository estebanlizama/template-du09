# PDS Normativo D9 / DU288 / DU09

## Pantalla 12 — Visación y Firma del Acto Administrativo por Rector/a

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 12: Visación y Firma del Acto Administrativo — Perfil Rector/a** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a una etapa de **revisión final, firma del acto administrativo y continuidad del expediente**, posterior a la aprobación y firma registrada por **Secretaría General**.

En esta etapa, el Rector/a recibe el **documento administrativo ya generado en Decretación y previamente firmado por Secretaría General**, visualiza la resolución o decreto en formato **PDF**, lo descarga para gestionar su firma, carga nuevamente el archivo firmado y registra una decisión sobre la continuidad del expediente.

La pantalla debe permitir:

- Visualizar el acto administrativo proveniente de la etapa anterior como documento PDF.
- Confirmar que el documento corresponde al expediente PDS vigente.
- Visualizar que el documento cuenta con la firma o visación previa de Secretaría General.
- Descargar el archivo para firma del Rector/a.
- Subir el documento firmado por Rectoría.
- Visualizar el estado de carga del documento firmado.
- Aprobar y continuar el flujo únicamente cuando el documento firmado se encuentre cargado.
- Devolver con corrección el expediente cuando existan errores o reparos que deban ser subsanados.
- Rechazar la solicitud cuando no corresponda su continuidad.
- Registrar trazabilidad de la revisión, descarga, carga del documento y decisión del Rector/a.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 12 — Rector/a**. No modifica la etapa de Secretaría General ni las etapas posteriores del flujo. Su objetivo es definir qué documento debe visualizarse, qué acciones puede ejecutar el Rector/a, cómo se gestiona la firma del acto administrativo y qué decisiones puede registrar sobre el expediente.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P12 |
| **Nombre** | Visación y Firma del Acto Administrativo por Rector/a |
| **Perfil principal** | Rector/a o usuario autorizado para la firma rectoral del acto administrativo |
| **Etapa del flujo** | Etapa 12 — Firma rectoral del acto administrativo |
| **Estado de entrada esperado** | Documento administrativo generado en Decretación, revisado y firmado por Secretaría General |
| **Objetivo principal** | Permitir que el Rector/a visualice el PDF recibido desde la etapa anterior, lo descargue para firma, cargue el documento firmado y decida si aprueba su continuidad, lo devuelve con corrección o rechaza la solicitud. |
| **Resultado posible** | Documento firmado por Rectoría cargado y aprobado para continuar; expediente devuelto con corrección; o solicitud rechazada. |

---

# 3. Principio funcional de la Pantalla 12

La Pantalla 12 debe operar como una **vista de firma rectoral y visación documental**, centrada en el acto administrativo previamente generado y firmado en la etapa anterior.

El documento que se muestra en esta etapa no debe ser reconstruido, recalculado ni editable desde Rectoría. Debe corresponder a la **versión documental formal recibida desde Secretaría General**, incluyendo:

- VISTOS.
- CONSIDERANDOS.
- RESUELVO / DISPÓNESE.
- Tabla documental de prestaciones.
- Firmantes definidos.
- Firma o visación previa de Secretaría General, cuando corresponda.
- Distribución.
- Cierre documental.

La labor del Rector/a consiste en:

1. Revisar el documento PDF.
2. Descargarlo para gestionar su firma.
3. Cargar la versión firmada.
4. Aprobar la continuidad del flujo o devolver/rechazar según corresponda.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 12 debe permitir que el Rector/a:

- Visualice la identificación del expediente asociado al documento.
- Visualice el estado actual del proceso de firma rectoral.
- Revise la trazabilidad previa del expediente hasta la etapa de Secretaría General.
- Visualice que el documento proviene de Secretaría General y corresponde a la versión enviada a firma rectoral.
- Visualice el acto administrativo en formato PDF embebido en la pantalla.
- Revise el documento completo desde el visor PDF.
- Visualice los metadatos del documento:
  - Código de solicitud.
  - Tipo de acto administrativo.
  - Fecha de envío desde Secretaría General.
  - Versión documental enviada.
  - Firma o visación previa de Secretaría General.
  - Firmantes definidos en Decretación.
  - Estado de firma rectoral.
- Descargue el PDF para gestionar su firma.
- Suba el documento firmado por Rectoría.
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
- Devuelva con corrección el expediente mediante la acción **DEVOLVER CON CORRECCIÓN**.
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
- Genere una notificación automática por correo al Solicitante cuando exista devolución con corrección.
- Genere una notificación automática por correo al Solicitante y al rol Archivo Universitario cuando exista rechazo definitivo, si esta regla se mantiene para esta etapa.
- Muestre un aviso visible de que la notificación fue generada, sin desplegar el contenido completo del correo en pantalla.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 12 no debe:

- Editar los textos del acto administrativo.
- Modificar VISTOS, CONSIDERANDOS, RESUELVO o cualquier sección textual del documento.
- Alterar la tabla de prestaciones incluida en el documento.
- Modificar firmantes seleccionados en Decretación.
- Modificar la distribución del documento.
- Regenerar el acto administrativo desde esta etapa.
- Sustituir el documento recibido desde Secretaría General antes de su firma, salvo mediante el mecanismo formal de devolución con corrección.
- Modificar los antecedentes técnicos, financieros o normativos de la solicitud.
- Incorporar nuevos funcionarios.
- Excluir o reponer funcionarios.
- Aprobar la continuidad del flujo si no existe un documento firmado cargado.
- Enviar a la siguiente etapa una versión distinta del archivo firmado cargado.
- Reemplazar silenciosamente un archivo firmado sin dejar trazabilidad.
- Devolver la solicitud sin registrar motivo y comentario.
- Rechazar la solicitud sin registrar motivo y comentario.
- Mostrar en pantalla el contenido completo de los correos automáticos de notificación.
- Incorporar la acción **Salir sin guardar** como acción del proceso.

---

# 4. Objetivo funcional de la Pantalla 12

La pantalla debe permitir que el Rector/a:

1. Identifique el expediente que ingresa a revisión y firma rectoral.
2. Visualice el estado actual de firma del acto administrativo.
3. Revise la trazabilidad completa hasta Secretaría General.
4. Confirme que el documento proviene de la etapa de Secretaría General.
5. Visualice el PDF recibido para firma rectoral.
6. Revise en pantalla el contenido completo del acto administrativo.
7. Consulte los metadatos de versión, envío, firma previa y firmantes del documento.
8. Descargue el PDF para gestionar su firma.
9. Suba el documento ya firmado por Rectoría.
10. Visualice si el documento firmado fue cargado correctamente.
11. Consulte los datos del archivo firmado cargado.
12. Apruebe y continúe el flujo cuando el documento firmado esté disponible.
13. Devuelva con corrección cuando detecte errores subsanables en el documento o expediente formalizado.
14. Rechace la solicitud cuando estime que no corresponde continuar.
15. Ingrese comentarios obligatorios para devolución y rechazo.
16. Confirme las decisiones que cambien el estado del expediente.
17. Registre trazabilidad de la etapa de firma rectoral.
18. Genere las notificaciones automáticas correspondientes en caso de devolución o rechazo.
19. Visualice una confirmación de envío de notificación sin desplegar el cuerpo completo del correo.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 12 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P12-B01** | Encabezado del expediente y estado de firma rectoral | Identificar la solicitud, la etapa y el estado documental. |
| **P12-B02** | Trazabilidad previa del expediente | Mostrar el recorrido de la solicitud hasta Secretaría General. |
| **P12-B03** | Resumen del acto administrativo recibido | Mostrar metadatos del documento recibido desde la etapa anterior. |
| **P12-B04** | Visor PDF del documento | Permitir revisar el acto administrativo completo en pantalla. |
| **P12-B05** | Descarga del documento para firma rectoral | Permitir obtener el PDF para su firma. |
| **P12-B06** | Carga del documento firmado por Rectoría | Permitir subir el archivo firmado. |
| **P12-B07** | Estado y metadatos del documento firmado | Mostrar si fue cargado, cuándo y por quién. |
| **P12-B08** | Decisión global del Rector/a | Aprobar y continuar, devolver con corrección o rechazar. |
| **P12-B09** | Modal global de devolución/rechazo | Registrar motivo, comentario y confirmación. |
| **P12-B10** | Confirmación, transición de estado, notificación y trazabilidad | Confirmar aprobación, aplicar cambios de estado, emitir notificaciones y registrar auditoría. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P12-B01 — Encabezado del expediente y estado de firma rectoral

## Funcionalidad P12-F01 — Visualizar identificación del expediente

### A. Descripción funcional

El sistema debe mostrar claramente la identificación de la solicitud y del documento administrativo que se encuentra en etapa de firma por Rectoría.

### B. Actor principal

Rector/a.

### C. Datos que debe mostrar el sistema

- Código único de solicitud.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Título de la etapa: Firma Rectoral del Acto Administrativo.
- Tipo de documento:
  - Resolución.
  - Decreto.
  - Otro, si se define.
- Identificador documental, si existe.

### D. Reglas de negocio

- El identificador de solicitud debe mantenerse inalterable.
- El documento mostrado debe estar asociado al expediente correcto.

### E. Historia de usuario preliminar

**HU-P12-01:** Como **Rector/a**, quiero visualizar claramente el expediente y el acto administrativo en firma, para asegurar que estoy revisando el documento correcto.

### F. Requerimientos funcionales preliminares

- **RF-P12-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-P12-002:** El sistema debe mostrar el tipo de acto administrativo asociado.
- **RF-P12-003:** El sistema debe mostrar el identificador documental cuando exista.

---

## Funcionalidad P12-F02 — Visualizar estado de la etapa de firma rectoral

### A. Descripción funcional

El sistema debe mostrar el estado actual del proceso de firma del documento por Rectoría.

### B. Actor principal

Rector/a.

### C. Estados posibles

- Pendiente de revisión documental.
- Disponible para descarga.
- Documento descargado para firma, si se registra este evento.
- Pendiente de carga de documento firmado.
- Documento firmado cargado.
- Aprobado por Rector/a.
- Devuelto con corrección.
- Rechazado.

### D. Reglas de negocio

- El estado debe reflejar la condición real del documento en la etapa.
- La opción **APROBAR Y CONTINUAR** solo debe habilitarse cuando exista un documento firmado cargado.

### E. Historia de usuario preliminar

**HU-P12-02:** Como **Rector/a**, quiero visualizar el estado de firma del documento, para saber si está pendiente de revisión, pendiente de carga o listo para avanzar.

### F. Requerimientos funcionales preliminares

- **RF-P12-004:** El sistema debe mostrar el estado actual de la firma rectoral.
- **RF-P12-005:** El sistema debe distinguir si el documento firmado se encuentra pendiente o cargado.
- **RF-P12-006:** El sistema debe condicionar la aprobación a la existencia de un documento firmado cargado.

---

# P12-B02 — Trazabilidad previa del expediente

## Funcionalidad P12-F03 — Visualizar trazabilidad del expediente hasta Secretaría General

### A. Descripción funcional

El sistema debe mostrar el historial de avance del expediente hasta el momento en que Secretaría General aprobó y derivó el documento a Rectoría.

### B. Actor principal

Rector/a.

### C. Etapas mínimas a mostrar

- Creación y envío por Solicitante.
- Aprobación por Jefe de Proyecto.
- Aprobación por Jefatura Directa / Dirección de Departamento.
- Revisión DGDP.
- Revisión Finanzas de Facultad.
- Aprobación Decano/a.
- Revisión Dirección de Finanzas.
- Generación documental en Decretación.
- Revisión y firma registrada por Secretaría General.
- Envío del acto administrativo a firma rectoral.

### D. Datos por etapa

- Etapa.
- Usuario.
- Rol.
- Acción ejecutada.
- Fecha.
- Hora.
- Comentarios asociados, si existen.

### E. Historia de usuario preliminar

**HU-P12-03:** Como **Rector/a**, quiero revisar la trazabilidad previa del expediente, para conocer el respaldo de aprobación y firma anterior antes de continuar con la formalización.

### F. Requerimientos funcionales preliminares

- **RF-P12-007:** El sistema debe mostrar cronológicamente las etapas previas del expediente.
- **RF-P12-008:** El sistema debe mostrar usuario, rol, acción, fecha y hora por etapa.
- **RF-P12-009:** El sistema debe registrar y mostrar el envío desde Secretaría General hacia Rectoría.

---

# P12-B03 — Resumen del acto administrativo recibido

## Funcionalidad P12-F04 — Visualizar metadatos del documento recibido desde Secretaría General

### A. Descripción funcional

El sistema debe mostrar un resumen del acto administrativo recibido desde Secretaría General, con información suficiente para confirmar la versión documental que será firmada por Rectoría.

### B. Actor principal

Rector/a.

### C. Datos que debe mostrar el sistema

- Código de solicitud.
- Tipo de documento.
- Número o identificador de resolución/decreto, si existe.
- Fecha de generación o envío desde Decretación.
- Fecha de aprobación y envío desde Secretaría General.
- Usuario responsable del envío anterior.
- Versión documental.
- Estado:
  - Enviado a firma rectoral.
  - Firmado cargado.
- Firma o visación previa de Secretaría General.
- Firmantes definidos en Decretación.
- Distribución definida en Decretación, como antecedente.

### D. Reglas de negocio

- La información debe provenir del documento recibido desde Secretaría General.
- El Rector/a no puede modificar estos datos desde esta pantalla.

### E. Historia de usuario preliminar

**HU-P12-04:** Como **Rector/a**, quiero visualizar los metadatos del documento recibido desde Secretaría General, para confirmar que corresponde a la versión correcta antes de firmarlo.

### F. Requerimientos funcionales preliminares

- **RF-P12-010:** El sistema debe mostrar los metadatos del acto administrativo recibido desde Secretaría General.
- **RF-P12-011:** El sistema debe mostrar la versión documental vigente.
- **RF-P12-012:** El sistema debe mostrar la firma o visación previa de Secretaría General, los firmantes definidos y la distribución configurada como antecedentes informativos.

---

# P12-B04 — Visor PDF del documento

## Funcionalidad P12-F05 — Visualizar el acto administrativo como PDF

### A. Descripción funcional

El sistema debe mostrar en pantalla el documento recibido para firma rectoral mediante un visor PDF embebido.

### B. Actor principal

Rector/a.

### C. Contenido visible del documento

El visor debe permitir revisar el documento completo, incluyendo:

- Encabezado institucional.
- Número o identificador de resolución/decreto, si existe.
- VISTOS.
- CONSIDERANDOS.
- RESUELVO / DISPÓNESE.
- Tabla documental de prestaciones.
- Firmantes definidos.
- Firma o visación previa de Secretaría General, cuando corresponda.
- Distribución incorporada.
- Cierre documental.

### D. Reglas de negocio

- El PDF visualizado debe corresponder a la versión recibida desde Secretaría General.
- El documento debe mostrarse en modo solo lectura.
- No deben existir controles de edición textual en esta etapa.

### E. Historia de usuario preliminar

**HU-P12-05:** Como **Rector/a**, quiero visualizar en PDF el acto administrativo recibido desde Secretaría General, para revisarlo antes de firmarlo.

### F. Requerimientos funcionales preliminares

- **RF-P12-013:** El sistema debe mostrar el documento recibido mediante un visor PDF.
- **RF-P12-014:** El visor debe permitir revisar el documento completo.
- **RF-P12-015:** El documento visualizado debe corresponder a la versión vigente enviada a Rectoría.
- **RF-P12-016:** El sistema no debe permitir editar el contenido del PDF desde esta pantalla.

---

# P12-B05 — Descarga del documento para firma rectoral

## Funcionalidad P12-F06 — Descargar documento para firma

### A. Descripción funcional

El sistema debe permitir descargar el PDF recibido desde Secretaría General para gestionar su firma por Rectoría.

### B. Actor principal

Rector/a.

### C. Acción disponible

- Botón: **DESCARGAR DOCUMENTO PARA FIRMA**.

### D. Reglas de negocio

- La descarga debe corresponder exactamente al PDF visualizado.
- El sistema puede registrar la descarga como evento de trazabilidad, si se define.
- La descarga no debe alterar el estado del expediente por sí sola, salvo que se formalice un estado intermedio.

### E. Historia de usuario preliminar

**HU-P12-06:** Como **Rector/a**, quiero descargar el PDF del acto administrativo, para firmarlo según el procedimiento definido.

### F. Requerimientos funcionales preliminares

- **RF-P12-017:** El sistema debe permitir descargar el PDF recibido desde Secretaría General.
- **RF-P12-018:** El archivo descargado debe coincidir con la versión visualizada en pantalla.
- **RF-P12-019:** El sistema debe poder registrar el evento de descarga cuando esta trazabilidad se habilite.

---

# P12-B06 — Carga del documento firmado por Rectoría

## Funcionalidad P12-F07 — Subir documento firmado

### A. Descripción funcional

El sistema debe permitir cargar el documento firmado por el Rector/a y asociarlo al expediente correspondiente.

### B. Actor principal

Rector/a.

### C. Acción disponible

- Botón: **SUBIR DOCUMENTO FIRMADO**.

### D. Datos o validaciones esperadas

- Archivo firmado.
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

**HU-P12-07:** Como **Rector/a**, quiero subir el documento ya firmado, para dejar el respaldo formal en el expediente y continuar con el flujo.

### G. Requerimientos funcionales preliminares

- **RF-P12-020:** El sistema debe permitir cargar el documento firmado.
- **RF-P12-021:** El sistema debe asociar el archivo cargado al expediente correspondiente.
- **RF-P12-022:** El sistema debe registrar fecha, hora y usuario de carga.
- **RF-P12-023:** El sistema debe mostrar confirmación visible de carga exitosa.
- **RF-P12-024:** El sistema debe impedir aprobar y continuar si no existe documento firmado cargado.

---

# P12-B07 — Estado y metadatos del documento firmado

## Funcionalidad P12-F08 — Visualizar estado del documento firmado cargado

### A. Descripción funcional

El sistema debe mostrar si el documento firmado por Rectoría ya fue cargado y los antecedentes básicos del archivo asociado.

### B. Actor principal

Rector/a.

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
  - PDF recibido desde Secretaría General.
  - PDF firmado y cargado por Rectoría.

### E. Historia de usuario preliminar

**HU-P12-08:** Como **Rector/a**, quiero visualizar el estado y datos del documento firmado cargado, para confirmar que el respaldo correcto quedó asociado al expediente.

### F. Requerimientos funcionales preliminares

- **RF-P12-025:** El sistema debe mostrar el estado de carga del documento firmado.
- **RF-P12-026:** El sistema debe mostrar nombre del archivo, fecha, hora y usuario de carga.
- **RF-P12-027:** El sistema debe distinguir visualmente el documento recibido desde Secretaría General del documento firmado cargado por Rectoría.

---

# P12-B08 — Decisión global del Rector/a

## Funcionalidad P12-F09 — Aprobar y continuar con documento firmado

### A. Descripción funcional

El Rector/a debe poder aprobar la continuidad del expediente una vez que el documento firmado se encuentre cargado correctamente.

### B. Actor principal

Rector/a.

### C. Acción disponible

- Botón: **APROBAR Y CONTINUAR**.

### D. Resultado esperado

- El expediente avanza a la siguiente etapa del flujo.
- Se conserva el documento firmado como respaldo de esta etapa.
- Se registra la decisión aprobatoria.

### E. Reglas de negocio

- La aprobación debe estar bloqueada si no existe documento firmado cargado.
- La aprobación debe quedar asociada a la versión del archivo firmado disponible al momento de decidir.
- La aprobación debe registrar usuario, rol, fecha y hora.

> **TODO:** Confirmar la etapa siguiente exacta del flujo posterior a Rectoría.

### F. Historia de usuario preliminar

**HU-P12-09:** Como **Rector/a**, quiero aprobar y continuar el expediente una vez cargado el documento firmado, para remitirlo a la siguiente etapa del proceso institucional.

### G. Requerimientos funcionales preliminares

- **RF-P12-028:** El sistema debe permitir aprobar y continuar cuando exista documento firmado cargado.
- **RF-P12-029:** El sistema debe bloquear la aprobación cuando no exista documento firmado cargado.
- **RF-P12-030:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
- **RF-P12-031:** El sistema debe derivar el expediente a la etapa siguiente definida en el flujo.

---

## Funcionalidad P12-F10 — Devolver con corrección

### A. Descripción funcional

El Rector/a debe poder devolver el expediente cuando detecte errores o inconsistencias en el acto administrativo que puedan ser corregidas.

### B. Actor principal

Rector/a.

### C. Acción disponible

- Botón: **DEVOLVER CON CORRECCIÓN**.

### D. Datos de entrada requeridos

- Motivo de devolución.
- Comentario obligatorio.

### E. Reglas de negocio

- La devolución debe registrar trazabilidad del motivo y usuario.
- El comentario debe quedar visible para la etapa de destino.
- La devolución puede ejecutarse sin necesidad de cargar previamente un documento firmado.
- Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante.
- El correo debe contener como mínimo:
  - Código de solicitud.
  - Etapa origen: Rectoría.
  - Acción ejecutada: Devolución con comentarios.
  - Observaciones ingresadas.
  - Fecha y hora.
  - Instrucción correspondiente de corrección.
- La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso.

> **TODO:** Definir con precisión la etapa de retorno de la devolución del Rector/a dentro del flujo final.

### F. Historia de usuario preliminar

**HU-P12-10:** Como **Rector/a**, quiero devolver con corrección el documento cuando detecte observaciones subsanables, para que sean revisadas antes de continuar el proceso de formalización.

### G. Requerimientos funcionales preliminares

- **RF-P12-032:** El sistema debe permitir devolver con corrección el expediente.
- **RF-P12-033:** El sistema debe exigir motivo y comentario obligatorio.
- **RF-P12-034:** El sistema debe registrar la devolución con usuario, rol, fecha y hora.
- **RF-P12-035:** El sistema debe dejar visible la observación para la etapa de destino.
- **RF-P12-036:** El sistema debe permitir devolver con corrección aun cuando no se haya cargado un documento firmado.
- **RF-P12-037:** El sistema debe generar y enviar automáticamente un correo electrónico al Solicitante al registrar la devolución.
- **RF-P12-038:** El sistema debe desplegar un aviso visible confirmando la generación y envío del correo de notificación, sin mostrar su contenido completo.

---

## Funcionalidad P12-F11 — Rechazar solicitud

### A. Descripción funcional

El Rector/a debe poder rechazar la solicitud cuando determine que no corresponde continuar con el acto administrativo.

### B. Actor principal

Rector/a.

### C. Acción disponible

- Botón: **RECHAZAR SOLICITUD**.

### D. Datos de entrada requeridos

- Motivo de rechazo.
- Comentario obligatorio.

### E. Reglas de negocio

- El rechazo debe cerrar la continuidad del expediente.
- El rechazo debe quedar registrado en trazabilidad.
- El rechazo puede ejecutarse antes o después de la carga del documento firmado.
- Todo rechazo definitivo debe generar una notificación automática por correo electrónico al Solicitante y al rol Archivo Universitario de forma simultánea.
- El correo debe contener como mínimo:
  - Código de solicitud.
  - Etapa origen: Rectoría.
  - Acción ejecutada: Rechazo definitivo.
  - Causal o reparo formal.
  - Comentarios detallados.
  - Fecha y hora.
  - Instrucción correspondiente.
- La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso.

### F. Historia de usuario preliminar

**HU-P12-11:** Como **Rector/a**, quiero rechazar la solicitud cuando no corresponda continuar con el acto administrativo, para cerrar el proceso con trazabilidad del motivo.

### G. Requerimientos funcionales preliminares

- **RF-P12-039:** El sistema debe permitir rechazar la solicitud.
- **RF-P12-040:** El sistema debe exigir motivo y comentario obligatorio.
- **RF-P12-041:** El sistema debe registrar usuario, rol, fecha, hora y motivo del rechazo.
- **RF-P12-042:** El sistema debe impedir que una solicitud rechazada continúe a etapas posteriores.
- **RF-P12-043:** El sistema debe enviar automáticamente un correo electrónico de notificación al Solicitante y al rol Archivo Universitario al registrar el rechazo definitivo.
- **RF-P12-044:** El sistema debe mostrar un aviso visible confirmando el envío de la notificación, sin desplegar el contenido completo del correo.

---

# P12-B09 — Modal global de devolución/rechazo

## Funcionalidad P12-F12 — Gestionar devolución y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un modal global único para gestionar las acciones de:

- **DEVOLVER CON CORRECCIÓN**.
- **RECHAZAR SOLICITUD**.

### B. Actor principal

Rector/a.

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
- La acción confirmada debe generar trazabilidad.
- Cuando corresponda, la confirmación debe gatillar la generación de notificación automática por correo.

### E. Historia de usuario preliminar

**HU-P12-12:** Como **Rector/a**, quiero gestionar la devolución o rechazo mediante un modal único, para registrar claramente el motivo antes de modificar el estado del expediente.

### F. Requerimientos funcionales preliminares

- **RF-P12-045:** El sistema debe usar un modal global único para devolución con corrección y rechazo.
- **RF-P12-046:** El sistema debe exigir comentario obligatorio.
- **RF-P12-047:** El sistema debe permitir cancelar la acción sin modificar el expediente.
- **RF-P12-048:** El sistema debe ejecutar las notificaciones automáticas definidas para devolución y rechazo cuando la acción sea confirmada.

---

# P12-B10 — Confirmación, transición de estado, notificación y trazabilidad

## Funcionalidad P12-F13 — Confirmar aprobación y continuidad

### A. Descripción funcional

Antes de aprobar y continuar, el sistema debe solicitar confirmación explícita al Rector/a.

### B. Actor principal

Rector/a.

### C. Contenido de la confirmación

- Se aprobará el documento firmado cargado.
- El expediente avanzará a la siguiente etapa.
- Se utilizará el archivo firmado actualmente asociado.
- La acción quedará registrada.

### D. Reglas de negocio

- La confirmación debe estar disponible solo cuando exista documento firmado cargado.
- Debe poder cancelarse sin modificar el estado.

### E. Historia de usuario preliminar

**HU-P12-13:** Como **Rector/a**, quiero confirmar la aprobación antes de ejecutarla, para evitar avanzar por error con un documento incorrecto.

### F. Requerimientos funcionales preliminares

- **RF-P12-049:** El sistema debe solicitar confirmación antes de aprobar y continuar.
- **RF-P12-050:** El sistema debe validar la existencia de documento firmado cargado antes de confirmar.
- **RF-P12-051:** El sistema debe permitir cancelar la aprobación antes de aplicarla.

---

## Funcionalidad P12-F14 — Registrar trazabilidad de firma y decisión rectoral

### A. Descripción funcional

El sistema debe registrar de forma auditable las acciones ejecutadas por el Rector/a durante la etapa.

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
- Generación y envío de notificaciones automáticas.

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
- Registro de notificación generada, cuando corresponda.

### E. Historia de usuario preliminar

**HU-P12-14:** Como **sistema**, debo registrar las acciones de descarga, carga, aprobación, devolución, rechazo y notificación realizadas en Rectoría, para mantener trazabilidad completa del proceso de firma del acto administrativo.

### F. Requerimientos funcionales preliminares

- **RF-P12-052:** El sistema debe registrar las acciones relevantes de la etapa.
- **RF-P12-053:** El sistema debe registrar la carga del documento firmado con fecha, hora y usuario.
- **RF-P12-054:** El sistema debe registrar las decisiones de aprobación, devolución y rechazo.
- **RF-P12-055:** El sistema debe conservar la relación entre el expediente y el archivo firmado cargado.
- **RF-P12-056:** El sistema debe registrar en trazabilidad la generación y envío de los correos automáticos asociados a devolución o rechazo.

---

# 7. Estados de salida de la Pantalla 12

| Acción del Rector/a | Estado resultante | Destino |
|---|---|---|
| Descargar documento | Documento disponible para firma rectoral | Permanece en Rectoría |
| Subir documento firmado | Documento firmado cargado | Permanece en Rectoría |
| **APROBAR Y CONTINUAR** | Aprobado por Rector/a | Continúa a la siguiente etapa del flujo |
| **DEVOLVER CON CORRECCIÓN** | Devuelto por Rector/a | Etapa de retorno por definir |
| **RECHAZAR SOLICITUD** | Rechazado por Rector/a | Cierre definitivo del expediente |

---

# 8. Estados posibles del documento en Rectoría

| Estado | Descripción |
|---|---|
| **Pendiente de revisión** | El documento llegó desde Secretaría General y está disponible para visualización. |
| **Disponible para descarga** | El PDF puede descargarse para firma rectoral. |
| **Pendiente de firma/carga** | El documento fue revisado, pero aún no existe archivo firmado cargado. |
| **Documento firmado cargado** | Se cargó el archivo firmado y quedó asociado al expediente. |
| **Aprobado por Rector/a** | El documento firmado fue aprobado para continuar. |
| **Devuelto con corrección** | El documento fue retornado con observaciones. |
| **Rechazado** | El expediente fue cerrado desde esta etapa. |

---

# 9. Reglas globales de comportamiento de la Pantalla 12

| Código | Regla |
|---|---|
| **RG-P12-001** | El Rector/a debe recibir el documento remitido desde Secretaría General. |
| **RG-P12-002** | El PDF visualizado debe corresponder a la versión documental vigente enviada a firma rectoral. |
| **RG-P12-003** | La pantalla debe mostrar el documento en modo solo lectura. |
| **RG-P12-004** | El Rector/a no debe editar el contenido del acto administrativo desde esta pantalla. |
| **RG-P12-005** | La pantalla debe permitir descargar el PDF para firma rectoral. |
| **RG-P12-006** | La pantalla debe permitir subir el documento firmado y asociarlo al expediente. |
| **RG-P12-007** | La pantalla debe mostrar confirmación visible de carga exitosa del documento firmado. |
| **RG-P12-008** | La aprobación y continuidad del flujo debe bloquearse mientras no exista documento firmado cargado. |
| **RG-P12-009** | La devolución con corrección debe exigir comentario obligatorio. |
| **RG-P12-010** | El rechazo debe exigir comentario obligatorio. |
| **RG-P12-011** | La devolución y el rechazo deben gestionarse mediante un modal global único. |
| **RG-P12-012** | La aprobación debe solicitar confirmación explícita antes de avanzar. |
| **RG-P12-013** | Toda decisión del Rector/a debe quedar registrada en trazabilidad. |
| **RG-P12-014** | La carga del documento firmado debe registrar fecha, hora y usuario. |
| **RG-P12-015** | El documento firmado cargado debe conservarse como respaldo del expediente. |
| **RG-P12-016** | La pantalla debe diferenciar entre el PDF recibido desde Secretaría General y el archivo firmado cargado por Rectoría. |
| **RG-P12-017** | La pantalla no debe modificar firmantes, distribución ni contenido documental definido en Decretación. |
| **RG-P12-018** | La pantalla no debe incorporar la acción Salir sin guardar. |
| **RG-P12-019** | Toda acción de devolución debe gatillar un correo electrónico automático de notificación al Solicitante y dejar registro auditable. |
| **RG-P12-020** | Todo rechazo definitivo debe gatillar un correo electrónico automático de notificación al Solicitante y al rol Archivo Universitario, dejando registro auditable. |
| **RG-P12-021** | La pantalla debe mostrar confirmación visible de envío de notificación, sin desplegar el cuerpo completo del correo. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 12

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P12-001** | Legibilidad documental | El visor PDF debe permitir revisar adecuadamente el acto administrativo recibido desde Secretaría General. |
| **RNF-P12-002** | Integridad documental | El documento mostrado debe corresponder a la versión vigente enviada a Rectoría. |
| **RNF-P12-003** | Seguridad por rol | Solo usuarios autorizados como Rector/a deben ejecutar las acciones de esta etapa. |
| **RNF-P12-004** | Control de carga | El sistema debe conservar y asociar correctamente el archivo firmado cargado. |
| **RNF-P12-005** | Trazabilidad | La descarga, carga, decisiones y notificaciones del Rector/a deben quedar registradas. |
| **RNF-P12-006** | Confirmación de acciones | La aprobación, devolución y rechazo deben requerir confirmación según corresponda. |
| **RNF-P12-007** | Bloqueo condicional | El sistema debe bloquear la aprobación si no existe documento firmado cargado. |
| **RNF-P12-008** | Diferenciación de archivos | La pantalla debe distinguir claramente el PDF recibido desde Secretaría General del documento firmado cargado por Rectoría. |
| **RNF-P12-009** | Comentarios obligatorios | El sistema debe impedir devolver o rechazar sin comentario. |
| **RNF-P12-010** | Persistencia del respaldo | El documento firmado debe quedar almacenado como respaldo asociado al expediente. |
| **RNF-P12-011** | Continuidad del flujo | La aprobación debe avanzar a la etapa siguiente definida y la devolución debe respetar la ruta de retorno formal que se establezca. |
| **RNF-P12-012** | Coherencia con Secretaría General | La pantalla debe operar sobre el documento recibido desde la etapa anterior, sin reconstruirlo ni editarlo. |
| **RNF-P12-013** | Comunicación automatizada | Las devoluciones y rechazos deben generar notificaciones automáticas según las reglas definidas. |
| **RNF-P12-014** | Confirmación visible de notificación | La interfaz debe informar el envío exitoso de la notificación sin mostrar el contenido completo del correo. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 12

| Código | Funcionalidad |
|---|---|
| **P12-F01** | Visualizar identificación del expediente. |
| **P12-F02** | Visualizar estado de la etapa de firma rectoral. |
| **P12-F03** | Visualizar trazabilidad del expediente hasta Secretaría General. |
| **P12-F04** | Visualizar metadatos del documento recibido desde Secretaría General. |
| **P12-F05** | Visualizar el acto administrativo como PDF. |
| **P12-F06** | Descargar documento para firma. |
| **P12-F07** | Subir documento firmado por Rectoría. |
| **P12-F08** | Visualizar estado del documento firmado cargado. |
| **P12-F09** | Aprobar y continuar con documento firmado. |
| **P12-F10** | Devolver con corrección. |
| **P12-F11** | Rechazar solicitud. |
| **P12-F12** | Gestionar devolución y rechazo mediante modal global único. |
| **P12-F13** | Confirmar aprobación y continuidad. |
| **P12-F14** | Registrar trazabilidad de firma y decisión rectoral. |