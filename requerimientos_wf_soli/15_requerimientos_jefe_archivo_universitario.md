# PDS Normativo D9 / DU288 / DU09

## Pantalla 15 — Archivo, Registro y Cierre Definitivo del Expediente por Jefe de Archivo Universitario

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 15: Archivo, Registro y Cierre Definitivo del Expediente — Perfil Jefe de Archivo Universitario** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a la **última etapa del flujo PDS Normativo**, posterior a la **Toma de Razón Final emitida por el Contralor Universitario**.

En esta etapa, el Jefe de Archivo Universitario recibe la **resolución o acto administrativo totalmente tramitado**, es decir, un documento que ya cuenta con:

- Generación formal en Decretación.
- Firma de Secretaría General.
- Firma de Rectoría.
- Visación favorable del Profesional de Contraloría.
- Toma de Razón definitiva del Contralor Universitario.

El objetivo de esta pantalla es **registrar, archivar y cerrar definitivamente el expediente**, almacenando la resolución final en la base de datos o repositorio documental institucional de Archivo Universitario.

La pantalla debe permitir:

- Visualizar el documento final totalmente tramitado como PDF.
- Revisar la trazabilidad completa del expediente.
- Confirmar que todas las etapas previas fueron finalizadas.
- Archivar formalmente la resolución final en la BDD o repositorio de Archivo Universitario.
- Cerrar definitivamente el expediente.
- Descargar una copia fiel del documento archivado.
- Registrar trazabilidad de archivo, cierre y almacenamiento institucional.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 15 — Archivo Universitario**. No modifica etapas previas ni incorpora decisiones de revisión, rechazo o devolución. Su objetivo es definir cómo se visualiza, archiva y cierra formalmente una resolución PDS totalmente tramitada.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P15 |
| **Nombre** | Archivo, Registro y Cierre Definitivo del Expediente |
| **Perfil principal** | Jefe de Archivo Universitario / Usuario autorizado de Archivo Institucional |
| **Etapa del flujo** | Etapa 15 — Archivo Universitario y cierre de expediente |
| **Estado de entrada esperado** | Resolución con Toma de Razón definitiva registrada por Contralor Universitario |
| **Objetivo principal** | Permitir que Archivo Universitario visualice el acto administrativo totalmente tramitado, lo almacene en la base documental institucional y cierre definitivamente el expediente PDS. |
| **Resultado posible** | Resolución archivada en repositorio institucional y expediente cerrado definitivamente. |

---

# 3. Principio funcional de la Pantalla 15

La Pantalla 15 debe operar como una **vista de cierre documental e institucional del expediente**.

A diferencia de las etapas anteriores, este rol:

- No revisa la admisibilidad del expediente.
- No visa contenido.
- No firma el documento.
- No modifica información.
- No devuelve ni rechaza la solicitud.
- No interviene en la validez previa del acto administrativo.

Su función es **custodiar y registrar el documento final aprobado**, dejando trazabilidad del archivo y declarando el expediente como **finalizado**.

La secuencia funcional esperada es:

1. Recibir el expediente aprobado desde Contraloría Final.
2. Visualizar la resolución completamente tramitada.
3. Verificar el estado final del flujo.
4. Archivar la resolución en el repositorio institucional.
5. Cerrar el expediente.
6. Permitir descargar copia fiel del documento archivado.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 15 debe permitir que el Jefe de Archivo Universitario:

- Visualice la identificación del expediente totalmente tramitado.
- Visualice el número o identificador de la resolución/decreto final.
- Visualice el estado general:
  - **Proceso finalizado**.
  - **Pendiente de archivo**, antes de ejecutar el cierre.
  - **Archivado y cerrado**, una vez completada la acción.
- Revise la trazabilidad documental completa del expediente.
- Visualice que el expediente fue:
  - Aprobado en todas las etapas previas.
  - Formalizado en Decretación.
  - Firmado por Secretaría General.
  - Firmado por Rectoría.
  - Visado por Profesional de Contraloría.
  - Tomado de razón por Contralor Universitario.
- Visualice el acto administrativo final en formato PDF embebido.
- Revise el documento final completo desde el visor.
- Visualice indicadores de cierre documental, incluyendo:
  - Firma de Secretario General registrada.
  - Firma de Rectoría registrada.
  - Toma de Razón del Contralor registrada.
- Visualice datos de registro del expediente:
  - Código PDS.
  - Número de resolución.
  - Fecha de cierre.
  - Estado de archivo.
  - Identificador de registro, cuando exista.
- Ejecute la acción **ARCHIVAR Y CERRAR**.
- Guarde la resolución final en la base de datos o repositorio documental de Archivo Universitario.
- Registre el cierre definitivo del expediente.
- Genere un log de archivo asociado al documento.
- Visualice confirmación de archivo exitoso.
- Permita descargar una **COPIA FIEL** del documento archivado.
- Registre trazabilidad de:
  - Recepción desde Contraloría Final.
  - Archivo del documento.
  - Cierre del expediente.
  - Descarga de copia fiel, si el proceso decide registrarla.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 15 no debe:

- Editar el contenido del acto administrativo.
- Modificar la resolución final.
- Reemplazar el documento aprobado por una nueva versión.
- Incorporar anexos no autorizados al expediente.
- Alterar firmas previas de Secretaría General o Rectoría.
- Modificar la Toma de Razón del Contralor Universitario.
- Reabrir la solicitud desde esta pantalla.
- Devolver el expediente a etapas anteriores.
- Rechazar el expediente.
- Aprobar nuevamente el documento.
- Modificar datos técnicos, financieros, normativos o administrativos del expediente.
- Cambiar el estado de tramitación previo.
- Archivar un documento si el expediente no cuenta con Toma de Razón definitiva.
- Cerrar un expediente sin asociar correctamente el documento final en el repositorio.
- Mostrar acciones de visación, devolución o rechazo.
- Incorporar la acción **Salir sin guardar** como acción de proceso.

---

# 4. Objetivo funcional de la Pantalla 15

La pantalla debe permitir que el Jefe de Archivo Universitario:

1. Identifique el expediente que llega a cierre documental.
2. Visualice el número o identificador de la resolución final.
3. Confirme que el expediente cuenta con todas las aprobaciones y firmas previas.
4. Verifique que existe Toma de Razón definitiva del Contralor Universitario.
5. Visualice el estado del proceso como expediente totalmente tramitado.
6. Revise el documento final en formato PDF.
7. Consulte la trazabilidad completa del flujo.
8. Visualice el estado de firmas y autorizaciones finales.
9. Registre el archivo definitivo del documento en la BDD o repositorio institucional.
10. Ejecute el cierre formal del expediente.
11. Visualice la confirmación de que el expediente fue archivado correctamente.
12. Consulte el log de registro asociado al archivo.
13. Descargue una copia fiel del documento archivado.
14. Mantenga trazabilidad completa del cierre institucional.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 15 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P15-B01** | Encabezado del expediente y estado final del proceso | Identificar la resolución, el expediente y su condición de cierre. |
| **P15-B02** | Visor PDF de resolución totalmente tramitada | Mostrar el acto administrativo final aprobado. |
| **P15-B03** | Indicadores de firmas y Toma de Razón | Confirmar que el documento cuenta con todas las actuaciones previas requeridas. |
| **P15-B04** | Trazabilidad documental completa | Mostrar el recorrido íntegro del expediente hasta Archivo Universitario. |
| **P15-B05** | Panel de archivo institucional | Mostrar el estado de archivo y permitir ejecutar el cierre. |
| **P15-B06** | Acción Archivar y Cerrar | Guardar el documento final en repositorio y cerrar el expediente. |
| **P15-B07** | Descarga de copia fiel | Permitir obtener una copia del documento archivado. |
| **P15-B08** | Log de registro y confirmación de cierre | Mostrar ID de archivo, fecha, estado y confirmación de operación. |
| **P15-B09** | Trazabilidad final de archivo y cierre | Registrar las acciones de almacenamiento institucional y cierre del expediente. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P15-B01 — Encabezado del expediente y estado final del proceso

## Funcionalidad P15-F01 — Visualizar identificación del expediente finalizado

### A. Descripción funcional

El sistema debe mostrar claramente la identificación del expediente PDS que ha completado todas las etapas del flujo y se encuentra listo para archivo definitivo.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Datos que debe mostrar el sistema

- Código único de solicitud PDS.
- Número o identificador de resolución/decreto.
- Título de la etapa:
  - **Archivo Universitario**.
  - **Cierre de Expediente**.
- Estado principal:
  - **Resolución totalmente tramitada**.
- Estado visual:
  - **Proceso finalizado**, una vez completado el archivo.
  - **Pendiente de archivo**, si aún no se ejecuta la acción de cierre.

### D. Reglas de negocio

- El expediente debe haber superado la etapa de Toma de Razón Final.
- La resolución mostrada debe corresponder al acto administrativo aprobado en la etapa anterior.

### E. Historia de usuario preliminar

**HU-P15-01:** Como **Jefe de Archivo Universitario**, quiero visualizar claramente el expediente y la resolución totalmente tramitada, para identificar el documento que debe archivarse y cerrarse institucionalmente.

### F. Requerimientos funcionales preliminares

- **RF-P15-001:** El sistema debe mostrar el código único del expediente PDS.
- **RF-P15-002:** El sistema debe mostrar el número o identificador de la resolución/decreto final.
- **RF-P15-003:** El sistema debe mostrar que el documento corresponde a una resolución totalmente tramitada.
- **RF-P15-004:** El sistema debe mostrar el estado de proceso finalizado o pendiente de archivo según corresponda.

---

# P15-B02 — Visor PDF de resolución totalmente tramitada

## Funcionalidad P15-F02 — Visualizar el documento final como PDF

### A. Descripción funcional

El sistema debe mostrar el acto administrativo final en un visor PDF embebido, permitiendo revisar el documento totalmente tramitado antes de su archivo formal.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Contenido visible del documento

El visor debe permitir revisar:

- Encabezado institucional.
- Número de resolución/decreto.
- Texto final del acto administrativo.
- Firma de Secretaría General.
- Firma de Rectoría.
- Constancia de Toma de Razón del Contralor Universitario.
- Tabla o cuerpo documental incorporado.
- Distribución final, si corresponde.
- Cierre del acto administrativo.

### D. Reglas de negocio

- El PDF debe corresponder a la versión final derivada desde Contraloría Final.
- El documento debe mostrarse en modo solo lectura.
- No debe permitirse reemplazar ni editar el archivo desde esta pantalla.

### E. Historia de usuario preliminar

**HU-P15-02:** Como **Jefe de Archivo Universitario**, quiero visualizar la resolución final como PDF, para confirmar el documento que será archivado institucionalmente.

### F. Requerimientos funcionales preliminares

- **RF-P15-005:** El sistema debe mostrar la resolución final en un visor PDF.
- **RF-P15-006:** El visor debe permitir revisar el documento completo.
- **RF-P15-007:** El PDF debe corresponder a la versión final posterior a la Toma de Razón definitiva.
- **RF-P15-008:** El sistema no debe permitir editar ni reemplazar el documento desde esta pantalla.

---

# P15-B03 — Indicadores de firmas y Toma de Razón

## Funcionalidad P15-F03 — Visualizar estado de validaciones finales del documento

### A. Descripción funcional

El sistema debe mostrar indicadores visibles que confirmen que el documento cuenta con las actuaciones finales requeridas para su archivo.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Indicadores mínimos

- **Secretaría General:** Firmado.
- **Rectoría:** Firmado.
- **Contralor Universitario:** Toma de Razón realizada.

### D. Reglas de negocio

- Los indicadores deben reflejar la información registrada en las etapas anteriores.
- El archivo definitivo no debe ejecutarse si alguna de estas actuaciones no se encuentra registrada como completada.

### E. Historia de usuario preliminar

**HU-P15-03:** Como **Jefe de Archivo Universitario**, quiero visualizar el estado de firmas y Toma de Razón del documento, para confirmar que está habilitado para archivo definitivo.

### F. Requerimientos funcionales preliminares

- **RF-P15-009:** El sistema debe mostrar el estado de firma de Secretaría General.
- **RF-P15-010:** El sistema debe mostrar el estado de firma de Rectoría.
- **RF-P15-011:** El sistema debe mostrar el estado de Toma de Razón del Contralor Universitario.
- **RF-P15-012:** El sistema debe impedir archivar y cerrar si falta alguna actuación final obligatoria.

---

# P15-B04 — Trazabilidad documental completa

## Funcionalidad P15-F04 — Visualizar historial íntegro del expediente

### A. Descripción funcional

El sistema debe mostrar la trazabilidad completa de la solicitud desde su creación hasta su llegada a Archivo Universitario.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Etapas mínimas a mostrar

- Creación y envío inicial.
- Aprobación por Jefe de Proyecto.
- Aprobación por Jefatura Directa / Dirección de Departamento.
- Revisión y aprobación por DGDP.
- Revisión y aprobación por Finanzas de Facultad.
- Aprobación por Decanato.
- Aprobación por Dirección de Finanzas.
- Generación documental en Decretación.
- Firma de Secretaría General.
- Firma de Rectoría.
- Visación de Profesional de Contraloría.
- Toma de Razón definitiva del Contralor Universitario.
- Ingreso a Archivo Universitario.
- Archivo y cierre, una vez ejecutado.

### D. Datos por etapa

- Fecha y hora.
- Rol.
- Usuario.
- Acción ejecutada.
- Comentario asociado, cuando exista.

### E. Historia de usuario preliminar

**HU-P15-04:** Como **Jefe de Archivo Universitario**, quiero revisar la trazabilidad completa del expediente, para confirmar que el documento que se archiva recorrió satisfactoriamente todo el flujo institucional.

### F. Requerimientos funcionales preliminares

- **RF-P15-013:** El sistema debe mostrar cronológicamente todas las etapas del expediente.
- **RF-P15-014:** El sistema debe mostrar usuario, rol, acción, fecha y hora en cada hito.
- **RF-P15-015:** El sistema debe mostrar la Toma de Razón definitiva como antecedente previo al archivo.
- **RF-P15-016:** El sistema debe registrar el archivo y cierre como evento final de la trazabilidad.

---

# P15-B05 — Panel de archivo institucional

## Funcionalidad P15-F05 — Visualizar estado de archivo institucional

### A. Descripción funcional

El sistema debe mostrar un panel resumen del estado de archivo del expediente, indicando que el documento está habilitado para almacenarse en el repositorio institucional.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Datos que debe mostrar el sistema

- Estado de archivo:
  - Pendiente de archivo.
  - Archivado correctamente.
- Estado del documento:
  - Totalmente tramitado.
- Repositorio de destino:
  - Archivo Universitario / BDD de archivos.
- Identificador de registro, si existe.
- Fecha de archivo, una vez completado.
- Usuario responsable del archivo.

### D. Historia de usuario preliminar

**HU-P15-05:** Como **Jefe de Archivo Universitario**, quiero visualizar el estado de archivo del expediente, para saber si el documento aún debe almacenarse o ya fue registrado oficialmente.

### E. Requerimientos funcionales preliminares

- **RF-P15-017:** El sistema debe mostrar el estado de archivo del expediente.
- **RF-P15-018:** El sistema debe indicar el repositorio institucional donde será almacenado.
- **RF-P15-019:** El sistema debe mostrar el identificador de registro y fecha de archivo una vez completado el proceso.
- **RF-P15-020:** El sistema debe mostrar el usuario responsable del archivo institucional.

---

# P15-B06 — Acción Archivar y Cerrar

## Funcionalidad P15-F06 — Archivar resolución final y cerrar expediente

### A. Descripción funcional

El Jefe de Archivo Universitario debe poder ejecutar la acción final que almacena la resolución totalmente tramitada en el repositorio institucional y cierra definitivamente el expediente.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Acción disponible

- Botón: **ARCHIVAR Y CERRAR**.

### D. Resultado esperado

- La resolución final queda almacenada en la BDD o repositorio de Archivo Universitario.
- El expediente cambia a estado:
  - **Archivado y cerrado**.
- Se genera un registro institucional del archivo.
- El flujo PDS se considera terminado.

### E. Reglas de negocio

- Solo debe permitirse archivar expedientes con:
  - Firma de Secretaría General registrada.
  - Firma de Rectoría registrada.
  - Toma de Razón definitiva del Contralor Universitario registrada.
- El sistema debe asociar al registro de archivo:
  - Documento final.
  - Código de expediente.
  - Número de resolución.
  - Fecha de archivo.
  - Usuario responsable.
- Una vez archivado y cerrado, el expediente no debe volver a etapas anteriores mediante esta pantalla.
- La acción debe requerir confirmación explícita antes de ejecutarse.

### F. Historia de usuario preliminar

**HU-P15-06:** Como **Jefe de Archivo Universitario**, quiero archivar la resolución final y cerrar el expediente, para registrar institucionalmente el acto administrativo ya totalmente tramitado.

### G. Requerimientos funcionales preliminares

- **RF-P15-021:** El sistema debe permitir ejecutar la acción **ARCHIVAR Y CERRAR**.
- **RF-P15-022:** El sistema debe guardar la resolución final en la BDD o repositorio documental institucional.
- **RF-P15-023:** El sistema debe cambiar el estado del expediente a **Archivado y cerrado**.
- **RF-P15-024:** El sistema debe generar un registro institucional de archivo.
- **RF-P15-025:** El sistema debe impedir archivar si no se cumplen las actuaciones finales obligatorias.
- **RF-P15-026:** El sistema debe solicitar confirmación antes de archivar y cerrar.

---

# P15-B07 — Descarga de copia fiel

## Funcionalidad P15-F07 — Descargar copia fiel del documento archivado

### A. Descripción funcional

El sistema debe permitir descargar una copia fiel de la resolución final archivada.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Acción disponible

- Botón: **DESCARGAR COPIA FIEL**.

### D. Reglas de negocio

- La copia fiel debe corresponder al documento final archivado.
- La descarga no debe modificar el estado del expediente.
- La acción puede quedar registrada en trazabilidad si se define como evento auditable.

### E. Historia de usuario preliminar

**HU-P15-07:** Como **Jefe de Archivo Universitario**, quiero descargar una copia fiel de la resolución archivada, para disponer del documento final oficialmente almacenado.

### F. Requerimientos funcionales preliminares

- **RF-P15-027:** El sistema debe permitir descargar una copia fiel del documento archivado.
- **RF-P15-028:** La copia descargada debe corresponder a la resolución final almacenada.
- **RF-P15-029:** El sistema debe poder registrar la descarga si esta trazabilidad se habilita.

---

# P15-B08 — Log de registro y confirmación de cierre

## Funcionalidad P15-F08 — Visualizar confirmación y log de archivo

### A. Descripción funcional

Una vez ejecutado el archivo, el sistema debe mostrar una confirmación visible y un registro resumen del cierre institucional.

### B. Actor principal

Jefe de Archivo Universitario.

### C. Datos que debe mostrar el sistema

- Mensaje:
  - **Expediente archivado correctamente en el repositorio institucional**.
- Identificador de registro del archivo.
- Código del expediente.
- Número de resolución.
- Fecha de archivo.
- Hora de archivo.
- Usuario responsable.
- Estado:
  - Archivado y cerrado.

### D. Reglas de negocio

- La confirmación debe mostrarse únicamente después de una operación exitosa.
- El log debe corresponder al registro efectivamente almacenado.

### E. Historia de usuario preliminar

**HU-P15-08:** Como **Jefe de Archivo Universitario**, quiero visualizar la confirmación y el log de archivo, para verificar que el expediente fue almacenado y cerrado correctamente.

### F. Requerimientos funcionales preliminares

- **RF-P15-030:** El sistema debe mostrar una confirmación visible de archivo exitoso.
- **RF-P15-031:** El sistema debe mostrar el ID o identificador de registro documental.
- **RF-P15-032:** El sistema debe mostrar fecha, hora y usuario responsable del archivo.
- **RF-P15-033:** El sistema debe mostrar el estado final del expediente como **Archivado y cerrado**.

---

# P15-B09 — Trazabilidad final de archivo y cierre

## Funcionalidad P15-F09 — Registrar trazabilidad final del proceso

### A. Descripción funcional

El sistema debe registrar de forma auditable las acciones realizadas en la etapa final de Archivo Universitario.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Recepción del expediente desde Contralor Universitario.
- Apertura o visualización del expediente, si se decide registrar.
- Archivo de resolución final.
- Cierre definitivo del expediente.
- Generación del registro en repositorio.
- Descarga de copia fiel, si se decide registrar.

### D. Datos mínimos de trazabilidad

- Código de expediente.
- Número de resolución.
- Usuario.
- Rol.
- Acción ejecutada.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Identificador del registro de archivo.
- Repositorio destino.

### E. Historia de usuario preliminar

**HU-P15-09:** Como **sistema**, debo registrar el archivo y cierre definitivo del expediente, para dejar evidencia auditable de la conclusión formal del flujo PDS Normativo.

### F. Requerimientos funcionales preliminares

- **RF-P15-034:** El sistema debe registrar la recepción del expediente en Archivo Universitario.
- **RF-P15-035:** El sistema debe registrar la acción de archivo definitivo.
- **RF-P15-036:** El sistema debe registrar el cierre final del expediente.
- **RF-P15-037:** El sistema debe conservar el identificador del registro de archivo institucional.
- **RF-P15-038:** El sistema debe registrar la relación entre la resolución final y el repositorio documental de destino.

---

# 7. Estados de salida de la Pantalla 15

| Acción del Jefe de Archivo Universitario | Estado resultante | Destino |
|---|---|---|
| **ARCHIVAR Y CERRAR** | Expediente archivado y cerrado | Fin del flujo PDS Normativo |
| **DESCARGAR COPIA FIEL** | Sin cambio de estado | Permanece archivado |

---

# 8. Estados posibles del expediente en Archivo Universitario

| Estado | Descripción |
|---|---|
| **Pendiente de archivo** | El expediente llegó desde Contraloría Final con Toma de Razón definitiva y espera registro institucional. |
| **Archivando** | El sistema se encuentra registrando la resolución en el repositorio institucional, si se implementa un estado transitorio. |
| **Archivado y cerrado** | La resolución fue almacenada y el flujo quedó finalizado. |
| **Proceso finalizado** | Estado visible de cierre completo del expediente. |

---

# 9. Reglas globales de comportamiento de la Pantalla 15

| Código | Regla |
|---|---|
| **RG-P15-001** | Archivo Universitario debe recibir únicamente expedientes con Toma de Razón definitiva registrada. |
| **RG-P15-002** | El documento visualizado debe corresponder a la resolución final totalmente tramitada. |
| **RG-P15-003** | La pantalla debe mostrar el acto administrativo mediante visor PDF en modo solo lectura. |
| **RG-P15-004** | El Jefe de Archivo Universitario no debe editar ni reemplazar el documento final. |
| **RG-P15-005** | La pantalla debe mostrar la trazabilidad completa del expediente hasta su cierre institucional. |
| **RG-P15-006** | El sistema debe mostrar el estado de firma de Secretaría General, Rectoría y Toma de Razón del Contralor. |
| **RG-P15-007** | El sistema debe impedir archivar si falta alguna actuación final obligatoria. |
| **RG-P15-008** | La acción **ARCHIVAR Y CERRAR** debe almacenar la resolución final en la BDD o repositorio institucional. |
| **RG-P15-009** | La acción **ARCHIVAR Y CERRAR** debe cerrar definitivamente el expediente. |
| **RG-P15-010** | El sistema debe generar un registro institucional de archivo con identificador, fecha y usuario. |
| **RG-P15-011** | El sistema debe mostrar confirmación visible de archivo exitoso. |
| **RG-P15-012** | La descarga de copia fiel debe corresponder al documento final archivado. |
| **RG-P15-013** | La pantalla no debe incluir acciones de aprobación, devolución, rechazo, firma o edición documental. |
| **RG-P15-014** | Una vez archivado y cerrado, el expediente no debe retornar a etapas previas desde esta pantalla. |
| **RG-P15-015** | Toda acción de archivo y cierre debe quedar registrada en trazabilidad. |
| **RG-P15-016** | La pantalla no debe incorporar la acción Salir sin guardar. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 15

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P15-001** | Integridad documental | El documento archivado debe corresponder exactamente a la resolución final aprobada y tomada de razón. |
| **RNF-P15-002** | Seguridad por rol | Solo usuarios autorizados de Archivo Universitario deben ejecutar el archivo y cierre. |
| **RNF-P15-003** | Persistencia documental | La resolución final debe almacenarse correctamente en el repositorio institucional definido. |
| **RNF-P15-004** | Trazabilidad | El archivo, cierre y registro final deben quedar documentados de forma auditable. |
| **RNF-P15-005** | Claridad de estado | La interfaz debe mostrar si el expediente está pendiente de archivo o ya fue archivado y cerrado. |
| **RNF-P15-006** | Confirmación de acción | El cierre definitivo debe requerir confirmación previa. |
| **RNF-P15-007** | Modo solo lectura | La pantalla no debe habilitar edición del documento ni de sus antecedentes. |
| **RNF-P15-008** | Consistencia con flujo previo | Solo deben ingresar expedientes correctamente finalizados por Contraloría Universitaria. |
| **RNF-P15-009** | Disponibilidad de copia fiel | El sistema debe permitir obtener el documento final archivado sin alterarlo. |
| **RNF-P15-010** | Registro institucional | El archivo debe conservar identificador de expediente, número de resolución, fecha, usuario y repositorio destino. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 15

| Código | Funcionalidad |
|---|---|
| **P15-F01** | Visualizar identificación del expediente finalizado. |
| **P15-F02** | Visualizar el documento final como PDF. |
| **P15-F03** | Visualizar estado de validaciones finales del documento. |
| **P15-F04** | Visualizar historial íntegro del expediente. |
| **P15-F05** | Visualizar estado de archivo institucional. |
| **P15-F06** | Archivar resolución final y cerrar expediente. |
| **P15-F07** | Descargar copia fiel del documento archivado. |
| **P15-F08** | Visualizar confirmación y log de archivo. |
| **P15-F09** | Registrar trazabilidad final del proceso. |