# PDS Normativo D9 / DU288 / DU09

## Pantalla 08 — Decretación, Formalización y Generación del Acto Administrativo

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 08: Decretación, Formalización y Generación del Acto Administrativo — Perfil Jefe/a de Decretación** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a la etapa en la que el expediente, ya revisado y aprobado por las instancias previas, se transforma en un **acto administrativo formal**, mediante la generación de una **resolución, decreto o documento administrativo equivalente**, construido a partir de:

- La información aprobada de la solicitud.
- Los antecedentes normativos y financieros validados.
- Los funcionarios vigentes que continúan en el flujo.
- Los funcionarios excluidos previamente, que deben quedar visibles en pantalla pero no incorporarse al documento final.
- Las secciones textuales propias del acto administrativo.
- La plantilla base almacenada en base de datos.
- La tabla documental con los datos de la prestación.
- La selección de autoridades firmantes.
- La distribución oficial o circuito documental posterior.

La Pantalla 08 no se limita a revisar el expediente, sino que permite **formalizarlo documentalmente**, editando los textos normativos y preparando el documento que será enviado al circuito de firma.

Debe permitir:

- Visualizar toda la información aprobada en etapas anteriores.
- Confirmar el expediente que será formalizado.
- Cargar una base documental desde BDD.
- Editar los textos del acto administrativo:
  - VISTO.
  - CONSIDERANDO.
  - RESUELVO / DISPÓNESE.
  - Otros bloques documentales definidos por plantilla.
- Guardar los textos editados.
- Visualizar una tabla de prestaciones y validaciones que formará parte del documento generado.
- Seleccionar mediante controles tipo **select** a las autoridades firmantes.
- Gestionar una distribución editable del documento.
- Previsualizar el documento final antes de enviarlo a firma.
- Devolver con corrección el expediente cuando se detecten observaciones que deban subsanarse.
- Rechazar la solicitud cuando no corresponda continuar con su formalización.
- Enviar el documento a firma cuando se encuentre preparado.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 08 — Decretación**. No modifica las pantallas anteriores. Su objetivo es definir qué información debe visualizar el rol de Decretación, qué elementos documentales puede editar, cómo se genera la resolución y qué decisiones puede registrar antes de enviar el expediente al flujo de firmas legales.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P08 |
| **Nombre** | Decretación, Formalización y Generación del Acto Administrativo |
| **Perfil principal** | Jefe/a de Decretación o usuario autorizado de formalización documental |
| **Etapa del flujo** | Etapa 08 — Preparación del acto administrativo y envío a firma |
| **Estado de entrada esperado** | Solicitud aprobada por Dirección de Finanzas y enviada a Decretación |
| **Objetivo principal** | Permitir que Decretación revise el expediente aprobado, genere el acto administrativo correspondiente, edite sus secciones textuales, seleccione firmantes, administre la distribución, previsualice el documento y lo envíe al circuito de firma. |
| **Resultado posible** | Documento guardado como borrador; solicitud devuelta con corrección; solicitud rechazada; o resolución/decreto generado y enviado a firma. |

---

# 3. Principio funcional de la Pantalla 08

La Pantalla 08 debe operar como una **vista de formalización documental del expediente**, donde el rol de Decretación transforma la solicitud aprobada en un documento administrativo jurídicamente estructurado y listo para su proceso de firma.

A diferencia de las pantallas previas, esta etapa:

- No ejecuta nuevas validaciones normativas de elegibilidad.
- No modifica los datos técnicos o financieros originales de la PDS.
- No excluye funcionarios.
- No altera las decisiones emitidas por DGDP, Finanzas de Facultad, Decanato o Dirección de Finanzas.

Su función central es:

1. **Revisar el expediente consolidado.**
2. **Generar el acto administrativo desde una base documental.**
3. **Editar sus textos normativos.**
4. **Incorporar la tabla documental de prestaciones y validaciones.**
5. **Definir firmantes y distribución.**
6. **Previsualizar el resultado.**
7. **Enviar a firma o devolver/rechazar según corresponda.**

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 08 debe permitir que Decretación:

- Visualice la solicitud completa en modo solo lectura respecto de sus datos de origen.
- Revise las decisiones y visaciones emitidas en las etapas anteriores:
  - Solicitante.
  - Jefe de Proyecto.
  - Jefatura Directa / Dirección de Departamento.
  - DGDP.
  - Finanzas de Facultad.
  - Decano/a.
  - Dirección de Finanzas.
- Visualice el estado consolidado de aprobación previa del expediente.
- Visualice si DGDP excluyó funcionarios y el motivo resumido de dicha exclusión.
- Visualice los funcionarios vigentes que formarán parte de la resolución.
- Visualice los funcionarios excluidos, dejando claro que **no serán incorporados al acto administrativo final**.
- Revise los datos generales del expediente:
  - Centro de Costo.
  - Proyecto.
  - Unidad ejecutora.
  - Jefe de Proyecto.
  - Tipo de financiamiento.
  - Decreto afecto.
  - Vigencia de la prestación.
  - Periodo de ejecución.
  - Total asignación.
- Visualice la información financiera y presupuestaria aprobada:
  - Saldo disponible general.
  - Ítems presupuestarios.
  - Montos asociados.
  - Suficiencia presupuestaria.
- Visualice la actividad general, tipo de prestación, justificación técnica y evidencias comprometidas.
- Visualice el detalle de cada funcionario vigente:
  - Identificación.
  - Estamento.
  - Cargo o jerarquía.
  - Grado.
  - Tipo de vinculación.
  - Jornada.
  - Contrato seleccionado.
  - Actividad específica.
  - Monto bruto.
  - Monto líquido estimado, cuando exista.
  - Meses de pago.
  - Total comprometido.
  - Validaciones previas resumidas.
- Visualice historial de PDS, pagos, topes, compensaciones, SEA, deudas y otras validaciones relevantes como antecedentes informativos.
- Cargue una **plantilla base documental** desde la base de datos.
- Genere un borrador de resolución/decreto asociado al expediente.
- Edite las secciones del documento administrativo, incluyendo al menos:
  - **VISTO**.
  - **CONSIDERANDO**.
  - **RESUELVO / DISPÓNESE**.
  - Fórmulas de cierre u otros textos configurados en la plantilla.
- Edite los textos mediante un editor enriquecido.
- Agregue, modifique, elimine o reorganice bloques de texto cuando la plantilla lo permita.
- Guarde los textos editados del documento.
- Guarde el borrador documental sin enviar aún a firma.
- Visualice una **tabla documental de prestaciones y validaciones**, ubicada entre los textos del acto administrativo y la sección de firmantes.
- Visualice en dicha tabla el detalle de las prestaciones incluidas en la resolución, con sus datos aprobados y validaciones correspondientes.
- Seleccione mediante controles tipo **select** a las autoridades firmantes del documento.
- Visualice y gestione, como mínimo:
  - Vicerrector/a de Administración y Finanzas.
  - Secretario/a General.
- Registre qué persona específica ocupará cada rol firmante en el documento.
- Gestione la **distribución oficial** o circuito documental posterior:
  - Visualice la distribución base derivada del flujo.
  - Agregue nuevos registros.
  - Edite registros existentes.
  - Elimine registros cuando corresponda.
- Previsualice el documento final antes de enviarlo a firma.
- Devuelva el expediente con corrección mediante la acción **DEVOLVER CON CORRECCIÓN**.
- Rechace la solicitud mediante la acción **RECHAZAR SOLICITUD**, si el proceso mantiene esta capacidad para el rol.
- Envíe el documento al circuito de firmas mediante la acción **ENVIAR A FIRMA**.
- Confirme las acciones que cambien el estado del expediente.
- Registre trazabilidad de:
  - Carga de plantilla.
  - Edición de textos.
  - Guardado de borrador.
  - Selección de firmantes.
  - Edición de distribución.
  - Previsualización, si se decide registrar.
  - Devolución.
  - Rechazo.
  - Envío a firma.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 08 no debe:

- Editar los datos originales de la solicitud ingresados por el Solicitante.
- Modificar los resultados de validación emitidos por DGDP.
- Modificar la revisión financiera emitida por Finanzas de Facultad.
- Modificar la aprobación de Decanato.
- Modificar la aprobación de Dirección de Finanzas.
- Incorporar nuevos funcionarios a la PDS.
- Excluir funcionarios del expediente.
- Reponer funcionarios excluidos en etapas previas.
- Alterar los montos, meses de pago, compensaciones o topes ya aprobados en el flujo.
- Modificar manualmente los saldos presupuestarios.
- Cambiar el ítem presupuestario de la prestación.
- Alterar el historial de pagos o de prestaciones del funcionario.
- Incorporar en la resolución final a funcionarios previamente excluidos.
- Enviar a firma un documento sin firmantes obligatorios seleccionados.
- Enviar a firma un documento sin textos documentales mínimos requeridos.
- Enviar a firma un documento cuya tabla de prestaciones no se encuentre generada.
- Presentar como final un documento no guardado o inconsistente con el expediente vigente.
- Incorporar la opción **Salir sin guardar** como acción crítica del flujo.
- Ejecutar una firma legal en nombre de los firmantes posteriores.

---

# 4. Objetivo funcional de la Pantalla 08

La pantalla debe permitir que Decretación:

1. Identifique la solicitud aprobada que ingresa a formalización documental.
2. Visualice el estado actual del expediente y su etapa del flujo.
3. Revise la trazabilidad completa de todas las etapas previas.
4. Visualice el resultado de DGDP, Finanzas de Facultad, Decanato y Dirección de Finanzas.
5. Conozca si hubo funcionarios excluidos y por qué.
6. Visualice los funcionarios vigentes que integrarán la resolución.
7. Revise el resumen ejecutivo del expediente técnico-financiero.
8. Consulte el Centro de Costo, proyecto, unidad ejecutora, financiamiento y decreto afecto.
9. Visualice los ítems presupuestarios y saldos aprobados en etapas anteriores.
10. Visualice el periodo de ejecución, vigencia y monto total de la prestación.
11. Revise la actividad general, tipo de prestación, justificación y evidencias.
12. Visualice el detalle laboral, financiero y normativo de cada funcionario vigente.
13. Visualice el personal excluido, sin incorporarlo al documento final.
14. Cargue una plantilla base de acto administrativo desde BDD.
15. Genere el borrador del documento que formaliza la PDS.
16. Edite la sección **VISTO**.
17. Edite uno o más bloques de **CONSIDERANDO**.
18. Edite la sección **RESUELVO / DISPÓNESE**.
19. Edite otros textos documentales habilitados por plantilla.
20. Guarde los textos documentales modificados.
21. Guarde el documento como borrador.
22. Visualice una tabla documental con las prestaciones vigentes y sus validaciones.
23. Verifique que la tabla documental incluya solo funcionarios habilitados.
24. Seleccione a los firmantes requeridos mediante listas desplegables.
25. Registre la persona que ejercerá cada rol firmante.
26. Visualice y edite la distribución oficial del documento.
27. Agregue, modifique o elimine registros de distribución.
28. Previsualice el decreto/resolución antes de enviarlo al circuito de firma.
29. Devuelva con corrección el expediente cuando detecte observaciones subsanables.
30. Rechace la solicitud cuando no corresponda formalizarla.
31. Envíe el documento a firma cuando esté completo.
32. Confirme las acciones de devolución, rechazo o envío.
33. Registre trazabilidad completa de la formalización documental.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 08 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P08-B01** | Encabezado del expediente y estado de Decretación | Identificar la solicitud, su estado documental y el rol responsable. |
| **P08-B02** | Trazabilidad de etapas previas | Mostrar todo el recorrido de aprobación hasta Dirección de Finanzas. |
| **P08-B03** | Resumen ejecutivo del expediente aprobado | Mostrar los datos esenciales de la PDS que será formalizada. |
| **P08-B04** | Centro de Costo, financiamiento e ítems presupuestarios | Mostrar los antecedentes presupuestarios aprobados del expediente. |
| **P08-B05** | Nómina de funcionarios vigentes incorporables a la resolución | Mostrar el personal aprobado que formará parte del acto administrativo. |
| **P08-B06** | Personal excluido del acto administrativo | Mostrar quienes fueron retirados en etapas anteriores y no aparecerán en la resolución final. |
| **P08-B07** | Validaciones consolidadas del expediente | Mostrar resultados DGDP, Finanzas Facultad, Decanato y Dirección de Finanzas. |
| **P08-B08** | Plantilla documental y generación de borrador | Cargar la base de texto desde BDD y asociar el acto administrativo al expediente. |
| **P08-B09** | Edición de textos normativos del acto administrativo | Editar VISTO, CONSIDERANDO, RESUELVO y otros bloques configurados. |
| **P08-B10** | Tabla documental de prestaciones y validaciones | Mostrar el detalle que será incorporado al documento generado. |
| **P08-B11** | Selección de firmantes del documento | Elegir mediante select a las autoridades firmantes. |
| **P08-B12** | Distribución editable del documento | Visualizar, agregar, editar y eliminar actores o destinatarios de distribución. |
| **P08-B13** | Guardado de borrador y persistencia de textos | Guardar el contenido documental sin enviar aún a firma. |
| **P08-B14** | Previsualización del decreto o resolución | Mostrar el documento generado antes de su despacho. |
| **P08-B15** | Decisiones globales de Decretación | Devolver con corrección, rechazar o enviar a firma. |
| **P08-B16** | Modal global de devolución/rechazo | Gestionar comentarios y confirmación para esas decisiones. |
| **P08-B17** | Confirmación, transición de estado y trazabilidad | Aplicar cambios de estado y registrar auditoría del proceso documental. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P08-B01 — Encabezado del expediente y estado de Decretación

## Funcionalidad P08-F01 — Visualizar identificación de la solicitud y del acto en preparación

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación de la solicitud que se encuentra en la etapa de Decretación y, cuando exista, el identificador documental asociado al acto administrativo en preparación.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

- Código único de solicitud PDS.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Estado documental:
  - Pendiente de formalización.
  - Borrador en edición.
  - Borrador guardado.
  - Preparado para firma.
- Identificador del acto administrativo, si ya fue asignado.
- Título de la etapa: Decretación y Formalización.

### D. Reglas de negocio

- El código de solicitud debe mantenerse inalterable.
- El identificador documental, cuando exista, debe asociarse de forma única al expediente.
- El estado documental debe reflejar la situación real del borrador.

> **TODO:** Definir en qué momento se asigna oficialmente el número de resolución/decreto:
> - Al ingresar a Decretación.
> - Al guardar el borrador.
> - Al enviar a firma.
> - En otra etapa posterior.

### E. Historia de usuario preliminar

**HU-P08-01:** Como **Decretación**, quiero visualizar la identificación del expediente y del acto administrativo en preparación, para formalizar correctamente la solicitud aprobada.

### F. Requerimientos funcionales preliminares

- **RF-PP08-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-PP08-002:** El sistema debe mostrar el estado documental de la resolución o decreto en preparación.
- **RF-PP08-003:** El sistema debe mostrar el identificador del acto administrativo cuando este exista.

---

## Funcionalidad P08-F02 — Visualizar estado de entrada a Decretación

### A. Descripción funcional

El sistema debe mostrar que la solicitud se encuentra habilitada para formalización documental por haber superado las etapas previas definidas.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

- Estado: **En Decretación / Formalización documental**.
- Fecha de ingreso a la etapa.
- Etapa anterior completada: Dirección de Finanzas.
- Estado general: **Aprobado previamente para formalización**.

### D. Reglas de negocio

- Solo deben ingresar a esta pantalla solicitudes aprobadas por Dirección de Finanzas.
- Mientras el expediente se encuentra en Decretación, sus datos fuente no deben ser editables por roles anteriores.

### E. Historia de usuario preliminar

**HU-P08-02:** Como **Decretación**, quiero visualizar que el expediente está habilitado para formalización, para trabajar únicamente con solicitudes ya aprobadas.

### F. Requerimientos funcionales preliminares

- **RF-PP08-004:** El sistema debe mostrar el estado actual del expediente en Decretación.
- **RF-PP08-005:** El sistema debe mostrar la fecha de ingreso a la etapa.
- **RF-PP08-006:** El sistema debe indicar que la solicitud fue aprobada previamente por Dirección de Finanzas.

---

# P08-B02 — Trazabilidad de etapas previas

## Funcionalidad P08-F03 — Visualizar trazabilidad completa del expediente

### A. Descripción funcional

El sistema debe mostrar el recorrido histórico de la solicitud desde su creación hasta su ingreso a Decretación.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

Por cada etapa:

- Etapa.
- Rol.
- Usuario responsable.
- Acción ejecutada.
- Fecha.
- Hora.
- Comentario asociado, si existe.
- Exclusiones individuales, si corresponde.

### D. Etapas mínimas a mostrar

- Creación y envío por Solicitante.
- Aprobación por Jefe de Proyecto.
- Aprobación por Jefatura Directa / Dirección de Departamento.
- Revisión y aprobación por DGDP.
- Exclusiones DGDP, si existieron.
- Revisión de Finanzas de Facultad.
- Aprobación de Decanato.
- Aprobación de Dirección de Finanzas.

### E. Historia de usuario preliminar

**HU-P08-03:** Como **Decretación**, quiero revisar la trazabilidad completa de la solicitud, para conocer el camino formal que respalda la generación del acto administrativo.

### F. Requerimientos funcionales preliminares

- **RF-PP08-007:** El sistema debe mostrar cronológicamente la trazabilidad de las etapas previas.
- **RF-PP08-008:** El sistema debe mostrar usuario, rol, fecha, hora, acción y comentario cuando corresponda.
- **RF-PP08-009:** El sistema debe mostrar las exclusiones de funcionarios registradas en DGDP como parte de la historia del expediente.

---

## Funcionalidad P08-F04 — Visualizar línea de avance del flujo

### A. Descripción funcional

El sistema debe mostrar visualmente el avance del expediente dentro del flujo PDS Normativo, destacando la etapa de Decretación y las etapas de firma posteriores.

### B. Actor principal

Decretación.

### C. Hitos mínimos a mostrar

- Solicitud.
- Jefe de Proyecto.
- Jefatura Directa / Dirección de Departamento.
- DGDP.
- Finanzas Facultad.
- Decanato.
- Dirección de Finanzas.
- Etapa actual: Decretación.
- Etapas siguientes: Firmantes legales / Secretaría General / flujo posterior definido.

### D. Historia de usuario preliminar

**HU-P08-04:** Como **Decretación**, quiero visualizar el avance del flujo, para ubicar la generación del acto administrativo dentro del proceso institucional completo.

### E. Requerimientos funcionales preliminares

- **RF-PP08-010:** El sistema debe mostrar una línea visual de avance del expediente.
- **RF-PP08-011:** El sistema debe diferenciar etapas cumplidas, etapa actual y etapas pendientes.

---

# P08-B03 — Resumen ejecutivo del expediente aprobado

## Funcionalidad P08-F05 — Visualizar resumen técnico-financiero del expediente a formalizar

### A. Descripción funcional

El sistema debe mostrar un resumen ejecutivo del expediente que será transformado en acto administrativo.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Nombre del proyecto.
- Unidad ejecutora.
- Jefe de Proyecto.
- Tipo de financiamiento.
- Decreto afecto.
- Vigencia de la resolución o periodo de ejecución.
- Prorrateo o cantidad de meses.
- Monto total de la asignación.
- Número de funcionarios vigentes.
- Número de funcionarios excluidos.
- Estado de aprobación previa.

### D. Reglas de negocio

- Los datos deben corresponder al expediente vigente aprobado antes de ingresar a Decretación.
- El monto total debe considerar únicamente funcionarios vigentes.

### E. Historia de usuario preliminar

**HU-P08-05:** Como **Decretación**, quiero visualizar un resumen técnico-financiero del expediente, para comprender rápidamente el contenido que será formalizado en la resolución.

### F. Requerimientos funcionales preliminares

- **RF-PP08-012:** El sistema debe mostrar los datos generales de la solicitud aprobada.
- **RF-PP08-013:** El sistema debe mostrar el monto total vigente que será formalizado.
- **RF-PP08-014:** El sistema debe mostrar la cantidad de funcionarios vigentes y excluidos.

---

# P08-B04 — Centro de Costo, financiamiento e ítems presupuestarios

## Funcionalidad P08-F06 — Visualizar información financiera y presupuestaria aprobada

### A. Descripción funcional

El sistema debe mostrar los antecedentes financieros ya validados del expediente, como información de soporte para la redacción del acto administrativo.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

- Código del Centro de Costo.
- Nombre del Centro de Costo.
- Proyecto asociado.
- Unidad ejecutora.
- Tipo de financiamiento.
- Decreto afecto.
- Saldo disponible general informado.
- Monto comprometido por la solicitud.
- Saldo proyectado, cuando exista.
- Tabla de ítems presupuestarios.

### D. Tabla de ítems presupuestarios

La tabla debe mostrar:

- Ítem presupuestario.
- Cargo, estamento o categoría asociada.
- Presupuesto asignado.
- Monto comprometido.
- Monto vigente de la solicitud.
- Saldo proyectado.
- Estado de suficiencia presupuestaria.

### E. Reglas de negocio

- Esta información es de solo lectura.
- Decretación no debe recalcular ni modificar saldos.
- Los datos deben provenir del expediente ya validado financieramente.

### F. Historia de usuario preliminar

**HU-P08-06:** Como **Decretación**, quiero visualizar los datos financieros y presupuestarios aprobados, para sustentar correctamente el contenido del acto administrativo.

### G. Requerimientos funcionales preliminares

- **RF-PP08-015:** El sistema debe mostrar la información financiera aprobada del Centro de Costo.
- **RF-PP08-016:** El sistema debe mostrar la tabla de ítems presupuestarios asociados al expediente.
- **RF-PP08-017:** La tabla debe mostrar presupuesto asignado, monto comprometido, monto vigente de la solicitud, saldo proyectado y estado.
- **RF-PP08-018:** El sistema no debe permitir editar los datos presupuestarios desde esta pantalla.

---

# P08-B05 — Nómina de funcionarios vigentes incorporables a la resolución

## Funcionalidad P08-F07 — Visualizar funcionarios que integrarán el acto administrativo

### A. Descripción funcional

El sistema debe mostrar la nómina de funcionarios vigentes y aprobados que serán incorporados en la resolución/decreto.

### B. Actor principal

Decretación.

### C. Datos resumidos por funcionario

- RUT.
- Nombre completo.
- Estamento.
- Cargo o jerarquía.
- Grado.
- Jornada.
- Contrato seleccionado.
- Monto bruto.
- Monto líquido estimado, cuando exista.
- Total comprometido.
- Estado DGDP.
- Estado Finanzas Facultad.
- Estado Decanato.
- Estado Dirección de Finanzas.

### D. Reglas de negocio

- Solo deben aparecer en esta sección los funcionarios vigentes.
- Estos funcionarios son la base de la tabla que se incorporará al acto administrativo.

### E. Historia de usuario preliminar

**HU-P08-07:** Como **Decretación**, quiero visualizar a los funcionarios vigentes que serán incorporados en la resolución, para confirmar la nómina formal del acto administrativo.

### F. Requerimientos funcionales preliminares

- **RF-PP08-019:** El sistema debe mostrar la nómina de funcionarios vigentes del expediente.
- **RF-PP08-020:** El sistema debe mostrar sus datos identificatorios, laborales y financieros esenciales.
- **RF-PP08-021:** El sistema debe incluir únicamente funcionarios habilitados para formalización.

---

# P08-B06 — Personal excluido del acto administrativo

## Funcionalidad P08-F08 — Visualizar personal excluido que no figurará en la resolución

### A. Descripción funcional

El sistema debe mostrar de forma diferenciada a los funcionarios excluidos en etapas anteriores, indicando que no formarán parte del acto administrativo que se está generando.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

- RUT.
- Nombre completo.
- Estamento.
- Motivo resumido de exclusión.
- Etapa de exclusión.
- Comentario asociado, si existe.
- Monto excluido del total vigente, cuando corresponda.

### D. Reglas de negocio

- Los funcionarios excluidos deben permanecer visibles como antecedente.
- Los funcionarios excluidos no deben incorporarse en la tabla documental final.
- Los funcionarios excluidos no deben figurar en la resolución generada.

### E. Historia de usuario preliminar

**HU-P08-08:** Como **Decretación**, quiero visualizar a los funcionarios excluidos en etapas previas, para confirmar que no serán incorporados en el acto administrativo final.

### F. Requerimientos funcionales preliminares

- **RF-PP08-022:** El sistema debe mostrar los funcionarios excluidos previamente.
- **RF-PP08-023:** El sistema debe mostrar el motivo de exclusión registrado.
- **RF-PP08-024:** El sistema debe impedir que los funcionarios excluidos se incorporen al documento final.
- **RF-PP08-025:** Si no existen funcionarios excluidos, el sistema debe mostrar un mensaje informativo que lo indique.

---

# P08-B07 — Validaciones consolidadas del expediente

## Funcionalidad P08-F09 — Visualizar checks o estados consolidados de validación previa

### A. Descripción funcional

El sistema debe mostrar de forma resumida que el expediente superó las revisiones previas necesarias para llegar a Decretación.

### B. Actor principal

Decretación.

### C. Validaciones a mostrar

- DGDP.
- Finanzas de Facultad.
- Decanato.
- Dirección de Finanzas.

### D. Datos que debe mostrar el sistema

- Estado de cada etapa:
  - Aprobado.
  - Aprobado con exclusiones previas, si corresponde.
  - Observado, si el expediente hubiese retornado antes.
- Fecha de aprobación.
- Comentario resumido, si existe.

### E. Reglas de negocio

- Esta sección es informativa.
- No permite editar ni alterar decisiones previas.

### F. Historia de usuario preliminar

**HU-P08-09:** Como **Decretación**, quiero visualizar las validaciones previas consolidadas, para confirmar que el expediente está habilitado para formalización documental.

### G. Requerimientos funcionales preliminares

- **RF-PP08-026:** El sistema debe mostrar los estados consolidados de las revisiones previas.
- **RF-PP08-027:** El sistema debe diferenciar las etapas aprobadas y registrar si existieron exclusiones.
- **RF-PP08-028:** El sistema no debe permitir modificar estas validaciones desde Decretación.

---

# P08-B08 — Plantilla documental y generación de borrador

## Funcionalidad P08-F10 — Cargar plantilla base de resolución o decreto desde BDD

### A. Descripción funcional

El sistema debe cargar una estructura documental base desde la base de datos para iniciar la generación del acto administrativo.

### B. Actor principal

Decretación / Sistema.

### C. Datos de origen

- Tipo de acto administrativo.
- Flujo PDS Normativo.
- Plantilla vigente almacenada.
- Secciones documentales predefinidas.

### D. Resultado esperado

- Creación de un borrador documental inicial.
- Carga de textos base en los editores.
- Asociación del borrador al expediente.

### E. Reglas de negocio

- La plantilla debe recuperarse desde BDD.
- El borrador debe quedar asociado a la solicitud PDS.
- La edición posterior no debe alterar la plantilla maestra, salvo que exista una funcionalidad administrativa distinta.

> **TODO:** Definir si Decretación puede actualizar plantillas maestras o si solo guarda textos del documento específico.

### F. Historia de usuario preliminar

**HU-P08-10:** Como **Decretación**, quiero cargar una plantilla documental base desde la BDD, para iniciar la generación de la resolución con textos institucionales predefinidos.

### G. Requerimientos funcionales preliminares

- **RF-PP08-029:** El sistema debe recuperar una plantilla base desde la base de datos.
- **RF-PP08-030:** El sistema debe cargar los textos iniciales en los editores documentales.
- **RF-PP08-031:** El sistema debe asociar el borrador documental al expediente PDS correspondiente.

---

## Funcionalidad P08-F11 — Generar borrador del acto administrativo

### A. Descripción funcional

El sistema debe crear o inicializar el documento administrativo que formaliza la solicitud aprobada.

### B. Actor principal

Decretación / Sistema.

### C. Datos utilizados

- Solicitud aprobada.
- Funcionarios vigentes.
- Información del proyecto.
- Datos presupuestarios.
- Plantilla base.
- Firmantes seleccionados, cuando existan.
- Distribución definida, cuando exista.

### D. Reglas de negocio

- El borrador debe mantener coherencia con el expediente vigente.
- Si se regeneran textos desde plantilla, el sistema debe evitar sobrescribir cambios previos sin advertencia.

### E. Historia de usuario preliminar

**HU-P08-11:** Como **Decretación**, quiero generar un borrador del acto administrativo, para preparar el documento que será enviado al circuito de firma.

### F. Requerimientos funcionales preliminares

- **RF-PP08-032:** El sistema debe permitir generar un borrador documental asociado a la solicitud.
- **RF-PP08-033:** El borrador debe contener la estructura base definida para el tipo de resolución.
- **RF-PP08-034:** El sistema debe mantener consistencia entre el borrador y los datos vigentes del expediente.

---

# P08-B09 — Edición de textos normativos del acto administrativo

## Funcionalidad P08-F12 — Editar sección VISTO

### A. Descripción funcional

El sistema debe permitir editar el texto correspondiente a la sección **VISTO**, utilizando un editor de texto enriquecido.

### B. Actor principal

Decretación.

### C. Características del editor

- Texto pre-cargado desde plantilla.
- Edición de contenido.
- Formato básico:
  - Negrita.
  - Cursiva.
  - Listas.
  - Otros formatos habilitados.

### D. Historia de usuario preliminar

**HU-P08-12:** Como **Decretación**, quiero editar la sección VISTO, para adecuar los antecedentes legales del acto administrativo a la solicitud específica.

### E. Requerimientos funcionales preliminares

- **RF-PP08-035:** El sistema debe mostrar el texto base de la sección VISTO.
- **RF-PP08-036:** El sistema debe permitir editar el contenido de la sección VISTO.
- **RF-PP08-037:** El sistema debe permitir aplicar formato básico dentro del editor.

---

## Funcionalidad P08-F13 — Editar uno o más bloques de CONSIDERANDO

### A. Descripción funcional

El sistema debe permitir editar los **CONSIDERANDOS** que justifican la resolución, pudiendo existir uno o más bloques textuales según la plantilla documental.

### B. Actor principal

Decretación.

### C. Datos o acciones posibles

- Modificar el texto de cada considerando.
- Visualizar orden o numeración.
- Agregar nuevos considerandos, si el diseño documental lo permite.
- Eliminar considerandos, si el diseño documental lo permite.
- Reordenar considerandos, si se define esta funcionalidad.

### D. Reglas de negocio

- La existencia de considerandos mínimos puede depender de la plantilla.
- Los cambios deben guardarse como parte del borrador.

### E. Historia de usuario preliminar

**HU-P08-13:** Como **Decretación**, quiero editar los considerandos del acto administrativo, para justificar correctamente la resolución según el expediente aprobado.

### F. Requerimientos funcionales preliminares

- **RF-PP08-038:** El sistema debe mostrar los considerandos cargados desde la plantilla.
- **RF-PP08-039:** El sistema debe permitir editar el texto de cada considerando.
- **RF-PP08-040:** El sistema debe permitir gestionar bloques de considerandos cuando la plantilla lo habilite.

---

## Funcionalidad P08-F14 — Editar sección RESUELVO / DISPÓNESE

### A. Descripción funcional

El sistema debe permitir editar el contenido de la sección resolutiva del acto administrativo.

### B. Actor principal

Decretación.

### C. Datos que puede contener

- Disposición de pago o asignación.
- Referencia a funcionarios incluidos.
- Referencia a monto, periodo o condiciones.
- Otras fórmulas institucionales de cierre.

### D. Historia de usuario preliminar

**HU-P08-14:** Como **Decretación**, quiero editar la sección RESUELVO o DISPÓNESE, para definir correctamente el contenido formal de la resolución que será firmada.

### E. Requerimientos funcionales preliminares

- **RF-PP08-041:** El sistema debe mostrar el texto base de la sección RESUELVO / DISPÓNESE.
- **RF-PP08-042:** El sistema debe permitir editar el contenido de dicha sección.
- **RF-PP08-043:** El sistema debe guardar los cambios realizados en la sección resolutiva.

---

## Funcionalidad P08-F15 — Editar otros textos documentales configurados por plantilla

### A. Descripción funcional

El sistema debe permitir editar otros bloques del acto administrativo que formen parte de la plantilla, tales como:

- Fórmula de cierre.
- “Anótese y comuníquese”.
- Encabezados o párrafos complementarios.
- Secciones adicionales que se definan para la resolución.

### B. Actor principal

Decretación.

### C. Reglas de negocio

- Solo deben mostrarse bloques definidos por la plantilla aplicable.
- Los bloques editables deben poder guardarse dentro del borrador.

### D. Historia de usuario preliminar

**HU-P08-15:** Como **Decretación**, quiero editar los demás textos configurados en la plantilla, para completar formalmente el documento que será generado.

### E. Requerimientos funcionales preliminares

- **RF-PP08-044:** El sistema debe mostrar los textos complementarios configurados en la plantilla.
- **RF-PP08-045:** El sistema debe permitir editarlos.
- **RF-PP08-046:** El sistema debe persistir estos cambios en el borrador del acto administrativo.

---

# P08-B10 — Tabla documental de prestaciones y validaciones

## Funcionalidad P08-F16 — Visualizar tabla de prestaciones que será incorporada al documento

### A. Descripción funcional

El sistema debe generar y mostrar una tabla documental entre los textos del acto administrativo y la sección de firmantes, incorporando los datos detallados de las prestaciones aprobadas y sus validaciones correspondientes.

### B. Actor principal

Decretación / Sistema.

### C. Datos mínimos de la tabla

Por cada funcionario vigente:

- RUT.
- Nombre completo.
- Estamento.
- Cargo o jerarquía.
- Grado.
- Tipo de vinculación.
- Jornada.
- Contrato seleccionado.
- Prestación.
- Actividad específica.
- Periodo de ejecución.
- Meses de pago.
- Monto bruto mensual.
- Monto líquido estimado, cuando exista.
- Total comprometido.
- Centro de Costo.
- Ítem presupuestario.
- Total en jornada.
- Total fuera de jornada.
- Total compensación horaria.
- Estado DGDP.
- Estado de Finanzas de Facultad.
- Estado Decanato.
- Estado Dirección de Finanzas.
- Estado de suficiencia presupuestaria.
- Otras validaciones relevantes resumidas, cuando corresponda.

### D. Reglas de negocio

- La tabla debe incluir solo funcionarios vigentes.
- La tabla debe excluir automáticamente a funcionarios retirados en DGDP.
- La tabla debe construirse a partir de datos aprobados en el expediente, no desde edición manual libre.
- La tabla debe formar parte del documento previsualizado y enviado a firma.

### E. Historia de usuario preliminar

**HU-P08-16:** Como **Decretación**, quiero visualizar la tabla de prestaciones y validaciones que se incorporará a la resolución, para verificar que el documento formaliza correctamente la información aprobada.

### F. Requerimientos funcionales preliminares

- **RF-PP08-047:** El sistema debe generar una tabla documental con las prestaciones vigentes del expediente.
- **RF-PP08-048:** La tabla debe incluir datos identificatorios, laborales, financieros y normativos de cada prestación.
- **RF-PP08-049:** La tabla debe excluir a funcionarios previamente rechazados o excluidos.
- **RF-PP08-050:** La tabla debe formar parte de la previsualización y del documento enviado a firma.

---

# P08-B11 — Selección de firmantes del documento

## Funcionalidad P08-F17 — Seleccionar autoridades firmantes mediante listas desplegables

### A. Descripción funcional

El sistema debe permitir que Decretación seleccione las personas que firmarán el acto administrativo mediante controles tipo **select**, asociados a roles firmantes predefinidos.

### B. Actor principal

Decretación.

### C. Firmantes mínimos esperados

- Vicerrector/a de Administración y Finanzas.
- Secretario/a General.

### D. Datos que debe mostrar o registrar el sistema

- Rol firmante.
- Persona seleccionada.
- Cargo institucional.
- Estado de selección:
  - Pendiente.
  - Seleccionado.
- Vigencia o disponibilidad del firmante, si la fuente lo permite.

### E. Reglas de negocio

- El sistema debe impedir el envío a firma si faltan firmantes obligatorios.
- La persona seleccionada debe quedar asociada al documento generado.
- La selección de firmantes debe quedar registrada en trazabilidad.

> **TODO:** Confirmar si existirán otros roles firmantes configurables desde esta pantalla.

### F. Historia de usuario preliminar

**HU-P08-17:** Como **Decretación**, quiero seleccionar a las autoridades firmantes desde listas desplegables, para generar la resolución con los nombres correctos y enviarla al circuito de firma adecuado.

### G. Requerimientos funcionales preliminares

- **RF-PP08-051:** El sistema debe mostrar listas desplegables para seleccionar firmantes.
- **RF-PP08-052:** El sistema debe registrar la persona seleccionada para cada rol firmante.
- **RF-PP08-053:** El sistema debe impedir enviar a firma si no se han seleccionado los firmantes obligatorios.
- **RF-PP08-054:** El sistema debe incorporar los firmantes seleccionados en el documento previsualizado y enviado.

---

# P08-B12 — Distribución editable del documento

## Funcionalidad P08-F18 — Visualizar distribución base del documento

### A. Descripción funcional

El sistema debe mostrar una lista de distribución asociada al expediente y al acto administrativo, considerando la historia del flujo y/o los destinatarios definidos para la circulación posterior del documento.

### B. Actor principal

Decretación.

### C. Datos que debe mostrar el sistema

Por cada registro de distribución:

- Nombre de la persona, unidad o rol.
- Acción o estado asociado.
- Orden o posición, si corresponde.
- Condición:
  - Originado por historial previo.
  - Agregado manualmente por Decretación.
- Fecha o referencia, si aplica.

### D. Historia de usuario preliminar

**HU-P08-18:** Como **Decretación**, quiero visualizar la distribución base del documento, para confirmar por dónde ha pasado o debe circular el expediente formalizado.

### E. Requerimientos funcionales preliminares

- **RF-PP08-055:** El sistema debe mostrar la distribución inicial asociada al expediente.
- **RF-PP08-056:** El sistema debe distinguir registros provenientes del historial y registros agregados manualmente.

---

## Funcionalidad P08-F19 — Agregar, editar y eliminar registros de distribución

### A. Descripción funcional

El sistema debe permitir que Decretación gestione la distribución del documento, incorporando nuevos actores o modificando la lista existente cuando el proceso documental lo requiera.

### B. Actor principal

Decretación.

### C. Acciones disponibles

- Añadir registro de distribución.
- Editar registro existente.
- Eliminar registro permitido.
- Confirmar cambios.

### D. Reglas de negocio

- Los cambios en distribución deben guardarse como parte del borrador.
- La distribución final debe reflejarse en la versión previsualizada del documento cuando corresponda.
- Los registros obligatorios definidos por el sistema no deben eliminarse si la regla institucional así lo establece.

> **TODO:** Definir qué registros de distribución son obligatorios y cuáles pueden ser eliminados.

### E. Historia de usuario preliminar

**HU-P08-19:** Como **Decretación**, quiero agregar, editar o eliminar registros de distribución, para ajustar el circuito documental del acto administrativo antes de su envío.

### F. Requerimientos funcionales preliminares

- **RF-PP08-057:** El sistema debe permitir agregar registros de distribución.
- **RF-PP08-058:** El sistema debe permitir editar registros de distribución existentes.
- **RF-PP08-059:** El sistema debe permitir eliminar registros de distribución cuando sea procedente.
- **RF-PP08-060:** El sistema debe guardar los cambios realizados en la distribución.
- **RF-PP08-061:** El sistema debe reflejar la distribución guardada en la previsualización del documento cuando corresponda.

---

# P08-B13 — Guardado de borrador y persistencia de textos

## Funcionalidad P08-F20 — Guardar borrador documental

### A. Descripción funcional

El sistema debe permitir guardar el estado actual del acto administrativo sin enviarlo aún al circuito de firma.

### B. Actor principal

Decretación.

### C. Elementos que deben guardarse

- Textos editados de:
  - VISTO.
  - CONSIDERANDO.
  - RESUELVO.
  - Otros bloques.
- Firmantes seleccionados.
- Distribución modificada.
- Identificador documental, si existe.
- Estado del borrador.
- Fecha y usuario de última modificación.

### D. Reglas de negocio

- Guardar borrador no debe derivar el expediente a la etapa siguiente.
- El documento debe poder recuperarse posteriormente con los cambios guardados.
- El sistema debe advertir si se intenta salir o enviar sin guardar cambios críticos, si esta funcionalidad se incorpora.

### E. Historia de usuario preliminar

**HU-P08-20:** Como **Decretación**, quiero guardar el borrador del acto administrativo, para continuar trabajando en él sin perder las modificaciones realizadas.

### F. Requerimientos funcionales preliminares

- **RF-PP08-062:** El sistema debe permitir guardar el borrador documental.
- **RF-PP08-063:** El sistema debe persistir textos, firmantes y distribución configurada.
- **RF-PP08-064:** El sistema debe permitir recuperar posteriormente el borrador guardado.
- **RF-PP08-065:** Guardar borrador no debe cambiar el estado del flujo hacia firma.

---

# P08-B14 — Previsualización del decreto o resolución

## Funcionalidad P08-F21 — Previsualizar documento generado antes del envío

### A. Descripción funcional

El sistema debe permitir previsualizar el acto administrativo generado con la información actual del expediente y las ediciones realizadas por Decretación.

### B. Actor principal

Decretación.

### C. La previsualización debe incluir

- Encabezado documental.
- Identificador del expediente.
- VISTO.
- CONSIDERANDO.
- RESUELVO / DISPÓNESE.
- Tabla documental de prestaciones y validaciones.
- Firmantes seleccionados.
- Distribución definida.
- Cierre documental.

### D. Reglas de negocio

- La previsualización debe utilizar el contenido vigente del borrador.
- Si faltan datos obligatorios, el sistema debe advertirlo.
- La previsualización no debe enviar el documento a firma por sí sola.

### E. Historia de usuario preliminar

**HU-P08-21:** Como **Decretación**, quiero previsualizar el acto administrativo completo, para revisar su contenido antes de enviarlo al circuito de firma.

### F. Requerimientos funcionales preliminares

- **RF-PP08-066:** El sistema debe permitir previsualizar el documento generado.
- **RF-PP08-067:** La previsualización debe incorporar textos, tabla documental, firmantes y distribución.
- **RF-PP08-068:** La previsualización debe advertir si existen datos documentales obligatorios pendientes.

---

# P08-B15 — Decisiones globales de Decretación

## Funcionalidad P08-F22 — Enviar documento a firma

### A. Descripción funcional

Decretación debe poder enviar el acto administrativo generado al circuito de firma cuando se encuentre completo.

### B. Actor principal

Decretación.

### C. Acción disponible

- Botón: **ENVIAR A FIRMA**.

### D. Validaciones previas mínimas

- Documento generado.
- Textos documentales requeridos completos.
- Tabla documental generada.
- Firmantes obligatorios seleccionados.
- Distribución definida según reglas.
- Borrador guardado o contenido vigente confirmado.
- Expediente aprobado previamente.

### E. Reglas de negocio

- El envío debe derivar el expediente a la etapa de firma siguiente.
- El envío debe registrar usuario, fecha y hora.
- El documento enviado debe congelar o versionar el contenido remitido a firma.

> **TODO:** Confirmar si la primera etapa de firma corresponde directamente a Secretaría General o a otro firmante previo dentro del circuito legal.

### F. Historia de usuario preliminar

**HU-P08-22:** Como **Decretación**, quiero enviar el acto administrativo al circuito de firma cuando esté completo, para continuar con su formalización institucional.

### G. Requerimientos funcionales preliminares

- **RF-PP08-069:** El sistema debe permitir enviar a firma el documento generado.
- **RF-PP08-070:** El sistema debe validar que el documento esté completo antes de enviarlo.
- **RF-PP08-071:** El sistema debe impedir el envío si faltan firmantes obligatorios, textos requeridos o tabla documental.
- **RF-PP08-072:** El sistema debe derivar el expediente a la siguiente etapa de firma.
- **RF-PP08-073:** El sistema debe registrar la versión documental enviada a firma.

---

## Funcionalidad P08-F23 — Devolver con corrección

### A. Descripción funcional

Decretación debe poder devolver el expediente cuando detecte observaciones que deban ser corregidas antes de continuar con la formalización.

### B. Actor principal

Decretación.

### C. Acción disponible

- Botón: **DEVOLVER CON CORRECCIÓN**.

### D. Datos de entrada requeridos

- Motivo de devolución.
- Comentario obligatorio.

### E. Reglas de negocio

- La devolución debe registrar trazabilidad.
- El expediente debe quedar en estado de corrección.
- El comentario debe quedar visible para el destinatario del retorno.

> **TODO:** Definir la etapa exacta a la que vuelve la solicitud desde Decretación:
> - Solicitante.
> - Dirección de Finanzas.
> - Otra etapa correctiva.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Decretación), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P08-23:** Como **Decretación**, quiero devolver con corrección el expediente cuando detecte observaciones subsanables, para evitar enviar a firma un documento inconsistente.

### G. Requerimientos funcionales preliminares

- **RF-PP08-074:** El sistema debe permitir devolver con corrección el expediente.
- **RF-PP08-075:** El sistema debe exigir motivo y comentario obligatorio.
- **RF-PP08-076:** El sistema debe registrar la devolución en trazabilidad.
- **RF-PP08-077:** El sistema debe cambiar el estado del expediente según la ruta de devolución definida.
* **RF-PP08-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de legalidad o de redacción del acto administrativo y comentarios correspondientes.
* **RF-PP08-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P08-F24 — Rechazar solicitud

### A. Descripción funcional

Decretación debe poder rechazar la solicitud cuando se determine que no corresponde generar o continuar con el acto administrativo.

### B. Actor principal

Decretación.

### C. Acción disponible

- Botón: **RECHAZAR SOLICITUD**.

### D. Datos de entrada requeridos

- Motivo de rechazo.
- Comentario obligatorio.

### E. Reglas de negocio

- La solicitud rechazada no debe avanzar a firma.
- El rechazo debe quedar registrado con fecha, usuario y comentario.
- El borrador documental asociado debe mantenerse como antecedente, si ya existía.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Decretación), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones de legalidad o de redacción del acto administrativo), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P08-24:** Como **Decretación**, quiero rechazar la solicitud cuando no corresponda su formalización, para cerrar el proceso con trazabilidad del motivo.

### G. Requerimientos funcionales preliminares

- **RF-PP08-078:** El sistema debe permitir rechazar la solicitud desde Decretación.
- **RF-PP08-079:** El sistema debe exigir motivo y comentario obligatorio para rechazar.
- **RF-PP08-080:** El sistema debe impedir que una solicitud rechazada continúe al flujo de firma.
- **RF-PP08-081:** El sistema debe registrar la decisión de rechazo.
* **RF-PP08-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P08-B16 — Modal global de devolución/rechazo

## Funcionalidad P08-F25 — Gestionar devolución y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un modal global único para las acciones de devolución y rechazo, permitiendo capturar motivo, comentario y confirmación.

### B. Actor principal

Decretación.

### C. Información del modal

- Acción seleccionada:
  - Devolver con corrección.
  - Rechazar solicitud.
- Motivo.
- Comentario obligatorio.
- Advertencia del impacto.
- Confirmar.
- Cancelar.

### D. Reglas de negocio

- No debe permitir confirmar sin comentario obligatorio.
- Debe permitir cancelar sin modificar el estado.
- La acción confirmada debe quedar trazada.

### E. Historia de usuario preliminar

**HU-P08-25:** Como **Decretación**, quiero gestionar devolución o rechazo desde un modal único, para registrar claramente la causa antes de modificar el estado del expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP08-082:** El sistema debe utilizar un modal global único para devolución y rechazo.
- **RF-PP08-083:** El sistema debe exigir comentario obligatorio dentro del modal.
- **RF-PP08-084:** El sistema debe permitir cancelar la acción sin cambiar el estado.
- **RF-PP08-085:** El sistema debe registrar la acción confirmada en trazabilidad.

---

# P08-B17 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P08-F26 — Confirmar envío a firma

### A. Descripción funcional

Antes de enviar el documento al circuito de firma, el sistema debe solicitar confirmación explícita a Decretación.

### B. Actor principal

Decretación.

### C. Mensaje mínimo de confirmación

- Se enviará el documento a firma.
- Se utilizará la versión actual del borrador.
- Los firmantes seleccionados quedarán asociados.
- La distribución definida será la vigente.

### D. Reglas de negocio

- Debe permitir cancelar sin enviar.
- Debe validar las condiciones previas antes de confirmar.
*   **Registro de Envío**: El sistema debe dejar registro del envío del correo electrónico en la trazabilidad del expediente.

### E. Historia de usuario preliminar

**HU-P08-26:** Como **Decretación**, quiero confirmar el envío a firma antes de ejecutarlo, para evitar despachar por error un acto administrativo incompleto.

### F. Requerimientos funcionales preliminares

- **RF-PP08-086:** El sistema debe solicitar confirmación antes de enviar a firma.
- **RF-PP08-087:** El sistema debe permitir cancelar el envío.
- **RF-PP08-088:** El sistema debe ejecutar las validaciones documentales antes de permitir la confirmación.
* **RF-PP08-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

## Funcionalidad P08-F27 — Registrar trazabilidad documental de la etapa Decretación

### A. Descripción funcional

El sistema debe registrar de forma auditable todas las acciones relevantes ejecutadas durante la formalización documental.

### B. Actor principal

Sistema.

### C. Eventos a registrar

- Carga de plantilla base.
- Generación del borrador.
- Guardado de textos.
- Modificación de secciones.
- Selección de firmantes.
- Modificación de distribución.
- Guardado de borrador.
- Previsualización, si se decide registrar.
- Devolución con corrección.
- Rechazo.
- Envío a firma.

### D. Datos mínimos de trazabilidad

- Código de solicitud.
- Identificador documental, si existe.
- Usuario.
- Rol.
- Acción ejecutada.
- Fecha y hora.
- Estado anterior.
- Estado posterior.
- Comentario, cuando corresponda.
- Versión del documento, cuando corresponda.

### E. Historia de usuario preliminar

**HU-P08-27:** Como **sistema**, debo registrar las acciones de formalización realizadas por Decretación, para mantener trazabilidad completa del acto administrativo generado.

### F. Requerimientos funcionales preliminares

- **RF-PP08-089:** El sistema debe registrar las acciones documentales relevantes de Decretación.
- **RF-PP08-090:** El sistema debe registrar usuario, fecha, hora y estado asociado.
- **RF-PP08-091:** El sistema debe conservar la versión documental enviada a firma.
- **RF-PP08-092:** El sistema debe mantener trazabilidad de firmantes y distribución seleccionados.

---

# 7. Estados de salida de la Pantalla 08

| Acción de Decretación | Estado resultante del expediente | Destino |
|---|---|---|
| Guardar borrador | Borrador documental guardado | Permanece en Decretación |
| Devolver con corrección | Devuelta con corrección por Decretación | Ruta de retorno por definir |
| Rechazar solicitud | Rechazada por Decretación | Cierre definitivo del expediente |
| Enviar a firma | Documento formalizado y enviado a firma | Etapa siguiente del circuito legal |

---

# 8. Estados documentales posibles del acto administrativo

| Estado | Descripción |
|---|---|
| **Pendiente de formalización** | La solicitud ingresó a Decretación, pero aún no tiene borrador documental iniciado. |
| **Borrador en edición** | La plantilla fue cargada y los textos pueden estar siendo modificados. |
| **Borrador guardado** | El contenido documental fue persistido y puede recuperarse. |
| **Preparado para firma** | El documento tiene textos, tabla, firmantes y distribución completos. |
| **Enviado a firma** | La versión documental fue remitida al circuito de firmantes legales. |
| **Devuelto con corrección** | La etapa de Decretación devolvió el expediente por observaciones. |
| **Rechazado** | La solicitud fue cerrada desde Decretación y no continúa al flujo de firma. |

---

# 9. Reglas globales de comportamiento de la Pantalla 08

| Código | Regla |
|---|---|
| **RG-P08-001** | Decretación debe trabajar sobre expedientes previamente aprobados por Dirección de Finanzas. |
| **RG-P08-002** | La pantalla debe visualizar la trazabilidad completa del expediente antes de generar el acto administrativo. |
| **RG-P08-003** | Los datos técnicos, normativos y financieros del expediente deben mostrarse en modo solo lectura. |
| **RG-P08-004** | La resolución debe construirse a partir de una plantilla base recuperada desde BDD. |
| **RG-P08-005** | Los textos VISTO, CONSIDERANDO, RESUELVO y demás bloques habilitados deben ser editables desde la pantalla. |
| **RG-P08-006** | Los textos editados deben poder guardarse como parte del borrador documental. |
| **RG-P08-007** | El borrador documental debe quedar asociado al expediente PDS correspondiente. |
| **RG-P08-008** | La tabla documental debe incluir solo funcionarios vigentes y aprobados. |
| **RG-P08-009** | Los funcionarios excluidos deben mantenerse visibles en pantalla, pero no deben incorporarse al documento final. |
| **RG-P08-010** | La tabla documental debe mostrar los datos relevantes de la prestación y las validaciones correspondientes. |
| **RG-P08-011** | Los firmantes deben seleccionarse mediante listas desplegables configuradas por rol. |
| **RG-P08-012** | No se debe permitir enviar a firma si faltan firmantes obligatorios. |
| **RG-P08-013** | La distribución del documento debe poder visualizarse y editarse por Decretación. |
| **RG-P08-014** | Los cambios en distribución deben guardarse junto al borrador documental. |
| **RG-P08-015** | La previsualización debe reflejar la versión vigente del documento preparado. |
| **RG-P08-016** | El envío a firma debe ejecutarse mediante una acción explícita y confirmada. |
| **RG-P08-017** | La devolución con corrección debe exigir motivo y comentario obligatorio. |
| **RG-P08-018** | El rechazo de solicitud debe exigir motivo y comentario obligatorio. |
| **RG-P08-019** | La devolución y el rechazo deben gestionarse mediante un modal global único. |
| **RG-P08-020** | Toda acción relevante de formalización documental debe quedar registrada en trazabilidad. |
| **RG-P08-021** | La pantalla no debe permitir modificar datos de la solicitud que fueron aprobados en etapas previas. |
| **RG-P08-022** | La pantalla no debe incorporar nuevamente a funcionarios excluidos por DGDP. |
| **RG-P08-023** | La pantalla no debe ejecutar firmas legales; solo prepara y envía el documento al circuito de firma. |
| **RG-P08-024** | La numeración oficial de la resolución/decreto queda pendiente de definición operativa si aún no se ha establecido en el flujo. |
| **RG-PP08-025** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 08

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P08-001** | Legibilidad documental | La pantalla debe permitir revisar el expediente y editar el documento sin perder claridad entre datos fuente y textos redactados. |
| **RNF-P08-002** | Persistencia de borradores | Los textos y configuraciones del documento deben poder guardarse y recuperarse. |
| **RNF-P08-003** | Integridad del expediente | La edición documental no debe alterar los datos aprobados de la solicitud. |
| **RNF-P08-004** | Trazabilidad | Todas las acciones relevantes de generación, edición y despacho deben quedar registradas. |
| **RNF-P08-005** | Coherencia documental | La previsualización y el documento enviado deben corresponder al estado vigente del borrador. |
| **RNF-P08-006** | Separación de roles | Decretación prepara el documento, pero no ejecuta las firmas legales posteriores. |
| **RNF-P08-007** | Seguridad por rol | Solo usuarios autorizados de Decretación deben acceder a esta pantalla y modificar textos del acto. |
| **RNF-P08-008** | Control de datos obligatorios | El sistema debe impedir enviar a firma si faltan firmantes, textos mínimos o tabla documental. |
| **RNF-P08-009** | Organización visual | Los textos, tabla documental, firmantes y distribución deben presentarse en una secuencia clara y coherente con la estructura del documento. |
| **RNF-P08-010** | Consistencia de firmantes | La selección de autoridades firmantes debe reflejarse de forma consistente en la previsualización y en el documento enviado. |
| **RNF-P08-011** | Gestión editable de distribución | La lista de distribución debe permitir agregación, edición y eliminación controlada. |
| **RNF-P08-012** | Control de versiones | El sistema debe preservar la versión del documento enviada a firma. |
| **RNF-P08-013** | Recuperabilidad | Un borrador guardado debe reabrirse con textos, firmantes y distribución previamente registrados. |
| **RNF-P08-014** | Continuidad visual | La pantalla debe conservar coherencia gráfica y estructural con las vistas P05, P06 y P07, incorporando además el módulo de edición documental. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 08

| Código | Funcionalidad |
|---|---|
| **P08-F01** | Visualizar identificación de la solicitud y del acto en preparación. |
| **P08-F02** | Visualizar estado de entrada a Decretación. |
| **P08-F03** | Visualizar trazabilidad completa del expediente. |
| **P08-F04** | Visualizar línea de avance del flujo. |
| **P08-F05** | Visualizar resumen técnico-financiero del expediente a formalizar. |
| **P08-F06** | Visualizar información financiera y presupuestaria aprobada. |
| **P08-F07** | Visualizar funcionarios que integrarán el acto administrativo. |
| **P08-F08** | Visualizar personal excluido que no figurará en la resolución. |
| **P08-F09** | Visualizar checks o estados consolidados de validación previa. |
| **P08-F10** | Cargar plantilla base de resolución o decreto desde BDD. |
| **P08-F11** | Generar borrador del acto administrativo. |
| **P08-F12** | Editar sección VISTO. |
| **P08-F13** | Editar uno o más bloques de CONSIDERANDO. |
| **P08-F14** | Editar sección RESUELVO / DISPÓNESE. |
| **P08-F15** | Editar otros textos documentales configurados por plantilla. |
| **P08-F16** | Visualizar tabla de prestaciones que será incorporada al documento. |
| **P08-F17** | Seleccionar autoridades firmantes mediante listas desplegables. |
| **P08-F18** | Visualizar distribución base del documento. |
| **P08-F19** | Agregar, editar y eliminar registros de distribución. |
| **P08-F20** | Guardar borrador documental. |
| **P08-F21** | Previsualizar documento generado antes del envío. |
| **P08-F22** | Enviar documento a firma. |
| **P08-F23** | Devolver con corrección. |
| **P08-F24** | Rechazar solicitud. |
| **P08-F25** | Gestionar devolución y rechazo mediante modal global único. |
| **P08-F26** | Confirmar envío a firma. |
| **P08-F27** | Registrar trazabilidad documental de la etapa Decretación. |