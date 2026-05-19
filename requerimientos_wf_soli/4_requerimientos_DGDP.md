# PDS Normativo D9 / DU288 / DU09

## Pantalla 04 — Revisión y Validación Normativa por DGDP

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 04: Revisión y Validación Normativa — Perfil DGDP** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

A diferencia de las etapas anteriores, esta pantalla no corresponde únicamente a una instancia de visación jerárquica, sino a un **punto de auditoría normativa y técnica especializada**, donde la Dirección de Gestión y Desarrollo de Personas debe revisar en profundidad la información asociada a:

- La solicitud completa.
- El Centro de Costo y origen de financiamiento.
- Las validaciones ejecutadas en las pantallas previas.
- La situación contractual y administrativa de cada funcionario.
- El historial de prestaciones y pagos.
- Los topes económicos.
- Las reglas de jornada, SEA y compensación.
- Las deudas e inhabilidades.
- Las condiciones especiales que puedan aplicar.

Además, la pantalla debe permitir que DGDP **excluya uno o más funcionarios de la solicitud cuando no cumplan las condiciones normativas**, sin que ello implique necesariamente el rechazo completo del expediente. Los funcionarios excluidos no continúan en el flujo, mientras que los funcionarios que sí cumplen pueden seguir avanzando hacia las etapas posteriores.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 04 — DGDP**. No modifica las pantallas anteriores. Su objetivo es definir qué debe visualizarse, qué debe volver a validarse, qué decisiones puede tomar DGDP y cómo debe operar la exclusión individual de funcionarios dentro de una solicitud que puede continuar parcialmente.

---

# 2. Identificación general de la pantalla

| Elemento | Descripción |
|---|---|
| **Código de pantalla** | P04 |
| **Nombre** | Revisión y Validación Normativa DGDP |
| **Perfil principal** | Analista / Profesional autorizado DGDP |
| **Etapa del flujo** | Etapa 04 — Control normativo centralizado de personas |
| **Estado de entrada esperado** | Solicitud aprobada por Jefatura Directa / Dirección de Departamento y enviada a revisión DGDP |
| **Objetivo principal** | Permitir que DGDP revalide integralmente la solicitud, revise el cumplimiento normativo de cada funcionario y decida si aprueba la continuidad del expediente, devuelve la solicitud con corrección al Solicitante, rechaza definitivamente o excluye funcionarios específicos por incumplimiento. |
| **Resultado posible** | Aprobada y derivada a la etapa siguiente; aprobada con exclusión de uno o más funcionarios; devuelta con corrección al Solicitante; o rechazada definitivamente. |

---

# 3. Principio funcional de la Pantalla 04

La Pantalla 04 debe operar como una **vista de auditoría normativa, revalidación técnica y depuración individual de funcionarios**.

DGDP no solo visualiza la información que permitió llegar a esta etapa, sino que debe contar con los antecedentes suficientes para **revisar nuevamente las condiciones de cumplimiento** con información actualizada y tomar decisiones fundadas por funcionario y por solicitud.

---

## 3.1 Funciones que sí debe cumplir

La Pantalla 04 debe permitir que DGDP:

- Visualice la solicitud completa y su trazabilidad previa.
- Revise las visaciones favorables del:
  - Jefe de Proyecto.
  - Jefatura Directa / Dirección de Departamento.
- Visualice todos los datos asociados al Centro de Costo.
- Visualice una tabla informativa de ítems presupuestarios asociados al expediente, cuando la información se encuentre disponible.
- Revise la actividad general, tipo de prestación y evidencias comprometidas.
- Visualice la nómina completa de funcionarios incorporados.
- Cambie entre los funcionarios incorporados para revisar el detalle individual de cada uno.
- Revise por cada funcionario:
  - Datos identificatorios.
  - Cantidad de contratos vigentes.
  - Detalle de cada contrato.
  - Contrato seleccionado para la PDS.
  - Jerarquía, estamento, grado, jornada y tipo de vínculo.
  - Renta bruta y neta, cuando aplique a la validación.
  - Historial de prestaciones de servicios.
  - Historial de pagos y acumulados.
  - Deudas institucionales.
  - Inhabilidades por cargo.
  - Estado de licencia médica o permiso sin goce de sueldo, si estas reglas se formalizan.
  - Resultado de la validación de topes.
  - Resultado de la validación de jornada, SEA y compensación.
  - Posibles vínculos familiares e incompatibilidades, sujeto a definición normativa pendiente.
- Revalidar las condiciones ya revisadas previamente por el sistema en la etapa del Solicitante.
- Visualizar el resultado previo de las validaciones y el resultado actualizado en DGDP cuando corresponda.
- Excluir uno o más funcionarios de la solicitud cuando detecte un incumplimiento normativo individual.
- Registrar el motivo obligatorio de exclusión de cada funcionario.
- Solicitar confirmación antes de excluir a un funcionario.
- Generar una notificación por correo al Solicitante informando la exclusión y su motivo.
- Visualizar un aviso o confirmación de que la notificación por exclusión fue generada, sin necesidad de desplegar el contenido completo del correo en pantalla.
- Mostrar un aviso o confirmación visible de que la notificación por exclusión fue generada correctamente.
- Visualizar un **estado consolidado de revisión DGDP**, incluyendo:
  - Cantidad de funcionarios habilitados.
  - Cantidad de funcionarios excluidos.
  - Cantidad de funcionarios pendientes de revisión.
  - Estado general de preparación para la decisión final.
- Aprobar la solicitud con los funcionarios que cumplen, si la exclusión de otros no impide la continuidad del expediente.
- Devolver la solicitud completa al Solicitante mediante la acción **DEVOLVER CON CORRECCIÓN**.
- Rechazar definitivamente la solicitud completa mediante la acción **RECHAZAR SOLICITUD**.
- Aprobar y avanzar a la etapa siguiente mediante la acción **APROBAR Y CONTINUAR**.
- Gestionar la devolución con corrección y el rechazo mediante un **modal global único**.
- Bloquear la aprobación cuando:
  - No existan funcionarios habilitados.
  - Existan funcionarios pendientes de revisión.
- Registrar trazabilidad de todas las decisiones y acciones ejecutadas.

---

## 3.2 Funciones que no debe cumplir

La Pantalla 04 no debe:

- Permitir editar los datos originales ingresados por el Solicitante.
- Permitir modificar directamente montos, meses, actividades, evidencias o compensaciones.
- Permitir incorporar nuevos funcionarios.
- Permitir reemplazar funcionarios excluidos desde esta vista.
- Modificar la aprobación previa del Jefe de Proyecto ni de la Jefatura Directa.
- Incorporar la opción de **Aprobación con Alcance**, la cual corresponde a otra etapa del flujo si se mantiene en el diseño final.
- Ocultar los motivos de exclusión o rechazo.
- Eliminar silenciosamente a un funcionario sin confirmación expresa de DGDP.
- Desplegar en pantalla el contenido completo del correo de notificación generado por exclusión de funcionario.
- Permitir aprobar y continuar cuando no existan funcionarios habilitados.
- Permitir aprobar y continuar cuando existan funcionarios pendientes de revisión.
- Incorporar la acción **Salir sin guardar** como opción operativa de la pantalla.

---

# 4. Objetivo funcional de la Pantalla 04

La pantalla debe permitir que DGDP:

1. Identifique la solicitud sometida a revisión normativa.
2. Visualice su estado actual y la trazabilidad de etapas previas.
3. Revise la aprobación del Jefe de Proyecto y de la Jefatura Directa / Dirección de Departamento.
4. Visualice el resumen ejecutivo del expediente.
5. Consulte todos los datos disponibles del Centro de Costo y sus validaciones previas.
6. Revise el tipo de prestación, actividad general y evidencias comprometidas.
7. Visualice la totalidad de funcionarios incorporados.
8. Seleccione o cambie entre funcionarios para revisar su información individual.
9. Revise la ficha completa de cada funcionario.
10. Consulte la cantidad de contratos asociados al funcionario y el detalle de cada uno.
11. Revise el contrato seleccionado para la PDS.
12. Verifique nuevamente inhabilidades, deudas y demás condiciones normativas.
13. Consulte el historial de PDS anteriores y pagos asociados.
14. Revise el cálculo de topes salariales y montos acumulados.
15. Revise la modalidad de jornada, condición SEA y compensación horaria.
16. Visualice posibles familiares o incompatibilidades cuando la fuente de datos y la regla normativa sean definidas.
17. Mantenga identificado como pendiente el análisis de ANID / DIUFRO / DITT, sin incorporarlo como validación operativa de esta versión.
18. Determine si cada funcionario cumple o no cumple con la normativa.
19. Excluya funcionarios que no cumplan, dejando trazabilidad y motivo de la decisión.
20. Notifique por correo la exclusión del funcionario y muestre en pantalla una confirmación visible de que dicha notificación fue generada, sin desplegar el contenido completo del correo.
21. Visualice el estado consolidado de la revisión DGDP.
22. Apruebe la solicitud si quedan funcionarios válidos, no existen revisiones pendientes y el expediente mantiene condiciones para continuar.
23. Devuelva con corrección la solicitud al Solicitante si requiere ajustes generales.
24. Rechace definitivamente la solicitud si el incumplimiento afecta al expediente completo.
25. Confirme cualquier acción antes de ejecutarla.
26. Registre la trazabilidad completa de las decisiones DGDP.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 04 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P04-B01** | Encabezado de expediente y estado DGDP | Identificar la solicitud, su estado actual y el perfil revisor. |
| **P04-B02** | Trazabilidad de aprobaciones previas | Mostrar las decisiones emitidas por Jefe de Proyecto y Jefatura Directa / Dirección de Departamento. |
| **P04-B03** | Resumen ejecutivo de la solicitud y estado consolidado DGDP | Presentar los datos principales del expediente y el estado global de revisión de funcionarios. |
| **P04-B04** | Centro de Costo, proyecto y origen de fondos | Mostrar todos los datos presupuestarios, administrativos y normativos disponibles. |
| **P04-B05** | ANID / DIUFRO / DITT — Bloque pendiente de incorporación | Registrar que la validación se encuentra en definición y no forma parte operativa de esta versión. |
| **P04-B06** | Actividad general, tipo de prestación y evidencias | Revisar el contenido técnico declarado por el Solicitante. |
| **P04-B07** | Nómina general y estado de revisión de funcionarios | Mostrar todos los funcionarios incorporados y su estado de validación DGDP. |
| **P04-B08** | Selector y ficha contractual integral por funcionario | Permitir cambiar entre funcionarios y mostrar identificación, contratos, vínculo, estamento, grado, jornada y datos asociados. |
| **P04-B09** | Revalidación normativa de elegibilidad | Revisar inhabilidades, deudas, licencias, permisos y demás restricciones. |
| **P04-B10** | Historial de prestaciones previas | Mostrar PDS históricas y validar recurrencia o reglas de periodicidad. |
| **P04-B11** | Historial de pagos e información financiera | Mostrar acumulados de pagos, montos previos y proyección asociada al funcionario. |
| **P04-B12** | Validación de topes económicos | Recalcular y mostrar el cumplimiento de topes según perfil y prestaciones acumuladas. |
| **P04-B13** | Jornada, SEA y compensación horaria | Revalidar la ejecución dentro/fuera de jornada y el cumplimiento de compensaciones. |
| **P04-B14** | Parentescos e incompatibilidades | Mostrar posibles familiares y definir posteriormente si su existencia es condicionante. |
| **P04-B15** | Exclusión individual de funcionarios | Permitir quitar funcionarios que no cumplen, sin detener por sí sola a toda la solicitud. |
| **P04-B16** | Notificación por exclusión | Generar comunicación al Solicitante con el motivo de la exclusión. |
| **P04-B17** | Decisión global de DGDP | Permitir devolver con corrección, rechazar solicitud o aprobar y continuar. |
| **P04-B18** | Modal global de devolución/rechazo | Gestionar comentarios, motivo y confirmación para devolución con corrección o rechazo de la solicitud. |
| **P04-B19** | Confirmación, transición de estado y trazabilidad | Confirmar decisiones, aplicar bloqueos de aprobación y registrar todos los eventos en el historial del expediente. |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P04-B01 — Encabezado de expediente y estado DGDP

## Funcionalidad P04-F01 — Visualizar identificación de la solicitud

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación única del expediente sometido a revisión DGDP.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Número o código único de solicitud.
- Nombre del flujo: PDS Normativo D9 / DU288 / DU09.
- Título general de revisión normativa.

### D. Reglas de negocio

- El identificador debe ser único e inalterable durante todo el flujo.
- Debe permanecer visible mientras DGDP revisa el expediente.

### E. Historia de usuario preliminar

**HU-P04-01:** Como **DGDP**, quiero visualizar claramente el identificador de la solicitud en revisión, para asociar cada análisis y decisión al expediente correcto.

### F. Requerimientos funcionales preliminares

* **RF-PP04-001**: El sistema debe generar y enviar de forma automática un correo electrónico de notificación tanto al Solicitante como al Funcionario excluido por cada funcionario removido.
* **RF-PP04-002**: El correo debe incluir la causal o motivo normativo detallado y el comentario técnico de la exclusión.
* **RF-PP04-003**: El sistema debe registrar en la bitácora de trazabilidad el envío de la notificación al Solicitante y al Funcionario.
* **RF-PP04-004**: La interfaz debe representar esta acción mediante un aviso o confirmación visible (Toast/modal de éxito) de notificación generada, sin necesidad de desplegar el cuerpo completo del correo en pantalla.
---

## Funcionalidad P04-F02 — Visualizar estado actual del expediente

### A. Descripción funcional

El sistema debe mostrar que la solicitud se encuentra en revisión por DGDP.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Estado: **En revisión por DGDP**.
- Etapa actual del flujo.
- Fecha de ingreso a la etapa DGDP.

### D. Reglas de negocio

- Solo deben llegar a DGDP solicitudes aprobadas por la Jefatura Directa / Dirección de Departamento.
- Mientras el expediente esté en DGDP, no debe estar disponible para edición por el Solicitante.

### E. Historia de usuario preliminar

**HU-P04-02:** Como **DGDP**, quiero visualizar el estado actual de la solicitud, para confirmar que se encuentra habilitada para revisión normativa.

### F. Requerimientos funcionales preliminares

- **RF-PP04-005:** El sistema debe mostrar el estado actual de revisión DGDP.
- **RF-PP04-006:** El sistema debe mostrar la fecha de ingreso de la solicitud a esta etapa.

---

# P04-B02 — Trazabilidad de aprobaciones previas

## Funcionalidad P04-F03 — Visualizar visaciones previas del flujo

### A. Descripción funcional

El sistema debe mostrar las decisiones emitidas en las etapas anteriores, permitiendo a DGDP conocer el recorrido previo del expediente.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

Por cada visación previa:

- Etapa.
- Rol aprobador.
- Usuario responsable.
- Fecha.
- Hora.
- Acción realizada.
- Comentarios asociados, cuando existan.

### D. Etapas previas mínimas a mostrar

- Envío del Solicitante.
- Aprobación del Jefe de Proyecto.
- Aprobación de la Jefatura Directa / Dirección de Departamento.

### E. Historia de usuario preliminar

**HU-P04-03:** Como **DGDP**, quiero revisar las visaciones previas del expediente, para conocer su trazabilidad antes de ejecutar la auditoría normativa.

### F. Requerimientos funcionales preliminares

- **RF-PP04-007:** El sistema debe mostrar cronológicamente las acciones previas del expediente.
- **RF-PP04-008:** El sistema debe mostrar usuario, rol, fecha, hora y comentario cuando corresponda.

---

## Funcionalidad P04-F04 — Visualizar línea de avance del flujo

### A. Descripción funcional

El sistema debe mostrar visualmente el avance del expediente dentro del flujo PDS Normativo.

### B. Actor principal

DGDP.

### C. Hitos mínimos

- Solicitud creada.
- Enviada por Solicitante.
- Aprobada por Jefe de Proyecto.
- Aprobada por Jefatura Directa / Dirección de Departamento.
- Etapa actual: Revisión DGDP.
- Etapa siguiente pendiente.

### D. Historia de usuario preliminar

**HU-P04-04:** Como **DGDP**, quiero visualizar el avance del expediente dentro del flujo, para comprender el punto exacto en que se encuentra y sus etapas ya cumplidas.

### E. Requerimientos funcionales preliminares

- **RF-PP04-009:** El sistema debe mostrar una línea de trazabilidad del flujo.
- **RF-PP04-010:** El sistema debe diferenciar visualmente etapas cumplidas, etapa actual y etapas pendientes.

---

# P04-B03 — Resumen ejecutivo de la solicitud y estado consolidado DGDP

## Funcionalidad P04-F05 — Visualizar resumen general del expediente

### A. Descripción funcional

El sistema debe mostrar un resumen ejecutivo de la solicitud antes del detalle técnico.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Centro de Costo.
- Nombre del proyecto.
- Unidad ejecutora.
- Tipo de financiamiento.
- Decreto afecto.
- Periodo de prestación.
- Monto total vigente de la solicitud.
- Cantidad de funcionarios inicialmente incorporados.
- Cantidad de funcionarios habilitados.
- Cantidad de funcionarios excluidos por DGDP, si aplica.
- Cantidad de funcionarios pendientes de revisión.

### D. Reglas de negocio

- El monto total de la solicitud debe recalcularse si DGDP excluye uno o más funcionarios.
- Debe diferenciarse entre:
  - Monto original recibido desde etapas previas.
  - Monto vigente posterior a exclusiones DGDP, si aplica.

### E. Historia de usuario preliminar

**HU-P04-05:** Como **DGDP**, quiero visualizar un resumen ejecutivo del expediente, para conocer de inmediato su alcance económico, institucional y la cantidad de funcionarios en revisión.

### F. Requerimientos funcionales preliminares

- **RF-PP04-011:** El sistema debe mostrar los datos clave de la solicitud.
- **RF-PP04-012:** El sistema debe mostrar el monto total original y el monto actualizado cuando existan exclusiones.
- **RF-PP04-013:** El sistema debe mostrar el número de funcionarios iniciales, habilitados, excluidos y pendientes de revisión.

---

## Funcionalidad P04-F06 — Visualizar estado consolidado de revisión DGDP

### A. Descripción funcional

El sistema debe mostrar un estado consolidado que permita a DGDP conocer, de manera resumida, el avance de la revisión normativa de los funcionarios incluidos en la solicitud.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Total de funcionarios recibidos.
- Funcionarios habilitados.
- Funcionarios excluidos.
- Funcionarios pendientes de revisión.
- Estado de posibilidad de aprobación:
  - Habilitada para aprobar.
  - Bloqueada por falta de funcionarios habilitados.
  - Bloqueada por funcionarios pendientes de revisión.

### D. Reglas de negocio

- Si no existen funcionarios habilitados, el estado consolidado debe indicar que la aprobación se encuentra bloqueada.
- Si existen funcionarios pendientes de revisión, el estado consolidado debe indicar que la aprobación se encuentra bloqueada.
- El estado consolidado debe actualizarse al excluir o revisar funcionarios.

### E. Historia de usuario preliminar

**HU-P04-06:** Como **DGDP**, quiero visualizar un estado consolidado de revisión, para saber si la solicitud se encuentra en condiciones de ser aprobada o si aún existen impedimentos.

### F. Requerimientos funcionales preliminares

- **RF-PP04-014:** El sistema debe mostrar el estado consolidado de revisión DGDP.
- **RF-PP04-015:** El sistema debe indicar si existen funcionarios habilitados, excluidos o pendientes.
- **RF-PP04-016:** El sistema debe mostrar si la aprobación está habilitada o bloqueada según el estado consolidado.

---

# P04-B04 — Centro de Costo, proyecto y origen de fondos

## Funcionalidad P04-F07 — Visualizar información completa del Centro de Costo

### A. Descripción funcional

DGDP debe visualizar todos los datos disponibles del Centro de Costo y del proyecto asociado, junto con las validaciones ejecutadas en etapas previas.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Código del Centro de Costo.
- Nombre del Centro de Costo.
- Unidad ejecutora.
- Jefe de Proyecto asociado.
- RUT del Jefe de Proyecto, si está disponible.
- Nombre del proyecto.
- Tipo de financiamiento.
- Decreto afecto.
- Ítem presupuestario, si corresponde.
- Tabla de ítems presupuestarios asociados al expediente, cuando la fuente de datos lo permita.
- Saldo disponible consultado.
- Estado de vigencia del Centro de Costo.
- Estado de habilitación.
- Condición estructural / no estructural, cuando corresponda.
- Resultado de validación de Formación Continua.
- Alertas no bloqueantes identificadas previamente.

### D. Reglas de negocio

- La información debe mostrarse en modo solo lectura.
- DGDP debe ver tanto los datos ingresados y recuperados en Pantalla 01 como los resultados de las validaciones aplicadas.
- Si una alerta fue informativa y no bloqueó el flujo, debe seguir siendo visible.
- Si existen ítems presupuestarios asociados al expediente, estos deben mostrarse como antecedente informativo, sin posibilidad de edición desde la vista DGDP.

### E. Historia de usuario preliminar

**HU-P04-07:** Como **DGDP**, quiero revisar toda la información del Centro de Costo y del proyecto, para contrastar el origen presupuestario con las reglas normativas aplicables.

### F. Requerimientos funcionales preliminares

- **RF-PP04-017:** El sistema debe mostrar todos los datos disponibles del Centro de Costo y proyecto asociado.
- **RF-PP04-018:** El sistema debe mostrar las validaciones previas aplicadas al Centro de Costo.
- **RF-PP04-019:** El sistema debe conservar visibles las alertas informativas detectadas en etapas anteriores.
- **RF-PP04-020:** El sistema debe permitir visualizar una tabla informativa de ítems presupuestarios asociados al expediente cuando dicha información esté disponible.

---

## Funcionalidad P04-F08 — Revalidar condiciones del Centro de Costo

### A. Descripción funcional

El sistema debe permitir que DGDP revise nuevamente las condiciones críticas del Centro de Costo consideradas en la creación de la solicitud.

### B. Actor principal

DGDP / Sistema.

### C. Validaciones a revisar

- Centro de Costo vigente.
- Centro de Costo habilitado.
- Tipo de financiamiento compatible.
- Decreto afecto identificado.
- Condición de Formación Continua.
- Estado del proyecto, cuando aplique.

### D. Historia de usuario preliminar

**HU-P04-08:** Como **DGDP**, quiero revisar nuevamente las condiciones del Centro de Costo, para verificar que el expediente mantiene coherencia normativa al momento de la auditoría central.

### E. Requerimientos funcionales preliminares

- **RF-PP04-020:** El sistema debe mostrar el resultado vigente de las validaciones críticas del Centro de Costo.
- **RF-PP04-021:** El sistema debe distinguir entre validación previa y validación revisada en DGDP cuando corresponda.

---

# P04-B05 — ANID / DIUFRO / DITT — Bloque pendiente de incorporación

## Funcionalidad P04-F09 — Registrar que la validación ANID / DIUFRO / DITT se encuentra pendiente de definición

### A. Descripción funcional

La pantalla debe dejar explícito que la validación asociada a proyectos ANID / DIUFRO / DITT se encuentra **pendiente de definición funcional y normativa**, por lo que **no forma parte de las validaciones operativas incorporadas en esta versión**.

### B. Actor principal

DGDP.

### C. Estado actual de definición

> **TODO:** Definir fuente, mecanismo de identificación, respaldo exigido y efectos normativos de la condición ANID / DIUFRO / DITT.

### D. Reglas de negocio

- Esta sección debe mostrarse como un bloque pendiente o no incorporado en la versión actual.
- No debe presentar resultados simulados de cumplimiento.
- No debe mostrar ejemplos que indiquen que la validación ya fue implementada.
- No debe afectar las decisiones operativas de aprobación, devolución, rechazo o exclusión de funcionarios mientras no se defina su comportamiento.

### E. Historia de usuario preliminar

**HU-P04-09:** Como **DGDP**, quiero visualizar que la validación ANID / DIUFRO / DITT se encuentra pendiente de incorporación, para distinguir claramente qué controles forman parte de la versión actual y cuáles aún están en definición.

### F. Requerimientos funcionales preliminares

- **RF-PP04-022:** El sistema debe mostrar que la validación ANID / DIUFRO / DITT no está incorporada operativamente en esta versión.
- **RF-PP04-023:** El sistema no debe mostrar esta validación como cumplida, rechazada o evaluada.
- **RF-PP04-024:** El sistema debe permitir mantener este bloque como referencia funcional pendiente para futuras versiones.

---

# P04-B06 — Actividad general, tipo de prestación y evidencias

## Funcionalidad P04-F10 — Visualizar actividad general, tipo de prestación y periodo

### A. Descripción funcional

DGDP debe visualizar el contenido técnico seleccionado en la solicitud tal como fue ingresado por el Solicitante.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Descripción general de la actividad.
- Tipo o tipos de prestación seleccionados.
- Descripción de “Otro”, si fue utilizada.
- Fecha de inicio de la prestación.
- Fecha de término de la prestación.

### D. Historia de usuario preliminar

**HU-P04-10:** Como **DGDP**, quiero revisar la actividad general y clasificación de la prestación, para contextualizar la auditoría normativa del expediente.

### E. Requerimientos funcionales preliminares

- **RF-PP04-025:** El sistema debe mostrar la descripción general de la prestación.
- **RF-PP04-026:** El sistema debe mostrar los tipos de prestación seleccionados.
- **RF-PP04-027:** El sistema debe mostrar el periodo de inicio y término de la solicitud.

---

## Funcionalidad P04-F11 — Visualizar evidencias comprometidas

### A. Descripción funcional

DGDP debe poder revisar los entregables comprometidos y sus fechas de entrega.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Evidencia seleccionada.
- Tipo de evidencia.
- Descripción de evidencia “Otra”, si existe.
- Fecha estimada de entrega por evidencia.
- Relación entre evidencia y actividad, si se incorpora posteriormente.

### D. Historia de usuario preliminar

**HU-P04-11:** Como **DGDP**, quiero revisar las evidencias comprometidas en la solicitud, para conocer los respaldos documentales que sustentan la prestación.

### E. Requerimientos funcionales preliminares

- **RF-PP04-028:** El sistema debe mostrar las evidencias comprometidas.
- **RF-PP04-029:** El sistema debe mostrar la fecha estimada de entrega de cada evidencia.
- **RF-PP04-030:** El sistema debe mostrar el detalle de evidencias de tipo “Otra”.

---

# P04-B07 — Nómina general y estado de revisión de funcionarios

## Funcionalidad P04-F12 — Visualizar nómina completa de funcionarios en revisión

### A. Descripción funcional

DGDP debe visualizar la nómina completa de funcionarios recibidos desde las etapas anteriores, identificando su estado dentro de la revisión normativa.

### B. Actor principal

DGDP.

### C. Datos mínimos por funcionario en vista resumida

- RUT.
- Nombre completo.
- Estamento.
- Cargo o jerarquía.
- Contrato seleccionado.
- Tipo de jornada.
- Monto bruto mensual.
- Total PDS.
- Estado de revisión DGDP:
  - Pendiente de revisión.
  - Cumple.
  - Excluido por DGDP.
- Indicador de alertas críticas, si existen.

### D. Reglas de negocio

- Un funcionario excluido por DGDP debe permanecer visible en el expediente con estado de exclusión y motivo.
- No debe desaparecer silenciosamente de la trazabilidad.
- Los funcionarios excluidos no deben avanzar a etapas posteriores.
- Los identificadores de funcionarios, incluido el RUT, deben mantenerse consistentes entre la interfaz visual y la estructura de datos utilizada por el sistema.

### E. Historia de usuario preliminar

**HU-P04-12:** Como **DGDP**, quiero visualizar la nómina completa de funcionarios y su estado de revisión, para identificar quiénes cumplen y quiénes requieren una decisión de exclusión.

### F. Requerimientos funcionales preliminares

- **RF-PP04-031:** El sistema debe mostrar la nómina completa de funcionarios enviados a DGDP.
- **RF-PP04-032:** El sistema debe mostrar el estado de revisión normativa por funcionario.
- **RF-PP04-033:** El sistema debe mantener visibles los funcionarios excluidos con su motivo asociado.
- **RF-PP04-034:** El sistema debe asegurar consistencia de RUT entre los datos internos y la representación visual.

---

# P04-B08 — Selector y ficha contractual integral por funcionario

## Funcionalidad P04-F13 — Seleccionar funcionario para revisión detallada

### A. Descripción funcional

El sistema debe permitir a DGDP cambiar entre los funcionarios incorporados en la solicitud para visualizar su detalle individual de revisión.

### B. Actor principal

DGDP.

### C. Comportamiento esperado

- Seleccionar un funcionario desde la nómina o selector disponible.
- Cargar la información detallada correspondiente al funcionario seleccionado.
- Actualizar la ficha contractual, validaciones, historial, pagos y estados asociados al funcionario seleccionado.

### D. Reglas de negocio

- El cambio de funcionario no debe alterar datos registrados.
- El funcionario seleccionado debe mantenerse claramente identificado en pantalla.
- La selección debe respetar el estado real de cada funcionario: pendiente, cumple o excluido.

### E. Historia de usuario preliminar

**HU-P04-13:** Como **DGDP**, quiero seleccionar distintos funcionarios dentro de la solicitud, para revisar el detalle normativo de cada uno sin salir de la pantalla.

### F. Requerimientos funcionales preliminares

- **RF-PP04-035:** El sistema debe permitir seleccionar o cambiar entre funcionarios de la solicitud.
- **RF-PP04-036:** El sistema debe actualizar la ficha visible según el funcionario seleccionado.
- **RF-PP04-037:** El sistema debe mantener visible la identidad del funcionario actualmente revisado.

---

## Funcionalidad P04-F14 — Visualizar datos identificatorios y laborales completos

### A. Descripción funcional

DGDP debe contar con una ficha integral de cada funcionario para revisar su situación institucional vigente.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- RUT.
- Nombre completo.
- Jerarquía.
- Estamento.
- Tipo de vinculación.
- Grado.
- Tipo de jornada.
- Jornada en horas.
- Antigüedad contractual.
- Renta bruta.
- Renta neta, cuando sea requerida.
- Estado de vigencia contractual.
- Condición SEA, cuando corresponda.

### D. Historia de usuario preliminar

**HU-P04-14:** Como **DGDP**, quiero visualizar la ficha laboral completa del funcionario, para revisar los antecedentes que sustentan la validación normativa.

### E. Requerimientos funcionales preliminares

- **RF-PP04-038:** El sistema debe mostrar los datos identificatorios y laborales completos por funcionario.
- **RF-PP04-039:** El sistema debe mostrar los datos salariales que se utilicen en cálculos normativos.

---

## Funcionalidad P04-F15 — Visualizar cantidad de contratos y detalle contractual

### A. Descripción funcional

DGDP debe visualizar la cantidad de contratos vigentes del funcionario y el detalle de cada uno, distinguiendo el contrato seleccionado para la PDS.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Cantidad de contratos vigentes identificados.
- Detalle de cada contrato:
  - Código o identificador contractual.
  - Tipo de vínculo.
  - Estamento.
  - Grado.
  - Jornada.
  - Renta asociada.
  - Vigencia.
- Contrato seleccionado por el Solicitante para la PDS.
- Contrato usado para cálculo de topes, cuando aplique.

### D. Reglas de negocio

- Debe distinguirse claramente:
  - Contrato seleccionado en Pantalla 01.
  - Contratos vigentes adicionales.
  - Contrato utilizado como referencia para el cálculo del tope, si la regla así lo define.

### E. Historia de usuario preliminar

**HU-P04-15:** Como **DGDP**, quiero revisar todos los contratos vigentes del funcionario y distinguir el contrato asociado a la PDS, para verificar que los cálculos y condiciones se aplicaron sobre la información correcta.

### F. Requerimientos funcionales preliminares

- **RF-PP04-040:** El sistema debe mostrar la cantidad de contratos vigentes del funcionario.
- **RF-PP04-041:** El sistema debe listar el detalle de todos los contratos vigentes.
- **RF-PP04-042:** El sistema debe identificar visualmente el contrato seleccionado para la solicitud.

---

# P04-B09 — Revalidación normativa de elegibilidad

## Funcionalidad P04-F16 — Revalidar inhabilidades por cargo

### A. Descripción funcional

DGDP debe revisar nuevamente si el funcionario se encuentra afecto a una inhabilidad o restricción normativa por cargo.

### B. Actor principal

DGDP / Sistema.

### C. Validaciones a mostrar

- Autoridades superiores.
- Contraloría.
- Directivos administrativos.
- Decanos/as, con excepción definida cuando corresponda.
- Directores de Instituto Independiente.
- Académicos con funciones directivas.
- Otras restricciones que se incorporen formalmente.

### D. Resultado esperado

- Cumple.
- No aplica.
- Incumple.
- Requiere revisión especial.

### E. Historia de usuario preliminar

**HU-P04-16:** Como **DGDP**, quiero revisar nuevamente la inhabilidad o restricción por cargo del funcionario, para decidir si puede mantenerse dentro del expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP04-043:** El sistema debe mostrar el resultado actualizado de la validación de inhabilidades.
- **RF-PP04-044:** El sistema debe distinguir cargos habilitados, restringidos e inhabilitados.

---

## Funcionalidad P04-F17 — Revalidar estado de deudas institucionales

### A. Descripción funcional

DGDP debe verificar si el funcionario mantiene o no deudas institucionales pendientes.

### B. Actor principal

DGDP / Sistema.

### C. Datos que debe mostrar el sistema

- Estado general de deuda:
  - Sin deudas.
  - Con deuda pendiente.
- Tipo de deuda.
- Monto, si corresponde.
- Fecha o periodo asociado.
- Detalle o motivo.
- Resultado de la regla:
  - Cumple.
  - Incumple.

### D. Reglas de negocio

- Si el funcionario presenta una deuda que impide continuar, DGDP debe poder excluirlo individualmente de la solicitud.
- El motivo de exclusión debe incorporar la causal de deuda cuando corresponda.

### E. Historia de usuario preliminar

**HU-P04-17:** Como **DGDP**, quiero revisar el estado de deudas institucionales por funcionario, para determinar si cumple con las condiciones requeridas para continuar.

### F. Requerimientos funcionales preliminares

- **RF-PP04-045:** El sistema debe mostrar el estado de deuda por funcionario.
- **RF-PP04-046:** El sistema debe mostrar el detalle y motivo asociado a una deuda detectada.
- **RF-PP04-047:** El sistema debe permitir utilizar la deuda como causal de exclusión individual cuando aplique.

---

## Funcionalidad P04-F18 — Revalidar licencia médica, permiso sin goce de sueldo u otras restricciones administrativas

### A. Descripción funcional

DGDP debe visualizar el resultado de las validaciones complementarias relacionadas con la situación administrativa del funcionario, cuando dichas reglas se formalicen en el flujo.

### B. Actor principal

DGDP / Sistema.

### C. Estado actual

> **TODO:** Confirmar si licencia médica, permiso sin goce de sueldo u otras situaciones administrativas serán reglas bloqueantes, alertas o verificaciones informativas.

### D. Información que debería mostrarse

- Condición de licencia médica.
- Condición de permiso sin goce de sueldo.
- Otras observaciones administrativas relevantes.
- Efecto de la condición detectada sobre la continuidad del funcionario.

### E. Historia de usuario preliminar

**HU-P04-18:** Como **DGDP**, quiero revisar las restricciones administrativas vigentes del funcionario, para aplicar correctamente las reglas del flujo cuando estas condiciones estén formalmente definidas.

### F. Requerimientos funcionales preliminares

- **RF-PP04-048:** El sistema debe disponer de un espacio de revisión para restricciones administrativas complementarias.
- **RF-PP04-049:** El sistema debe mostrar el efecto de cada restricción cuando la regla de negocio sea definida.

---

# P04-B10 — Historial de prestaciones previas

## Funcionalidad P04-F19 — Visualizar historial de PDS anteriores por funcionario

### A. Descripción funcional

DGDP debe revisar el historial de prestaciones de servicios previas del funcionario, para evaluar recurrencia, periodicidad y antecedentes que puedan incidir en la validación actual.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

Por cada PDS previa:

- Número o identificador de solicitud.
- Periodo de ejecución.
- Mes o meses de pago.
- Centro de Costo.
- Tipo de prestación.
- Monto bruto mensual.
- Monto total.
- Estado de la prestación.
- Observaciones.
- Relación con la regla actual, cuando corresponda.

### D. Reglas de negocio

- El historial debe permitir revisar el año calendario actual.
- Cuando el negocio lo requiera, podrá ampliarse a los últimos 12 meses.
- Debe identificarse si el funcionario ya utilizó meses de PDS que afectan la regla de periodicidad.

### E. Historia de usuario preliminar

**HU-P04-19:** Como **DGDP**, quiero revisar el historial de prestaciones previas del funcionario, para verificar si la nueva solicitud cumple con las reglas de periodicidad y acumulación.

### F. Requerimientos funcionales preliminares

- **RF-PP04-050:** El sistema debe mostrar el historial de PDS previas por funcionario.
- **RF-PP04-051:** El sistema debe identificar las PDS del año calendario actual.
- **RF-PP04-052:** El sistema debe indicar cuando el historial influye en una validación normativa.

---

## Funcionalidad P04-F20 — Validar cumplimiento de regla de meses de prestación

### A. Descripción funcional

DGDP debe revisar si el funcionario cumple con el límite de meses de prestación definido para la misma actividad o proyecto dentro del año calendario.

### B. Actor principal

DGDP / Sistema.

### C. Datos que debe mostrar el sistema

- Meses ya utilizados en prestaciones previas.
- Meses solicitados en la prestación actual.
- Total resultante.
- Estado de la regla:
  - Cumple.
  - Excede.
  - Requiere análisis.

### D. Historia de usuario preliminar

**HU-P04-20:** Como **DGDP**, quiero revisar el uso acumulado de meses de prestación del funcionario, para verificar si la solicitud respeta la periodicidad permitida.

### E. Requerimientos funcionales preliminares

- **RF-PP04-053:** El sistema debe calcular la cantidad de meses de PDS acumulados por funcionario.
- **RF-PP04-054:** El sistema debe contrastar los meses previos con los meses solicitados actualmente.
- **RF-PP04-055:** El sistema debe indicar si la regla de periodicidad se cumple o se excede.

---

# P04-B11 — Historial de pagos e información financiera

## Funcionalidad P04-F21 — Visualizar historial de pagos por funcionario

### A. Descripción funcional

DGDP debe contar con una vista financiera por funcionario que permita revisar montos previamente pagados y su incidencia en las validaciones económicas.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Periodo de pago.
- Monto bruto pagado.
- Monto neto pagado, si está disponible.
- Centro de Costo asociado.
- Estado del pago.
- Tipo de prestación.
- Relación con la solicitud actual.
- Total acumulado en el periodo consultado.

### D. Historia de usuario preliminar

**HU-P04-21:** Como **DGDP**, quiero visualizar el historial de pagos del funcionario, para revisar su comportamiento financiero previo y su impacto en la validación del expediente.

### E. Requerimientos funcionales preliminares

- **RF-PP04-056:** El sistema debe mostrar el historial de pagos asociados a PDS previas.
- **RF-PP04-057:** El sistema debe mostrar montos brutos, netos y acumulados cuando estén disponibles.
- **RF-PP04-058:** El sistema debe vincular el historial financiero con las validaciones económicas actuales.

---

## Funcionalidad P04-F22 — Visualizar resumen financiero actual por funcionario

### A. Descripción funcional

DGDP debe revisar el impacto económico de la solicitud actual por funcionario.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Monto bruto mensual solicitado.
- Monto neto estimado, si el sistema lo calcula.
- Meses seleccionados.
- Monto total de la PDS actual.
- Otras PDS vigentes o acumuladas consideradas en el cálculo.
- Total mensual proyectado.

### D. Historia de usuario preliminar

**HU-P04-22:** Como **DGDP**, quiero visualizar el resumen financiero de la PDS actual por funcionario, para revisar el monto solicitado en relación con sus antecedentes previos.

### E. Requerimientos funcionales preliminares

- **RF-PP04-059:** El sistema debe mostrar los montos actuales de la PDS por funcionario.
- **RF-PP04-060:** El sistema debe mostrar la suma de montos previos y actuales cuando intervengan en el cálculo normativo.

---

# P04-B12 — Validación de topes económicos

## Funcionalidad P04-F23 — Recalcular y mostrar tope aplicable por funcionario

### A. Descripción funcional

DGDP debe revisar el cálculo del tope aplicable a cada funcionario utilizando la información contractual y financiera disponible.

### B. Actor principal

DGDP / Sistema.

### C. Datos que debe mostrar el sistema

- Regla aplicada.
- Base de cálculo.
- Monto máximo permitido.
- Monto solicitado actual.
- Monto de PDS previas consideradas.
- Total acumulado.
- Margen disponible.
- Porcentaje de utilización del tope.
- Resultado:
  - Cumple.
  - Cercano al límite.
  - Excede.

### D. Reglas de negocio consideradas

- Académicos: 50% de la remuneración bruta, según regla definida.
- Plantas técnica, administrativa y auxiliar: topes fijos según normativa.
- Jornadas parciales: regla proyectada a jornada completa, si corresponde.
- Múltiples contratos: criterio definido para contrato aplicable.
- Directores de Instituto Independiente: regla especial cuando corresponda.
- ANID / DIUFRO / DITT: **TODO**, hasta definir su mecanismo y efecto.

### E. Historia de usuario preliminar

**HU-P04-23:** Como **DGDP**, quiero revisar el cálculo normativo de topes económicos por funcionario, para verificar que el monto solicitado se encuentra dentro de los límites aplicables.

### F. Requerimientos funcionales preliminares

- **RF-PP04-061:** El sistema debe calcular y mostrar el tope económico aplicable por funcionario.
- **RF-PP04-062:** El sistema debe mostrar la base de cálculo utilizada.
- **RF-PP04-063:** El sistema debe mostrar el margen disponible y el porcentaje de utilización.
- **RF-PP04-064:** El sistema debe indicar si el funcionario cumple o excede el tope.

---

# P04-B13 — Jornada, SEA y compensación horaria

## Funcionalidad P04-F24 — Revalidar modalidad dentro o fuera de jornada

### A. Descripción funcional

DGDP debe revisar la modalidad de ejecución declarada para cada funcionario.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Dentro de jornada.
- Fuera de jornada.
- Resultado de validación previa.
- Resultado revisado en DGDP, cuando corresponda.

### D. Historia de usuario preliminar

**HU-P04-24:** Como **DGDP**, quiero revisar la modalidad de jornada declarada, para verificar que la solicitud aplicó correctamente las reglas de ejecución.

### E. Requerimientos funcionales preliminares

- **RF-PP04-065:** El sistema debe mostrar la modalidad de ejecución por funcionario.
- **RF-PP04-066:** El sistema debe mostrar la validación asociada a dicha modalidad.

---

## Funcionalidad P04-F25 — Revalidar condición SEA del funcionario académico

### A. Descripción funcional

Cuando el funcionario sea académico y la prestación se ejecute dentro de jornada, DGDP debe revisar la condición SEA utilizada para determinar si correspondía compensación.

### B. Actor principal

DGDP / Sistema.

### C. Datos que debe mostrar el sistema

- Resultado SEA:
  - Cumple.
  - No cumple.
  - No aplica.
- Jornada contratada.
- Antigüedad contractual considerada.
- Regla utilizada para determinar SEA.
- Consecuencia aplicada:
  - No requiere compensación.
  - Requiere compensación.

### D. Historia de usuario preliminar

**HU-P04-25:** Como **DGDP**, quiero revisar la condición SEA aplicada al funcionario académico, para verificar si la exigencia o exención de compensación fue correctamente determinada.

### E. Requerimientos funcionales preliminares

- **RF-PP04-067:** El sistema debe mostrar el resultado SEA por funcionario académico.
- **RF-PP04-068:** El sistema debe mostrar las variables utilizadas en la evaluación SEA.
- **RF-PP04-069:** El sistema debe mostrar su efecto sobre la compensación horaria.

---

## Funcionalidad P04-F26 — Revisar compensación horaria registrada

### A. Descripción funcional

Cuando la compensación haya sido exigida, DGDP debe revisar el detalle registrado por el Solicitante.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Día de compensación.
- Cantidad de horas.
- Total de horas registradas.
- Relación con la jornada base.
- Validación del límite máximo de 12 horas totales diarias.

### D. Historia de usuario preliminar

**HU-P04-26:** Como **DGDP**, quiero revisar la compensación horaria registrada, para comprobar que se ajusta a las condiciones de jornada definidas para el flujo.

### E. Requerimientos funcionales preliminares

- **RF-PP04-070:** El sistema debe mostrar la compensación horaria registrada por funcionario.
- **RF-PP04-071:** El sistema debe mostrar el resultado de la validación del límite de 12 horas diarias.
- **RF-PP04-072:** El sistema debe permitir usar un incumplimiento de compensación como causal de exclusión individual cuando corresponda.

---

# P04-B14 — Parentescos e incompatibilidades

## Funcionalidad P04-F27 — Visualizar posibles vínculos familiares e incompatibilidades

### A. Descripción funcional

DGDP debe contar con una sección destinada a revisar posibles familiares o vínculos de parentesco asociados al funcionario, cuando exista una fuente disponible y se defina la regla normativa aplicable.

### B. Actor principal

DGDP.

### C. Estado actual de definición

> **TODO:** Definir si la existencia de familiares constituye:
> - Una alerta informativa.
> - Una causal de revisión especial.
> - Una causal bloqueante.
> - Una causal de exclusión individual.

### D. Datos que debería mostrar el sistema cuando la funcionalidad sea formalizada

- Familiar identificado.
- Tipo de relación.
- Unidad.
- Cargo.
- Posible relación con el proyecto o línea jerárquica.
- Estado de revisión:
  - Sin conflicto.
  - Posible conflicto.
  - Conflicto confirmado.
- Efecto normativo, una vez definido.

### E. Historia de usuario preliminar

**HU-P04-27:** Como **DGDP**, quiero visualizar posibles vínculos familiares o incompatibilidades relacionadas con el funcionario, para aplicar la revisión que corresponda cuando esta regla quede formalizada.

### F. Requerimientos funcionales preliminares

- **RF-PP04-073:** El sistema debe disponer de una sección para mostrar vínculos familiares o incompatibilidades cuando exista información disponible.
- **RF-PP04-074:** El sistema debe mostrar el estado de revisión del vínculo familiar.
- **RF-PP04-075:** El sistema debe permitir configurar posteriormente el efecto normativo de esta validación.

---

# P04-B15 — Exclusión individual de funcionarios

## Funcionalidad P04-F28 — Excluir funcionario que no cumple condiciones normativas

### A. Descripción funcional

DGDP debe poder excluir uno o más funcionarios específicos de la solicitud cuando, tras la revisión normativa, se determine que no cumplen las condiciones para continuar en el flujo.

La exclusión de un funcionario debe entenderse como un **rechazo individual**, no como un rechazo automático de toda la solicitud.

### B. Actor principal

DGDP.

### C. Acción disponible

- Botón: **Excluir funcionario** o **Quitar de la solicitud**.

### D. Datos de entrada requeridos

- Motivo de exclusión obligatorio.
- Comentario técnico obligatorio.
- Regla o validación incumplida, cuando corresponda.

### E. Reglas de negocio

- DGDP debe poder excluir uno o más funcionarios sin detener la continuidad de los funcionarios que sí cumplen.
- El funcionario excluido no debe avanzar a etapas posteriores.
- El funcionario debe mantenerse visible en el expediente con estado:
  - **Excluido por DGDP**.
- Debe registrarse:
  - Usuario DGDP.
  - Fecha.
  - Hora.
  - Motivo.
  - Comentario.
  - Regla incumplida.
- El monto total de la solicitud debe recalcularse excluyendo al funcionario removido.
- La exclusión de un funcionario no debe eliminar el historial de su revisión.
- Si todos los funcionarios son excluidos, el sistema debe impedir **APROBAR Y CONTINUAR** y mantener disponibles únicamente las decisiones globales correspondientes:
  - **DEVOLVER CON CORRECCIÓN**.
  - **RECHAZAR SOLICITUD**.

### F. Historia de usuario preliminar

**HU-P04-28:** Como **DGDP**, quiero excluir de la solicitud a los funcionarios que no cumplen la normativa, para permitir que el expediente continúe únicamente con quienes sí resultan habilitados.

### G. Requerimientos funcionales preliminares

- **RF-PP04-076:** El sistema debe permitir excluir uno o más funcionarios desde la vista DGDP.
- **RF-PP04-077:** El sistema debe exigir motivo y comentario obligatorio para cada exclusión.
- **RF-PP04-078:** El sistema debe conservar visible al funcionario excluido con su estado y motivo.
- **RF-PP04-079:** El sistema debe recalcular el monto total del expediente al excluir funcionarios.
- **RF-PP04-080:** El sistema debe impedir aprobar la solicitud si no queda ningún funcionario habilitado.

---

## Funcionalidad P04-F29 — Confirmar exclusión de funcionario

### A. Descripción funcional

Antes de ejecutar la exclusión individual de un funcionario, el sistema debe solicitar confirmación explícita a DGDP.

### B. Actor principal

DGDP.

### C. Contenido mínimo de la confirmación

- Nombre del funcionario.
- RUT.
- Mensaje de advertencia sobre el impacto:
  - El funcionario no continuará en el flujo.
  - La acción quedará registrada.
  - Se generará notificación al Solicitante.
- Motivo ingresado.
- Opción de confirmar o cancelar.

### D. Historia de usuario preliminar

**HU-P04-29:** Como **DGDP**, quiero confirmar la exclusión de un funcionario antes de ejecutarla, para evitar retirarlo de la solicitud por error.

### E. Requerimientos funcionales preliminares

- **RF-PP04-081:** El sistema debe solicitar confirmación antes de excluir a un funcionario.
- **RF-PP04-082:** El sistema debe mostrar el impacto de la exclusión antes de confirmar.
- **RF-PP04-083:** El sistema debe permitir cancelar la exclusión sin modificar el expediente.

---

# P04-B16 — Notificación por exclusión

## Funcionalidad P04-F30 — Generar correo al Solicitante y Funcionario por exclusión de funcionario

### A. Descripción funcional

Cuando DGDP excluya a un funcionario de la solicitud, el sistema debe generar una notificación por correo electrónico informando la acción y su motivo.

### B. Actor principal

Sistema.

### C. Destinatarios mínimos

* Solicitante de la PDS.
* Funcionario excluido de la PDS.

> **TODO:** Definir si el correo debe copiar también al Jefe de Proyecto, Jefatura Directa / Dirección de Departamento u otros actores.

### D. Contenido mínimo del correo

* Código de solicitud.
* Nombre del proyecto o prestación.
* Nombre y RUT del funcionario excluido.
* Etapa en que ocurrió la exclusión: DGDP.
* Causal o motivo normativo detallado de la exclusión.
* Comentario técnico ingresado.
* Fecha y hora de la decisión.
* Instrucción de revisión y corrección para el Solicitante (para que evalúe su reemplazo o corrección).
* Notificación de los motivos formales al Funcionario excluido.
### E. Representación visual en pantalla

La pantalla no debe desplegar el contenido completo del correo de notificación generado por la exclusión del funcionario.

Como confirmación operativa para DGDP, basta con mostrar un aviso, mensaje o estado visible que indique que la notificación fue generada correctamente.

### F. Historia de usuario preliminar

**HU-P04-30:** Como **sistema**, debo notificar al Solicitante cuando DGDP excluya a un funcionario y mostrar a DGDP una confirmación visible de que la notificación fue generada, para dejar constancia del motivo y del impacto de la decisión sin desplegar el contenido completo del correo en pantalla.
### F. Requerimientos funcionales preliminares

- **RF-PP04-001:** El sistema debe generar un correo automático al Solicitante por cada funcionario excluido.
- **RF-PP04-002:** El correo debe incluir el motivo y comentario técnico de exclusión.
- **RF-PP04-003:** El sistema debe registrar que la notificación fue generada.
- **RF-PP04-004:** La interfaz puede representar esta acción mediante un aviso visible de notificación generada, sin necesidad de desplegar el cuerpo completo del correo en pantalla.


---

# P04-B17 — Decisión global de DGDP

## Funcionalidad P04-F31 — Aprobar solicitud y derivar a la etapa siguiente

### A. Descripción funcional

DGDP debe poder aprobar la solicitud cuando el expediente cumple las condiciones globales, existe al menos un funcionario habilitado y no quedan funcionarios pendientes de revisión.

### B. Actor principal

DGDP.

### C. Acción disponible

- Botón: **APROBAR Y CONTINUAR**.

### D. Reglas de negocio

- La aprobación debe considerar únicamente a los funcionarios vigentes dentro de la solicitud.
- Si hubo exclusiones, estas deben mantenerse registradas, y la solicitud debe continuar con la nómina actualizada.
- La aprobación debe quedar bloqueada si:
  - No existe ningún funcionario habilitado.
  - Existe uno o más funcionarios pendientes de revisión.
- La solicitud aprobada debe avanzar a la etapa siguiente definida en el flujo.

### E. Historia de usuario preliminar

**HU-P04-31:** Como **DGDP**, quiero aprobar la solicitud con los funcionarios que cumplen, para permitir su continuidad en el flujo sin arrastrar a quienes fueron excluidos por incumplimiento.

### F. Requerimientos funcionales preliminares

- **RF-PP04-004:** El sistema debe permitir aprobar la solicitud cuando exista al menos un funcionario habilitado y no existan funcionarios pendientes.
- **RF-PP04-084:** El sistema debe derivar el expediente aprobado a la siguiente etapa del flujo.
- **RF-PP04-085:** El sistema debe mantener registro de las exclusiones realizadas antes de la aprobación.
- **RF-PP04-086:** El sistema debe bloquear la aprobación cuando no existan funcionarios habilitados.
- **RF-PP04-087:** El sistema debe bloquear la aprobación cuando existan funcionarios pendientes de revisión.

---

## Funcionalidad P04-F32 — Devolver con corrección al Solicitante

### A. Descripción funcional

DGDP debe poder devolver la solicitud al Solicitante cuando detecte inconsistencias generales que deban ser corregidas en el origen.

### B. Actor principal

DGDP.

### C. Acción disponible

- Botón: **DEVOLVER CON CORRECCIÓN**.

### D. Datos de entrada requeridos

- Comentario obligatorio de devolución.
- Motivo o categoría de devolución, si se define un catálogo.

### E. Reglas de negocio

- La devolución afecta a la solicitud completa.
- El expediente debe quedar en estado **Devuelta con corrección al Solicitante por DGDP**.
- El Solicitante debe poder volver a editar lo que corresponda.
- Los comentarios deben quedar visibles y trazables.
- La devolución debe gestionarse mediante un **modal global único**.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (DGDP), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P04-32:** Como **DGDP**, quiero devolver con corrección la solicitud al Solicitante, para que el expediente pueda ser subsanado antes de continuar.

### G. Requerimientos funcionales preliminares

- **RF-PP04-088:** El sistema debe permitir devolver con corrección la solicitud completa al Solicitante.
- **RF-PP04-089:** El sistema debe exigir comentario obligatorio para devolver.
- **RF-PP04-090:** El sistema debe registrar la devolución y habilitar la corrección por parte del Solicitante.
- **RF-PP04-091:** El sistema debe gestionar la devolución mediante un modal global único.
* **RF-PP04-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de cumplimiento normativo o previsional y comentarios correspondientes.
* **RF-PP04-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P04-F33 — Rechazar solicitud

### A. Descripción funcional

DGDP debe poder rechazar definitivamente el expediente completo cuando el incumplimiento detectado afecta la continuidad integral de la solicitud.

### B. Actor principal

DGDP.

### C. Acción disponible

- Botón: **RECHAZAR SOLICITUD**.

### D. Datos de entrada requeridos

- Comentario obligatorio de rechazo.
- Motivo o categoría de rechazo, si se define un catálogo.

### E. Reglas de negocio

- El rechazo definitivo afecta a toda la solicitud.
- La solicitud no debe continuar a etapas posteriores.
- Los funcionarios incluidos o excluidos hasta ese momento deben conservarse en trazabilidad.
- El motivo de rechazo debe quedar disponible para consulta posterior.
- El rechazo debe gestionarse mediante un **modal global único**.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (DGDP), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones de cumplimiento normativo o previsional), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P04-33:** Como **DGDP**, quiero rechazar definitivamente una solicitud que presenta incumplimientos globales insalvables, para cerrar su tramitación con trazabilidad del motivo.

### G. Requerimientos funcionales preliminares

- **RF-PP04-092:** El sistema debe permitir rechazar definitivamente la solicitud completa.
- **RF-PP04-093:** El sistema debe exigir comentario obligatorio para rechazar.
- **RF-PP04-094:** El sistema debe cerrar la continuidad del expediente rechazado.
- **RF-PP04-095:** El sistema debe gestionar el rechazo mediante un modal global único.
* **RF-PP04-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P04-B18 — Modal global de devolución/rechazo

## Funcionalidad P04-F34 — Gestionar devolución con corrección y rechazo mediante modal global único

### A. Descripción funcional

El sistema debe utilizar un único modal global para gestionar las acciones de **DEVOLVER CON CORRECCIÓN** y **RECHAZAR SOLICITUD**, centralizando el ingreso de motivo, comentario y confirmación.

### B. Actor principal

DGDP.

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

**HU-P04-34:** Como **DGDP**, quiero gestionar la devolución o rechazo desde un modal único, para registrar de forma clara el motivo y confirmar la acción antes de modificar el expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP04-096:** El sistema debe utilizar un modal global único para devolución con corrección y rechazo.
- **RF-PP04-097:** El sistema debe exigir comentario obligatorio dentro del modal.
- **RF-PP04-098:** El sistema debe permitir cancelar la acción sin modificar el estado.
- **RF-PP04-099:** El sistema debe registrar la acción confirmada en trazabilidad.

---

# P04-B19 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P04-F35 — Confirmar decisión global antes de ejecutarla

### A. Descripción funcional

Antes de aprobar, devolver con corrección o rechazar globalmente la solicitud, el sistema debe solicitar confirmación explícita a DGDP.

### B. Actor principal

DGDP.

### C. Acciones que requieren confirmación

- **APROBAR Y CONTINUAR**.
- **DEVOLVER CON CORRECCIÓN**.
- **RECHAZAR SOLICITUD**.

### D. Reglas de negocio

- La confirmación debe permitir cancelar la acción sin modificar el expediente.
- Devolución y rechazo requieren comentario ingresado antes de confirmar.
- La aprobación debe verificar que:
  - Existe al menos un funcionario habilitado.
  - No existen funcionarios pendientes de revisión.

### E. Historia de usuario preliminar

**HU-P04-35:** Como **DGDP**, quiero confirmar mi decisión global antes de ejecutarla, para evitar cambios de estado erróneos en el expediente.

### F. Requerimientos funcionales preliminares

- **RF-PP04-100:** El sistema debe solicitar confirmación antes de aprobar, devolver con corrección o rechazar.
- **RF-PP04-101:** El sistema debe permitir cancelar la decisión antes de ejecutarla.
- **RF-PP04-102:** El sistema debe impedir aprobar si no existe al menos un funcionario habilitado.
- **RF-PP04-103:** El sistema debe impedir aprobar si existe uno o más funcionarios pendientes de revisión.

---

## Funcionalidad P04-F36 — Registrar trazabilidad integral de decisiones DGDP

### A. Descripción funcional

El sistema debe registrar de forma automática y auditable todas las acciones ejecutadas por DGDP durante la revisión del expediente.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Aprobación global.
- Devolución con corrección al Solicitante.
- Rechazo definitivo.
- Exclusión individual de funcionario.
- Confirmación de notificación por exclusión.
- Cambio de estado de revisión individual de funcionarios, cuando corresponda.

### D. Datos mínimos de trazabilidad

- Código único de solicitud.
- Acción realizada.
- Usuario DGDP.
- Rol.
- Fecha y hora.
- Estado anterior.
- Estado resultante.
- Funcionario afectado, cuando aplique.
- Motivo y comentario, cuando aplique.
- Resultado de notificación por correo, cuando aplique.

### E. Reglas de negocio

- No debe modificarse el estado de la solicitud ni excluirse a un funcionario sin generar simultáneamente el registro de trazabilidad.
- La trazabilidad debe quedar disponible para todas las etapas posteriores.
- El registro debe distinguir entre:
  - Decisión global del expediente.
  - Decisión individual sobre un funcionario.

### F. Historia de usuario preliminar

**HU-P04-36:** Como **sistema**, debo registrar cada decisión y exclusión realizada por DGDP, para mantener una trazabilidad completa de la auditoría normativa del expediente.

### G. Requerimientos funcionales preliminares

- **RF-PP04-104:** El sistema debe registrar toda acción ejecutada por DGDP.
- **RF-PP04-105:** El sistema debe distinguir eventos globales del expediente y eventos individuales por funcionario.
- **RF-PP04-106:** El sistema debe registrar el motivo y comentario asociado a exclusiones, devoluciones y rechazos.
- **RF-PP04-107:** El sistema debe registrar la generación de correos de notificación por exclusión.
* **RF-PP04-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

# 7. Estados de salida de la Pantalla 04

| Acción DGDP | Estado resultante de la solicitud | Destino del flujo |
|---|---|---|
| **APROBAR Y CONTINUAR** sin exclusiones | Aprobada por DGDP / En revisión por etapa siguiente | Continúa el flujo institucional |
| **APROBAR Y CONTINUAR** con exclusión de uno o más funcionarios | Aprobada por DGDP con exclusiones registradas / En revisión por etapa siguiente | Continúa el flujo con nómina depurada |
| **DEVOLVER CON CORRECCIÓN** | Devuelta con corrección al Solicitante por DGDP | Regresa a edición del Solicitante |
| **RECHAZAR SOLICITUD** | Rechazada por DGDP | Cierre definitivo del expediente |

---

# 8. Estados individuales posibles por funcionario en DGDP

| Estado | Descripción |
|---|---|
| **Pendiente de revisión DGDP** | Funcionario recibido desde etapas previas y aún no determinado por DGDP. |
| **Cumple DGDP** | Funcionario que mantiene condiciones para continuar dentro de la solicitud. |
| **Excluido por DGDP** | Funcionario retirado de la continuidad del flujo por incumplimiento normativo o condición no habilitante. |
| **Requiere revisión especial** | Estado transitorio para casos sujetos a definición normativa o respaldo pendiente, si el proceso lo incorpora. |

---

# 9. Reglas globales de comportamiento de la Pantalla 04

| Código | Regla |
|---|---|
| **RG-P04-001** | DGDP debe visualizar todos los datos relevantes de la solicitud y las validaciones ejecutadas en etapas previas. |
| **RG-P04-002** | DGDP debe revalidar las condiciones normativas críticas de cada funcionario con la información disponible al momento de la revisión. |
| **RG-P04-003** | La exclusión de un funcionario no implica automáticamente el rechazo de toda la solicitud. |
| **RG-P04-004** | Un funcionario excluido por DGDP no debe continuar a etapas posteriores. |
| **RG-P04-005** | La exclusión de un funcionario debe registrar motivo, comentario, usuario, fecha y hora. |
| **RG-P04-006** | La exclusión de un funcionario debe solicitar confirmación antes de ejecutarse. |
| **RG-P04-007** | La exclusión de un funcionario debe generar notificación por correo automático al Solicitante y al Funcionario excluido, indicando el motivo normativo. |
| **RG-P04-008** | El monto total de la solicitud debe recalcularse si uno o más funcionarios son excluidos. |
| **RG-P04-009** | Si no quedan funcionarios habilitados, la solicitud no puede ser aprobada por DGDP. |
| **RG-P04-010** | Si existen funcionarios pendientes de revisión, la solicitud no puede ser aprobada por DGDP. |
| **RG-P04-011** | La devolución de la solicitud completa se ejecuta mediante la acción **DEVOLVER CON CORRECCIÓN** y requiere comentario obligatorio. |
| **RG-P04-012** | El rechazo definitivo de la solicitud completa se ejecuta mediante la acción **RECHAZAR SOLICITUD** y requiere comentario obligatorio. |
| **RG-P04-013** | La aprobación de la solicitud se ejecuta mediante la acción **APROBAR Y CONTINUAR**. |
| **RG-P04-014** | Toda acción de DGDP debe quedar registrada en trazabilidad. |
| **RG-P04-015** | La condición ANID / DIUFRO / DITT queda marcada como **TODO** y no se incorpora como validación operativa en esta versión. |
| **RG-P04-016** | La revisión de parentescos e incompatibilidades queda marcada como **TODO** hasta definir si es una validación informativa, condicionante o bloqueante. |
| **RG-P04-017** | La pantalla no debe incorporar opción de Aprobación con Alcance. |
| **RG-P04-018** | La pantalla no debe incorporar la acción **Salir sin guardar**. |
| **RG-P04-019** | La devolución con corrección y el rechazo deben gestionarse mediante un **modal global único**. |
| **RG-P04-020** | El sistema debe permitir cambiar entre funcionarios para revisar su detalle individual. |
| **RG-P04-021** | Los RUT de los funcionarios deben mantenerse alineados entre la información visualizada y la estructura de datos que respalda la pantalla. |
| **RG-P04-022** | El resumen de la solicitud debe mostrar un estado consolidado de revisión DGDP. |
| **RG-PP04-023** | Toda acción de devolución, rechazo o exclusión individual de funcionario debe gatillar la notificación por correo automático a los destinatarios definidos y dejar registro en la trazabilidad. |

---

# 10. Requerimientos no funcionales preliminares aplicables a la Pantalla 04

| Código | Requerimiento no funcional | Detalle |
|---|---|---|
| **RNF-P04-001** | Legibilidad de auditoría | La pantalla debe permitir revisar información extensa por funcionario sin perder la relación entre datos contractuales, financieros y normativos. |
| **RNF-P04-002** | Trazabilidad | Todas las decisiones DGDP deben quedar registradas y disponibles para etapas posteriores. |
| **RNF-P04-003** | Integridad del expediente | La exclusión de un funcionario no debe eliminar su historial de revisión ni alterar los datos originales de manera opaca. |
| **RNF-P04-004** | Solo lectura estructural | DGDP no debe editar directamente los datos originales ingresados por el Solicitante. |
| **RNF-P04-005** | Claridad de estados | La pantalla debe diferenciar claramente funcionarios que cumplen, funcionarios excluidos y validaciones pendientes o especiales. |
| **RNF-P04-006** | Seguridad por rol | Solo usuarios autorizados de DGDP deben acceder a esta vista y ejecutar decisiones. |
| **RNF-P04-007** | Confirmación de exclusiones | Toda exclusión individual debe requerir confirmación explícita. |
| **RNF-P04-008** | Comentarios obligatorios | El sistema debe impedir exclusiones, devoluciones o rechazos sin motivo/comentario cuando corresponda. |
| **RNF-P04-009** | Consistencia financiera | Los montos totales del expediente deben actualizarse de manera coherente si DGDP excluye funcionarios. |
| **RNF-P04-010** | Comunicación automatizada | Las exclusiones individuales deben generar una notificación registrada al Solicitante. |
| **RNF-P04-011** | Auditabilidad por funcionario | Debe ser posible reconstruir qué ocurrió con cada funcionario dentro del expediente. |
| **RNF-P04-012** | Comparabilidad de validaciones | La vista debe permitir contrastar las validaciones previas con la revisión actual DGDP cuando corresponda. |
| **RNF-P04-013** | Consistencia de identificación | La información identificatoria de los funcionarios, incluido su RUT, debe mostrarse de forma coherente entre los distintos componentes de la pantalla. |
| **RNF-P04-014** | Estado consolidado visible | La pantalla debe mostrar de forma comprensible el avance global de la revisión DGDP y los bloqueos asociados a la aprobación. |
| **RNF-P04-015** | Homologación de acciones | Las acciones globales deben presentarse con la nomenclatura definida: DEVOLVER CON CORRECCIÓN, RECHAZAR SOLICITUD y APROBAR Y CONTINUAR. |

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 04

| Código | Funcionalidad |
|---|---|
| **P04-F01** | Visualizar identificación de la solicitud. |
| **P04-F02** | Visualizar estado actual del expediente. |
| **P04-F03** | Visualizar visaciones previas del flujo. |
| **P04-F04** | Visualizar línea de avance del flujo. |
| **P04-F05** | Visualizar resumen general del expediente. |
| **P04-F06** | Visualizar estado consolidado de revisión DGDP. |
| **P04-F07** | Visualizar información completa del Centro de Costo. |
| **P04-F08** | Revalidar condiciones del Centro de Costo. |
| **P04-F09** | Registrar que la validación ANID / DIUFRO / DITT se encuentra pendiente de definición. |
| **P04-F10** | Visualizar actividad general, tipo de prestación y periodo. |
| **P04-F11** | Visualizar evidencias comprometidas. |
| **P04-F12** | Visualizar nómina completa de funcionarios en revisión. |
| **P04-F13** | Seleccionar funcionario para revisión detallada. |
| **P04-F14** | Visualizar datos identificatorios y laborales completos. |
| **P04-F15** | Visualizar cantidad de contratos y detalle contractual. |
| **P04-F16** | Revalidar inhabilidades por cargo. |
| **P04-F17** | Revalidar estado de deudas institucionales. |
| **P04-F18** | Revalidar licencia médica, permiso sin goce de sueldo u otras restricciones administrativas. |
| **P04-F19** | Visualizar historial de PDS anteriores por funcionario. |
| **P04-F20** | Validar cumplimiento de regla de meses de prestación. |
| **P04-F21** | Visualizar historial de pagos por funcionario. |
| **P04-F22** | Visualizar resumen financiero actual por funcionario. |
| **P04-F23** | Recalcular y mostrar tope aplicable por funcionario. |
| **P04-F24** | Revalidar modalidad dentro o fuera de jornada. |
| **P04-F25** | Revalidar condición SEA del funcionario académico. |
| **P04-F26** | Revisar compensación horaria registrada. |
| **P04-F27** | Visualizar posibles vínculos familiares e incompatibilidades. |
| **P04-F28** | Excluir funcionario que no cumple condiciones normativas. |
| **P04-F29** | Confirmar exclusión de funcionario. |
| **P04-F30** | Generar correo al Solicitante por exclusión de funcionario. |
| **P04-F31** | Aprobar solicitud y derivar a la etapa siguiente. |
| **P04-F32** | Devolver con corrección al Solicitante. |
| **P04-F33** | Rechazar solicitud. |
| **P04-F34** | Gestionar devolución con corrección y rechazo mediante modal global único. |
| **P04-F35** | Confirmar decisión global antes de ejecutarla. |
| **P04-F36** | Registrar trazabilidad integral de decisiones DGDP. |
