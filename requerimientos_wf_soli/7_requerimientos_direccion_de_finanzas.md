# PDS Normativo D9 / DU288 / DU09

## Pantalla 07 — Visación Financiera Central por Dirección de Finanzas

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 07: Visación Financiera Central — Perfil Dirección de Finanzas** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a una etapa de **revisión financiera central e institucional**, posterior a la visación del **Decano/a**. Su propósito es permitir que la Dirección de Finanzas visualice el expediente completo, revise los antecedentes técnicos, normativos, presupuestarios, financieros y de trazabilidad generados en las etapas anteriores, y emita una decisión global sobre la continuidad de la solicitud.

La Pantalla 07 debe mantener una estructura visual y funcional coherente con las pantallas anteriores, especialmente con:

- **Pantalla 05 — Finanzas de Facultad**, por la profundidad del detalle financiero, presupuestario y por funcionario.
- **Pantalla 06 — Decano/a**, por la lógica de revisión global en modo solo lectura y decisión institucional.

La Pantalla 07 debe permitir revisar:

- La información general de la solicitud.
- El expediente técnico de la prestación.
- El historial completo de visaciones y decisiones previas.
- Los resultados de la revisión normativa DGDP.
- Los funcionarios excluidos previamente y sus motivos.
- Los resultados de la revisión financiera de Finanzas de Facultad.
- La decisión emitida por el Decano/a.
- El Centro de Costo y su información presupuestaria.
- La tabla de ítems presupuestarios por cargo, estamento o categoría.
- La suficiencia presupuestaria asociada a cada ítem.
- La nómina vigente de funcionarios que continúan en la solicitud.
- El detalle completo de cada funcionario vigente.
- El historial de PDS, pagos e información financiera acumulada.
- El resumen consolidado del expediente previo a la decisión de Dirección de Finanzas.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 07 — Dirección de Finanzas**. No modifica las pantallas anteriores. Su objetivo es definir qué información debe visualizar Dirección de Finanzas, qué antecedentes previos deben estar disponibles y qué decisiones globales puede registrar sobre la solicitud.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P07 |
| **Nombre** | Visación Financiera Central por Dirección de Finanzas |
| **Perfil principal** | Analista / Profesional autorizado de Dirección de Finanzas |
| **Etapa del flujo** | Etapa 07 — Visación financiera central |
| **Estado de entrada esperado** | Solicitud aprobada por Decano/a y enviada a revisión de Dirección de Finanzas |
| **Objetivo principal** | Permitir que Dirección de Finanzas revise integralmente el expediente, visualice los resultados técnicos, normativos, financieros y jerárquicos de etapas previas, y emita una decisión global sobre la continuidad de la solicitud. |
| **Resultado posible** | Solicitud aprobada y derivada a la etapa siguiente; solicitud devuelta con corrección al Solicitante; o solicitud rechazada. |

---

# 3. Principio funcional de la Pantalla 07

La Pantalla 07 debe operar como una **vista de revisión financiera central y decisión global**, basada en la información consolidada del expediente y en los resultados emitidos por las etapas previas.

A diferencia de **Finanzas de Facultad**, esta pantalla no está orientada a registrar una nueva revisión financiera individual por funcionario, salvo que una definición posterior del flujo indique lo contrario. Su foco principal es permitir que Dirección de Finanzas revise el expediente completo desde una perspectiva financiera central, institucional y de consistencia presupuestaria global.

La vista debe mantener un nivel de detalle equivalente al de la Pantalla 05 y la Pantalla 06, incorporando:

- Revisión del expediente técnico.
- Revisión de la trazabilidad completa.
- Revisión de funcionarios excluidos previamente.
- Revisión de funcionarios vigentes.
- Revisión de antecedentes DGDP.
- Revisión de antecedentes financieros de Facultad.
- Revisión de la autorización de Decanato.
- Revisión de Centro de Costo e ítems presupuestarios.
- Revisión del detalle financiero y contractual por funcionario.
- Decisión global de Dirección de Finanzas.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 07 debe permitir que Dirección de Finanzas:

- Visualice la solicitud completa en modo solo lectura.
- Revise las decisiones y visaciones emitidas en las etapas anteriores:
  - Solicitante.
  - Jefe de Proyecto.
  - Jefatura Directa / Dirección de Departamento.
  - DGDP.
  - Finanzas de Facultad.
  - Decano/a.
- Visualice el resultado de la revisión normativa DGDP.
- Visualice si DGDP excluyó funcionarios y el motivo resumido de dicha exclusión.
- Visualice el resultado de la revisión financiera de Finanzas de Facultad.
- Visualice la decisión emitida por el Decano/a.
- Revise el Centro de Costo y todos sus datos financieros relevantes.
- Visualice:
  - Saldo disponible general del Centro de Costo.
  - Monto total original de la solicitud.
  - Monto actualizado posterior a exclusiones previas.
  - Monto vigente aprobado por etapas anteriores.
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
- Visualice la actividad general, tipo de prestación, justificación técnica y evidencias comprometidas.
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
  - Estado de visación del Decano/a como antecedente global.
- Visualice, por cada funcionario excluido por DGDP:
  - Identificación.
  - Etapa de exclusión.
  - Motivo resumido.
  - Comentario asociado, si corresponde.
  - Monto excluido de la solicitud vigente.
- Visualice un resumen consolidado del expediente, considerando:
  - Estado general de la solicitud.
  - Funcionarios vigentes.
  - Funcionarios excluidos.
  - Resultado DGDP.
  - Resultado de Finanzas de Facultad.
  - Resultado de Decanato.
  - Monto vigente de la solicitud.
  - Disponibilidad general e ítems presupuestarios.
- Apruebe la solicitud mediante la acción **APROBAR Y CONTINUAR**.
- Devuelva la solicitud al Solicitante mediante la acción **DEVOLVER CON CORRECCIÓN**.
- Rechace la solicitud mediante la acción **RECHAZAR SOLICITUD**.
- Gestione la devolución con corrección y el rechazo mediante un **modal global único**.
- Registre comentarios obligatorios cuando la solicitud no sea aprobada.
- Confirme la acción antes de modificar el estado del expediente.
- Mantenga trazabilidad completa de la decisión de Dirección de Finanzas.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 07 no debe:

- Editar los datos originales ingresados por el Solicitante.
- Modificar los antecedentes aprobados en etapas previas.
- Incorporar nuevos funcionarios a la solicitud.
- Reponer funcionarios excluidos por DGDP.
- Cambiar los motivos de exclusión registrados por DGDP.
- Alterar los resultados de validación normativa emitidos por DGDP.
- Alterar los resultados de revisión financiera emitidos por Finanzas de Facultad.
- Alterar la decisión emitida por Decanato.
- Registrar una nueva aprobación o rechazo individual por funcionario, salvo definición posterior del flujo.
- Revalidar presupuestariamente los ítems como función operativa principal, salvo que se defina formalmente como responsabilidad de esta etapa.
- Modificar directamente compensaciones horarias, condición SEA, topes salariales o inhabilidades.
- Alterar manualmente los saldos presupuestarios desde la vista.
- Cambiar el ítem presupuestario asociado a un funcionario.
- Eliminar información histórica del expediente.
- Ocultar a los funcionarios que fueron excluidos previamente del proceso.
- Alterar los registros históricos de prestaciones o pagos de los funcionarios.
- Incorporar la opción de **Aprobación con Alcance**, salvo que una definición posterior del proceso indique que corresponde a esta etapa.
- Incorporar la acción **Salir sin guardar** como opción operativa de la pantalla.

---

# 4. Objetivo funcional de la Pantalla 07

La pantalla debe permitir que Dirección de Finanzas:

1. Identifique la solicitud que ingresa a visación financiera central.
2. Visualice el estado actual del expediente y la etapa del flujo.
3. Revise la trazabilidad completa de las decisiones previas.
4. Visualice la aprobación del Jefe de Proyecto.
5. Visualice la aprobación de la Jefatura Directa / Dirección de Departamento.
6. Visualice el resultado de la revisión DGDP.
7. Conozca si hubo exclusiones de funcionarios en DGDP y por qué.
8. Visualice el resultado consolidado de la revisión financiera de Finanzas de Facultad.
9. Visualice la decisión emitida por Decano/a.
10. Visualice un resumen ejecutivo completo de la solicitud.
11. Revise los datos del Centro de Costo, proyecto, unidad ejecutora, decreto y financiamiento.
12. Consulte el saldo disponible general del Centro de Costo.
13. Visualice la tabla de ítems presupuestarios asociados al Centro de Costo.
14. Revise el presupuesto disponible por cargo, estamento o categoría asociada a cada ítem.
15. Compare el monto total original de la solicitud con el monto vigente posterior a exclusiones.
16. Visualice el impacto financiero total de la PDS.
17. Revise los antecedentes generales de la prestación:
    - Actividad.
    - Tipo de prestación.
    - Justificación técnica.
    - Evidencias comprometidas.
    - Periodo de ejecución.
18. Visualice los funcionarios que continúan activos en la solicitud.
19. Visualice los funcionarios excluidos previamente y el motivo de su salida del flujo.
20. Seleccione o cambie entre funcionarios para revisar su detalle individual.
21. Revise el detalle laboral y contractual de cada funcionario activo.
22. Revise el contrato seleccionado para la PDS.
23. Visualice el ítem presupuestario que corresponde al funcionario según su cargo, estamento o categoría.
24. Visualice el estado de suficiencia presupuestaria del ítem correspondiente.
25. Visualice la lista de prestaciones solicitadas por funcionario.
26. Revise los montos comprometidos por prestación, incluyendo:
    - Total comprometido.
    - Total en jornada.
    - Total fuera de jornada.
    - Total compensación horaria.
27. Visualice la lista de contratos vigentes del funcionario junto con los datos definidos para revisión institucional.
28. Revise la condición SEA asociada al funcionario cuando corresponda.
29. Consulte el historial de PDS previas por funcionario.
30. Consulte el historial de pagos e información financiera acumulada por funcionario.
31. Visualice el estado DGDP de cada funcionario.
32. Visualice el resultado financiero registrado por Finanzas de Facultad, cuando corresponda.
33. Visualice un resumen consolidado de la solicitud antes de decidir.
34. Apruebe la solicitud cuando considere que puede continuar.
35. Devuelva con corrección la solicitud al Solicitante cuando existan observaciones subsanables.
36. Rechace la solicitud cuando existan observaciones que impidan su continuidad.
37. Confirme la decisión antes de aplicarla.
38. Registre trazabilidad de toda decisión ejecutada en esta etapa.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 07 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P07-B01** | Encabezado de expediente y estado de revisión de Dirección de Finanzas | Identificar la solicitud, su estado y el rol revisor. |
| **P07-B02** | Trazabilidad de etapas previas | Mostrar el historial completo de aprobación y revisión hasta Decanato. |
| **P07-B03** | Resumen de funcionarios excluidos previamente | Mostrar quiénes fueron retirados del proceso y por qué. |
| **P07-B04** | Resumen ejecutivo financiero central del expediente | Mostrar el estado general financiero e institucional antes de la decisión. |
| **P07-B05** | Centro de Costo, proyecto y disponibilidad presupuestaria general | Exponer los antecedentes financieros centrales del expediente. |
| **P07-B06** | Ítems presupuestarios por cargo, estamento o categoría | Mostrar la distribución presupuestaria del Centro de Costo y el saldo aplicable a los funcionarios. |
| **P07-B07** | Actividad, prestación, justificación y evidencias del expediente | Mostrar el contexto técnico general de la solicitud. |
| **P07-B08** | Nómina de funcionarios vigentes | Mostrar los funcionarios que continúan activos en la solicitud. |
| **P07-B09** | Selector y ficha laboral/contractual por funcionario | Permitir cambiar entre funcionarios y revisar sus datos individuales. |
| **P07-B10** | Prestaciones solicitadas en la solicitud actual por funcionario | Mostrar el detalle de cada prestación solicitada y sus montos asociados. |
| **P07-B11** | Contratos vigentes y datos asociados por funcionario | Mostrar los contratos del funcionario y los datos relevantes para la revisión central. |
| **P07-B12** | Historial de prestaciones previas e información financiera acumulada | Mostrar PDS históricas y acumulados asociados al funcionario. |
| **P07-B13** | Historial de pagos por funcionario | Mostrar pagos previos y antecedentes financieros históricos. |
| **P07-B14** | Estado resumido de validaciones DGDP por funcionario | Mostrar los resultados normativos previos. |
| **P07-B15** | Estado resumido de revisión financiera por funcionario | Mostrar los resultados de Finanzas de Facultad por funcionario, cuando corresponda. |
| **P07-B16** | Estado de visación de Decanato | Mostrar la aprobación o decisión emitida por Decano/a como antecedente de entrada. |
| **P07-B17** | Resumen consolidado para decisión de Dirección de Finanzas | Mostrar el estado integral de la solicitud previo a la visación central. |
| **P07-B18** | Decisión global de Dirección de Finanzas | Permitir devolver con corrección, rechazar solicitud o aprobar y continuar. |
| **P07-B19** | Modal global de devolución/rechazo | Gestionar motivo, comentario y confirmación para devolución con corrección o rechazo. |
| **P07-B20** | Confirmación, transición de estado y trazabilidad | Confirmar decisiones y registrar el historial de la etapa. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P07-B01 — Encabezado de expediente y estado de revisión de Dirección de Finanzas

## Funcionalidad P07-F01 — Visualizar identificación de la solicitud

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación única de la solicitud que será revisada por Dirección de Finanzas.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Número o código único de solicitud.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Título de la etapa: Visación Financiera Central.

### D. Reglas de negocio

- El identificador de la solicitud debe mantenerse inalterable durante todo el flujo.
- Debe permanecer visible durante la revisión de Dirección de Finanzas.

### E. Historia de usuario preliminar

**HU-P07-01:** Como **Dirección de Finanzas**, quiero visualizar claramente el identificador del expediente en revisión, para asociar mi decisión a la solicitud correcta.

### F. Requerimientos funcionales preliminares

- **RF-PP07-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-PP07-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo.

---

## Funcionalidad P07-F02 — Visualizar estado actual del expediente

### A. Descripción funcional

El sistema debe mostrar que la solicitud se encuentra en revisión por Dirección de Finanzas.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Estado: **En revisión por Dirección de Finanzas**.
- Etapa actual del flujo.
- Fecha de ingreso a la etapa de visación financiera central.

### D. Reglas de negocio

- Solo deben llegar a esta etapa solicitudes aprobadas previamente por Decano/a.
- Mientras el expediente se encuentre en revisión por Dirección de Finanzas, no debe ser editable por el Solicitante.

### E. Historia de usuario preliminar

**HU-P07-02:** Como **Dirección de Finanzas**, quiero visualizar el estado actual del expediente, para confirmar que se encuentra habilitado para mi revisión y decisión.

### F. Requerimientos funcionales preliminares

- **RF-PP07-003:** El sistema debe mostrar el estado actual de revisión por Dirección de Finanzas.
- **RF-PP07-004:** El sistema debe mostrar la fecha de ingreso de la solicitud a esta etapa.

---

# P07-B02 — Trazabilidad de etapas previas

## Funcionalidad P07-F03 — Visualizar aprobaciones y decisiones previas del flujo

### A. Descripción funcional

El sistema debe mostrar a Dirección de Finanzas el recorrido histórico completo del expediente hasta su llegada a esta etapa.

### B. Actor principal

Dirección de Finanzas.

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
- Decisión emitida por Decano/a.

### E. Historia de usuario preliminar

**HU-P07-03:** Como **Dirección de Finanzas**, quiero revisar las decisiones emitidas en etapas anteriores, para comprender el recorrido del expediente antes de emitir la visación financiera central.

### F. Requerimientos funcionales preliminares

- **RF-PP07-005:** El sistema debe mostrar cronológicamente las decisiones registradas antes de Dirección de Finanzas.
- **RF-PP07-006:** El sistema debe mostrar usuario, rol, acción, fecha, hora y comentario cuando corresponda.
- **RF-PP07-007:** El sistema debe incorporar en la trazabilidad las exclusiones realizadas por DGDP, la revisión de Finanzas de Facultad y la decisión de Decanato.

---

## Funcionalidad P07-F04 — Visualizar línea de avance del flujo

### A. Descripción funcional

El sistema debe mostrar visualmente el progreso del expediente dentro del flujo completo.

### B. Actor principal

Dirección de Finanzas.

### C. Hitos mínimos a mostrar

- Solicitud creada.
- Aprobación Jefe de Proyecto.
- Aprobación Jefatura Directa / Dirección de Departamento.
- Revisión DGDP.
- Revisión Finanzas de Facultad.
- Visación Decanato.
- Etapa actual: Dirección de Finanzas.
- Etapa siguiente pendiente.

### D. Historia de usuario preliminar

**HU-P07-04:** Como **Dirección de Finanzas**, quiero visualizar el avance del expediente en el flujo, para comprender en qué etapa se encuentra y qué revisiones ya fueron realizadas.

### E. Requerimientos funcionales preliminares

- **RF-PP07-008:** El sistema debe mostrar una línea de avance del expediente.
- **RF-PP07-009:** El sistema debe diferenciar etapas cumplidas, etapa actual y etapas pendientes.

---

# P07-B03 — Resumen de funcionarios excluidos previamente

## Funcionalidad P07-F05 — Visualizar funcionarios excluidos por DGDP

### A. Descripción funcional

El sistema debe mostrar de forma resumida a los funcionarios que fueron excluidos de la solicitud durante la etapa DGDP, junto con el motivo de exclusión.

### B. Actor principal

Dirección de Finanzas.

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
- Monto bruto original asociado.
- Monto descontado del total vigente de la solicitud.

### D. Reglas de negocio

- Los funcionarios excluidos no deben formar parte del cálculo vigente de la solicitud.
- Deben mantenerse visibles como antecedente histórico del expediente.
- La exclusión no puede ser editada desde la vista de Dirección de Finanzas.

### E. Historia de usuario preliminar

**HU-P07-05:** Como **Dirección de Finanzas**, quiero visualizar qué funcionarios fueron excluidos por DGDP y por qué, para comprender la composición final de la solicitud que llega a mi revisión.

### F. Requerimientos funcionales preliminares

- **RF-PP07-010:** El sistema debe mostrar los funcionarios excluidos por DGDP.
- **RF-PP07-011:** El sistema debe mostrar el motivo resumido de cada exclusión.
- **RF-PP07-012:** El sistema debe mostrar el monto excluido asociado a cada funcionario, cuando corresponda.
- **RF-PP07-013:** El sistema no debe permitir modificar las exclusiones previas desde esta pantalla.

---

# P07-B04 — Resumen ejecutivo financiero central del expediente

## Funcionalidad P07-F06 — Visualizar resumen general de la solicitud

### A. Descripción funcional

El sistema debe mostrar un resumen ejecutivo que permita a Dirección de Finanzas comprender rápidamente el estado financiero e institucional del expediente.

### B. Actor principal

Dirección de Finanzas.

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
- Monto total excluido por DGDP.
- Monto total vigente posterior a exclusiones.
- Saldo disponible general del Centro de Costo.
- Saldo estimado posterior a aprobación, si la fuente lo permite.
- Estado consolidado de la revisión DGDP.
- Estado consolidado de la revisión de Finanzas de Facultad.
- Estado de visación de Decanato.

### D. Reglas de negocio

- El monto total vigente debe considerar únicamente a los funcionarios que continúan activos en el proceso.
- Debe diferenciarse claramente el monto original del monto ajustado posterior a exclusiones.
- El resumen debe presentar el expediente en su estado vigente al ingreso a Dirección de Finanzas.

### E. Historia de usuario preliminar

**HU-P07-06:** Como **Dirección de Finanzas**, quiero visualizar un resumen financiero central del expediente, para tomar una decisión informada sobre su continuidad.

### F. Requerimientos funcionales preliminares

- **RF-PP07-014:** El sistema debe mostrar el monto original de la solicitud.
- **RF-PP07-015:** El sistema debe mostrar el monto vigente posterior a exclusiones previas.
- **RF-PP07-016:** El sistema debe mostrar la cantidad de funcionarios originales, excluidos y vigentes.
- **RF-PP07-017:** El sistema debe mostrar el saldo disponible general del Centro de Costo.
- **RF-PP07-018:** El sistema debe mostrar el resultado consolidado de DGDP, Finanzas de Facultad y Decanato.

---

# P07-B05 — Centro de Costo, proyecto y disponibilidad presupuestaria general

## Funcionalidad P07-F07 — Visualizar información completa del Centro de Costo

### A. Descripción funcional

Dirección de Finanzas debe visualizar todos los antecedentes del Centro de Costo asociados al expediente, priorizando los elementos relevantes para comprender la consistencia financiera central de la solicitud.

### B. Actor principal

Dirección de Finanzas.

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
- Los datos del Centro de Costo deben corresponder al expediente vigente posterior a Decanato.
- La información general del Centro de Costo debe vincularse visualmente con la tabla de ítems presupuestarios por cargo, estamento o categoría.

### E. Historia de usuario preliminar

**HU-P07-07:** Como **Dirección de Finanzas**, quiero revisar la información completa del Centro de Costo y su disponibilidad presupuestaria, para comprender el respaldo financiero central de la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP07-019:** El sistema debe mostrar los datos financieros y administrativos del Centro de Costo.
- **RF-PP07-020:** El sistema debe mostrar el saldo disponible general y el monto comprometido por la solicitud.
- **RF-PP07-021:** El sistema debe vincular la información del Centro de Costo con sus ítems presupuestarios asociados.

---

# P07-B06 — Ítems presupuestarios por cargo, estamento o categoría

## Funcionalidad P07-F08 — Visualizar tabla de ítems presupuestarios asociados al Centro de Costo

### A. Descripción funcional

El sistema debe mostrar a Dirección de Finanzas la tabla de ítems presupuestarios disponibles en el Centro de Costo, diferenciados según el cargo, estamento o categoría funcionaria habilitada para su imputación.

### B. Actor principal

Dirección de Finanzas.

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
- Los valores deben reflejar la última revisión financiera disponible en el expediente.
- La tabla debe ser informativa y no editable desde la vista de Dirección de Finanzas, salvo definición posterior del flujo.

### E. Historia de usuario preliminar

**HU-P07-08:** Como **Dirección de Finanzas**, quiero visualizar los ítems presupuestarios del Centro de Costo diferenciados por cargo o estamento, para conocer cómo se respalda financieramente la solicitud a nivel central.

### F. Requerimientos funcionales preliminares

- **RF-PP07-022:** El sistema debe mostrar una tabla de ítems presupuestarios asociados al Centro de Costo.
- **RF-PP07-023:** El sistema debe mostrar el cargo, estamento o categoría relacionada con cada ítem.
- **RF-PP07-024:** El sistema debe mostrar presupuesto asignado, monto comprometido, saldo disponible, monto solicitado y saldo proyectado por ítem.
- **RF-PP07-025:** El sistema debe mostrar el estado de suficiencia presupuestaria por ítem.
- **RF-PP07-026:** El sistema no debe permitir modificar los datos presupuestarios desde la vista de Dirección de Finanzas.

---

# P07-B07 — Actividad, prestación, justificación y evidencias del expediente

## Funcionalidad P07-F09 — Visualizar contexto técnico resumido de la solicitud

### A. Descripción funcional

Dirección de Finanzas debe visualizar de manera resumida el contexto técnico del expediente, con el fin de relacionar la solicitud con la prestación que la origina.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Descripción general de la actividad.
- Justificación técnica de la necesidad.
- Tipo o tipos de prestación seleccionados.
- Descripción de “Otro”, si corresponde.
- Fecha de inicio.
- Fecha de término.
- Evidencias comprometidas.
- Fecha estimada de entrega por evidencia.

### D. Reglas de negocio

- Esta sección es informativa y de solo lectura.
- No reemplaza las revisiones técnicas de etapas anteriores.
- Debe permitir entender el gasto asociado a la prestación sin editar el contenido del expediente.

### E. Historia de usuario preliminar

**HU-P07-09:** Como **Dirección de Finanzas**, quiero visualizar el contexto técnico resumido de la solicitud, para comprender el propósito institucional de la prestación antes de decidir.

### F. Requerimientos funcionales preliminares

- **RF-PP07-027:** El sistema debe mostrar la descripción general de la actividad.
- **RF-PP07-028:** El sistema debe mostrar la justificación técnica de la necesidad.
- **RF-PP07-029:** El sistema debe mostrar los tipos de prestación seleccionados.
- **RF-PP07-030:** El sistema debe mostrar las evidencias comprometidas y sus fechas estimadas.

---

# P07-B08 — Nómina de funcionarios vigentes

## Funcionalidad P07-F10 — Visualizar funcionarios activos que continúan en el proceso

### A. Descripción funcional

El sistema debe mostrar la nómina de funcionarios que continúan vigentes en la solicitud luego de las revisiones DGDP, Finanzas de Facultad y Decanato.

### B. Actor principal

Dirección de Finanzas.

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
- Los estados heredados desde DGDP, Finanzas de Facultad y Decanato deben mostrarse en modo solo lectura.

### E. Historia de usuario preliminar

**HU-P07-10:** Como **Dirección de Finanzas**, quiero visualizar la nómina de funcionarios vigentes y sus estados previos de validación, para comprender la composición de la solicitud antes de visarla.

### F. Requerimientos funcionales preliminares

- **RF-PP07-031:** El sistema debe mostrar la nómina de funcionarios vigentes posterior a las etapas previas.
- **RF-PP07-032:** El sistema debe mostrar el estado DGDP de cada funcionario.
- **RF-PP07-033:** El sistema debe mostrar el estado financiero registrado por Finanzas de Facultad cuando corresponda.
- **RF-PP07-034:** El sistema debe mostrar el ítem presupuestario asociado y el estado de suficiencia presupuestaria por funcionario.

---

# P07-B09 — Selector y ficha laboral/contractual por funcionario

## Funcionalidad P07-F11 — Seleccionar funcionario para revisión detallada

### A. Descripción funcional

El sistema debe permitir a Dirección de Finanzas cambiar entre los funcionarios vigentes en la solicitud para visualizar su detalle individual.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-11:** Como **Dirección de Finanzas**, quiero seleccionar distintos funcionarios dentro de la solicitud, para revisar el detalle de cada uno sin salir de la pantalla.

### F. Requerimientos funcionales preliminares

- **RF-PP07-035:** El sistema debe permitir seleccionar o cambiar entre funcionarios vigentes de la solicitud.
- **RF-PP07-036:** El sistema debe actualizar la información visible según el funcionario seleccionado.
- **RF-PP07-037:** El sistema debe mantener visible la identidad del funcionario actualmente revisado.

---

## Funcionalidad P07-F12 — Visualizar antecedentes laborales relevantes por funcionario

### A. Descripción funcional

Dirección de Finanzas debe visualizar la información laboral y contractual relevante de cada funcionario vigente como antecedente para su revisión central.

### B. Actor principal

Dirección de Finanzas.

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

### E. Historia de usuario preliminar

**HU-P07-12:** Como **Dirección de Finanzas**, quiero visualizar los antecedentes laborales relevantes del funcionario junto con sus estados previos de revisión, para contextualizar la decisión financiera central sobre la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP07-038:** El sistema debe mostrar la ficha laboral resumida de cada funcionario vigente.
- **RF-PP07-039:** El sistema debe identificar el contrato seleccionado para la PDS.
- **RF-PP07-040:** El sistema debe mostrar la cantidad de contratos vigentes cuando esta información esté disponible.
- **RF-PP07-041:** El sistema debe mostrar el ítem presupuestario asociado al funcionario.
- **RF-PP07-042:** El sistema debe mostrar los estados DGDP y Finanzas de Facultad como antecedentes de solo lectura.

---

# P07-B10 — Prestaciones solicitadas en la solicitud actual por funcionario

## Funcionalidad P07-F13 — Visualizar tabla de prestaciones solicitadas por funcionario

### A. Descripción funcional

Dirección de Finanzas debe visualizar una tabla con las prestaciones solicitadas asociadas a cada funcionario vigente.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-13:** Como **Dirección de Finanzas**, quiero visualizar la tabla de prestaciones solicitadas por funcionario, para conocer el contenido económico y operativo de la solicitud antes de decidir.

### F. Requerimientos funcionales preliminares

- **RF-PP07-043:** El sistema debe mostrar las prestaciones solicitadas por funcionario.
- **RF-PP07-044:** El sistema debe mostrar actividad específica y descripción de actividad asociadas a cada prestación.
- **RF-PP07-045:** El sistema debe mostrar meses de pago y total comprometido por prestación.
- **RF-PP07-046:** El sistema debe mostrar total en jornada, total fuera de jornada y total de compensación horaria por prestación.
- **RF-PP07-047:** El sistema debe mostrar el ítem presupuestario asociado a cada prestación.

---

# P07-B11 — Contratos vigentes y datos asociados por funcionario

## Funcionalidad P07-F14 — Visualizar lista de contratos vigentes del funcionario

### A. Descripción funcional

Dirección de Finanzas debe visualizar la lista de contratos vigentes del funcionario junto con los datos ya utilizados en las revisiones previas.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-14:** Como **Dirección de Finanzas**, quiero visualizar la lista de contratos vigentes del funcionario, para revisar los antecedentes laborales y de jornada que acompañan la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP07-048:** El sistema debe mostrar la lista de contratos vigentes del funcionario.
- **RF-PP07-049:** El sistema debe distinguir el contrato seleccionado para la PDS.
- **RF-PP07-050:** El sistema debe mostrar, por contrato, descripción de actividad, meses de pago, total comprometido, total en jornada, total fuera de jornada, total compensación horaria y SEA.

---

# P07-B12 — Historial de prestaciones previas e información financiera acumulada

## Funcionalidad P07-F15 — Visualizar historial de PDS previas del funcionario

### A. Descripción funcional

Dirección de Finanzas debe visualizar el historial de prestaciones de servicios anteriores del funcionario como antecedente institucional.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-15:** Como **Dirección de Finanzas**, quiero revisar las prestaciones previas del funcionario, para disponer de antecedentes históricos antes de emitir mi decisión.

### F. Requerimientos funcionales preliminares

- **RF-PP07-051:** El sistema debe mostrar el historial de PDS previas por funcionario.
- **RF-PP07-052:** El sistema debe informar cuando no existan PDS previas registradas.
- **RF-PP07-053:** El sistema debe permitir identificar la relación entre las PDS previas y la solicitud actual cuando corresponda.

---

## Funcionalidad P07-F16 — Visualizar información financiera acumulada del funcionario

### A. Descripción funcional

El sistema debe consolidar la información financiera histórica del funcionario como antecedente de revisión.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Total pagado en PDS previas dentro del periodo consultado.
- Total de prestaciones registradas.
- Monto acumulado histórico relevante.
- Último pago registrado.
- Otras solicitudes vigentes, si la información se encuentra disponible.
- Total comprometido actual en la solicitud.
- Comparación entre acumulado histórico y compromiso vigente, cuando corresponda.

### D. Historia de usuario preliminar

**HU-P07-16:** Como **Dirección de Finanzas**, quiero visualizar la información financiera acumulada del funcionario, para comprender sus antecedentes de prestaciones y compromisos vigentes.

### E. Requerimientos funcionales preliminares

- **RF-PP07-054:** El sistema debe mostrar un resumen consolidado del historial financiero por funcionario.
- **RF-PP07-055:** El sistema debe mostrar acumulados y cantidades relevantes para la revisión central.
- **RF-PP07-056:** El sistema debe mostrar el total comprometido actual dentro de la solicitud.

---

# P07-B13 — Historial de pagos por funcionario

## Funcionalidad P07-F17 — Visualizar historial de pagos del funcionario

### A. Descripción funcional

Dirección de Finanzas debe poder revisar el historial de pagos asociados a prestaciones anteriores del funcionario.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-17:** Como **Dirección de Finanzas**, quiero visualizar el historial de pagos del funcionario, para revisar sus antecedentes financieros vinculados a prestaciones previas.

### E. Requerimientos funcionales preliminares

- **RF-PP07-057:** El sistema debe mostrar el historial de pagos por funcionario.
- **RF-PP07-058:** El sistema debe mostrar montos brutos, netos y acumulados cuando se encuentren disponibles.
- **RF-PP07-059:** El sistema debe indicar el estado de cada pago registrado.

---

# P07-B14 — Estado resumido de validaciones DGDP por funcionario

## Funcionalidad P07-F18 — Visualizar resultado resumido de validaciones DGDP

### A. Descripción funcional

Dirección de Finanzas debe visualizar un resumen de las validaciones previas aplicadas por DGDP a cada funcionario.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Estado DGDP:
  - Cumple.
  - Excluido.
  - Otro estado definido.
- Tope normativo: Cumple / No aplica / Observado.
- Deudas institucionales: Sin deuda / Observado / Según estado registrado.
- Inhabilidad por cargo: Cumple / No aplica / Observado.
- SEA y compensación: Validado / No aplica / Observado.
- Observaciones relevantes heredadas de DGDP, cuando existan.

### D. Reglas de negocio

- Esta sección debe mostrarse como antecedente informativo.
- No debe permitir modificar el resultado de DGDP desde esta pantalla.

### E. Historia de usuario preliminar

**HU-P07-18:** Como **Dirección de Finanzas**, quiero visualizar un resumen de las validaciones DGDP aplicadas a cada funcionario, para conocer los controles normativos superados antes de emitir mi decisión.

### F. Requerimientos funcionales preliminares

- **RF-PP07-060:** El sistema debe mostrar el estado DGDP de cada funcionario.
- **RF-PP07-061:** El sistema debe mostrar de forma resumida los resultados normativos relevantes previamente registrados.
- **RF-PP07-062:** El sistema no debe permitir modificar las validaciones heredadas desde DGDP.

---

# P07-B15 — Estado resumido de revisión financiera por funcionario

## Funcionalidad P07-F19 — Visualizar resultado financiero registrado por Finanzas de Facultad

### A. Descripción funcional

Dirección de Finanzas debe visualizar el resultado de la revisión financiera realizada por Finanzas de Facultad sobre cada funcionario, cuando dicha revisión individual forme parte del flujo definido.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-19:** Como **Dirección de Finanzas**, quiero visualizar el resultado financiero registrado por Finanzas de Facultad, para conocer el respaldo presupuestario previo antes de decidir sobre la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP07-063:** El sistema debe mostrar el resultado financiero registrado por Finanzas de Facultad para cada funcionario, cuando corresponda.
- **RF-PP07-064:** El sistema debe mostrar comentarios u observaciones financieras asociadas, cuando existan.
- **RF-PP07-065:** El sistema no debe permitir modificar las decisiones financieras emitidas por Finanzas de Facultad.

---

# P07-B16 — Estado de visación de Decanato

## Funcionalidad P07-F20 — Visualizar decisión emitida por Decano/a

### A. Descripción funcional

Dirección de Finanzas debe visualizar la decisión emitida por Decano/a como antecedente jerárquico previo al ingreso del expediente a esta etapa.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Estado de visación de Decanato.
- Nombre del Decano/a o autoridad que visó.
- Fecha y hora de aprobación.
- Comentario asociado, si existe.
- Estado resultante enviado a Dirección de Finanzas.

### D. Reglas de negocio

- La solicitud no debe ingresar a Pantalla 07 si no fue aprobada previamente por Decano/a.
- La decisión de Decanato debe mostrarse en modo solo lectura.
- Dirección de Finanzas no debe modificar la decisión emitida por Decanato.

### E. Historia de usuario preliminar

**HU-P07-20:** Como **Dirección de Finanzas**, quiero visualizar la aprobación emitida por Decano/a, para confirmar que el expediente cuenta con la visación jerárquica de Facultad antes de mi revisión.

### F. Requerimientos funcionales preliminares

- **RF-PP07-066:** El sistema debe mostrar el estado de visación de Decanato.
- **RF-PP07-067:** El sistema debe mostrar usuario, fecha y hora de la decisión del Decano/a.
- **RF-PP07-068:** El sistema debe mostrar comentarios asociados a la decisión de Decanato cuando existan.
- **RF-PP07-069:** El sistema no debe permitir modificar la decisión de Decanato desde la vista de Dirección de Finanzas.

---

# P07-B17 — Resumen consolidado para decisión de Dirección de Finanzas

## Funcionalidad P07-F21 — Visualizar resumen global previo a la decisión

### A. Descripción funcional

El sistema debe mostrar un resumen consolidado del expediente antes de que Dirección de Finanzas tome una decisión global.

### B. Actor principal

Dirección de Finanzas.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Proyecto.
- Unidad ejecutora.
- Tipo de financiamiento.
- Decreto afecto.
- Monto original de la solicitud.
- Monto excluido por DGDP.
- Monto vigente posterior a exclusiones.
- Saldo disponible general.
- Resumen de ítems presupuestarios.
- Cantidad de funcionarios vigentes.
- Cantidad de funcionarios excluidos por DGDP.
- Resultado consolidado DGDP.
- Resultado consolidado de Finanzas de Facultad.
- Resultado de Decanato.
- Alertas u observaciones registradas en etapas previas, cuando existan.
- Estado general del expediente para decisión de Dirección de Finanzas.

### D. Historia de usuario preliminar

**HU-P07-21:** Como **Dirección de Finanzas**, quiero revisar un resumen global del expediente, para decidir si la solicitud puede continuar, debe devolverse con corrección o debe ser rechazada.

### E. Requerimientos funcionales preliminares

- **RF-PP07-070:** El sistema debe mostrar un resumen global del expediente previo a la decisión de Dirección de Finanzas.
- **RF-PP07-071:** El sistema debe integrar montos, funcionarios, estados DGDP, resultados de Finanzas de Facultad, decisión de Decanato e ítems presupuestarios.
- **RF-PP07-072:** El sistema debe mostrar alertas u observaciones previas relevantes para la decisión.

---

# P07-B18 — Decisión global de Dirección de Finanzas

## Funcionalidad P07-F22 — Aprobar solicitud y derivar a la etapa siguiente

### A. Descripción funcional

Dirección de Finanzas debe poder aprobar la solicitud cuando, conforme a su revisión central, el expediente puede continuar a la etapa siguiente del flujo.

### B. Actor principal

Dirección de Finanzas.

### C. Acción disponible

- Botón: **APROBAR Y CONTINUAR**.

### D. Reglas de negocio

- La aprobación debe registrar:
  - Usuario aprobador.
  - Rol.
  - Fecha y hora.
  - Estado resultante.
- La solicitud aprobada debe avanzar a la etapa siguiente del flujo definida por el proceso.
- La aprobación se realiza sobre el expediente recibido desde Decanato, sin modificación de datos desde esta vista.

### E. Historia de usuario preliminar

**HU-P07-22:** Como **Dirección de Finanzas**, quiero aprobar la solicitud cuando considero que puede continuar, para derivarla a la siguiente etapa institucional del flujo.

### F. Requerimientos funcionales preliminares

- **RF-PP07-073:** El sistema debe permitir aprobar la solicitud desde la vista de Dirección de Finanzas.
- **RF-PP07-074:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
- **RF-PP07-075:** El sistema debe derivar la solicitud aprobada a la etapa siguiente del flujo.

---

## Funcionalidad P07-F23 — Devolver con corrección al Solicitante

### A. Descripción funcional

Dirección de Finanzas debe poder devolver la solicitud al Solicitante cuando detecte observaciones que puedan ser corregidas.

### B. Actor principal

Dirección de Finanzas.

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
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Dirección de Finanzas), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P07-23:** Como **Dirección de Finanzas**, quiero devolver con corrección la solicitud al Solicitante con comentarios, para informar observaciones subsanables antes de que el expediente continúe.

### G. Requerimientos funcionales preliminares

- **RF-PP07-076:** El sistema debe permitir devolver con corrección la solicitud al Solicitante.
- **RF-PP07-077:** El sistema debe exigir comentario obligatorio para ejecutar esta acción.
- **RF-PP07-078:** El sistema debe registrar la decisión con usuario, rol, fecha, hora y comentario.
- **RF-PP07-079:** El sistema debe dejar visible la observación al Solicitante.
- **RF-PP07-080:** El sistema debe ejecutar la devolución mediante un modal global único.
* **RF-PP07-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de imputación contable o disponibilidad presupuestaria central y comentarios correspondientes.
* **RF-PP07-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P07-F24 — Rechazar solicitud

### A. Descripción funcional

Dirección de Finanzas debe poder rechazar definitivamente la solicitud cuando considere que no corresponde su continuidad.

### B. Actor principal

Dirección de Finanzas.

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
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Dirección de Finanzas), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones de imputación contable o disponibilidad presupuestaria central), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P07-24:** Como **Dirección de Finanzas**, quiero rechazar la solicitud con comentarios, para detener expedientes cuya continuidad no corresponda desde la revisión financiera central.

### G. Requerimientos funcionales preliminares

- **RF-PP07-081:** El sistema debe permitir rechazar la solicitud desde la pantalla de Dirección de Finanzas.
- **RF-PP07-082:** El sistema debe exigir comentario obligatorio para ejecutar el rechazo.
- **RF-PP07-083:** El sistema debe registrar la decisión con usuario, rol, fecha, hora y comentario.
- **RF-PP07-084:** El sistema debe impedir que una solicitud rechazada continúe a etapas posteriores.
- **RF-PP07-085:** El sistema debe ejecutar el rechazo mediante un modal global único.
* **RF-PP07-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P07-B19 — Modal global de devolución/rechazo

## Funcionalidad P07-F25 — Gestionar devolución con corrección y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un único modal global para gestionar las acciones de **DEVOLVER CON CORRECCIÓN** y **RECHAZAR SOLICITUD**, centralizando el ingreso de motivo, comentario y confirmación.

### B. Actor principal

Dirección de Finanzas.

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

**HU-P07-25:** Como **Dirección de Finanzas**, quiero gestionar la devolución o rechazo desde un modal único, para registrar de forma clara el motivo y confirmar la acción antes de modificar el expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP07-086:** El sistema debe utilizar un modal global único para devolución con corrección y rechazo.
- **RF-PP07-087:** El sistema debe exigir comentario obligatorio dentro del modal.
- **RF-PP07-088:** El sistema debe permitir cancelar la acción sin modificar el estado.
- **RF-PP07-089:** El sistema debe registrar la acción confirmada en trazabilidad.

---

# P07-B20 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P07-F26 — Confirmar decisión global antes de ejecutarla

### A. Descripción funcional

Antes de aprobar, devolver con corrección o rechazar la solicitud, el sistema debe solicitar confirmación explícita a Dirección de Finanzas.

### B. Actor principal

Dirección de Finanzas.

### C. Acciones que requieren confirmación

- **APROBAR Y CONTINUAR**.
- **DEVOLVER CON CORRECCIÓN**.
- **RECHAZAR SOLICITUD**.

### D. Reglas de negocio

- La confirmación debe permitir cancelar la acción sin modificar el estado del expediente.
- El comentario obligatorio debe estar registrado antes de confirmar una devolución o rechazo.
*   **Registro de Envío**: El sistema debe dejar registro del envío del correo electrónico en la trazabilidad del expediente.

### E. Historia de usuario preliminar

**HU-P07-26:** Como **Dirección de Finanzas**, quiero confirmar mi decisión antes de ejecutarla, para evitar modificar por error el estado del expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP07-090:** El sistema debe solicitar confirmación antes de aprobar, devolver con corrección o rechazar.
- **RF-PP07-091:** El sistema debe permitir cancelar la decisión antes de aplicarla.
- **RF-PP07-092:** El sistema debe validar que las condiciones de comentario obligatorio se cumplan antes de confirmar devolución o rechazo.
* **RF-PP07-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

## Funcionalidad P07-F27 — Registrar trazabilidad de decisiones de Dirección de Finanzas

### A. Descripción funcional

El sistema debe generar un registro automático y auditable de toda acción ejecutada en la Pantalla 07.

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
- Rol: Dirección de Finanzas.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Comentario asociado, cuando corresponda.
- Motivo de devolución o rechazo, cuando aplique.

### E. Reglas de negocio

- No debe modificarse el estado global de la solicitud sin generar simultáneamente el registro de trazabilidad.
- La trazabilidad debe quedar disponible para etapas posteriores del flujo.

### F. Historia de usuario preliminar

**HU-P07-27:** Como **sistema**, debo registrar las decisiones emitidas por Dirección de Finanzas, para mantener una trazabilidad completa de la visación financiera central del expediente.

### G. Requerimientos funcionales preliminares

- **RF-PP07-093:** El sistema debe registrar toda decisión ejecutada por Dirección de Finanzas.
- **RF-PP07-094:** El sistema debe almacenar comentario y motivo cuando corresponda.
- **RF-PP07-095:** El sistema debe dejar disponible la trazabilidad de esta etapa para los revisores posteriores.

---

# 7. Estados de salida de la Pantalla 07

| Acción de Dirección de Finanzas | Estado resultante de la solicitud | Destino del flujo |
|---|---|---|
| **APROBAR Y CONTINUAR** | Aprobada por Dirección de Finanzas / En revisión por etapa siguiente | Continúa el flujo institucional |
| **DEVOLVER CON CORRECCIÓN** | Devuelta con corrección al Solicitante por Dirección de Finanzas | Regresa al Solicitante para corrección |
| **RECHAZAR SOLICITUD** | Rechazada por Dirección de Finanzas | Cierre definitivo del expediente |

---

# 8. Reglas globales de comportamiento de la Pantalla 07

| Código | Regla |
|---|---|
| **RG-P07-001** | Dirección de Finanzas debe visualizar la información completa del expediente en modo solo lectura. |
| **RG-P07-002** | La pantalla debe mostrar la trazabilidad completa de las etapas previas, incluyendo DGDP, Finanzas de Facultad y Decanato. |
| **RG-P07-003** | La pantalla debe mostrar a los funcionarios excluidos por DGDP y el motivo resumido de su exclusión. |
| **RG-P07-004** | Los funcionarios excluidos por DGDP no deben formar parte del monto vigente de la solicitud. |
| **RG-P07-005** | La pantalla debe mostrar el monto original de la solicitud, el monto excluido y el monto vigente posterior a exclusiones. |
| **RG-P07-006** | La pantalla debe mostrar información financiera del Centro de Costo, incluido el saldo disponible general y el monto comprometido. |
| **RG-P07-007** | La pantalla debe mostrar una tabla de ítems presupuestarios asociados al Centro de Costo, diferenciados por cargo, estamento o categoría. |
| **RG-P07-008** | La pantalla debe mostrar el estado de suficiencia presupuestaria por ítem como antecedente de revisión central. |
| **RG-P07-009** | La pantalla debe identificar el ítem presupuestario aplicable a cada funcionario según su cargo, estamento o categoría. |
| **RG-P07-010** | La pantalla debe mostrar la lista de prestaciones solicitadas por funcionario. |
| **RG-P07-011** | La pantalla debe mostrar, por prestación, actividad específica, descripción, meses de pago, total comprometido, total en jornada, total fuera de jornada y total de compensación horaria. |
| **RG-P07-012** | La pantalla debe mostrar la lista de contratos vigentes del funcionario y los datos definidos, incluyendo SEA. |
| **RG-P07-013** | La pantalla debe mostrar el historial de PDS y de pagos por funcionario vigente, cuando exista información registrada. |
| **RG-P07-014** | La pantalla debe mostrar información financiera acumulada por funcionario. |
| **RG-P07-015** | La pantalla debe mostrar el estado DGDP de cada funcionario como antecedente de revisión. |
| **RG-P07-016** | La pantalla debe mostrar el estado financiero registrado por Finanzas de Facultad, cuando corresponda. |
| **RG-P07-017** | La pantalla debe mostrar la decisión de Decanato como antecedente de ingreso a esta etapa. |
| **RG-P07-018** | Dirección de Finanzas no debe aprobar ni rechazar individualmente funcionarios, salvo definición posterior del flujo. |
| **RG-P07-019** | Dirección de Finanzas no debe modificar datos técnicos, normativos ni financieros ya revisados. |
| **RG-P07-020** | La aprobación global de la solicitud debe registrar usuario, rol, fecha y hora. |
| **RG-P07-021** | La devolución con corrección debe exigir comentario obligatorio. |
| **RG-P07-022** | El rechazo de solicitud debe exigir comentario obligatorio. |
| **RG-P07-023** | Toda decisión global de esta pantalla debe quedar registrada en trazabilidad. |
| **RG-P07-024** | La pantalla no debe editar datos de origen ni alterar exclusiones realizadas por DGDP. |
| **RG-P07-025** | La pantalla no debe incorporar Aprobación con Alcance, salvo definición posterior del proceso. |
| **RG-P07-026** | Las acciones globales de la pantalla deben homologarse a: **DEVOLVER CON CORRECCIÓN**, **RECHAZAR SOLICITUD** y **APROBAR Y CONTINUAR**. |
| **RG-P07-027** | La devolución con corrección y el rechazo deben gestionarse mediante un **modal global único**. |
| **RG-P07-028** | La pantalla no debe incorporar la acción **Salir sin guardar**. |
| **RG-P07-029** | El sistema debe permitir cambiar entre funcionarios para revisar su detalle individual. |
| **RG-PP07-030** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 9. Requerimientos no funcionales preliminares aplicables a la Pantalla 07

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P07-001** | Legibilidad integral | La pantalla debe permitir revisar información extensa del expediente sin perder la relación entre datos técnicos, normativos, financieros y de trazabilidad. |
| **RNF-P07-002** | Trazabilidad | Toda aprobación, devolución o rechazo de Dirección de Finanzas debe quedar registrada y ser consultable en etapas posteriores. |
| **RNF-P07-003** | Integridad de datos | Los datos de etapas previas deben mantenerse en modo solo lectura y no alterarse desde esta pantalla. |
| **RNF-P07-004** | Claridad de funcionarios excluidos | Los funcionarios excluidos por DGDP deben visualizarse claramente separados de la nómina vigente. |
| **RNF-P07-005** | Consistencia de montos | El sistema debe mantener coherencia entre monto original, monto excluido, monto vigente, monto por funcionario, monto por ítem y monto global del expediente. |
| **RNF-P07-006** | Seguridad por rol | Solo usuarios autorizados con rol de Dirección de Finanzas deben acceder a esta pantalla y ejecutar sus acciones. |
| **RNF-P07-007** | Confirmación de acciones | Las decisiones que cambien el estado del expediente deben requerir confirmación previa. |
| **RNF-P07-008** | Comentarios obligatorios | El sistema debe impedir devolver con corrección o rechazar la solicitud sin comentario registrado. |
| **RNF-P07-009** | Auditabilidad financiera central | Debe ser posible reconstruir la decisión de Dirección de Finanzas y el estado del expediente al momento de emitirla. |
| **RNF-P07-010** | Coherencia de antecedentes | La información mostrada debe mantenerse alineada con la versión del expediente que ingresó a la etapa Dirección de Finanzas. |
| **RNF-P07-011** | Organización tabular | Las prestaciones solicitadas, los contratos vigentes y los ítems presupuestarios deben visualizarse en estructuras tabulares que faciliten su lectura. |
| **RNF-P07-012** | Separación funcional | La pantalla debe distinguir claramente entre información heredada desde DGDP, Finanzas de Facultad, Decanato y la decisión emitida por Dirección de Finanzas. |
| **RNF-P07-013** | Transparencia presupuestaria | La pantalla debe permitir identificar claramente qué ítems presupuestarios respaldan la solicitud. |
| **RNF-P07-014** | Homologación de acciones | Las acciones globales deben presentarse con la nomenclatura definida: DEVOLVER CON CORRECCIÓN, RECHAZAR SOLICITUD y APROBAR Y CONTINUAR. |
| **RNF-P07-015** | Continuidad visual | La pantalla debe mantener una estructura visual coherente con P05 y P06 para facilitar la revisión secuencial del expediente. |

---

# 10. Inventario consolidado de funcionalidades de la Pantalla 07

| Código | Funcionalidad |
|---|---|
| **P07-F01** | Visualizar identificación de la solicitud. |
| **P07-F02** | Visualizar estado actual del expediente. |
| **P07-F03** | Visualizar aprobaciones y decisiones previas del flujo. |
| **P07-F04** | Visualizar línea de avance del flujo. |
| **P07-F05** | Visualizar funcionarios excluidos por DGDP. |
| **P07-F06** | Visualizar resumen general de la solicitud. |
| **P07-F07** | Visualizar información completa del Centro de Costo. |
| **P07-F08** | Visualizar tabla de ítems presupuestarios asociados al Centro de Costo. |
| **P07-F09** | Visualizar contexto técnico resumido de la solicitud. |
| **P07-F10** | Visualizar funcionarios activos que continúan en el proceso. |
| **P07-F11** | Seleccionar funcionario para revisión detallada. |
| **P07-F12** | Visualizar antecedentes laborales relevantes por funcionario. |
| **P07-F13** | Visualizar tabla de prestaciones solicitadas por funcionario. |
| **P07-F14** | Visualizar lista de contratos vigentes del funcionario. |
| **P07-F15** | Visualizar historial de PDS previas del funcionario. |
| **P07-F16** | Visualizar información financiera acumulada del funcionario. |
| **P07-F17** | Visualizar historial de pagos del funcionario. |
| **P07-F18** | Visualizar resultado resumido de validaciones DGDP. |
| **P07-F19** | Visualizar resultado financiero registrado por Finanzas de Facultad. |
| **P07-F20** | Visualizar decisión emitida por Decano/a. |
| **P07-F21** | Visualizar resumen global previo a la decisión. |
| **P07-F22** | Aprobar solicitud y derivar a la etapa siguiente. |
| **P07-F23** | Devolver con corrección al Solicitante. |
| **P07-F24** | Rechazar solicitud. |
| **P07-F25** | Gestionar devolución con corrección y rechazo mediante modal global único. |
| **P07-F26** | Confirmar decisión global antes de ejecutarla. |
| **P07-F27** | Registrar trazabilidad de decisiones de Dirección de Finanzas. |
