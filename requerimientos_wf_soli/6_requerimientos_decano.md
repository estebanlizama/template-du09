# PDS Normativo D9 / DU288 / DU09

## Pantalla 06 — Visación y Decisión de Facultad por Decano/a

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 06: Visación y Decisión de Facultad — Perfil Decano/a** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a una etapa de **revisión jerárquica y decisión institucional a nivel de Facultad**, posterior a la revisión financiera realizada por **Finanzas de Facultad**. Su propósito es permitir que el Decano/a visualice el expediente completo, incluyendo los antecedentes técnicos, normativos, financieros y de trazabilidad construidos en etapas anteriores, para emitir una decisión global sobre la continuidad de la solicitud.

La Pantalla 06 debe permitir revisar:

- La información general de la solicitud.
- El historial completo de visaciones y decisiones previas.
- Los resultados de la revisión normativa DGDP.
- Los funcionarios excluidos previamente y sus motivos.
- Los resultados de la revisión financiera de Finanzas de Facultad.
- El Centro de Costo y su información presupuestaria.
- La tabla de ítems presupuestarios por cargo, estamento o categoría.
- La suficiencia presupuestaria asociada a cada ítem.
- La nómina vigente de funcionarios que continúan en la solicitud.
- El detalle completo de cada funcionario:
  - Datos laborales.
  - Contratos vigentes.
  - Prestaciones solicitadas.
  - Historial de PDS.
  - Historial de pagos.
  - Información financiera acumulada.
  - Estado DGDP.
  - Estado financiero emitido por Finanzas de Facultad, cuando corresponda.
- El resumen consolidado del expediente previo a la decisión del Decano/a.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 06 — Decano/a**. No modifica las pantallas anteriores. Su objetivo es definir qué información debe visualizar el Decano/a, qué antecedentes previos deben estar disponibles y qué decisiones globales puede registrar sobre la solicitud.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P06 |
| **Nombre** | Visación y Decisión de Facultad por Decano/a |
| **Perfil principal** | Decano/a o autoridad facultada para la visación institucional de la Facultad |
| **Etapa del flujo** | Etapa 06 — Visación jerárquica de Facultad |
| **Estado de entrada esperado** | Solicitud aprobada por Finanzas de Facultad y enviada a revisión del Decano/a |
| **Objetivo principal** | Permitir que el Decano/a revise integralmente el expediente, visualice los resultados técnicos, normativos y financieros de etapas previas, y emita una decisión global sobre la continuidad de la solicitud. |
| **Resultado posible** | Solicitud aprobada y derivada a la etapa siguiente; solicitud devuelta con corrección al Solicitante; o solicitud rechazada. |

---

# 3. Principio funcional de la Pantalla 06

La Pantalla 06 debe operar como una **vista de revisión institucional integral y decisión jerárquica**, basada en la información consolidada del expediente y en los resultados emitidos por las etapas previas.

A diferencia de DGDP y Finanzas de Facultad, el Decano/a **no ejecuta una nueva auditoría normativa ni una nueva certificación presupuestaria**, sino que visualiza la información completa ya revisada para decidir si la solicitud, en su estado vigente, puede continuar dentro del flujo institucional.

La vista debe mantener un nivel de detalle equivalente al de la Pantalla 05, incluyendo un nivel de estructuración tabular comparable para la revisión por funcionario, de manera que el Decano/a pueda revisar con suficiente contexto:

- El estado del Centro de Costo.
- La disponibilidad presupuestaria general.
- Los ítems presupuestarios por cargo o estamento.
- Los funcionarios vigentes.
- Los funcionarios excluidos previamente.
- Los antecedentes financieros y laborales de cada funcionario.
- Las validaciones y decisiones emitidas por DGDP y Finanzas de Facultad.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 06 debe permitir que el Decano/a:

- Visualice la solicitud completa de forma detallada, ordenada y en modo solo lectura.
- Revise las decisiones y visaciones emitidas en las etapas anteriores:
  - Solicitante.
  - Jefe de Proyecto.
  - Jefatura Directa / Dirección de Departamento.
  - DGDP.
  - Finanzas de Facultad.
- Visualice si DGDP excluyó funcionarios y el motivo resumido de dicha exclusión.
- Visualice el resultado de la revisión financiera de Finanzas de Facultad.
- Revise el Centro de Costo y todos sus datos financieros relevantes.
- Visualice:
  - Saldo disponible general del Centro de Costo.
  - Monto total original de la solicitud.
  - Monto actualizado posterior a exclusiones previas.
  - Saldo proyectado posterior a aprobación, si la información se encuentra disponible.
- Visualice la **tabla de ítems presupuestarios por cargo, estamento o categoría**, indicando:
  - Ítem presupuestario.
  - Cargo, estamento o categoría asociada.
  - Presupuesto asignado.
  - Monto ya comprometido o ejecutado.
  - Saldo disponible.
  - Monto solicitado en la PDS actual para dicho ítem.
  - Saldo proyectado posterior a aprobación.
  - Estado de suficiencia presupuestaria.
- Revise el tipo de financiamiento, decreto afecto, unidad ejecutora y proyecto.
- Visualice la actividad general, tipo de prestación y evidencias comprometidas como antecedentes del expediente.
- Revise la nómina de funcionarios vigentes que continúan en la solicitud.
- Cambie entre los funcionarios vigentes para revisar el detalle individual de cada uno.
- Revise, por cada funcionario vigente:
  - Identificación.
  - Datos laborales y contractuales relevantes.
  - Contrato seleccionado para la PDS.
  - Ítem presupuestario asociado según su cargo, estamento o categoría.
  - Estado de suficiencia presupuestaria del ítem.
  - Lista de prestaciones solicitadas en tabla junto con los datos de cada prestación:
    - Prestación.
    - Actividad específica.
    - Descripción de la actividad.
    - Meses de pago.
    - Total comprometido.
    - Total en jornada.
    - Total fuera de jornada.
    - Total compensación horaria.
  - Información financiera acumulada.
  - Lista de contratos vigentes del funcionario junto a sus datos completos:
    - Contrato seleccionado para la PDS.
    - Descripción de la actividad.
    - Meses de pago.
    - Total comprometido.
    - Total en jornada.
    - Total fuera de jornada.
    - Total compensación horaria.
    - SEA.
  - Historial de PDS previas.
  - Historial de pagos.
  - Estado de validación DGDP resumido.
  - Estado financiero registrado por Finanzas de Facultad, cuando corresponda.
- Visualice el detalle por funcionario en bloques estructurados, preferentemente en formato tabular o equivalente, para facilitar la revisión comparativa de antecedentes laborales, financieros y contractuales.
- Visualice, por cada funcionario excluido por DGDP:
  - Identificación.
  - Etapa de exclusión.
  - Motivo resumido.
  - Comentario asociado, si corresponde.
- Visualice un **resumen consolidado del expediente**, considerando:
  - Estado general de la solicitud.
  - Funcionarios vigentes.
  - Funcionarios excluidos.
  - Resultado DGDP.
  - Resultado de Finanzas de Facultad.
  - Monto vigente de la solicitud.
  - Disponibilidad general e ítems presupuestarios.
- Apruebe la solicitud mediante la acción **APROBAR Y CONTINUAR**.
- Devuelva la solicitud al Solicitante mediante la acción **DEVOLVER CON CORRECCIÓN**.
- Rechace la solicitud mediante la acción **RECHAZAR SOLICITUD**.
- Gestione la devolución con corrección y el rechazo mediante un **modal global único**.
- Registre comentarios obligatorios cuando la solicitud no sea aprobada.
- Confirme la acción antes de modificar el estado del expediente.
- Mantenga trazabilidad completa de la decisión del Decano/a.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 06 no debe:

- Editar los datos originales ingresados por el Solicitante.
- Modificar los antecedentes aprobados en etapas previas.
- Incorporar nuevos funcionarios a la solicitud.
- Reponer funcionarios excluidos por DGDP.
- Cambiar los motivos de exclusión registrados por DGDP.
- Alterar los resultados de validación normativa emitidos por DGDP.
- Alterar los resultados de revisión financiera emitidos por Finanzas de Facultad.
- Revalidar presupuestariamente los ítems como función decisoria propia.
- Modificar directamente compensaciones horarias, condición SEA, topes salariales o inhabilidades.
- Alterar manualmente los saldos presupuestarios desde la vista.
- Cambiar el ítem presupuestario asociado a un funcionario.
- Aprobar o rechazar individualmente funcionarios.
- Registrar exclusiones individuales de funcionarios.
- Eliminar información histórica del expediente.
- Ocultar a los funcionarios que fueron excluidos previamente del proceso.
- Alterar los registros históricos de prestaciones o pagos de los funcionarios.
- Incorporar la opción de **Aprobación con Alcance**, salvo que una definición posterior del proceso indique lo contrario.
- Incorporar la acción **Salir sin guardar** como opción operativa de la pantalla.

---

# 4. Objetivo funcional de la Pantalla 06

La pantalla debe permitir que el Decano/a:

1. Identifique la solicitud que ingresa a visación institucional.
2. Visualice el estado actual del expediente y la etapa del flujo.
3. Revise la trazabilidad completa de las decisiones previas.
4. Conozca si hubo exclusiones de funcionarios en DGDP y por qué.
5. Visualice el resultado consolidado de la revisión financiera de Finanzas de Facultad.
6. Visualice un resumen ejecutivo completo de la solicitud.
7. Revise los datos del Centro de Costo, proyecto, unidad ejecutora, decreto y financiamiento.
8. Consulte el saldo disponible general del Centro de Costo.
9. Visualice la tabla de ítems presupuestarios asociados al Centro de Costo.
10. Revise el presupuesto disponible por cargo, estamento o categoría asociada a cada ítem.
11. Compare el monto total original de la solicitud con el monto vigente posterior a exclusiones.
12. Visualice el impacto financiero total de la PDS.
13. Revise los antecedentes generales de la prestación:
    - Actividad.
    - Tipo de prestación.
    - Evidencias comprometidas.
    - Periodo de ejecución.
14. Visualice los funcionarios que continúan activos en la solicitud.
15. Visualice los funcionarios excluidos previamente y el motivo de su salida del flujo.
16. Seleccione o cambie entre funcionarios para revisar su detalle individual.
17. Revise el detalle laboral y contractual de cada funcionario activo.
18. Revise el contrato seleccionado para la PDS.
19. Visualice el ítem presupuestario que corresponde al funcionario según su cargo, estamento o categoría.
20. Visualice el estado de suficiencia presupuestaria del ítem correspondiente.
21. Visualice la lista de prestaciones solicitadas por funcionario.
22. Revise los montos comprometidos por prestación, incluyendo:
    - Total comprometido.
    - Total en jornada.
    - Total fuera de jornada.
    - Total compensación horaria.
23. Visualice la lista de contratos vigentes del funcionario junto con los datos definidos para revisión institucional.
24. Revise la condición SEA asociada al funcionario cuando corresponda.
25. Consulte el historial de PDS previas por funcionario.
26. Consulte el historial de pagos e información financiera acumulada por funcionario.
27. Visualice el estado DGDP de cada funcionario.
28. Visualice el resultado financiero registrado por Finanzas de Facultad, cuando corresponda.
29. Visualice un resumen consolidado de la solicitud antes de decidir.
30. Apruebe la solicitud cuando considere que puede continuar.
31. Devuelva con corrección la solicitud al Solicitante cuando existan observaciones subsanables.
32. Rechace la solicitud cuando existan observaciones que impidan su continuidad.
33. Confirme la decisión antes de aplicarla.
34. Registre trazabilidad de toda decisión ejecutada en esta etapa.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 06 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P06-B01** | Encabezado de expediente y estado de revisión del Decano/a | Identificar la solicitud, su estado y el rol revisor. |
| **P06-B02** | Trazabilidad de etapas previas | Mostrar el historial completo de aprobación y revisión hasta Finanzas de Facultad. |
| **P06-B03** | Resumen de funcionarios excluidos previamente | Mostrar quiénes fueron retirados del proceso y por qué. |
| **P06-B04** | Resumen ejecutivo institucional del expediente | Mostrar el estado general de la solicitud antes de la decisión del Decano/a. |
| **P06-B05** | Centro de Costo, proyecto y disponibilidad presupuestaria general | Exponer los antecedentes financieros centrales del expediente. |
| **P06-B06** | Ítems presupuestarios por cargo, estamento o categoría | Mostrar la distribución presupuestaria del Centro de Costo y el saldo aplicable a los funcionarios. |
| **P06-B07** | Actividad, prestación y evidencias como antecedente del expediente | Mostrar el contexto técnico general de la solicitud. |
| **P06-B08** | Nómina de funcionarios vigentes | Mostrar los funcionarios que continúan activos en la solicitud. |
| **P06-B09** | Selector y ficha laboral/contractual por funcionario | Permitir cambiar entre funcionarios y revisar sus datos individuales. |
| **P06-B10** | Prestaciones solicitadas en la solicitud actual por funcionario | Mostrar el detalle de cada prestación solicitada y sus montos asociados. |
| **P06-B11** | Contratos vigentes y datos asociados por funcionario | Mostrar los contratos del funcionario y los datos relevantes para la revisión institucional. |
| **P06-B12** | Historial de prestaciones previas e información financiera acumulada | Mostrar PDS históricas y acumulados asociados al funcionario. |
| **P06-B13** | Historial de pagos por funcionario | Mostrar pagos previos y antecedentes financieros históricos. |
| **P06-B14** | Estado resumido de validaciones DGDP por funcionario | Mostrar los resultados normativos previos. |
| **P06-B15** | Estado resumido de revisión financiera por funcionario | Mostrar los resultados de Finanzas de Facultad por funcionario, cuando corresponda. |
| **P06-B16** | Resumen consolidado para decisión del Decano/a | Mostrar el estado integral de la solicitud previo a la visación. |
| **P06-B17** | Decisión global del Decano/a | Permitir devolver con corrección, rechazar solicitud o aprobar y continuar. |
| **P06-B18** | Modal global de devolución/rechazo | Gestionar motivo, comentario y confirmación para devolución con corrección o rechazo. |
| **P06-B19** | Confirmación, transición de estado y trazabilidad | Confirmar decisiones y registrar el historial de la etapa. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P06-B01 — Encabezado de expediente y estado de revisión del Decano/a

## Funcionalidad P06-F01 — Visualizar identificación de la solicitud

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación única de la solicitud que será revisada por el Decano/a.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Número o código único de solicitud.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Título de la etapa: Visación y Decisión de Facultad.

### D. Reglas de negocio

- El identificador de la solicitud debe mantenerse inalterable durante todo el flujo.
- Debe permanecer visible durante la revisión del Decano/a.

### E. Historia de usuario preliminar

**HU-P06-01:** Como **Decano/a**, quiero visualizar claramente el identificador del expediente en revisión, para asociar mi decisión a la solicitud correcta.

### F. Requerimientos funcionales preliminares

- **RF-PP06-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-PP06-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo.

---

## Funcionalidad P06-F02 — Visualizar estado actual del expediente

### A. Descripción funcional

El sistema debe mostrar que la solicitud se encuentra en revisión por el Decano/a.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Estado: **En revisión por Decano/a**.
- Etapa actual del flujo.
- Fecha de ingreso a la etapa de visación del Decano/a.

### D. Reglas de negocio

- Solo deben llegar a esta etapa solicitudes aprobadas previamente por Finanzas de Facultad.
- Mientras el expediente se encuentre en revisión por el Decano/a, no debe ser editable por el Solicitante.

### E. Historia de usuario preliminar

**HU-P06-02:** Como **Decano/a**, quiero visualizar el estado actual del expediente, para confirmar que se encuentra habilitado para mi revisión y decisión.

### F. Requerimientos funcionales preliminares

- **RF-PP06-003:** El sistema debe mostrar el estado actual de revisión por Decano/a.
- **RF-PP06-004:** El sistema debe mostrar la fecha de ingreso de la solicitud a esta etapa.

---

# P06-B02 — Trazabilidad de etapas previas

## Funcionalidad P06-F03 — Visualizar aprobaciones y decisiones previas del flujo

### A. Descripción funcional

El sistema debe mostrar al Decano/a el recorrido histórico completo del expediente hasta su llegada a esta etapa.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

Por cada etapa previa:

- Etapa.
- Rol aprobador o revisor.
- Usuario responsable.
- Acción ejecutada.
- Fecha.
- Hora.
- Comentario asociado, cuando exista.

### D. Etapas previas mínimas a mostrar

- Creación y envío por Solicitante.
- Aprobación por Jefe de Proyecto.
- Aprobación por Jefatura Directa / Dirección de Departamento.
- Revisión y aprobación por DGDP.
- Exclusiones individuales ejecutadas por DGDP, si existieron.
- Revisión y aprobación por Finanzas de Facultad.
- Rechazos financieros individuales, si el flujo los incorpora y fueron registrados previamente.

### E. Historia de usuario preliminar

**HU-P06-03:** Como **Decano/a**, quiero revisar las decisiones emitidas en etapas anteriores, para comprender el recorrido del expediente antes de visarlo institucionalmente.

### F. Requerimientos funcionales preliminares

- **RF-PP06-005:** El sistema debe mostrar cronológicamente las decisiones registradas antes de la revisión del Decano/a.
- **RF-PP06-006:** El sistema debe mostrar usuario, rol, acción, fecha, hora y comentario cuando corresponda.
- **RF-PP06-007:** El sistema debe incorporar en la trazabilidad las exclusiones realizadas por DGDP y las decisiones financieras registradas por Finanzas de Facultad, cuando correspondan.

---

## Funcionalidad P06-F04 — Visualizar línea de avance del flujo

### A. Descripción funcional

El sistema debe mostrar visualmente el progreso del expediente dentro del flujo completo.

### B. Actor principal

Decano/a.

### C. Hitos mínimos a mostrar

- Solicitud creada.
- Aprobación Jefe de Proyecto.
- Aprobación Jefatura Directa / Dirección de Departamento.
- Revisión DGDP.
- Revisión Finanzas de Facultad.
- Etapa actual: Decano/a.
- Etapa siguiente pendiente.

### D. Historia de usuario preliminar

**HU-P06-04:** Como **Decano/a**, quiero visualizar el avance del expediente en el flujo, para comprender en qué etapa se encuentra y qué revisiones ya fueron realizadas.

### E. Requerimientos funcionales preliminares

- **RF-PP06-008:** El sistema debe mostrar una línea de avance del expediente.
- **RF-PP06-009:** El sistema debe diferenciar etapas cumplidas, etapa actual y etapas pendientes.

---

# P06-B03 — Resumen de funcionarios excluidos previamente

## Funcionalidad P06-F05 — Visualizar funcionarios excluidos por DGDP

### A. Descripción funcional

El sistema debe mostrar de forma resumida a los funcionarios que fueron excluidos de la solicitud durante la etapa DGDP, junto con el motivo de exclusión.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

Por cada funcionario excluido:

- RUT.
- Nombre completo.
- Estado: **Excluido por DGDP**.
- Fecha de exclusión.
- Etapa de exclusión.
- Motivo resumido.
- Comentario técnico asociado, cuando corresponda.
- Regla o causal de exclusión, si fue registrada.

### D. Reglas de negocio

- Los funcionarios excluidos no deben formar parte del cálculo vigente de la solicitud.
- Deben mantenerse visibles como antecedente histórico del expediente.
- La exclusión no puede ser editada desde la vista del Decano/a.

### E. Historia de usuario preliminar

**HU-P06-05:** Como **Decano/a**, quiero visualizar qué funcionarios fueron excluidos por DGDP y por qué, para comprender la composición final de la solicitud que llega a mi revisión.

### F. Requerimientos funcionales preliminares

- **RF-PP06-010:** El sistema debe mostrar los funcionarios excluidos por DGDP.
- **RF-PP06-011:** El sistema debe mostrar el motivo resumido de cada exclusión.
- **RF-PP06-012:** El sistema debe mantener visibles estas exclusiones como antecedente histórico.
- **RF-PP06-013:** El sistema no debe permitir modificar las exclusiones previas desde esta pantalla.

---

# P06-B04 — Resumen ejecutivo institucional del expediente

## Funcionalidad P06-F06 — Visualizar resumen general de la solicitud

### A. Descripción funcional

El sistema debe mostrar un resumen ejecutivo que permita al Decano/a comprender rápidamente el estado integral del expediente.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Nombre del proyecto.
- Unidad ejecutora.
- Tipo de financiamiento.
- Decreto afecto.
- Número total de funcionarios incorporados originalmente.
- Número de funcionarios excluidos por DGDP.
- Número de funcionarios vigentes.
- Monto total original de la solicitud.
- Monto total vigente posterior a exclusiones.
- Saldo disponible general del Centro de Costo.
- Saldo estimado posterior a aprobación, si la fuente lo permite.
- Estado consolidado de la revisión DGDP.
- Estado consolidado de la revisión de Finanzas de Facultad.

### D. Reglas de negocio

- El monto total vigente debe considerar únicamente a los funcionarios que continúan activos en el proceso.
- Debe diferenciarse claramente el monto original del monto ajustado posterior a exclusiones.
- El resumen debe presentar el expediente en su estado vigente al ingreso a Decano/a.

### E. Historia de usuario preliminar

**HU-P06-06:** Como **Decano/a**, quiero visualizar un resumen integral del expediente, para tomar una decisión jerárquica informada sobre su continuidad.

### F. Requerimientos funcionales preliminares

- **RF-PP06-014:** El sistema debe mostrar el monto original de la solicitud.
- **RF-PP06-015:** El sistema debe mostrar el monto vigente posterior a exclusiones previas.
- **RF-PP06-016:** El sistema debe mostrar la cantidad de funcionarios originales, excluidos y vigentes.
- **RF-PP06-017:** El sistema debe mostrar el saldo disponible general del Centro de Costo.
- **RF-PP06-018:** El sistema debe mostrar el resultado consolidado de DGDP y Finanzas de Facultad.

---

# P06-B05 — Centro de Costo, proyecto y disponibilidad presupuestaria general

## Funcionalidad P06-F07 — Visualizar información completa del Centro de Costo

### A. Descripción funcional

El Decano/a debe visualizar todos los antecedentes del Centro de Costo asociados al expediente, priorizando los elementos relevantes para comprender la sostenibilidad presupuestaria de la solicitud.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Código del Centro de Costo.
- Nombre del Centro de Costo.
- Proyecto asociado.
- Unidad ejecutora.
- Jefe de Proyecto.
- Tipo de financiamiento.
- Decreto afecto.
- Estado de vigencia.
- Estado de habilitación.
- Saldo disponible general del Centro de Costo.
- Monto actualmente comprometido por la solicitud.
- Saldo proyectado posterior a aprobación, si aplica.
- Referencia a los ítems presupuestarios asociados al Centro de Costo.

### D. Reglas de negocio

- La información debe mostrarse en modo solo lectura.
- Los datos del Centro de Costo deben corresponder al expediente vigente posterior a Finanzas de Facultad.
- La información general del Centro de Costo debe vincularse visualmente con la tabla de ítems presupuestarios por cargo, estamento o categoría.

### E. Historia de usuario preliminar

**HU-P06-07:** Como **Decano/a**, quiero revisar la información completa del Centro de Costo y su disponibilidad presupuestaria, para comprender el respaldo financiero de la solicitud que debo visar.

### F. Requerimientos funcionales preliminares

- **RF-PP06-019:** El sistema debe mostrar los datos financieros y administrativos del Centro de Costo.
- **RF-PP06-020:** El sistema debe mostrar el saldo disponible general y el monto comprometido por la solicitud.
- **RF-PP06-021:** El sistema debe vincular la información del Centro de Costo con sus ítems presupuestarios asociados.

---

# P06-B06 — Ítems presupuestarios por cargo, estamento o categoría

## Funcionalidad P06-F08 — Visualizar tabla de ítems presupuestarios asociados al Centro de Costo

### A. Descripción funcional

El sistema debe mostrar al Decano/a la tabla de ítems presupuestarios disponibles en el Centro de Costo, diferenciados según el cargo, estamento o categoría funcionaria habilitada para su imputación.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

Por cada ítem presupuestario:

- Código del ítem presupuestario, si existe.
- Nombre o descripción del ítem.
- Cargo, estamento o categoría asociada:
  - Académico.
  - Administrativo.
  - Técnico.
  - Auxiliar.
  - Otro, si aplica.
- Presupuesto asignado.
- Monto ya comprometido o ejecutado.
- Saldo disponible actual.
- Monto solicitado en la PDS vigente asociado a ese ítem.
- Número de funcionarios de la solicitud imputados a ese ítem, si corresponde.
- Saldo proyectado posterior a aprobación.
- Estado de suficiencia presupuestaria:
  - Suficiente.
  - Insuficiente.
  - Requiere revisión.

### D. Reglas de negocio

- La tabla debe mostrar los ítems presupuestarios relevantes para la solicitud.
- Los valores deben reflejar la revisión financiera emitida por Finanzas de Facultad.
- La tabla debe ser informativa y no editable desde la vista del Decano/a.

### E. Historia de usuario preliminar

**HU-P06-08:** Como **Decano/a**, quiero visualizar los ítems presupuestarios del Centro de Costo diferenciados por cargo o estamento, para conocer cómo se respalda financieramente la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP06-022:** El sistema debe mostrar una tabla de ítems presupuestarios asociados al Centro de Costo.
- **RF-PP06-023:** El sistema debe mostrar el cargo, estamento o categoría relacionada con cada ítem.
- **RF-PP06-024:** El sistema debe mostrar presupuesto asignado, monto comprometido, saldo disponible, monto solicitado y saldo proyectado por ítem.
- **RF-PP06-025:** El sistema debe mostrar el estado de suficiencia presupuestaria por ítem.
- **RF-PP06-026:** El sistema no debe permitir modificar los datos presupuestarios desde la vista del Decano/a.

---

# P06-B07 — Actividad, prestación y evidencias como antecedente del expediente

## Funcionalidad P06-F09 — Visualizar contexto técnico resumido de la solicitud

### A. Descripción funcional

El Decano/a debe visualizar de manera resumida el contexto técnico del expediente, con el fin de relacionar la solicitud con la prestación que la origina.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Descripción general de la actividad.
- Tipo o tipos de prestación seleccionados.
- Descripción de “Otro”, si corresponde.
- Fecha de inicio.
- Fecha de término.
- Evidencias comprometidas.
- Fecha estimada de entrega por evidencia.

### D. Reglas de negocio

- Esta sección es informativa y de solo lectura.
- No reemplaza la revisión técnica de etapas anteriores.

### E. Historia de usuario preliminar

**HU-P06-09:** Como **Decano/a**, quiero visualizar el contexto técnico resumido de la solicitud, para comprender el propósito institucional de la prestación antes de decidir.

### F. Requerimientos funcionales preliminares

- **RF-PP06-027:** El sistema debe mostrar la descripción general de la actividad.
- **RF-PP06-028:** El sistema debe mostrar los tipos de prestación seleccionados.
- **RF-PP06-029:** El sistema debe mostrar las evidencias comprometidas y sus fechas estimadas.

---

# P06-B08 — Nómina de funcionarios vigentes

## Funcionalidad P06-F10 — Visualizar funcionarios activos que continúan en el proceso

### A. Descripción funcional

El sistema debe mostrar la nómina de funcionarios que continúan vigentes en la solicitud luego de las revisiones DGDP y Finanzas de Facultad.

### B. Actor principal

Decano/a.

### C. Datos resumidos por funcionario

- RUT.
- Nombre completo.
- Estamento.
- Jerarquía o cargo.
- Contrato seleccionado.
- Jornada.
- Estado DGDP.
- Estado financiero emitido por Finanzas de Facultad, cuando corresponda.
- Ítem presupuestario asociado.
- Estado de suficiencia presupuestaria del ítem.
- Monto bruto mensual.
- Total asociado a la solicitud actual.

### D. Reglas de negocio

- La tabla debe mostrar solo como vigentes a los funcionarios que continúan en el proceso.
- Los funcionarios excluidos por DGDP deben mostrarse en su bloque específico, no mezclados con los funcionarios activos.
- Los estados heredados desde DGDP y Finanzas de Facultad deben mostrarse en modo solo lectura.

### E. Historia de usuario preliminar

**HU-P06-10:** Como **Decano/a**, quiero visualizar la nómina de funcionarios vigentes y sus estados previos de validación, para comprender la composición de la solicitud antes de visarla.

### F. Requerimientos funcionales preliminares

- **RF-PP06-030:** El sistema debe mostrar la nómina de funcionarios vigentes posterior a las etapas previas.
- **RF-PP06-031:** El sistema debe mostrar el estado DGDP de cada funcionario.
- **RF-PP06-032:** El sistema debe mostrar el estado financiero registrado por Finanzas de Facultad cuando corresponda.
- **RF-PP06-033:** El sistema debe mostrar el ítem presupuestario asociado y el estado de suficiencia presupuestaria por funcionario.

---

# P06-B09 — Selector y ficha laboral/contractual por funcionario

## Funcionalidad P06-F11 — Seleccionar funcionario para revisión detallada

### A. Descripción funcional

El sistema debe permitir al Decano/a cambiar entre los funcionarios vigentes en la solicitud para visualizar su detalle individual.

### B. Actor principal

Decano/a.

### C. Comportamiento esperado

- Seleccionar un funcionario desde la nómina o selector disponible.
- Cargar la información detallada correspondiente al funcionario seleccionado.
- Actualizar:
  - Ficha laboral.
  - Prestaciones solicitadas.
  - Contratos vigentes.
  - Historial de PDS.
  - Historial de pagos.
  - Estado DGDP.
  - Estado financiero de Finanzas de Facultad, cuando corresponda.
  - Ítem presupuestario asociado.
  - Estado de suficiencia presupuestaria.

### D. Reglas de negocio

- El cambio de funcionario no debe alterar datos registrados.
- El funcionario seleccionado debe mantenerse claramente identificado en pantalla.

### E. Historia de usuario preliminar

**HU-P06-11:** Como **Decano/a**, quiero seleccionar distintos funcionarios dentro de la solicitud, para revisar el detalle de cada uno sin salir de la pantalla.

### F. Requerimientos funcionales preliminares

- **RF-PP06-034:** El sistema debe permitir seleccionar o cambiar entre funcionarios vigentes de la solicitud.
- **RF-PP06-035:** El sistema debe actualizar la información visible según el funcionario seleccionado.
- **RF-PP06-036:** El sistema debe mantener visible la identidad del funcionario actualmente revisado.

---

## Funcionalidad P06-F12 — Visualizar antecedentes laborales relevantes por funcionario

### A. Descripción funcional

El Decano/a debe visualizar la información laboral y contractual relevante de cada funcionario vigente como antecedente para su revisión institucional.
La presentación de esta información debe mantener una estructura tabular equivalente a la utilizada en la Pantalla 05 cuando ello favorezca la comparación de antecedentes.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- RUT.
- Nombre completo.
- Estamento.
- Jerarquía.
- Tipo de vinculación.
- Grado.
- Jornada.
- Horas de jornada.
- Contrato seleccionado para la PDS.
- Cantidad de contratos vigentes, cuando se encuentre disponible.
- Renta bruta y neta cuando hayan sido utilizadas como antecedente en etapas previas.
- Estado DGDP resumido.
- Estado financiero emitido por Finanzas de Facultad, cuando corresponda.
- Ítem presupuestario asociado.
- Estado de suficiencia presupuestaria del ítem.

### D. Reglas de negocio

- La información debe mostrarse en modo solo lectura.
- Debe priorizarse el contrato seleccionado para la PDS.
- Los estados emitidos por DGDP y Finanzas deben mostrarse como antecedentes, sin posibilidad de modificación.
- Debe privilegiarse una disposición tabular o estructurada equivalente para facilitar la comparación de contratos, prestaciones, históricos y estados por funcionario.

### E. Historia de usuario preliminar

**HU-P06-12:** Como **Decano/a**, quiero visualizar los antecedentes laborales relevantes del funcionario junto con sus estados previos de revisión, para contextualizar la decisión institucional sobre la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP06-037:** El sistema debe mostrar la ficha laboral resumida de cada funcionario vigente.
- **RF-PP06-038:** El sistema debe identificar el contrato seleccionado para la PDS.
- **RF-PP06-039:** El sistema debe mostrar la cantidad de contratos vigentes cuando esta información esté disponible.
- **RF-PP06-040:** El sistema debe mostrar el ítem presupuestario asociado al funcionario.
- **RF-PP06-041:** El sistema debe mostrar los estados DGDP y Finanzas de Facultad como antecedentes de solo lectura.
- **RF-PP06-042:** El sistema debe presentar el detalle individual del funcionario en bloques estructurados, preferentemente tabulares o equivalentes al nivel de la Pantalla 05.

---

# P06-B10 — Prestaciones solicitadas en la solicitud actual por funcionario

## Funcionalidad P06-F13 — Visualizar tabla de prestaciones solicitadas por funcionario

### A. Descripción funcional

El Decano/a debe visualizar una tabla con las prestaciones solicitadas asociadas a cada funcionario vigente.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema por prestación

- Prestación.
- Actividad específica.
- Descripción de la actividad.
- Meses de pago.
- Total comprometido.
- Total en jornada.
- Total fuera de jornada.
- Total compensación horaria.
- Ítem presupuestario asociado.
- Estado de respaldo presupuestario del ítem.

### D. Reglas de negocio

- La tabla debe mostrar todas las prestaciones vinculadas al funcionario dentro de la solicitud actual.
- La información debe estar asociada al funcionario específico.
- Los montos presentados deben coincidir con los valores vigentes de la solicitud posterior a las revisiones previas.
- Cada prestación debe vincularse al ítem presupuestario correspondiente.

### E. Historia de usuario preliminar

**HU-P06-13:** Como **Decano/a**, quiero visualizar la tabla de prestaciones solicitadas por funcionario, para conocer el contenido económico y operativo de la solicitud antes de decidir.

### F. Requerimientos funcionales preliminares

- **RF-PP06-042:** El sistema debe mostrar las prestaciones solicitadas por funcionario.
- **RF-PP06-043:** El sistema debe mostrar actividad específica y descripción de actividad asociadas a cada prestación.
- **RF-PP06-044:** El sistema debe mostrar meses de pago y total comprometido por prestación.
- **RF-PP06-045:** El sistema debe mostrar total en jornada, total fuera de jornada y total de compensación horaria por prestación.
- **RF-PP06-046:** El sistema debe mostrar el ítem presupuestario asociado a cada prestación.

---

# P06-B11 — Contratos vigentes y datos asociados por funcionario

## Funcionalidad P06-F14 — Visualizar lista de contratos vigentes del funcionario

### A. Descripción funcional

El Decano/a debe visualizar la lista de contratos vigentes del funcionario junto con los datos ya utilizados en las revisiones previas.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema por contrato vigente

- Contrato seleccionado para la PDS.
- Descripción de la actividad.
- Meses de pago.
- Total comprometido.
- Total en jornada.
- Total fuera de jornada.
- Total compensación horaria.
- SEA.

### D. Reglas de negocio

- Debe distinguirse visualmente el contrato seleccionado para la PDS.
- La información debe mantenerse asociada al funcionario correspondiente.
- La condición SEA debe mostrarse cuando aplique.
- Los datos deben mostrarse en modo solo lectura.

### E. Historia de usuario preliminar

**HU-P06-14:** Como **Decano/a**, quiero visualizar la lista de contratos vigentes del funcionario, para revisar los antecedentes laborales y de jornada que acompañan la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP06-047:** El sistema debe mostrar la lista de contratos vigentes del funcionario.
- **RF-PP06-048:** El sistema debe distinguir el contrato seleccionado para la PDS.
- **RF-PP06-049:** El sistema debe mostrar, por contrato, descripción de actividad, meses de pago, total comprometido, total en jornada, total fuera de jornada, total compensación horaria y SEA.

---

# P06-B12 — Historial de prestaciones previas e información financiera acumulada

## Funcionalidad P06-F15 — Visualizar historial de PDS previas del funcionario

### A. Descripción funcional

El Decano/a debe visualizar el historial de prestaciones de servicios anteriores del funcionario como antecedente institucional.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

Por cada prestación previa:

- Número o identificador de solicitud.
- Periodo de ejecución.
- Centro de Costo asociado.
- Tipo de prestación.
- Meses de pago.
- Monto bruto mensual.
- Monto total.
- Estado de la prestación.
- Observaciones, cuando existan.

### D. Reglas de negocio

- El historial debe mostrar, como mínimo, las prestaciones relevantes para la revisión de la solicitud actual.
- Si no existen prestaciones previas, el sistema debe indicarlo explícitamente.

### E. Historia de usuario preliminar

**HU-P06-15:** Como **Decano/a**, quiero revisar las prestaciones previas del funcionario, para disponer de antecedentes históricos antes de emitir mi decisión.

### F. Requerimientos funcionales preliminares

- **RF-PP06-050:** El sistema debe mostrar el historial de PDS previas por funcionario.
- **RF-PP06-051:** El sistema debe informar cuando no existan PDS previas registradas.
- **RF-PP06-052:** El sistema debe permitir identificar la relación entre las PDS previas y la solicitud actual cuando corresponda.

---

## Funcionalidad P06-F16 — Visualizar información financiera acumulada del funcionario

### A. Descripción funcional

El sistema debe consolidar la información financiera histórica del funcionario como antecedente de revisión.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Total pagado en PDS previas dentro del periodo consultado.
- Total de prestaciones registradas.
- Monto acumulado histórico relevante.
- Último pago registrado.
- Otras solicitudes vigentes, si la información se encuentra disponible.
- Total comprometido actual en la solicitud.
- Comparación entre acumulado histórico y compromiso vigente, cuando corresponda.

### D. Historia de usuario preliminar

**HU-P06-16:** Como **Decano/a**, quiero visualizar la información financiera acumulada del funcionario, para comprender sus antecedentes de prestaciones y compromisos vigentes.

### E. Requerimientos funcionales preliminares

- **RF-PP06-053:** El sistema debe mostrar un resumen consolidado del historial financiero por funcionario.
- **RF-PP06-054:** El sistema debe mostrar acumulados y cantidades relevantes para la revisión institucional.
- **RF-PP06-055:** El sistema debe mostrar el total comprometido actual dentro de la solicitud.

---

# P06-B13 — Historial de pagos por funcionario

## Funcionalidad P06-F17 — Visualizar historial de pagos del funcionario

### A. Descripción funcional

El Decano/a debe poder revisar el historial de pagos asociados a prestaciones anteriores del funcionario.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Periodo de pago.
- Centro de Costo asociado.
- Monto bruto pagado.
- Monto neto pagado, si está disponible.
- Total pagado en el periodo consultado.
- Estado del pago.
- Tipo de prestación.
- Observaciones financieras, cuando existan.

### D. Historia de usuario preliminar

**HU-P06-17:** Como **Decano/a**, quiero visualizar el historial de pagos del funcionario, para revisar sus antecedentes financieros vinculados a prestaciones previas.

### E. Requerimientos funcionales preliminares

- **RF-PP06-056:** El sistema debe mostrar el historial de pagos por funcionario.
- **RF-PP06-057:** El sistema debe mostrar montos brutos, netos y acumulados cuando se encuentren disponibles.
- **RF-PP06-058:** El sistema debe indicar el estado de cada pago registrado.

---

# P06-B14 — Estado de validaciones previas y panel de auditoría integrada por funcionario

## Funcionalidad P06-F18 — Visualizar validaciones detalladas de Licencias, Deudas, Inhabilidades y Parentesco

### A. Descripción funcional

El Decano/a debe visualizar el panel de auditoría detallada heredado de DGDP, incorporando la información estructurada de restricciones administrativas, deudas institucionales vigentes y parentescos detectados del funcionario, garantizando que la decisión jerárquica cuente con toda la información relevante en pantalla.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

El sistema debe presentar tres paneles tabulares y de alertas bien estructurados:

1.  **Licencias y Restricciones Administrativas:**
    *   Listado de Licencias Médicas vigentes, Permisos sin Goce de Sueldo y suspensiones activas.
    *   Por cada registro: Tipo de licencia/permiso, Fecha de inicio, Fecha de término, Días totales, Estado de validación.
2.  **Historial de Deudas UFRO:**
    *   Deudas financieras pendientes u observaciones vigentes del funcionario con la Universidad.
    *   Por cada registro: Concepto/Glosa de deuda, Monto adeudado, Fecha de registro, Estado de la deuda (Vigente/Bloqueada).
3.  **Vínculos de Parentesco y Declaración de Incompatibilidad:**
    *   Relaciones familiares directas identificadas con otros funcionarios o directivos del Centro de Costo o de la Facultad.
    *   Por cada registro: Nombre del pariente, Vínculo (cónyuge, hijo/a, etc.), RUN, Cargo/ CC del pariente, Estado de Declaración de Parentesco (Completa, Pendiente, No requerida).

### D. Reglas de negocio

- Esta sección debe operar en modo solo lectura para este perfil.
- El sistema debe heredar dinámicamente esta información desde las validaciones de DGDP y la base de datos maestra (`mock_data_d9.js`).
- Los resultados de parentesco y deudas no deben bloquear de manera automatizada la revisión, operando como alertas informativas críticas.
- El panel debe conservar la misma estructura que en la etapa DGDP para mantener consistencia visual.

### E. Historia de usuario preliminar

**HU-P06-18:** Como **Decano/a**, quiero revisar el panel de auditoría de licencias, deudas y parentesco de cada funcionario, para asegurar la integridad de la asignación y evaluar riesgos administrativos asociados a la contratación antes de mi decisión.

### F. Requerimientos funcionales preliminares

- **RF-PP06-059:** El sistema debe mostrar el panel detallado de Licencias y Restricciones Administrativas por funcionario.
- **RF-PP06-060:** El sistema desplegará la tabla de Historial de Deudas UFRO activas del funcionario.
- **RF-PP06-061:** El sistema debe mostrar las relaciones de parentesco e incompatibilidad declaradas del funcionario.
- **RF-PP06-061A:** El sistema debe presentar estas validaciones de forma no modificable (solo lectura) y estandarizada en el panel de auditoría.

---

# P06-B15 — Estado resumido de revisión financiera por funcionario

## Funcionalidad P06-F19 — Visualizar resultado financiero registrado por Finanzas de Facultad

### A. Descripción funcional

El Decano/a debe visualizar el resultado de la revisión financiera realizada por Finanzas de Facultad sobre cada funcionario, cuando dicha revisión individual forme parte del flujo definido.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Estado financiero del funcionario:
  - Aprobado financieramente.
  - Rechazado financieramente.
  - Otro estado definido por el flujo.
- Comentario financiero asociado, cuando corresponda.
- Ítem presupuestario vinculado.
- Resultado de suficiencia presupuestaria del ítem.
- Observaciones financieras relevantes emitidas por Finanzas de Facultad.

### D. Reglas de negocio

- Esta sección debe mostrarse como antecedente informativo.
- No debe permitir modificar el resultado emitido por Finanzas de Facultad.
- Si la revisión financiera individual no se mantiene en el flujo final, este bloque deberá ajustarse para mostrar únicamente el resultado financiero consolidado del expediente.

### E. Historia de usuario preliminar

**HU-P06-19:** Como **Decano/a**, quiero visualizar el resultado financiero registrado por Finanzas de Facultad, para conocer el respaldo presupuestario previo antes de decidir sobre la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP06-062:** El sistema debe mostrar el resultado financiero registrado por Finanzas de Facultad para cada funcionario, cuando corresponda.
- **RF-PP06-063:** El sistema debe mostrar comentarios u observaciones financieras asociadas, cuando existan.
- **RF-PP06-064:** El sistema no debe permitir modificar las decisiones financieras emitidas por Finanzas de Facultad.

---

# P06-B16 — Resumen consolidado para decisión del Decano/a

## Funcionalidad P06-F20 — Visualizar resumen global previo a la decisión

### A. Descripción funcional

El sistema debe mostrar un resumen consolidado del expediente antes de que el Decano/a tome una decisión global.

### B. Actor principal

Decano/a.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Proyecto.
- Unidad ejecutora.
- Tipo de financiamiento.
- Decreto afecto.
- Monto original de la solicitud.
- Monto vigente posterior a exclusiones.
- Saldo disponible general.
- Resumen de ítems presupuestarios.
- Cantidad de funcionarios vigentes.
- Cantidad de funcionarios excluidos por DGDP.
- Resultado consolidado DGDP.
- Resultado consolidado de Finanzas de Facultad.
- Alertas u observaciones registradas en etapas previas, cuando existan.
- Estado general del expediente para decisión del Decano/a.

### D. Historia de usuario preliminar

**HU-P06-20:** Como **Decano/a**, quiero revisar un resumen global del expediente, para decidir si la solicitud puede continuar, debe devolverse con corrección o debe ser rechazada.

### E. Requerimientos funcionales preliminares

- **RF-PP06-065:** El sistema debe mostrar un resumen global del expediente previo a la decisión del Decano/a.
- **RF-PP06-066:** El sistema debe integrar montos, funcionarios, estados DGDP, resultados de Finanzas e ítems presupuestarios.
- **RF-PP06-067:** El sistema debe mostrar alertas u observaciones previas relevantes para la decisión.

---

# P06-B17 — Decisión global del Decano/a

## Funcionalidad P06-F21 — Aprobar solicitud y derivar a la etapa siguiente

### A. Descripción funcional

El Decano/a debe poder aprobar la solicitud cuando, conforme a su revisión institucional, el expediente puede continuar a la etapa siguiente del flujo.

### B. Actor principal

Decano/a.

### C. Acción disponible

- Botón: **APROBAR Y CONTINUAR**.

### D. Reglas de negocio

- La aprobación debe registrar:
  - Usuario aprobador.
  - Rol.
  - Fecha y hora.
  - Estado resultante.
- La solicitud aprobada debe avanzar a la etapa siguiente del flujo definida por el proceso.
- La aprobación se realiza sobre el expediente recibido desde Finanzas de Facultad, sin modificación de datos desde esta vista.

### E. Historia de usuario preliminar

**HU-P06-21:** Como **Decano/a**, quiero aprobar la solicitud cuando considero que puede continuar, para derivarla a la siguiente etapa institucional del flujo.

### F. Requerimientos funcionales preliminares

- **RF-PP06-068:** El sistema debe permitir aprobar la solicitud desde la vista del Decano/a.
- **RF-PP06-069:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
- **RF-PP06-070:** El sistema debe derivar la solicitud aprobada a la etapa siguiente del flujo.

---

## Funcionalidad P06-F22 — Devolver con corrección al Solicitante

### A. Descripción funcional

El Decano/a debe poder devolver la solicitud al Solicitante cuando detecte observaciones que puedan ser corregidas.

### B. Actor principal

Decano/a.

### C. Acción disponible

- Botón: **DEVOLVER CON CORRECCIÓN**.

### D. Datos de entrada requeridos

- Comentario obligatorio.
- Motivo o categoría de devolución, si se define un catálogo.

### E. Reglas de negocio

- La devolución con corrección debe registrar comentarios obligatorios.
- La solicitud debe volver al Solicitante para revisión o corrección.
- Los comentarios deben quedar visibles en la trazabilidad.
- La devolución debe gestionarse mediante un **modal global único**.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Decano), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P06-22:** Como **Decano/a**, quiero devolver con corrección la solicitud al Solicitante con comentarios, para informar observaciones subsanables antes de que el expediente continúe.

### G. Requerimientos funcionales preliminares

- **RF-PP06-071:** El sistema debe permitir devolver con corrección la solicitud al Solicitante.
- **RF-PP06-072:** El sistema debe exigir comentario obligatorio para ejecutar esta acción.
- **RF-PP06-073:** El sistema debe registrar la decisión con usuario, rol, fecha, hora y comentario.
- **RF-PP06-074:** El sistema debe dejar visible la observación al Solicitante.
- **RF-PP06-075:** El sistema debe ejecutar la devolución mediante un modal global único.
* **RF-PP06-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de mérito académico o institucional de la facultad y comentarios correspondientes.
* **RF-PP06-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P06-F23 — Rechazar solicitud

### A. Descripción funcional

El Decano/a debe poder rechazar definitivamente la solicitud cuando considere que no corresponde su continuidad.

### B. Actor principal

Decano/a.

### C. Acción disponible

- Botón: **RECHAZAR SOLICITUD**.

### D. Datos de entrada requeridos

- Comentario obligatorio.
- Motivo o categoría de rechazo, si se define un catálogo.

### E. Reglas de negocio

- El rechazo debe registrar comentarios obligatorios.
- La solicitud no debe continuar a etapas posteriores.
- Los comentarios deben quedar visibles en la trazabilidad.
- El rechazo debe gestionarse mediante un **modal global único**.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Decano), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones de mérito académico o institucional de la facultad), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P06-23:** Como **Decano/a**, quiero rechazar la solicitud con comentarios, para detener expedientes cuya continuidad no corresponda desde la visación de Facultad.

### G. Requerimientos funcionales preliminares

- **RF-PP06-076:** El sistema debe permitir rechazar la solicitud desde la pantalla del Decano/a.
- **RF-PP06-077:** El sistema debe exigir comentario obligatorio para ejecutar el rechazo.
- **RF-PP06-078:** El sistema debe registrar la decisión con usuario, rol, fecha, hora y comentario.
- **RF-PP06-079:** El sistema debe impedir que una solicitud rechazada continúe a etapas posteriores.
- **RF-PP06-080:** El sistema debe ejecutar el rechazo mediante un modal global único.
* **RF-PP06-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P06-B18 — Modal global de devolución/rechazo

## Funcionalidad P06-F24 — Gestionar devolución con corrección y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un único modal global para gestionar las acciones de **DEVOLVER CON CORRECCIÓN** y **RECHAZAR SOLICITUD**, centralizando el ingreso de motivo, comentario y confirmación.

### B. Actor principal

Decano/a.

### C. Información que debe contener el modal

- Tipo de acción seleccionada:
  - Devolver con corrección.
  - Rechazar solicitud.
- Motivo o categoría, si se define un catálogo.
- Comentario obligatorio.
- Mensaje de advertencia sobre el impacto de la acción.
- Botón de confirmar.
- Botón de cancelar.

### D. Reglas de negocio

- El modal debe adaptarse a la acción seleccionada.
- No debe permitir confirmar sin comentario obligatorio.
- Debe permitir cancelar sin modificar el estado de la solicitud.
- La acción confirmada debe generar trazabilidad.

### E. Historia de usuario preliminar

**HU-P06-24:** Como **Decano/a**, quiero gestionar la devolución o rechazo desde un modal único, para registrar de forma clara el motivo y confirmar la acción antes de modificar el expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP06-081:** El sistema debe utilizar un modal global único para devolución con corrección y rechazo.
- **RF-PP06-082:** El sistema debe exigir comentario obligatorio dentro del modal.
- **RF-PP06-083:** El sistema debe permitir cancelar la acción sin modificar el estado.
- **RF-PP06-084:** El sistema debe registrar la acción confirmada en trazabilidad.

---

# P06-B19 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P06-F25 — Confirmar decisión global antes de ejecutarla

### A. Descripción funcional

Antes de aprobar, devolver con corrección o rechazar la solicitud, el sistema debe solicitar confirmación explícita al Decano/a.

### B. Actor principal

Decano/a.

### C. Acciones que requieren confirmación

- **APROBAR Y CONTINUAR**.
- **DEVOLVER CON CORRECCIÓN**.
- **RECHAZAR SOLICITUD**.

### D. Reglas de negocio

- La confirmación debe permitir cancelar la acción sin modificar el estado del expediente.
- El comentario obligatorio debe estar registrado antes de confirmar una devolución o rechazo.
*   **Registro de Envío**: El sistema debe dejar registro del envío del correo electrónico en la trazabilidad del expediente.

### E. Historia de usuario preliminar

**HU-P06-25:** Como **Decano/a**, quiero confirmar mi decisión antes de ejecutarla, para evitar modificar por error el estado del expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP06-085:** El sistema debe solicitar confirmación antes de aprobar, devolver con corrección o rechazar.
- **RF-PP06-086:** El sistema debe permitir cancelar la decisión antes de aplicarla.
- **RF-PP06-087:** El sistema debe validar que las condiciones de comentario obligatorio se cumplan antes de confirmar devolución o rechazo.
* **RF-PP06-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

## Funcionalidad P06-F26 — Registrar trazabilidad de decisiones del Decano/a

### A. Descripción funcional

El sistema debe generar un registro automático y auditable de toda acción ejecutada en la Pantalla 06.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Aprobación global de la solicitud.
- Devolución con corrección al Solicitante.
- Rechazo de la solicitud.
- Comentarios asociados a devolución o rechazo.

### D. Datos mínimos de trazabilidad

- Código único de solicitud.
- Acción realizada.
- Usuario.
- Rol: Decano/a.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Comentario asociado, cuando corresponda.
- Motivo de devolución o rechazo, cuando aplique.

### E. Reglas de negocio

- No debe modificarse el estado global de la solicitud sin generar simultáneamente el registro de trazabilidad.
- La trazabilidad debe quedar disponible para etapas posteriores del flujo.

### F. Historia de usuario preliminar

**HU-P06-26:** Como **sistema**, debo registrar las decisiones emitidas por el Decano/a, para mantener una trazabilidad completa de la visación jerárquica del expediente.

### G. Requerimientos funcionales preliminares

- **RF-PP06-088:** El sistema debe registrar toda decisión ejecutada por el Decano/a.
- **RF-PP06-089:** El sistema debe almacenar comentario y motivo cuando corresponda.
- **RF-PP06-090:** El sistema debe dejar disponible la trazabilidad de esta etapa para los revisores posteriores.

---

# 7. Estados de salida de la Pantalla 06

| Acción del Decano/a | Estado resultante de la solicitud | Destino del flujo |
|---|---|---|
| **APROBAR Y CONTINUAR** | Aprobada por Decano/a / En revisión por etapa siguiente | Continúa el flujo institucional |
| **DEVOLVER CON CORRECCIÓN** | Devuelta con corrección al Solicitante por Decano/a | Regresa al Solicitante para corrección |
| **RECHAZAR SOLICITUD** | Rechazada por Decano/a | Cierre definitivo del expediente |

---

# 8. Reglas globales de comportamiento de la Pantalla 06

| Código | Regla |
|---|---|
| **RG-P06-001** | El Decano/a debe visualizar la información completa del expediente en modo solo lectura. |
| **RG-P06-002** | La pantalla debe mostrar la trazabilidad completa de las etapas previas, incluyendo DGDP y Finanzas de Facultad. |
| **RG-P06-003** | La pantalla debe mostrar a los funcionarios excluidos por DGDP y el motivo resumido de su exclusión. |
| **RG-P06-004** | La pantalla debe mostrar el monto original de la solicitud y el monto vigente posterior a exclusiones. |
| **RG-P06-005** | La pantalla debe mostrar información financiera del Centro de Costo, incluido el saldo disponible general y el monto comprometido. |
| **RG-P06-006** | La pantalla debe mostrar una tabla de ítems presupuestarios asociados al Centro de Costo, diferenciados por cargo, estamento o categoría. |
| **RG-P06-007** | La pantalla debe mostrar el estado de suficiencia presupuestaria por ítem como antecedente de revisión. |
| **RG-P06-008** | La pantalla debe identificar el ítem presupuestario aplicable a cada funcionario según su cargo, estamento o categoría. |
| **RG-P06-009** | La pantalla debe mostrar la lista de prestaciones solicitadas por funcionario. |
| **RG-P06-010** | La pantalla debe mostrar, por prestación, actividad específica, descripción, meses de pago, total comprometido, total en jornada, total fuera de jornada y total de compensación horaria. |
| **RG-P06-011** | La pantalla debe mostrar la lista de contratos vigentes del funcionario y los datos definidos, incluyendo SEA. |
| **RG-P06-012** | La pantalla debe mostrar el historial de PDS y de pagos por funcionario vigente, cuando exista información registrada. |
| **RG-P06-013** | La pantalla debe mostrar información financiera acumulada por funcionario. |
| **RG-P06-014** | La pantalla debe mostrar el estado DGDP de cada funcionario como antecedente de revisión. |
| **RG-P06-015** | La pantalla debe mostrar el estado financiero registrado por Finanzas de Facultad, cuando corresponda. |
| **RG-P06-016** | El Decano/a no debe aprobar ni rechazar individualmente funcionarios. |
| **RG-P06-017** | El Decano/a no debe modificar datos técnicos, normativos ni financieros ya revisados. |
| **RG-P06-018** | La aprobación global de la solicitud debe registrar usuario, rol, fecha y hora. |
| **RG-P06-019** | La devolución con corrección debe exigir comentario obligatorio. |
| **RG-P06-020** | El rechazo de solicitud debe exigir comentario obligatorio. |
| **RG-P06-021** | Toda decisión global de esta pantalla debe quedar registrada en trazabilidad. |
| **RG-P06-022** | La pantalla no debe editar datos de origen ni alterar exclusiones realizadas por DGDP. |
| **RG-P06-023** | La pantalla no debe incorporar Aprobación con Alcance, salvo definición posterior del proceso. |
| **RG-P06-024** | Las acciones globales de la pantalla deben homologarse a: **DEVOLVER CON CORRECCIÓN**, **RECHAZAR SOLICITUD** y **APROBAR Y CONTINUAR**. |
| **RG-P06-025** | La devolución con corrección y el rechazo deben gestionarse mediante un **modal global único**. |
| **RG-P06-026** | La pantalla no debe incorporar la acción **Salir sin guardar**. |
| **RG-P06-027** | El sistema debe permitir cambiar entre funcionarios para revisar su detalle individual. |
| **RG-PP06-028** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 9. Requerimientos no funcionales preliminares aplicables a la Pantalla 06

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P06-001** | Legibilidad integral | La pantalla debe permitir revisar información extensa del expediente sin perder la relación entre datos técnicos, normativos, financieros y de trazabilidad. |
| **RNF-P06-002** | Trazabilidad | Toda aprobación, devolución o rechazo del Decano/a debe quedar registrada y ser consultable en etapas posteriores. |
| **RNF-P06-003** | Integridad de datos | Los datos de etapas previas deben mantenerse en modo solo lectura y no alterarse desde esta pantalla. |
| **RNF-P06-004** | Claridad de funcionarios excluidos | Los funcionarios excluidos por DGDP deben visualizarse claramente separados de la nómina vigente. |
| **RNF-P06-005** | Consistencia de montos | El sistema debe mantener coherencia entre monto original, monto vigente, monto por funcionario, monto por ítem y monto global del expediente. |
| **RNF-P06-006** | Seguridad por rol | Solo usuarios autorizados con rol de Decano/a deben acceder a esta pantalla y ejecutar sus acciones. |
| **RNF-P06-007** | Confirmación de acciones | Las decisiones que cambien el estado del expediente deben requerir confirmación previa. |
| **RNF-P06-008** | Comentarios obligatorios | El sistema debe impedir devolver con corrección o rechazar la solicitud sin comentario registrado. |
| **RNF-P06-009** | Auditabilidad jerárquica | Debe ser posible reconstruir la decisión del Decano/a y el estado del expediente al momento de emitirla. |
| **RNF-P06-010** | Coherencia de antecedentes | La información mostrada debe mantenerse alineada con la versión del expediente que ingresó a la etapa Decano/a. |
| **RNF-P06-011** | Organización tabular | Las prestaciones solicitadas, los contratos vigentes y los ítems presupuestarios deben poder visualizarse en estructuras tabulares que faciliten su lectura. |
| **RNF-P06-012** | Separación funcional | La pantalla debe distinguir claramente entre información heredada desde DGDP, Finanzas de Facultad y la decisión emitida por el Decano/a. |
| **RNF-P06-013** | Transparencia presupuestaria | La pantalla debe permitir identificar claramente qué ítems presupuestarios respaldan la solicitud. |
| **RNF-P06-014** | Homologación de acciones | Las acciones globales deben presentarse con la nomenclatura definida: DEVOLVER CON CORRECCIÓN, RECHAZAR SOLICITUD y APROBAR Y CONTINUAR. |

---

# 10. Inventario consolidado de funcionalidades de la Pantalla 06

| Código | Funcionalidad |
|---|---|
| **P06-F01** | Visualizar identificación de la solicitud. |
| **P06-F02** | Visualizar estado actual del expediente. |
| **P06-F03** | Visualizar aprobaciones y decisiones previas del flujo. |
| **P06-F04** | Visualizar línea de avance del flujo. |
| **P06-F05** | Visualizar funcionarios excluidos por DGDP. |
| **P06-F06** | Visualizar resumen general de la solicitud. |
| **P06-F07** | Visualizar información completa del Centro de Costo. |
| **P06-F08** | Visualizar tabla de ítems presupuestarios asociados al Centro de Costo. |
| **P06-F09** | Visualizar contexto técnico resumido de la solicitud. |
| **P06-F10** | Visualizar funcionarios activos que continúan en el proceso. |
| **P06-F11** | Seleccionar funcionario para revisión detallada. |
| **P06-F12** | Visualizar antecedentes laborales relevantes por funcionario. |
| **P06-F13** | Visualizar tabla de prestaciones solicitadas por funcionario. |
| **P06-F14** | Visualizar lista de contratos vigentes del funcionario. |
| **P06-F15** | Visualizar historial de PDS previas del funcionario. |
| **P06-F16** | Visualizar información financiera acumulada del funcionario. |
| **P06-F17** | Visualizar historial de pagos del funcionario. |
| **P06-F18** | Visualizar resultado resumido de validaciones DGDP. |
| **P06-F19** | Visualizar resultado financiero registrado por Finanzas de Facultad. |
| **P06-F20** | Visualizar resumen global previo a la decisión. |
| **P06-F21** | Aprobar solicitud y derivar a la etapa siguiente. |
| **P06-F22** | Devolver con corrección al Solicitante. |
| **P06-F23** | Rechazar solicitud. |
| **P06-F24** | Gestionar devolución con corrección y rechazo mediante modal global único. |
| **P06-F25** | Confirmar decisión global antes de ejecutarla. |
| **P06-F26** | Registrar trazabilidad de decisiones del Decano/a. |
