# PDS Normativo D9 / DU288 / DU09

## Pantalla 05 — Revisión y Certificación Financiera por Finanzas de Facultad

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 05: Revisión y Certificación Financiera — Perfil Finanzas de Facultad** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

Esta pantalla corresponde a una etapa de **revisión financiera y presupuestaria descentralizada**, posterior a la validación normativa realizada por DGDP. Su propósito es permitir que Finanzas de Facultad revise la solicitud desde una perspectiva económica, presupuestaria y de correcta imputación del gasto, considerando:

- La información general de la solicitud.
- El historial completo de visaciones previas.
- El Centro de Costo y su disponibilidad presupuestaria.
- Los ítems presupuestarios asociados al Centro de Costo según cargo, estamento o categoría funcionaria.
- El saldo disponible por cada ítem presupuestario.
- El monto total de la solicitud.
- El monto actualizado posterior a exclusiones realizadas por DGDP.
- La nómina de funcionarios que continúan en el flujo.
- Los funcionarios excluidos previamente y sus motivos.
- El detalle financiero, contractual e histórico de cada funcionario.
- La lista de prestaciones solicitadas por funcionario.
- La lista de contratos vigentes asociados al funcionario.
- El historial de prestaciones y pagos previos.
- La distribución de pagos de la PDS actual.
- Los montos ejecutados o comprometidos dentro de jornada, fuera de jornada y por compensación horaria.
- La condición SEA cuando corresponda.
- La suficiencia presupuestaria por ítem en relación con el cargo o estamento del funcionario.
- La revisión financiera individual por funcionario.
- La decisión global de Finanzas de Facultad sobre la solicitud.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 05 — Finanzas de Facultad**. No modifica las pantallas anteriores. Su objetivo es definir qué información debe mostrarse, qué antecedentes financieros deben revisarse y qué decisiones debe poder registrar este rol dentro del flujo.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P05 |
| **Nombre** | Revisión y Certificación Financiera por Finanzas de Facultad |
| **Perfil principal** | Analista / Profesional autorizado de Finanzas de Facultad |
| **Etapa del flujo** | Etapa 05 — Revisión financiera y presupuestaria descentralizada |
| **Estado de entrada esperado** | Solicitud aprobada por DGDP y enviada a revisión de Finanzas de Facultad |
| **Objetivo principal** | Permitir que Finanzas de Facultad revise la solicitud desde una perspectiva presupuestaria y financiera, visualice los antecedentes aprobados en etapas previas, evalúe la información económica de cada funcionario vigente, verifique la suficiencia presupuestaria de los ítems asociados a cada cargo o estamento y registre una decisión sobre la continuidad de la solicitud. |
| **Resultado posible** | Solicitud aprobada y derivada a la etapa siguiente; solicitud devuelta con corrección al Solicitante; solicitud rechazada; revisión financiera individual aprobada o rechazada por funcionario, según corresponda. |

---

# 3. Principio funcional de la Pantalla 05

La Pantalla 05 debe operar como una **vista de revisión financiera del expediente**, basada en la información ya generada y validada en las etapas previas, pero reorganizada de acuerdo con las necesidades de Finanzas de Facultad.

La pantalla no busca repetir la auditoría normativa de DGDP, sino **presentar sus resultados como antecedentes resumidos**, incorporando además una revisión financiera más profunda sobre:

- Centro de Costo.
- Disponibilidad presupuestaria general.
- Ítems presupuestarios asociados al Centro de Costo.
- Saldos presupuestarios diferenciados por cargo, estamento o categoría.
- Montos comprometidos por funcionario.
- Funcionarios vigentes.
- Funcionarios excluidos previamente.
- Prestaciones solicitadas por funcionario.
- Contratos vigentes de cada funcionario.
- Historial de prestaciones previas.
- Historial de pagos.
- Información financiera acumulada.
- Proyección de pagos asociados a la solicitud actual.
- Totales en jornada, fuera de jornada y compensación horaria.
- Condición SEA cuando corresponda.
- Suficiencia presupuestaria del ítem correspondiente a cada funcionario.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 05 debe permitir que Finanzas de Facultad:

- Visualice la solicitud completa de forma resumida y organizada desde una perspectiva financiera.
- Revise las decisiones y visaciones emitidas en las etapas anteriores:
  - Jefe de Proyecto.
  - Jefatura Directa / Dirección de Departamento.
  - DGDP.
- Visualice si DGDP excluyó funcionarios y el motivo resumido de dicha exclusión.
- Revise el Centro de Costo y todos sus datos financieros relevantes.
- Visualice:
  - Saldo disponible general del Centro de Costo.
  - Monto total original de la solicitud.
  - Monto actualizado posterior a exclusiones.
  - Saldo proyectado posterior a aprobación, si la información se encuentra disponible.
- Visualice, junto a la información del Centro de Costo, una **tabla de ítems presupuestarios por cargo, estamento o categoría**, indicando:
  - Ítem presupuestario.
  - Cargo, estamento o categoría asociada.
  - Presupuesto asignado.
  - Monto ya comprometido o ejecutado.
  - Saldo disponible.
  - Monto solicitado en la PDS actual para dicho ítem.
  - Saldo proyectado posterior a la aprobación.
  - Estado de suficiencia presupuestaria.
- Revise el tipo de financiamiento, decreto afecto, unidad ejecutora y proyecto.
- Visualice la actividad general, tipo de prestación y evidencias comprometidas como antecedentes del gasto.
- Revise la nómina de funcionarios vigentes que continúan en la solicitud.
- Cambie entre los funcionarios vigentes para revisar el detalle individual de cada uno.
- Revise, por cada funcionario vigente:
  - Identificación.
  - Datos laborales y contractuales relevantes.
  - Contrato seleccionado para la PDS.
  - Ítem presupuestario asociado según su cargo, estamento o categoría.
  - Saldo disponible del ítem presupuestario correspondiente.
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
  - Estado de validación DGDP resumido.
- Visualice, por cada funcionario excluido por DGDP:
  - Identificación.
  - Etapa de exclusión.
  - Motivo resumido.
  - Comentario asociado, si corresponde.
- Visualice un estado informativo explícito cuando no existan funcionarios excluidos por DGDP en la solicitud.
- Registre una revisión financiera individual por funcionario, cuando el diseño final del flujo lo contemple.
- Visualice un **estado consolidado de revisión financiera**, considerando:
  - Funcionarios aprobados financieramente.
  - Funcionarios rechazados financieramente.
  - Funcionarios pendientes de revisión.
  - Estado general de preparación para la decisión final.
- Apruebe la solicitud mediante la acción **APROBAR Y CONTINUAR**.
- Devuelva la solicitud al Solicitante mediante la acción **DEVOLVER CON CORRECCIÓN**.
- Rechace la solicitud mediante la acción **RECHAZAR SOLICITUD**.
- Gestione la devolución con corrección y el rechazo mediante un **modal global único**.
- Bloquee la aprobación cuando:
  - No existan funcionarios aprobados financieramente o habilitados para continuar.
  - Existan funcionarios pendientes de revisión financiera.
- Registre comentarios obligatorios cuando la solicitud no sea aprobada.
- Confirme la acción antes de modificar el estado del expediente.
- Mantenga trazabilidad completa de la decisión financiera.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 05 no debe:

- Editar los datos originales ingresados por el Solicitante.
- Modificar los antecedentes aprobados en etapas previas.
- Incorporar nuevos funcionarios a la solicitud.
- Reponer funcionarios excluidos por DGDP.
- Cambiar los motivos de exclusión registrados por DGDP.
- Revalidar en profundidad las reglas normativas propias de DGDP como función principal de esta pantalla.
- Modificar directamente compensaciones horarias, condición SEA, topes salariales o inhabilidades.
- Alterar manualmente los saldos presupuestarios desde la vista.
- Cambiar el ítem presupuestario asociado a un funcionario si dicha relación proviene de una regla institucional o de datos estructurados del Centro de Costo.
- Eliminar información histórica del expediente.
- Ocultar a los funcionarios que fueron excluidos previamente del proceso.
- Alterar los registros históricos de prestaciones o pagos de los funcionarios.
- Incorporar la opción de **Aprobación con Alcance**, salvo que una definición posterior del proceso indique lo contrario.
- Incorporar la acción **Salir sin guardar** como opción operativa de la pantalla.

---

# 4. Objetivo funcional de la Pantalla 05

La pantalla debe permitir que Finanzas de Facultad:

1. Identifique la solicitud que ingresa a revisión financiera.
2. Visualice el estado actual del expediente y la etapa del flujo.
3. Revise la trazabilidad completa de las decisiones previas.
4. Conozca si hubo exclusiones de funcionarios en DGDP y por qué.
5. Visualice un resumen ejecutivo financiero de la solicitud.
6. Revise los datos del Centro de Costo, proyecto, unidad ejecutora, decreto y financiamiento.
7. Consulte el saldo disponible general del Centro de Costo.
8. Visualice la tabla de ítems presupuestarios asociados al Centro de Costo.
9. Revise el presupuesto disponible por cargo, estamento o categoría asociada a cada ítem.
10. Compare el monto total original de la solicitud con el monto vigente posterior a exclusiones.
11. Visualice el impacto financiero total de la PDS.
12. Revise los antecedentes generales de la prestación:
    - Actividad.
    - Tipo de prestación.
    - Evidencias comprometidas.
    - Periodo de ejecución.
13. Visualice los funcionarios que continúan activos en la solicitud.
14. Visualice los funcionarios excluidos previamente y el motivo de su salida del flujo.
15. Seleccione o cambie entre funcionarios para revisar su detalle financiero individual.
16. Revise el detalle laboral y contractual de cada funcionario activo.
17. Revise el contrato seleccionado para la PDS.
18. Visualice el ítem presupuestario que corresponde al funcionario según su cargo, estamento o categoría.
19. Revise si el saldo disponible del ítem presupuestario permite financiar la prestación solicitada.
20. Visualice la lista de prestaciones solicitadas por funcionario.
21. Revise los montos comprometidos por prestación, incluyendo:
    - Total comprometido.
    - Total en jornada.
    - Total fuera de jornada.
    - Total compensación horaria.
22. Visualice la lista de contratos vigentes del funcionario junto con los datos definidos para revisión financiera.
23. Revise la condición SEA asociada al funcionario cuando corresponda.
24. Consulte el historial de PDS previas por funcionario.
25. Consulte el historial de pagos e información financiera acumulada por funcionario.
26. Revise los montos y meses de pago de la solicitud actual por funcionario.
27. Visualice la distribución del gasto individual y su incidencia en el total de la solicitud.
28. Valide la suficiencia presupuestaria por ítem, tanto para el funcionario individual como de forma acumulada cuando varios funcionarios consuman el mismo ítem.
29. Registre la aprobación o rechazo financiero individual de cada funcionario, si el flujo lo define.
30. Visualice un resumen consolidado de la revisión financiera.
31. Apruebe la solicitud cuando considere que puede continuar.
32. Devuelva con corrección la solicitud al Solicitante cuando existan observaciones subsanables.
33. Rechace la solicitud cuando existan observaciones financieras que impidan su continuidad.
34. Confirme la decisión antes de aplicarla.
35. Registre trazabilidad de toda decisión ejecutada en esta etapa.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 05 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P05-B01** | Encabezado de expediente y estado de revisión financiera | Identificar la solicitud, su estado y el rol revisor. |
| **P05-B02** | Trazabilidad de etapas previas | Mostrar el historial de aprobación hasta DGDP. |
| **P05-B03** | Resumen de funcionarios excluidos previamente | Mostrar de forma resumida quiénes fueron retirados del proceso y por qué. |
| **P05-B04** | Resumen ejecutivo financiero y estado consolidado de revisión | Mostrar montos, cantidad de funcionarios y estado financiero general. |
| **P05-B05** | Centro de Costo, proyecto y disponibilidad presupuestaria general | Exponer los antecedentes financieros centrales del expediente. |
| **P05-B06** | Ítems presupuestarios por cargo, estamento o categoría | Mostrar la distribución presupuestaria del Centro de Costo y el saldo disponible aplicable a los funcionarios. |
| **P05-B07** | Actividad, prestación y evidencias como antecedente del gasto | Mostrar el contexto técnico resumido que fundamenta la solicitud. |
| **P05-B08** | Nómina de funcionarios vigentes para revisión financiera | Mostrar los funcionarios que continúan activos después de DGDP. |
| **P05-B09** | Selector y ficha laboral/contractual por funcionario | Permitir cambiar entre funcionarios y revisar sus datos individuales. |
| **P05-B10** | Prestaciones solicitadas en la solicitud actual por funcionario | Mostrar el detalle de cada prestación solicitada y sus montos asociados. |
| **P05-B11** | Contratos vigentes y datos asociados por funcionario | Mostrar los contratos del funcionario y los datos financieros definidos para revisión. |
| **P05-B12** | Historial de prestaciones previas e información financiera acumulada | Mostrar PDS históricas y acumulados asociados al funcionario. |
| **P05-B13** | Historial de pagos por funcionario | Mostrar pagos previos y estado financiero histórico. |
| **P05-B14** | Estado resumido de validaciones previas por funcionario | Mostrar, como antecedente, el resultado DGDP y controles anteriores relevantes. |
| **P05-B15** | Validación presupuestaria por funcionario e ítem | Verificar si el ítem presupuestario correspondiente cuenta con saldo suficiente para cubrir la prestación del funcionario. |
| **P05-B16** | Validación financiera individual por funcionario | Permitir registrar aprobación o rechazo financiero individual. |
| **P05-B17** | Resumen consolidado de revisión Finanzas de Facultad | Mostrar el estado financiero global antes de decidir. |
| **P05-B18** | Decisión global de Finanzas de Facultad | Permitir devolver con corrección, rechazar solicitud o aprobar y continuar. |
| **P05-B19** | Modal global de devolución/rechazo | Gestionar motivo, comentario y confirmación para devolución con corrección o rechazo. |
| **P05-B20** | Confirmación, transición de estado y trazabilidad | Confirmar decisiones, aplicar bloqueos de aprobación y registrar el historial de la etapa. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P05-B01 — Encabezado de expediente y estado de revisión financiera

## Funcionalidad P05-F01 — Visualizar identificación de la solicitud

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación única de la solicitud que será revisada por Finanzas de Facultad.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Número o código único de solicitud.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Título de la etapa: Revisión y Certificación Financiera.

### D. Reglas de negocio

- El identificador de la solicitud debe mantenerse inalterable durante todo el flujo.
- Debe permanecer visible durante la revisión financiera.

### E. Historia de usuario preliminar

**HU-P05-01:** Como **Finanzas de Facultad**, quiero visualizar claramente el identificador del expediente en revisión, para asociar mi análisis y decisión a la solicitud correcta.

### F. Requerimientos funcionales preliminares

- **RF-PP05-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-PP05-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo.

---

## Funcionalidad P05-F02 — Visualizar estado actual del expediente

### A. Descripción funcional

El sistema debe mostrar que la solicitud se encuentra en revisión por Finanzas de Facultad.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Estado: **En revisión por Finanzas de Facultad**.
- Etapa actual del flujo.
- Fecha de ingreso a la etapa financiera.

### D. Reglas de negocio

- Solo deben llegar a esta etapa solicitudes aprobadas previamente por DGDP.
- Mientras el expediente se encuentre en revisión financiera, no debe ser editable por el Solicitante.

### E. Historia de usuario preliminar

**HU-P05-02:** Como **Finanzas de Facultad**, quiero visualizar el estado actual del expediente, para confirmar que se encuentra habilitado para revisión presupuestaria.

### F. Requerimientos funcionales preliminares

- **RF-PP05-003:** El sistema debe mostrar el estado actual de revisión financiera.
- **RF-PP05-004:** El sistema debe mostrar la fecha de ingreso de la solicitud a esta etapa.

---

# P05-B02 — Trazabilidad de etapas previas

## Funcionalidad P05-F03 — Visualizar aprobaciones y decisiones previas del flujo

### A. Descripción funcional

El sistema debe mostrar a Finanzas de Facultad el recorrido histórico del expediente hasta su llegada a esta etapa.

### B. Actor principal

Finanzas de Facultad.

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

### E. Historia de usuario preliminar

**HU-P05-03:** Como **Finanzas de Facultad**, quiero revisar las decisiones emitidas en etapas anteriores, para comprender el recorrido previo del expediente antes de certificarlo financieramente.

### F. Requerimientos funcionales preliminares

- **RF-PP05-005:** El sistema debe mostrar cronológicamente las decisiones registradas antes de Finanzas de Facultad.
- **RF-PP05-006:** El sistema debe mostrar usuario, rol, acción, fecha, hora y comentario cuando corresponda.
- **RF-PP05-007:** El sistema debe incorporar en la trazabilidad las exclusiones de funcionarios realizadas por DGDP.

---

## Funcionalidad P05-F04 — Visualizar línea de avance del flujo

### A. Descripción funcional

El sistema debe mostrar visualmente el progreso del expediente dentro del flujo completo.

### B. Actor principal

Finanzas de Facultad.

### C. Hitos mínimos a mostrar

- Solicitud creada.
- Aprobación Jefe de Proyecto.
- Aprobación Jefatura Directa / Dirección de Departamento.
- Revisión DGDP.
- Etapa actual: Finanzas de Facultad.
- Etapa siguiente pendiente.

### D. Historia de usuario preliminar

**HU-P05-04:** Como **Finanzas de Facultad**, quiero visualizar el avance del expediente en el flujo, para comprender en qué etapa se encuentra y qué revisiones ya fueron realizadas.

### E. Requerimientos funcionales preliminares

- **RF-PP05-008:** El sistema debe mostrar una línea de avance del expediente.
- **RF-PP05-009:** El sistema debe diferenciar etapas cumplidas, etapa actual y etapas pendientes.

---

# P05-B03 — Resumen de funcionarios excluidos previamente

## Funcionalidad P05-F05 — Visualizar funcionarios excluidos por DGDP

### A. Descripción funcional

El sistema debe mostrar de forma resumida a los funcionarios que fueron excluidos de la solicitud durante la etapa DGDP, junto con el motivo de exclusión.

### B. Actor principal

Finanzas de Facultad.

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

- Los funcionarios excluidos no deben formar parte del cálculo financiero vigente de la solicitud.
- Deben mantenerse visibles como antecedente histórico del expediente.
- La exclusión no puede ser editada desde Finanzas de Facultad.
- Si no existen funcionarios excluidos por DGDP, la pantalla debe mostrar un mensaje o estado visible que lo indique explícitamente.

### E. Historia de usuario preliminar

**HU-P05-05:** Como **Finanzas de Facultad**, quiero visualizar qué funcionarios fueron excluidos por DGDP y por qué, para entender la composición final de la solicitud que llega a revisión financiera.

### F. Requerimientos funcionales preliminares

- **RF-PP05-010:** El sistema debe mostrar los funcionarios excluidos por DGDP.
- **RF-PP05-011:** El sistema debe mostrar el motivo resumido de cada exclusión.
- **RF-PP05-012:** El sistema debe excluir a estos funcionarios de los montos vigentes de la solicitud.
- **RF-PP05-013:** El sistema no debe permitir modificar las exclusiones previas desde esta pantalla.
- **RF-PP05-014:** El sistema debe informar explícitamente cuando no existan funcionarios excluidos por DGDP en la solicitud.

---

# P05-B04 — Resumen ejecutivo financiero y estado consolidado de revisión

## Funcionalidad P05-F06 — Visualizar resumen financiero general de la solicitud

### A. Descripción funcional

El sistema debe mostrar un resumen ejecutivo que permita a Finanzas de Facultad comprender rápidamente el impacto económico del expediente.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Nombre del proyecto.
- Unidad ejecutora.
- Tipo de financiamiento.
- Decreto afecto.
- Número total de funcionarios incorporados originalmente.
- Número de funcionarios excluidos por DGDP.
- Número de funcionarios vigentes en revisión financiera.
- Monto total original de la solicitud.
- Monto total vigente posterior a exclusiones.
- Saldo disponible general del Centro de Costo.
- Saldo estimado posterior a aprobación, si la fuente lo permite.

### D. Reglas de negocio

- El monto total vigente debe considerar únicamente a los funcionarios que continúan activos en el proceso.
- Debe diferenciarse claramente el monto original del monto ajustado posterior a exclusiones.
- El resumen financiero debe utilizar los datos vigentes disponibles al ingreso de la solicitud a Finanzas.

### E. Historia de usuario preliminar

**HU-P05-06:** Como **Finanzas de Facultad**, quiero visualizar un resumen financiero del expediente, para evaluar rápidamente el impacto presupuestario de la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP05-014:** El sistema debe mostrar el monto original de la solicitud.
- **RF-PP05-015:** El sistema debe mostrar el monto vigente posterior a exclusiones previas.
- **RF-PP05-016:** El sistema debe mostrar la cantidad de funcionarios originales, excluidos y vigentes.
- **RF-PP05-017:** El sistema debe mostrar el saldo disponible general del Centro de Costo.
- **RF-PP05-018:** El sistema debe mostrar el saldo proyectado posterior a aprobación cuando la información esté disponible.

---

## Funcionalidad P05-F07 — Visualizar estado consolidado de revisión financiera

### A. Descripción funcional

El sistema debe mostrar un estado consolidado de revisión financiera que permita identificar si la solicitud se encuentra preparada para una decisión global.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Total de funcionarios vigentes.
- Funcionarios aprobados financieramente.
- Funcionarios rechazados financieramente.
- Funcionarios pendientes de revisión.
- Estado general de posibilidad de aprobación:
  - Habilitada para aprobar.
  - Bloqueada por ausencia de funcionarios aprobados financieramente.
  - Bloqueada por funcionarios pendientes de revisión.
  - Bloqueada por condición financiera pendiente de definición, si aplica.

### D. Reglas de negocio

- Si no existen funcionarios aprobados financieramente o habilitados para continuar, la aprobación debe quedar bloqueada.
- Si existen funcionarios pendientes de revisión financiera, la aprobación debe quedar bloqueada.
- El estado consolidado debe actualizarse al aprobar o rechazar financieramente funcionarios.

### E. Historia de usuario preliminar

**HU-P05-07:** Como **Finanzas de Facultad**, quiero visualizar el estado consolidado de revisión financiera, para saber si la solicitud está preparada para aprobarse o si aún existen impedimentos.

### F. Requerimientos funcionales preliminares

- **RF-PP05-019:** El sistema debe mostrar un estado consolidado de revisión financiera.
- **RF-PP05-020:** El sistema debe indicar funcionarios aprobados, rechazados y pendientes.
- **RF-PP05-021:** El sistema debe mostrar si la aprobación global se encuentra habilitada o bloqueada.

---

# P05-B05 — Centro de Costo, proyecto y disponibilidad presupuestaria general

## Funcionalidad P05-F08 — Visualizar información financiera completa del Centro de Costo

### A. Descripción funcional

Finanzas de Facultad debe visualizar todos los antecedentes del Centro de Costo asociados al expediente, priorizando los elementos relevantes para la revisión presupuestaria.

### B. Actor principal

Finanzas de Facultad.

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
- Los datos del Centro de Costo deben corresponder al expediente vigente posterior a DGDP.
- Si existen alertas presupuestarias previas, deben mantenerse visibles como antecedente.
- La información general del Centro de Costo debe vincularse visualmente con la tabla de ítems presupuestarios por cargo, estamento o categoría.

### E. Historia de usuario preliminar

**HU-P05-08:** Como **Finanzas de Facultad**, quiero revisar la información completa del Centro de Costo y su disponibilidad presupuestaria, para evaluar si el gasto solicitado puede ser respaldado.

### F. Requerimientos funcionales preliminares

- **RF-PP05-022:** El sistema debe mostrar los datos financieros y administrativos del Centro de Costo.
- **RF-PP05-023:** El sistema debe mostrar el saldo disponible general y el monto comprometido por la solicitud.
- **RF-PP05-024:** El sistema debe mostrar alertas presupuestarias existentes, cuando corresponda.
- **RF-PP05-025:** El sistema debe vincular la información del Centro de Costo con sus ítems presupuestarios asociados.

---

# P05-B06 — Ítems presupuestarios por cargo, estamento o categoría

## Funcionalidad P05-F09 — Visualizar tabla de ítems presupuestarios asociados al Centro de Costo

### A. Descripción funcional

El sistema debe mostrar, junto a la información del Centro de Costo, una tabla con los ítems presupuestarios disponibles, diferenciados según el cargo, estamento o categoría funcionaria habilitada para su imputación.

### B. Actor principal

Finanzas de Facultad.

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

- La tabla debe mostrar los ítems presupuestarios asociados al Centro de Costo que resulten relevantes para la solicitud.
- La relación entre funcionario e ítem presupuestario debe determinarse según el cargo, estamento o categoría que corresponda.
- Si varios funcionarios consumen el mismo ítem, el monto solicitado debe mostrarse de forma acumulada.
- El saldo proyectado debe calcularse considerando la suma de los montos solicitados para ese ítem dentro de la PDS vigente.
- La suficiencia presupuestaria debe evaluarse por ítem, además del saldo general del Centro de Costo.

### E. Historia de usuario preliminar

**HU-P05-09:** Como **Finanzas de Facultad**, quiero visualizar los ítems presupuestarios del Centro de Costo diferenciados por cargo o estamento, para verificar si existe saldo suficiente para financiar las prestaciones solicitadas según el tipo de funcionario.

### F. Requerimientos funcionales preliminares

- **RF-PP05-026:** El sistema debe mostrar una tabla de ítems presupuestarios asociados al Centro de Costo.
- **RF-PP05-027:** El sistema debe mostrar el cargo, estamento o categoría relacionada con cada ítem.
- **RF-PP05-028:** El sistema debe mostrar presupuesto asignado, monto comprometido, saldo disponible, monto solicitado y saldo proyectado por ítem.
- **RF-PP05-029:** El sistema debe calcular el monto solicitado acumulado por ítem cuando existan varios funcionarios asociados.
- **RF-PP05-030:** El sistema debe indicar visualmente si el saldo del ítem es suficiente, insuficiente o requiere revisión.

---

## Funcionalidad P05-F10 — Validar suficiencia presupuestaria por ítem asociado al cargo del funcionario

### A. Descripción funcional

El sistema debe permitir revisar si el ítem presupuestario correspondiente al cargo, estamento o categoría del funcionario cuenta con saldo suficiente para cubrir el monto solicitado en la PDS.

### B. Actor principal

Finanzas de Facultad / Sistema.

### C. Datos a contrastar

- Cargo, estamento o categoría del funcionario.
- Ítem presupuestario asociado.
- Saldo disponible del ítem.
- Monto total solicitado por el funcionario.
- Monto acumulado de otros funcionarios imputados al mismo ítem dentro de la solicitud.
- Saldo proyectado posterior a la aprobación.

### D. Resultado esperado

- Cumple.
- No cumple.
- Requiere revisión.

### E. Reglas de negocio

- La validación debe realizarse por funcionario y también de forma acumulada por ítem.
- Si el saldo general del Centro de Costo es suficiente, pero el ítem específico no lo es, el sistema debe indicar que **no existe suficiencia presupuestaria para ese cargo, estamento o categoría**.
- El cumplimiento financiero del funcionario debe basarse en el ítem presupuestario que le corresponde, no solo en el saldo global del Centro de Costo.
- El resultado de esta validación debe quedar disponible como antecedente para la revisión financiera individual.

### F. Historia de usuario preliminar

**HU-P05-10:** Como **Finanzas de Facultad**, quiero validar el saldo disponible del ítem presupuestario correspondiente al cargo del funcionario, para determinar si su prestación cuenta con respaldo financiero específico.

### G. Requerimientos funcionales preliminares

- **RF-PP05-031:** El sistema debe identificar el ítem presupuestario asociado al cargo, estamento o categoría del funcionario.
- **RF-PP05-032:** El sistema debe comparar el monto solicitado del funcionario con el saldo disponible del ítem correspondiente.
- **RF-PP05-033:** El sistema debe considerar el consumo acumulado del mismo ítem cuando existan varios funcionarios asociados.
- **RF-PP05-034:** El sistema debe mostrar el resultado de suficiencia presupuestaria por funcionario e ítem.
- **RF-PP05-035:** El sistema debe advertir cuando el Centro de Costo tenga saldo general, pero el ítem específico no posea saldo suficiente.

---

# P05-B07 — Actividad, prestación y evidencias como antecedente del gasto

## Funcionalidad P05-F11 — Visualizar contexto técnico resumido de la solicitud

### A. Descripción funcional

Finanzas de Facultad debe visualizar de manera resumida el contexto técnico del expediente, con el fin de relacionar el gasto solicitado con la prestación que lo origina.

### B. Actor principal

Finanzas de Facultad.

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
- No reemplaza la revisión técnica realizada por las etapas anteriores.

### E. Historia de usuario preliminar

**HU-P05-11:** Como **Finanzas de Facultad**, quiero visualizar el contexto técnico resumido de la solicitud, para asociar el gasto requerido con la prestación que lo fundamenta.

### F. Requerimientos funcionales preliminares

- **RF-PP05-036:** El sistema debe mostrar la descripción general de la actividad.
- **RF-PP05-037:** El sistema debe mostrar los tipos de prestación seleccionados.
- **RF-PP05-038:** El sistema debe mostrar las evidencias comprometidas y sus fechas estimadas.

---

# P05-B08 — Nómina de funcionarios vigentes para revisión financiera

## Funcionalidad P05-F12 — Visualizar funcionarios activos que continúan en el proceso

### A. Descripción funcional

El sistema debe mostrar la nómina de funcionarios que continúan vigentes en la solicitud luego de la revisión DGDP.

### B. Actor principal

Finanzas de Facultad.

### C. Datos resumidos por funcionario

- RUT.
- Nombre completo.
- Estamento.
- Jerarquía o cargo.
- Contrato seleccionado.
- Jornada.
- Estado DGDP: **Cumple / Aprobado DGDP**.
- Ítem presupuestario asociado.
- Estado de suficiencia presupuestaria del ítem:
  - Cumple.
  - No cumple.
  - Requiere revisión.
- Monto bruto mensual.
- Total asociado a la solicitud actual.
- Estado de revisión financiera:
  - Pendiente.
  - Aprobado financieramente.
  - Rechazado financieramente.

### D. Reglas de negocio

- La tabla debe mostrar solo como vigentes a los funcionarios que continúan en el proceso.
- Los excluidos por DGDP deben mostrarse en su bloque específico, no mezclados con los funcionarios activos.
- El ítem presupuestario asociado y su estado de suficiencia deben quedar visibles en el resumen del funcionario.

### E. Historia de usuario preliminar

**HU-P05-12:** Como **Finanzas de Facultad**, quiero visualizar la nómina de funcionarios que continúan en el flujo y su estado presupuestario, para revisar el impacto financiero de cada asignación vigente.

### F. Requerimientos funcionales preliminares

- **RF-PP05-039:** El sistema debe mostrar la nómina de funcionarios vigentes posterior a DGDP.
- **RF-PP05-040:** El sistema debe mostrar el estado financiero de revisión por funcionario.
- **RF-PP05-041:** El sistema debe diferenciar visualmente funcionarios vigentes y funcionarios excluidos previamente.
- **RF-PP05-042:** El sistema debe mostrar el ítem presupuestario asociado y el estado de suficiencia presupuestaria por funcionario.

---

# P05-B09 — Selector y ficha laboral/contractual por funcionario

## Funcionalidad P05-F13 — Seleccionar funcionario para revisión detallada

### A. Descripción funcional

El sistema debe permitir a Finanzas de Facultad cambiar entre los funcionarios vigentes en la solicitud para visualizar su detalle financiero, laboral y presupuestario individual.
El detalle por funcionario debe presentarse en bloques estructurados, preferentemente mediante tablas o estructuras equivalentes de lectura comparativa.

### B. Actor principal

Finanzas de Facultad.

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
  - Ítem presupuestario asociado.
  - Resultado de suficiencia presupuestaria.
  - Estado de revisión financiera individual.

### D. Reglas de negocio

- El cambio de funcionario no debe alterar datos registrados.
- El funcionario seleccionado debe mantenerse claramente identificado en pantalla.
- La selección debe respetar el estado real del funcionario: pendiente, aprobado financieramente o rechazado financieramente.
- La información detallada del funcionario debe priorizar una presentación tabular para facilitar la comparación de contratos, prestaciones, históricos y estados financieros.

### E. Historia de usuario preliminar

**HU-P05-13:** Como **Finanzas de Facultad**, quiero seleccionar distintos funcionarios dentro de la solicitud, para revisar el detalle financiero de cada uno sin salir de la pantalla.

### F. Requerimientos funcionales preliminares

- **RF-PP05-043:** El sistema debe permitir seleccionar o cambiar entre funcionarios vigentes de la solicitud.
- **RF-PP05-044:** El sistema debe actualizar la información visible según el funcionario seleccionado.
- **RF-PP05-045:** El sistema debe mantener visible la identidad del funcionario actualmente revisado.
- **RF-PP05-046:** El sistema debe presentar el detalle individual del funcionario mediante bloques estructurados, preferentemente en formato tabular o equivalente.

---

## Funcionalidad P05-F14 — Visualizar antecedentes laborales relevantes por funcionario

### A. Descripción funcional

Finanzas de Facultad debe visualizar la información laboral y contractual relevante de cada funcionario vigente, como antecedente para revisar el gasto individual asociado.

### B. Actor principal

Finanzas de Facultad.

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
- Ítem presupuestario asociado según cargo, estamento o categoría.
- Estado de suficiencia presupuestaria del ítem.

### D. Reglas de negocio

- La información debe mostrarse en modo solo lectura.
- Debe priorizarse el contrato seleccionado para la PDS.
- La cantidad de contratos vigentes debe mantenerse visible cuando dicha información se encuentre disponible.
- El ítem presupuestario asociado debe corresponder a la categoría del funcionario revisado.

### E. Historia de usuario preliminar

**HU-P05-14:** Como **Finanzas de Facultad**, quiero visualizar los antecedentes laborales relevantes del funcionario junto con el ítem presupuestario que le corresponde, para contextualizar la revisión financiera de su participación en la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP05-046:** El sistema debe mostrar la ficha laboral resumida de cada funcionario vigente.
- **RF-PP05-047:** El sistema debe identificar el contrato seleccionado para la PDS.
- **RF-PP05-048:** El sistema debe mostrar la cantidad de contratos vigentes cuando esta información esté disponible.
- **RF-PP05-049:** El sistema debe mostrar el ítem presupuestario asociado al funcionario.
- **RF-PP05-050:** El sistema debe mostrar el estado de suficiencia del ítem presupuestario correspondiente.

---

# P05-B10 — Prestaciones solicitadas en la solicitud actual por funcionario

## Funcionalidad P05-F15 — Visualizar tabla de prestaciones solicitadas por funcionario

### A. Descripción funcional

Finanzas de Facultad debe visualizar una tabla con las prestaciones solicitadas asociadas a cada funcionario vigente, incorporando la información financiera y operativa definida para la revisión de esta etapa.

### B. Actor principal

Finanzas de Facultad.

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
- Los montos presentados deben coincidir con los valores vigentes de la solicitud posterior a la revisión DGDP.
- Si la solicitud posee más de una prestación para un funcionario, estas deben mostrarse en filas independientes o en una agrupación funcional equivalente.
- Cada prestación debe vincularse al ítem presupuestario correspondiente.

### E. Historia de usuario preliminar

**HU-P05-15:** Como **Finanzas de Facultad**, quiero visualizar la tabla de prestaciones solicitadas por funcionario, para revisar el desglose económico, su imputación presupuestaria y el respaldo financiero de cada asignación incluida en la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP05-051:** El sistema debe mostrar las prestaciones solicitadas por funcionario.
- **RF-PP05-052:** El sistema debe mostrar actividad específica y descripción de actividad asociadas a cada prestación.
- **RF-PP05-053:** El sistema debe mostrar meses de pago y total comprometido por prestación.
- **RF-PP05-054:** El sistema debe mostrar total en jornada, total fuera de jornada y total de compensación horaria por prestación.
- **RF-PP05-055:** El sistema debe mostrar el ítem presupuestario asociado a cada prestación.
- **RF-PP05-056:** El sistema debe mostrar el estado de respaldo presupuestario correspondiente.

---

# P05-B11 — Contratos vigentes y datos asociados por funcionario

## Funcionalidad P05-F16 — Visualizar lista de contratos vigentes del funcionario

### A. Descripción funcional

Finanzas de Facultad debe visualizar la lista de contratos vigentes del funcionario, junto con los datos definidos para apoyar la revisión financiera del expediente.

### B. Actor principal

Finanzas de Facultad.

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

**HU-P05-16:** Como **Finanzas de Facultad**, quiero visualizar la lista de contratos vigentes del funcionario junto con sus datos asociados, para revisar la información contractual y financiera relevante para la solicitud.

### F. Requerimientos funcionales preliminares

- **RF-PP05-057:** El sistema debe mostrar la lista de contratos vigentes del funcionario.
- **RF-PP05-058:** El sistema debe distinguir el contrato seleccionado para la PDS.
- **RF-PP05-059:** El sistema debe mostrar, por contrato, descripción de actividad, meses de pago, total comprometido, total en jornada, total fuera de jornada, total compensación horaria y SEA.

---

# P05-B12 — Historial de prestaciones previas e información financiera acumulada

## Funcionalidad P05-F17 — Visualizar historial de PDS previas del funcionario

### A. Descripción funcional

Finanzas de Facultad debe visualizar el historial de prestaciones de servicios anteriores del funcionario, como antecedente para revisar su información financiera y continuidad de compromisos económicos.

### B. Actor principal

Finanzas de Facultad.

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

**HU-P05-17:** Como **Finanzas de Facultad**, quiero revisar las prestaciones previas del funcionario, para contar con antecedentes históricos al evaluar su participación financiera en la solicitud actual.

### F. Requerimientos funcionales preliminares

- **RF-PP05-060:** El sistema debe mostrar el historial de PDS previas por funcionario.
- **RF-PP05-061:** El sistema debe informar cuando no existan PDS previas registradas.
- **RF-PP05-062:** El sistema debe permitir identificar la relación entre las PDS previas y la solicitud actual cuando corresponda.

---

## Funcionalidad P05-F18 — Visualizar información financiera acumulada del funcionario

### A. Descripción funcional

El sistema debe consolidar la información financiera histórica del funcionario para facilitar la revisión de Finanzas de Facultad.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Total pagado en PDS previas dentro del periodo consultado.
- Total de prestaciones registradas.
- Monto acumulado histórico relevante.
- Último pago registrado.
- Otras solicitudes vigentes, si la información se encuentra disponible.
- Total comprometido actual en la solicitud.
- Comparación entre acumulado histórico y compromiso vigente, cuando corresponda.

### D. Historia de usuario preliminar

**HU-P05-18:** Como **Finanzas de Facultad**, quiero visualizar la información financiera acumulada del funcionario, para revisar de forma consolidada sus antecedentes de pagos, prestaciones y compromisos vigentes.

### E. Requerimientos funcionales preliminares

- **RF-PP05-063:** El sistema debe mostrar un resumen consolidado del historial financiero por funcionario.
- **RF-PP05-064:** El sistema debe mostrar acumulados y cantidades relevantes para la revisión financiera.
- **RF-PP05-065:** El sistema debe mostrar el total comprometido actual dentro de la solicitud.

---

# P05-B13 — Historial de pagos por funcionario

## Funcionalidad P05-F19 — Visualizar historial de pagos del funcionario

### A. Descripción funcional

Finanzas de Facultad debe poder revisar el historial de pagos asociados a prestaciones anteriores del funcionario.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Periodo de pago.
- Centro de Costo asociado.
- Monto bruto pagado.
- Monto neto pagado, si está disponible.
- Total pagado en el periodo consultado.
- Estado del pago.
- Tipo de prestación.
- Observaciones financieras, cuando existan.

---

# P05-B14 — Estado de validaciones previas y panel de auditoría integrada por funcionario

## Funcionalidad P05-F20 — Visualizar validaciones detalladas de Licencias, Deudas, Inhabilidades y Parentesco

### A. Descripción funcional

Finanzas de Facultad debe visualizar el panel de auditoría detallada heredado de DGDP, incorporando la información estructurada de restricciones administrativas, deudas institucionales vigentes y parentescos detectados del funcionario, garantizando que el tomador de decisiones financieras posea toda la información relevante en pantalla.

### B. Actor principal

Finanzas de Facultad.

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
- Los resultados de parentesco y deudas no deben bloquear de manera automatizada la revisión presupuestaria, operando como alertas informativas críticas.
- El panel debe conservar la misma estructura que en la etapa DGDP para mantener consistencia visual.

### E. Historia de usuario preliminar

**HU-P05-20:** Como **Finanzas de Facultad**, quiero revisar el panel de auditoría de licencias, deudas y parentesco de cada funcionario, para asegurar la integridad de la asignación y evaluar riesgos administrativos asociados a la contratación.

### F. Requerimientos funcionales preliminares

- **RF-PP05-069:** El sistema debe mostrar el panel detallado de Licencias y Restricciones Administrativas por funcionario.
- **RF-PP05-070:** El sistema desplegará la tabla de Historial de Deudas UFRO activas del funcionario.
- **RF-PP05-071:** El sistema debe mostrar las relaciones de parentesco e incompatibilidad declaradas del funcionario.
- **RF-PP05-071A:** El sistema debe presentar estas validaciones de forma no modificable (solo lectura) y estandarizada en el panel de auditoría.

---

# P05-B15 — Validación presupuestaria por funcionario e ítem

## Funcionalidad P05-F21 — Visualizar validación presupuestaria del funcionario según ítem asociado

### A. Descripción funcional

El sistema debe mostrar, por cada funcionario vigente, el resultado de la validación presupuestaria correspondiente al ítem asociado a su cargo, estamento o categoría.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Funcionario.
- Cargo, estamento o categoría.
- Ítem presupuestario asociado.
- Saldo disponible del ítem.
- Monto solicitado por el funcionario.
- Monto acumulado solicitado en el mismo ítem dentro de la solicitud.
- Saldo proyectado.
- Estado:
  - Cumple.
  - No cumple.
  - Requiere revisión.

### D. Reglas de negocio

- La validación presupuestaria debe vincular al funcionario con el ítem que corresponda a su cargo, estamento o categoría.
- La suficiencia del ítem debe revisarse tanto para el funcionario individual como para el acumulado del ítem dentro de la solicitud.
- Si el ítem resulta insuficiente, debe quedar visible la causa del incumplimiento.
- Esta validación debe estar disponible como antecedente directo para aprobar o rechazar financieramente al funcionario.

### E. Historia de usuario preliminar

**HU-P05-21:** Como **Finanzas de Facultad**, quiero visualizar el respaldo presupuestario del funcionario según el ítem que le corresponde, para revisar si su prestación puede ser financiada.

### F. Requerimientos funcionales preliminares

- **RF-PP05-072:** El sistema debe mostrar la validación presupuestaria por funcionario e ítem.
- **RF-PP05-073:** El sistema debe mostrar saldo disponible, monto solicitado y saldo proyectado del ítem correspondiente.
- **RF-PP05-074:** El sistema debe indicar si la asignación del funcionario cumple o no con la disponibilidad del ítem.
- **RF-PP05-075:** El sistema debe mostrar el consumo acumulado del ítem cuando existan varios funcionarios asociados.

---

# P05-B16 — Validación financiera individual por funcionario

## Funcionalidad P05-F22 — Registrar resultado de revisión financiera por funcionario

### A. Descripción funcional

Finanzas de Facultad debe poder registrar el resultado de su revisión financiera sobre cada funcionario vigente en la solicitud.

### B. Actor principal

Finanzas de Facultad.

### C. Estados posibles de revisión financiera individual

- **Pendiente de revisión financiera.**
- **Aprobado financieramente.**
- **Rechazado financieramente.**

### D. Datos de entrada requeridos cuando exista rechazo financiero individual

- Motivo del rechazo financiero.
- Comentario obligatorio.
- Categoría de observación, si el proceso la define.

### E. Reglas de negocio

- La revisión financiera individual debe quedar registrada por funcionario.
- La condición **Rechazado financieramente** debe dejar trazabilidad.
- La aprobación global no debe estar disponible si existen funcionarios pendientes de revisión financiera.
- La aprobación global no debe estar disponible si no existen funcionarios aprobados financieramente o habilitados para continuar.
- La consecuencia definitiva de un funcionario rechazado financieramente sobre el flujo global debe quedar definida por el proceso.

> **TODO:** Definir si un funcionario marcado como **Rechazado financieramente**:
> 1. Se excluye individualmente del flujo y la solicitud continúa con los demás; o
> 2. Impide la aprobación global y obliga a devolver con corrección o rechazar la solicitud completa.

### F. Historia de usuario preliminar

**HU-P05-22:** Como **Finanzas de Facultad**, quiero registrar el resultado de revisión financiera por funcionario, para documentar si cada asignación individual cumple con los criterios presupuestarios revisados.

### G. Requerimientos funcionales preliminares

- **RF-PP05-076:** El sistema debe permitir registrar un estado de revisión financiera por funcionario.
- **RF-PP05-077:** El sistema debe permitir aprobar o rechazar financieramente a un funcionario.
- **RF-PP05-078:** El sistema debe exigir comentario obligatorio cuando un funcionario sea rechazado financieramente.
- **RF-PP05-079:** El sistema debe registrar la decisión financiera individual en la trazabilidad del expediente.
- **RF-PP05-080:** El sistema debe bloquear la aprobación global mientras existan funcionarios pendientes de revisión financiera.
- **RF-PP05-081:** El sistema debe bloquear la aprobación global cuando no existan funcionarios aprobados financieramente o habilitados para continuar.

---

## Funcionalidad P05-F23 — Visualizar consolidado de revisión financiera por funcionario

### A. Descripción funcional

El sistema debe mostrar el estado consolidado de la revisión financiera individual de los funcionarios vigentes.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Total de funcionarios vigentes.
- Funcionarios aprobados financieramente.
- Funcionarios rechazados financieramente.
- Funcionarios pendientes de revisión.
- Monto asociado a funcionarios aprobados.
- Monto asociado a funcionarios rechazados, cuando corresponda.
- Impacto del rechazo financiero individual sobre el monto total, si el flujo lo define.

### D. Historia de usuario preliminar

**HU-P05-23:** Como **Finanzas de Facultad**, quiero visualizar un consolidado de revisión financiera por funcionario, para conocer el estado de análisis antes de decidir sobre la solicitud completa.

### E. Requerimientos funcionales preliminares

- **RF-PP05-082:** El sistema debe mostrar un resumen de estados financieros individuales por funcionario.
- **RF-PP05-083:** El sistema debe mostrar montos asociados a cada estado de revisión individual cuando corresponda.

---

# P05-B17 — Resumen consolidado de revisión Finanzas de Facultad

## Funcionalidad P05-F24 — Visualizar resumen global de revisión financiera

### A. Descripción funcional

El sistema debe mostrar un resumen global de la revisión financiera antes de que el usuario tome una decisión sobre la solicitud.

### B. Actor principal

Finanzas de Facultad.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Saldo disponible general.
- Monto original de la solicitud.
- Monto vigente posterior a exclusiones DGDP.
- Monto total en revisión financiera.
- Cantidad de funcionarios vigentes.
- Cantidad de funcionarios excluidos por DGDP.
- Cantidad de funcionarios aprobados financieramente.
- Cantidad de funcionarios rechazados financieramente.
- Funcionarios pendientes de revisión.
- Resumen de suficiencia presupuestaria por ítem.
- Alertas presupuestarias, si existen.
- Resultado de comparación entre monto solicitado y saldo disponible general.
- Resultado de comparación entre montos solicitados y saldos por ítem.
- Estado global del expediente para toma de decisión.

### D. Historia de usuario preliminar

**HU-P05-24:** Como **Finanzas de Facultad**, quiero revisar un resumen global del expediente desde la perspectiva financiera, para decidir si la solicitud puede continuar, debe devolverse con corrección o debe ser rechazada.

### E. Requerimientos funcionales preliminares

- **RF-PP05-084:** El sistema debe mostrar un resumen global de la revisión financiera.
- **RF-PP05-085:** El sistema debe integrar en el resumen los montos, saldos, funcionarios vigentes y excluidos.
- **RF-PP05-086:** El sistema debe mostrar el estado de aprobación o rechazo financiero individual de los funcionarios.
- **RF-PP05-087:** El sistema debe mostrar alertas presupuestarias relevantes para la decisión final.
- **RF-PP05-088:** El sistema debe mostrar un resumen de suficiencia presupuestaria por ítem.

---

# P05-B18 — Decisión global de Finanzas de Facultad

## Funcionalidad P05-F25 — Aprobar solicitud y derivar a la etapa siguiente

### A. Descripción funcional

Finanzas de Facultad debe poder aprobar la solicitud cuando, conforme a su revisión, el expediente puede continuar a la etapa siguiente del flujo.

### B. Actor principal

Finanzas de Facultad.

### C. Acción disponible

- Botón: **APROBAR Y CONTINUAR**.

### D. Reglas de negocio

- La aprobación debe registrar:
  - Usuario aprobador.
  - Rol.
  - Fecha y hora.
  - Estado resultante.
- La solicitud aprobada debe avanzar a la etapa siguiente del flujo definida por el proceso.
- La aprobación global debe quedar bloqueada si:
  - Existen funcionarios pendientes de revisión financiera.
  - No existen funcionarios aprobados financieramente o habilitados para continuar.
- La aprobación global debe considerar el resultado de suficiencia presupuestaria general y por ítem.
- La regla final respecto de funcionarios rechazados financieramente queda pendiente de definición funcional.

> **TODO:** Definir si la aprobación global de Finanzas exige:
> 1. Que todos los funcionarios vigentes estén marcados como **Aprobado financieramente**.
> 2. Que no existan ítems presupuestarios insuficientes.
> 3. Que no existan funcionarios rechazados financieramente.

### E. Historia de usuario preliminar

**HU-P05-25:** Como **Finanzas de Facultad**, quiero aprobar la solicitud cuando su revisión presupuestaria se encuentra conforme, para que continúe a la siguiente etapa institucional.

### F. Requerimientos funcionales preliminares

- **RF-PP05-089:** El sistema debe permitir aprobar la solicitud desde la vista de Finanzas de Facultad.
- **RF-PP05-090:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
- **RF-PP05-091:** El sistema debe derivar la solicitud aprobada a la etapa siguiente del flujo.
- **RF-PP05-092:** El sistema debe validar las condiciones previas de aprobación global que se definan para esta etapa.
- **RF-PP05-093:** El sistema debe bloquear la aprobación mientras existan funcionarios pendientes de revisión financiera.
- **RF-PP05-094:** El sistema debe bloquear la aprobación cuando no existan funcionarios aprobados financieramente o habilitados para continuar.

---

## Funcionalidad P05-F26 — Devolver con corrección al Solicitante

### A. Descripción funcional

Finanzas de Facultad debe poder devolver la solicitud al Solicitante cuando detecte observaciones financieras o presupuestarias que puedan ser corregidas.

### B. Actor principal

Finanzas de Facultad.

### C. Acción disponible

- Botón: **DEVOLVER CON CORRECCIÓN**.

### D. Datos de entrada requeridos

- Comentario obligatorio.
- Motivo o categoría de devolución, si se define un catálogo.

### E. Reglas de negocio

- La devolución con corrección debe registrar comentarios obligatorios.
- La solicitud debe volver al Solicitante para revisión o corrección.
- Los comentarios deben quedar visibles en la trazabilidad.
- Si la observación corresponde a funcionarios específicos, debe permitir referenciar esos registros en el comentario o motivo.
- La devolución debe gestionarse mediante un **modal global único**.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Encargado de Finanzas de Facultad), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P05-26:** Como **Finanzas de Facultad**, quiero devolver con corrección la solicitud al Solicitante con comentarios, para informar observaciones financieras subsanables.

### G. Requerimientos funcionales preliminares

- **RF-PP05-095:** El sistema debe permitir devolver con corrección la solicitud al Solicitante.
- **RF-PP05-096:** El sistema debe exigir comentario obligatorio para ejecutar esta acción.
- **RF-PP05-097:** El sistema debe registrar la decisión con usuario, rol, fecha, hora y comentario.
- **RF-PP05-098:** El sistema debe dejar visible la observación al Solicitante.
- **RF-PP05-099:** El sistema debe ejecutar la devolución mediante un modal global único.
* **RF-PP05-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de financiamiento o disponibilidad presupuestaria de la facultad y comentarios correspondientes.
* **RF-PP05-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P05-F27 — Rechazar solicitud

### A. Descripción funcional

Finanzas de Facultad debe poder rechazar definitivamente la solicitud cuando detecte condiciones financieras o presupuestarias que impidan su continuidad.

### B. Actor principal

Finanzas de Facultad.

### C. Acción disponible

- Botón: **RECHAZAR SOLICITUD**.

### D. Datos de entrada requeridos

- Comentario obligatorio.
- Motivo o categoría de rechazo, si se define un catálogo.

### E. Reglas de negocio

- El rechazo debe registrar comentarios obligatorios.
- La solicitud no debe continuar a etapas posteriores.
- Los comentarios deben quedar visibles en la trazabilidad.
- Si el rechazo se relaciona con funcionarios específicos, debe poder referenciarse en el comentario.
- El rechazo debe gestionarse mediante un **modal global único**.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Encargado de Finanzas de Facultad), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones de financiamiento o disponibilidad presupuestaria de la facultad), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P05-27:** Como **Finanzas de Facultad**, quiero rechazar la solicitud con comentarios, para detener expedientes que no cuentan con respaldo financiero suficiente o presentan inconsistencias no subsanables.

### G. Requerimientos funcionales preliminares

- **RF-PP05-100:** El sistema debe permitir rechazar la solicitud desde la pantalla de Finanzas de Facultad.
- **RF-PP05-101:** El sistema debe exigir comentario obligatorio para ejecutar el rechazo.
- **RF-PP05-102:** El sistema debe registrar la decisión con usuario, rol, fecha, hora y comentario.
- **RF-PP05-103:** El sistema debe impedir que una solicitud rechazada continúe a etapas posteriores.
- **RF-PP05-104:** El sistema debe ejecutar el rechazo mediante un modal global único.
* **RF-PP05-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P05-B19 — Modal global de devolución/rechazo

## Funcionalidad P05-F28 — Gestionar devolución con corrección y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un único modal global para gestionar las acciones de **DEVOLVER CON CORRECCIÓN** y **RECHAZAR SOLICITUD**, centralizando el ingreso de motivo, comentario y confirmación.

### B. Actor principal

Finanzas de Facultad.

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

**HU-P05-28:** Como **Finanzas de Facultad**, quiero gestionar la devolución o rechazo desde un modal único, para registrar de forma clara el motivo y confirmar la acción antes de modificar el expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP05-105:** El sistema debe utilizar un modal global único para devolución con corrección y rechazo.
- **RF-PP05-106:** El sistema debe exigir comentario obligatorio dentro del modal.
- **RF-PP05-107:** El sistema debe permitir cancelar la acción sin modificar el estado.
- **RF-PP05-108:** El sistema debe registrar la acción confirmada en trazabilidad.

---

# P05-B20 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P05-F29 — Confirmar decisión global antes de ejecutarla

### A. Descripción funcional

Antes de aprobar, devolver con corrección o rechazar la solicitud, el sistema debe solicitar confirmación explícita a Finanzas de Facultad.

### B. Actor principal

Finanzas de Facultad.

### C. Acciones que requieren confirmación

- **APROBAR Y CONTINUAR**.
- **DEVOLVER CON CORRECCIÓN**.
- **RECHAZAR SOLICITUD**.

### D. Reglas de negocio

- La confirmación debe permitir cancelar la acción sin modificar el estado del expediente.
- El comentario obligatorio debe estar registrado antes de confirmar una devolución o rechazo.
- La aprobación debe verificar que:
  - Existen funcionarios aprobados financieramente o habilitados para continuar.
  - No existen funcionarios pendientes de revisión financiera.
*   **Registro de Envío**: El sistema debe dejar registro del envío del correo electrónico en la trazabilidad del expediente.

### E. Historia de usuario preliminar

**HU-P05-29:** Como **Finanzas de Facultad**, quiero confirmar mi decisión antes de ejecutarla, para evitar modificar por error el estado del expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP05-109:** El sistema debe solicitar confirmación antes de aprobar, devolver con corrección o rechazar.
- **RF-PP05-110:** El sistema debe permitir cancelar la decisión antes de aplicarla.
- **RF-PP05-111:** El sistema debe impedir aprobar si no existen funcionarios aprobados financieramente o habilitados para continuar.
- **RF-PP05-112:** El sistema debe impedir aprobar si existen funcionarios pendientes de revisión financiera.
* **RF-PP05-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

## Funcionalidad P05-F30 — Registrar trazabilidad de decisiones de Finanzas de Facultad

### A. Descripción funcional

El sistema debe generar un registro automático y auditable de toda acción ejecutada en la Pantalla 05.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Aprobación global de la solicitud.
- Devolución con corrección al Solicitante.
- Rechazo de la solicitud.
- Aprobación financiera individual por funcionario.
- Rechazo financiero individual por funcionario.
- Comentarios asociados a decisiones globales e individuales.
- Resultado de validación presupuestaria por ítem, cuando corresponda.

### D. Datos mínimos de trazabilidad

- Código único de solicitud.
- Acción realizada.
- Usuario.
- Rol: Finanzas de Facultad.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Funcionario afectado, cuando aplique.
- Ítem presupuestario relacionado, cuando aplique.
- Comentario asociado, cuando corresponda.
- Motivo de rechazo financiero individual, cuando aplique.

### E. Reglas de negocio

- No debe modificarse el estado global de la solicitud sin generar simultáneamente el registro de trazabilidad.
- No debe registrarse un rechazo financiero individual sin comentario obligatorio.
- La trazabilidad debe quedar disponible para etapas posteriores del flujo.
- Debe quedar constancia de las validaciones presupuestarias por ítem utilizadas como antecedente de la decisión.

### F. Historia de usuario preliminar

**HU-P05-30:** Como **sistema**, debo registrar las decisiones emitidas por Finanzas de Facultad, para mantener una trazabilidad completa de la revisión presupuestaria del expediente.

### G. Requerimientos funcionales preliminares

- **RF-PP05-113:** El sistema debe registrar toda decisión ejecutada por Finanzas de Facultad.
- **RF-PP05-114:** El sistema debe distinguir decisiones globales de decisiones individuales por funcionario.
- **RF-PP05-115:** El sistema debe almacenar comentario y motivo cuando corresponda.
- **RF-PP05-116:** El sistema debe dejar disponible la trazabilidad de esta etapa para los revisores posteriores.
- **RF-PP05-117:** El sistema debe registrar el ítem presupuestario relacionado con la decisión financiera cuando corresponda.

---

# 7. Estados de salida de la Pantalla 05

| Acción de Finanzas de Facultad | Estado resultante de la solicitud | Destino del flujo |
|---|---|---|
| **APROBAR Y CONTINUAR** | Aprobada por Finanzas de Facultad / En revisión por etapa siguiente | Continúa el flujo institucional |
| **DEVOLVER CON CORRECCIÓN** | Devuelta con corrección al Solicitante por Finanzas de Facultad | Regresa al Solicitante para corrección |
| **RECHAZAR SOLICITUD** | Rechazada por Finanzas de Facultad | Cierre definitivo del expediente |
| Aprobar financieramente a un funcionario | Estado individual actualizado | Continúa dentro de la revisión financiera del expediente |
| Rechazar financieramente a un funcionario | Estado individual actualizado con comentario obligatorio | Efecto global pendiente de definición funcional |

---

# 8. Estados individuales posibles por funcionario en Finanzas de Facultad

| Estado | Descripción |
|---|---|
| **Pendiente de revisión financiera** | Funcionario vigente recibido desde DGDP que aún no ha sido evaluado en esta etapa. |
| **Aprobado financieramente** | Funcionario cuya información económica y presupuestaria resulta conforme para la revisión de Finanzas de Facultad. |
| **Rechazado financieramente** | Funcionario cuya información presenta observaciones financieras que deben quedar registradas. |
| **Excluido por DGDP** | Funcionario retirado en la etapa anterior, visible solo como antecedente histórico y fuera de la nómina vigente. |

---

# 9. Estados posibles de suficiencia presupuestaria por ítem

| Estado | Descripción |
|---|---|
| **Suficiente** | El ítem presupuestario cuenta con saldo disponible para cubrir el monto solicitado y su acumulado asociado. |
| **Insuficiente** | El ítem presupuestario no cuenta con saldo suficiente para cubrir el monto requerido. |
| **Requiere revisión** | Existe información pendiente, inconsistente o no concluyente para determinar la suficiencia presupuestaria. |

---

# 10. Reglas globales de comportamiento de la Pantalla 05

| Código | Regla |
|---|---|
| **RG-P05-001** | Finanzas de Facultad debe visualizar la información de etapas anteriores de forma resumida y reorganizada desde una perspectiva financiera. |
| **RG-P05-002** | La pantalla debe mostrar a los funcionarios excluidos por DGDP y el motivo resumido de su exclusión. |
| **RG-P05-003** | Los funcionarios excluidos por DGDP no deben formar parte del monto vigente de la solicitud. |
| **RG-P05-004** | La pantalla debe mostrar el monto original de la solicitud y el monto vigente posterior a exclusiones. |
| **RG-P05-005** | La pantalla debe mostrar información financiera del Centro de Costo, incluido el saldo disponible general y el monto comprometido. |
| **RG-P05-006** | La pantalla debe mostrar una tabla de ítems presupuestarios asociados al Centro de Costo, diferenciados por cargo, estamento o categoría. |
| **RG-P05-007** | La disponibilidad presupuestaria debe validarse tanto a nivel general del Centro de Costo como a nivel específico de cada ítem presupuestario. |
| **RG-P05-008** | La pantalla debe identificar el ítem presupuestario aplicable a cada funcionario según su cargo, estamento o categoría. |
| **RG-P05-009** | La validación presupuestaria por ítem debe considerar el monto individual solicitado y el acumulado de funcionarios que consumen el mismo ítem. |
| **RG-P05-010** | La pantalla debe mostrar la lista de prestaciones solicitadas por funcionario. |
| **RG-P05-011** | La pantalla debe mostrar, por prestación, actividad específica, descripción, meses de pago, total comprometido, total en jornada, total fuera de jornada y total de compensación horaria. |
| **RG-P05-012** | La pantalla debe mostrar la lista de contratos vigentes del funcionario y los datos definidos para revisión financiera, incluyendo SEA. |
| **RG-P05-013** | La pantalla debe mostrar el historial de PDS y de pagos por funcionario vigente, cuando exista información registrada. |
| **RG-P05-014** | La pantalla debe mostrar información financiera acumulada por funcionario. |
| **RG-P05-015** | La pantalla debe mostrar el estado DGDP de cada funcionario como antecedente de revisión financiera. |
| **RG-P05-016** | La revisión financiera individual por funcionario debe quedar registrada si esta funcionalidad se mantiene en el diseño final. |
| **RG-P05-017** | La consecuencia sobre el flujo de un rechazo financiero individual queda pendiente de definición funcional. |
| **RG-P05-018** | La aprobación global de la solicitud debe registrar usuario, rol, fecha y hora. |
| **RG-P05-019** | La aprobación global debe bloquearse mientras existan funcionarios pendientes de revisión financiera. |
| **RG-P05-020** | La aprobación global debe bloquearse cuando no existan funcionarios aprobados financieramente o habilitados para continuar. |
| **RG-P05-021** | La devolución con corrección debe exigir comentario obligatorio. |
| **RG-P05-022** | El rechazo de solicitud debe exigir comentario obligatorio. |
| **RG-P05-023** | Toda decisión global o individual de esta pantalla debe quedar registrada en trazabilidad. |
| **RG-P05-024** | La pantalla no debe editar datos de origen ni alterar exclusiones realizadas por DGDP. |
| **RG-P05-025** | La pantalla no debe incorporar Aprobación con Alcance, salvo definición posterior del proceso. |
| **RG-P05-026** | Las acciones globales de la pantalla deben homologarse a: **DEVOLVER CON CORRECCIÓN**, **RECHAZAR SOLICITUD** y **APROBAR Y CONTINUAR**. |
| **RG-P05-027** | La devolución con corrección y el rechazo deben gestionarse mediante un **modal global único**. |
| **RG-P05-028** | La pantalla no debe incorporar la acción **Salir sin guardar**. |
| **RG-P05-029** | El sistema debe permitir cambiar entre funcionarios para revisar su detalle financiero individual. |
| **RG-P05-030** | El resumen de la solicitud debe mostrar un estado consolidado de revisión financiera. |
| **RG-PP05-031** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 11. Requerimientos no funcionales preliminares aplicables a la Pantalla 05

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P05-001** | Legibilidad financiera | La pantalla debe permitir revisar montos, saldos, históricos y estados por funcionario sin perder la relación con el expediente global. |
| **RNF-P05-002** | Trazabilidad | Toda aprobación, devolución, rechazo o decisión individual debe quedar registrada y ser consultable en etapas posteriores. |
| **RNF-P05-003** | Integridad de datos | Los datos de etapas previas deben mantenerse en modo solo lectura y no alterarse desde esta pantalla. |
| **RNF-P05-004** | Claridad de funcionarios excluidos | Los funcionarios excluidos por DGDP deben visualizarse claramente separados de la nómina vigente. |
| **RNF-P05-005** | Consistencia de montos | El sistema debe mantener coherencia entre monto original, monto vigente, monto por funcionario, monto por ítem y monto global del expediente. |
| **RNF-P05-006** | Seguridad por rol | Solo usuarios autorizados de Finanzas de Facultad deben acceder a esta pantalla y ejecutar sus acciones. |
| **RNF-P05-007** | Confirmación de acciones | Las decisiones que cambien el estado del expediente deben requerir confirmación previa. |
| **RNF-P05-008** | Comentarios obligatorios | El sistema debe impedir devolver con corrección o rechazar la solicitud sin comentario registrado. |
| **RNF-P05-009** | Auditabilidad financiera | Debe ser posible reconstruir qué revisión financiera se realizó sobre cada funcionario, cada ítem presupuestario y sobre la solicitud global. |
| **RNF-P05-010** | Coherencia de antecedentes | La información financiera, contractual e histórica mostrada por funcionario debe mantenerse alineada con la versión del expediente que ingresó a Finanzas de Facultad. |
| **RNF-P05-011** | Comparación presupuestaria | La vista debe permitir contrastar el monto vigente de la solicitud con la disponibilidad general del Centro de Costo y con la disponibilidad específica de cada ítem presupuestario. |
| **RNF-P05-012** | Separación funcional | La pantalla debe distinguir información heredada desde DGDP de la información revisada específicamente por Finanzas de Facultad. |
| **RNF-P05-013** | Organización tabular | Las prestaciones solicitadas, los contratos vigentes y los ítems presupuestarios deben poder visualizarse en estructuras tabulares que faciliten su comparación. |
| **RNF-P05-014** | Lectura acumulativa | La pantalla debe facilitar la lectura de totales comprometidos, totales en jornada, fuera de jornada y compensaciones sin exigir cálculos manuales al usuario. |
| **RNF-P05-015** | Transparencia de imputación | La pantalla debe permitir identificar claramente qué funcionario y qué prestación consumen cada ítem presupuestario. |
| **RNF-P05-016** | Consistencia de estados | El estado presupuestario por ítem, el estado financiero por funcionario y el estado global de la solicitud deben mantenerse sincronizados visual y funcionalmente. |
| **RNF-P05-017** | Estado consolidado visible | La pantalla debe mostrar de forma comprensible el avance global de la revisión financiera y los bloqueos asociados a la aprobación. |
| **RNF-P05-018** | Homologación de acciones | Las acciones globales deben presentarse con la nomenclatura definida: DEVOLVER CON CORRECCIÓN, RECHAZAR SOLICITUD y APROBAR Y CONTINUAR. |

---

# 12. Inventario consolidado de funcionalidades de la Pantalla 05

| Código | Funcionalidad |
|---|---|
| **P05-F01** | Visualizar identificación de la solicitud. |
| **P05-F02** | Visualizar estado actual del expediente. |
| **P05-F03** | Visualizar aprobaciones y decisiones previas del flujo. |
| **P05-F04** | Visualizar línea de avance del flujo. |
| **P05-F05** | Visualizar funcionarios excluidos por DGDP. |
| **P05-F06** | Visualizar resumen financiero general de la solicitud. |
| **P05-F07** | Visualizar estado consolidado de revisión financiera. |
| **P05-F08** | Visualizar información financiera completa del Centro de Costo. |
| **P05-F09** | Visualizar tabla de ítems presupuestarios asociados al Centro de Costo. |
| **P05-F10** | Validar suficiencia presupuestaria por ítem asociado al cargo del funcionario. |
| **P05-F11** | Visualizar contexto técnico resumido de la solicitud. |
| **P05-F12** | Visualizar funcionarios activos que continúan en el proceso. |
| **P05-F13** | Seleccionar funcionario para revisión detallada. |
| **P05-F14** | Visualizar antecedentes laborales relevantes por funcionario. |
| **P05-F15** | Visualizar tabla de prestaciones solicitadas por funcionario. |
| **P05-F16** | Visualizar lista de contratos vigentes del funcionario. |
| **P05-F17** | Visualizar historial de PDS previas del funcionario. |
| **P05-F18** | Visualizar información financiera acumulada del funcionario. |
| **P05-F19** | Visualizar historial de pagos del funcionario. |
| **P05-F20** | Visualizar resultado resumido de validaciones DGDP y etapas anteriores. |
| **P05-F21** | Visualizar validación presupuestaria del funcionario según ítem asociado. |
| **P05-F22** | Registrar resultado de revisión financiera por funcionario. |
| **P05-F23** | Visualizar consolidado de revisión financiera por funcionario. |
| **P05-F24** | Visualizar resumen global de revisión financiera. |
| **P05-F25** | Aprobar solicitud y derivar a la etapa siguiente. |
| **P05-F26** | Devolver con corrección al Solicitante. |
| **P05-F27** | Rechazar solicitud. |
| **P05-F28** | Gestionar devolución con corrección y rechazo mediante modal global único. |
| **P05-F29** | Confirmar decisión global antes de ejecutarla. |
| **P05-F30** | Registrar trazabilidad de decisiones de Finanzas de Facultad. |
