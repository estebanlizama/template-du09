

# PDS Normativo D9 / DU288 / DU09

## Pantalla 03 — Visación por Jefatura Directa / Dirección de Departamento

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 03: Visación de Solicitud — Perfil Jefatura Directa / Dirección de Departamento** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

La pantalla se documenta a partir de:

1. La estructura funcional ya definida para la **Pantalla 02 — Jefe de Proyecto**.
2. La necesidad de mantener una vista de revisión integral del expediente, sin edición de datos.
3. La maqueta de referencia entregada para la vista de **Visación Jefatura Superior**.
4. El criterio funcional indicado: esta etapa debe conservar la misma lógica de decisión que la etapa anterior:

   * Aprobar.
   * Devolver al Solicitante con comentarios.
   * Rechazar definitivamente.

> **Alcance de este documento:** Esta versión estructura exclusivamente la **Pantalla 03 — Jefatura Directa / Dirección de Departamento**. No modifica las pantallas previas. Su objetivo es definir qué debe visualizarse, qué antecedentes adicionales de trazabilidad deben exponerse y qué acciones de decisión debe poder ejecutar el perfil revisor.

---

# 2. Identificación general de la pantalla

| Elemento                       | Descripción                                                                                                                                                                                                                                         |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Código de pantalla**         | P03                                                                                                                                                                                                                                                 |
| **Nombre**                     | Visación de Solicitud por Jefatura Directa / Dirección de Departamento                                                                                                                                                                              |
| **Perfil principal**           | Jefatura Directa / Dirección de Departamento                                                                                                                                                                                                        |
| **Etapa del flujo**            | Etapa 03 — Revisión y visación posterior al Jefe de Proyecto                                                                                                                                                                                        |
| **Estado de entrada esperado** | Solicitud aprobada por Jefe de Proyecto / En revisión por Jefatura Directa o Dirección de Departamento                                                                                                                                              |
| **Objetivo principal**         | Permitir que la Jefatura Directa o Dirección de Departamento revise la solicitud completa, considere la aprobación previa del Jefe de Proyecto y decida si aprueba, devuelve al Solicitante con comentarios o rechaza definitivamente la solicitud. |
| **Resultado posible**          | Aprobada y derivada a DGDP; devuelta al Solicitante para corrección; o rechazada definitivamente.                                                                                                                                                   |

---

# 3. Principio funcional de la Pantalla 03

La Pantalla 03 debe operar como una **vista de revisión institucional y decisión jerárquica**, manteniendo la misma lógica visual y funcional de la etapa anterior, pero incorporando la **trazabilidad de la visación ya realizada por el Jefe de Proyecto**.

La visación de la Jefatura Directa es obligatoria tanto dentro como fuera de la jornada del funcionario. Los valores válidos de modalidad `S`, `D` y `N` deben conducir a esta etapa; la modalidad de jornada no constituye un motivo para omitirla. Las demás reglas generales del flujo, incluida la eventual omisión por responsable repetido cuando esté configurada, permanecen sin cambios.

## 3.1 Funciones que sí debe cumplir

* Mostrar todos los datos relevantes de la solicitud generada en la Pantalla 01.
* Mostrar el resultado de la aprobación emitida en la Pantalla 02 por el Jefe de Proyecto.
* Exponer las validaciones preventivas ya ejecutadas por el sistema.
* Permitir revisar la coherencia entre:

  * Proyecto.
  * Centro de Costo.
  * Unidad Ejecutora.
  * Actividad general.
  * Funcionarios incorporados.
  * Actividades específicas.
  * Montos.
  * Topes económicos.
  * Evidencias.
  * Jornada, SEA y compensaciones.
  * Validaciones previas.
* Permitir registrar una decisión de visación institucional.

## 3.2 Funciones que no debe cumplir

* No debe permitir editar campos de la solicitud.
* No debe permitir incorporar nuevos funcionarios.
* No debe permitir modificar montos, meses, evidencias, jornadas o compensaciones.
* No debe permitir alterar los datos provenientes de SISPER, Centro de Costo o reglas automáticas.
* No debe permitir modificar la aprobación previa del Jefe de Proyecto.
* No debe incorporar la opción de **Aprobación con Alcance** en esta etapa.

---

# 4. Objetivo funcional de la Pantalla 03

La pantalla debe permitir que la Jefatura Directa / Dirección de Departamento:

1. Identifique la solicitud que debe revisar.
2. Visualice su estado actual.
3. Reconozca que la solicitud ya fue aprobada por el Jefe de Proyecto.
4. Conozca quién creó la solicitud y cuándo fue enviada.
5. Revise el contexto presupuestario, administrativo y normativo del proyecto.
6. Revise la descripción general de la actividad de PDS.
7. Revise el tipo de prestación seleccionado.
8. Revise las evidencias comprometidas y sus fechas estimadas.
9. Visualice la nómina de funcionarios incorporados.
10. Revise por cada funcionario:

    * Identificación.
    * Perfil contractual.
    * Actividad específica.
    * Meses de ejecución.
    * Montos mensuales y totales.
    * Modalidad dentro/fuera de jornada.
    * SEA o compensación horaria.
    * Resultado de validaciones normativas previas.
    * Validación de topes económicos.
    * Historial de PDS previas si fue considerado.
11. Revise el resumen global de cumplimiento de la solicitud.
12. Visualice la trazabilidad acumulada del expediente hasta esta etapa.
13. Tome una decisión:

    * Aprobar.
    * Devolver al Solicitante con comentarios.
    * Rechazar definitivamente.
14. Registre comentarios obligatorios cuando devuelve o rechaza.
15. Confirme la acción antes de que el sistema modifique el estado de la solicitud.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 03 debe organizarse en los siguientes bloques funcionales:

| Código      | Bloque de pantalla                                 | Propósito                                                                                                   |
| ----------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| **P03-B01** | Encabezado de expediente y estado                  | Identificar la solicitud, su estado y el perfil revisor actual.                                             |
| **P03-B02** | Trazabilidad de visación previa                    | Mostrar que la solicitud fue visada por el Jefe de Proyecto y registrar el avance histórico del expediente. |
| **P03-B03** | Resumen ejecutivo de la solicitud                  | Mostrar los datos clave de la PDS para revisión rápida.                                                     |
| **P03-B04** | Contexto y origen de fondos                        | Exponer la información completa del Centro de Costo y proyecto validado.                                    |
| **P03-B05** | Actividad general y tipo de prestación             | Mostrar el propósito general de la PDS y su clasificación.                                                  |
| **P03-B06** | Evidencias comprometidas                           | Visualizar entregables seleccionados y fechas estimadas de entrega.                                         |
| **P03-B07** | Resumen de personal incorporado                    | Mostrar la nómina de funcionarios agregados a la solicitud.                                                 |
| **P03-B08** | Ficha detallada por funcionario                    | Exponer antecedentes funcionales, contractuales y operativos de cada funcionario.                           |
| **P03-B09** | Validaciones normativas previas por funcionario    | Mostrar los controles preventivos aplicados desde la etapa del Solicitante.                                 |
| **P03-B10** | Validaciones económicas y topes                    | Mostrar el análisis de montos, topes y acumulados utilizados para habilitar la solicitud.                   |
| **P03-B11** | Jornada, SEA y compensación                        | Mostrar modalidad de ejecución y compensaciones registradas cuando corresponda.                             |
| **P03-B12** | Historial de prestaciones previas                  | Mostrar antecedentes de PDS previas utilizados en validaciones o cálculos.                                  |
| **P03-B13** | Estado consolidado de validaciones de la solicitud | Presentar una lectura global de cumplimiento antes de la decisión.                                          |
| **P03-B14** | Decisión de visación                               | Permitir aprobar, devolver con comentarios o rechazar definitivamente.                                      |
| **P03-B15** | Confirmación y transición de estado                | Confirmar la acción, persistir decisión y derivar la solicitud según corresponda.                           |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P03-B01 — Encabezado de expediente y estado

## Funcionalidad P03-F01 — Visualizar identificación de la solicitud

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación única de la solicitud en revisión.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Número o código de solicitud.
* Título general de revisión.
* Flujo asociado: PDS Normativo D9 / DU288 / DU09.

### D. Reglas de negocio

* La solicitud debe mantener un identificador único a lo largo de todo el flujo.
* El identificador debe permanecer visible para facilitar trazabilidad y referencia.

### E. Historia de usuario preliminar

**HU-P03-01:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar el identificador de la solicitud que reviso, para reconocer el expediente sobre el cual debo emitir una decisión.

### F. Requerimientos funcionales preliminares

* **RF-PP03-001:** El sistema debe mostrar el código único de la solicitud.
* **RF-PP03-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo cuando aplique.

---

## Funcionalidad P03-F02 — Visualizar estado actual del expediente

### A. Descripción funcional

El sistema debe mostrar que la solicitud se encuentra en revisión por la Jefatura Directa / Dirección de Departamento.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Estado: **En revisión — Jefatura Directa / Dirección de Departamento**.
* Etapa actual del flujo.

### D. Reglas de negocio

* Solo deben ingresar a esta pantalla solicitudes aprobadas previamente por el Jefe de Proyecto.
* Mientras la solicitud se encuentre en esta etapa, no debe estar editable por el Solicitante.

### E. Historia de usuario preliminar

**HU-P03-02:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar el estado actual del expediente, para confirmar que me corresponde su revisión.

### F. Requerimientos funcionales preliminares

* **RF-PP03-003:** El sistema debe mostrar el estado actual de la solicitud.
* **RF-PP03-004:** El sistema debe identificar que la solicitud se encuentra en revisión por la Jefatura Directa / Dirección de Departamento.

---

## Funcionalidad P03-F03 — Visualizar antecedentes de creación y envío

### A. Descripción funcional

El sistema debe mostrar quién creó la solicitud y la fecha de generación o envío al flujo.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Nombre del Solicitante.
* Fecha de creación.
* Fecha de envío a revisión.

### D. Reglas de negocio

* Estos datos deben ser de solo lectura.
* Deben formar parte de la trazabilidad general del expediente.

### E. Historia de usuario preliminar

**HU-P03-03:** Como **Jefatura Directa / Dirección de Departamento**, quiero saber quién generó la solicitud y cuándo fue enviada, para contextualizar la revisión del expediente.

### F. Requerimientos funcionales preliminares

* **RF-PP03-005:** El sistema debe mostrar el nombre del Solicitante.
* **RF-PP03-006:** El sistema debe mostrar la fecha de creación de la solicitud.
* **RF-PP03-007:** El sistema debe mostrar la fecha de envío a revisión cuando esté disponible.

---

# P03-B02 — Trazabilidad de visación previa

## Funcionalidad P03-F04 — Visualizar aprobación previa del Jefe de Proyecto

### A. Descripción funcional

El sistema debe mostrar de manera explícita que la solicitud fue visada favorablemente por el Jefe de Proyecto antes de llegar a esta etapa.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Estado de visación del Jefe de Proyecto: Aprobada.
* Nombre del Jefe de Proyecto que visó.
* Fecha y hora de aprobación.
* Comentario asociado, si la aprobación admite observación o nota informativa futura.

### D. Reglas de negocio

* La solicitud no debe llegar a la Pantalla 03 si no fue aprobada previamente en la Pantalla 02.
* La aprobación anterior debe ser visible y no editable.

### E. Historia de usuario preliminar

**HU-P03-04:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar la aprobación previa del Jefe de Proyecto, para conocer que la solicitud ya superó la revisión inicial de pertinencia del proyecto.

### F. Requerimientos funcionales preliminares

* **RF-PP03-008:** El sistema debe mostrar que la solicitud fue aprobada por el Jefe de Proyecto.
* **RF-PP03-009:** El sistema debe mostrar fecha, hora y usuario responsable de la visación previa.

---

## Funcionalidad P03-F05 — Visualizar línea de avance del flujo hasta la etapa actual

### A. Descripción funcional

El sistema debe mostrar visualmente la trayectoria del expediente desde su creación hasta la etapa de revisión actual.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Hitos mínimos a mostrar

* Solicitud creada.
* Envío a revisión.
* Visación del Jefe de Proyecto.
* Etapa actual: Visación Jefatura Directa / Dirección de Departamento.
* Próxima etapa pendiente: DGDP.

### D. Reglas de negocio

* La línea de avance debe reflejar el estado real de la solicitud.
* Los hitos finalizados deben diferenciarse visualmente de los pendientes.

### E. Historia de usuario preliminar

**HU-P03-05:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar el avance del expediente dentro del flujo, para comprender su historial y el punto exacto en que debo intervenir.

### F. Requerimientos funcionales preliminares

* **RF-PP03-010:** El sistema debe mostrar una línea de trazabilidad del expediente.
* **RF-PP03-011:** El sistema debe diferenciar hitos cumplidos, etapa actual e hitos pendientes.

---

# P03-B03 — Resumen ejecutivo de la solicitud

## Funcionalidad P03-F06 — Visualizar datos clave de la PDS

### A. Descripción funcional

El sistema debe presentar un resumen ejecutivo con los datos más relevantes del expediente.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Centro de Costo.
* Tipo de fondo.
* Periodo general de prestación.
* Monto total acumulado de la solicitud.
* Cantidad de funcionarios incorporados.

### D. Reglas de negocio

* Los valores deben coincidir con la información aprobada por el Jefe de Proyecto.
* El monto total debe representar la suma de las prestaciones registradas.

### E. Historia de usuario preliminar

**HU-P03-06:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar un resumen ejecutivo de la solicitud, para comprender rápidamente su alcance operativo y presupuestario.

### F. Requerimientos funcionales preliminares

* **RF-PP03-012:** El sistema debe mostrar el Centro de Costo asociado.
* **RF-PP03-013:** El sistema debe mostrar el tipo de fondo o financiamiento.
* **RF-PP03-014:** El sistema debe mostrar el periodo general de la prestación.
* **RF-PP03-015:** El sistema debe mostrar el monto total de la solicitud.
* **RF-PP03-016:** El sistema debe mostrar la cantidad de funcionarios incorporados.

---

# P03-B04 — Contexto y origen de fondos

## Funcionalidad P03-F07 — Visualizar información completa del Centro de Costo

### A. Descripción funcional

El sistema debe mostrar la información del Centro de Costo que fue seleccionada y validada en la etapa de origen.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Código del Centro de Costo.
* Nombre del Centro de Costo.
* Estado de vigencia.
* Estado de habilitación.
* Condición estructural / no estructural cuando corresponda.
* Saldo disponible consultado.
* Tipo de financiamiento.
* Decreto afecto.
* Resultado de validación respecto de Formación Continua, cuando corresponda.

### D. Reglas de negocio

* Si existieron alertas informativas no bloqueantes en la etapa inicial, deben mantenerse visibles.
* La información debe corresponder a la versión de solicitud aprobada por el Jefe de Proyecto.

### E. Historia de usuario preliminar

**HU-P03-07:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar la información completa del Centro de Costo, para verificar que la solicitud mantiene coherencia con el proyecto y origen de fondos.

### F. Requerimientos funcionales preliminares

* **RF-PP03-017:** El sistema debe mostrar los datos del Centro de Costo seleccionados en la solicitud.
* **RF-PP03-018:** El sistema debe mostrar el estado de las validaciones aplicadas al Centro de Costo.
* **RF-PP03-019:** El sistema debe mostrar alertas informativas no bloqueantes registradas previamente.

---

## Funcionalidad P03-F08 — Visualizar datos del proyecto y responsables asociados

### A. Descripción funcional

El sistema debe mostrar la información institucional del proyecto vinculada al Centro de Costo.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Nombre del proyecto.
* Unidad ejecutora.
* RUT del Jefe de Proyecto.
* Nombre del Jefe de Proyecto.
* Decreto afecto.
* Tipo de financiamiento.

### D. Reglas de negocio

* Los datos deben mostrarse en solo lectura.
* Deben corresponder a la información persistida desde la Pantalla 01.

### E. Historia de usuario preliminar

**HU-P03-08:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar los datos institucionales del proyecto, para validar su correspondencia con la solicitud presentada.

### F. Requerimientos funcionales preliminares

* **RF-PP03-020:** El sistema debe mostrar el nombre del proyecto.
* **RF-PP03-021:** El sistema debe mostrar la unidad ejecutora.
* **RF-PP03-022:** El sistema debe mostrar RUT y nombre del Jefe de Proyecto.
* **RF-PP03-023:** El sistema debe mostrar decreto afecto y tipo de financiamiento.

---

# P03-B05 — Actividad general y tipo de prestación

## Funcionalidad P03-F09 — Visualizar descripción general de la actividad de PDS

### A. Descripción funcional

El sistema debe mostrar la descripción general de la actividad de prestación de servicios registrada originalmente.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Descripción general de la actividad.

### D. Reglas de negocio

* La descripción debe mantenerse como dato de solo lectura.
* Debe diferenciarse de la actividad específica por funcionario.

### E. Historia de usuario preliminar

**HU-P03-09:** Como **Jefatura Directa / Dirección de Departamento**, quiero leer la descripción general de la actividad solicitada, para evaluar su relación con el proyecto y con las funciones institucionales implicadas.

### F. Requerimientos funcionales preliminares

* **RF-PP03-024:** El sistema debe mostrar la descripción general de la actividad de la PDS.

---

## Funcionalidad P03-F10 — Visualizar tipo de prestación declarado

### A. Descripción funcional

El sistema debe mostrar los tipos de prestación seleccionados en la solicitud.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Asistencia Técnica.
* Investigación.
* Otro, con descripción, si fue seleccionado.
* Uno o más tipos de prestación, según la configuración del flujo.

### D. Reglas de negocio

* Deben mostrarse todos los tipos de prestación definidos en la etapa inicial.

### E. Historia de usuario preliminar

**HU-P03-10:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar el tipo de prestación declarado, para verificar la clasificación de la actividad presentada.

### F. Requerimientos funcionales preliminares

* **RF-PP03-025:** El sistema debe mostrar los tipos de prestación seleccionados.
* **RF-PP03-026:** El sistema debe mostrar el texto descriptivo cuando se haya seleccionado “Otro”.

---

# P03-B06 — Evidencias comprometidas

## Funcionalidad P03-F11 — Visualizar evidencias seleccionadas y fechas estimadas

### A. Descripción funcional

El sistema debe mostrar la planificación de evidencias comprometidas en la solicitud.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Evidencias seleccionadas:

  * Acta firmada.
  * Informe con evidencias.
  * Base de datos entregada.
  * Otra, con detalle.
* Fecha estimada de entrega por evidencia.

### D. Reglas de negocio

* Las evidencias deben mostrarse asociadas a su fecha estimada.

### E. Historia de usuario preliminar

**HU-P03-11:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar las evidencias comprometidas y sus fechas estimadas, para conocer los respaldos documentales asociados a la prestación.

### F. Requerimientos funcionales preliminares

* **RF-PP03-027:** El sistema debe mostrar las evidencias seleccionadas.
* **RF-PP03-028:** El sistema debe mostrar la fecha estimada asociada a cada evidencia.
* **RF-PP03-029:** El sistema debe mostrar el detalle de evidencias de tipo “Otra”.

---

# P03-B07 — Resumen de personal incorporado

## Funcionalidad P03-F12 — Visualizar nómina general de funcionarios

### A. Descripción funcional

El sistema debe mostrar una tabla o listado de los funcionarios asociados a la solicitud.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema a nivel de resumen

* Nombre completo.
* RUT.
* Jerarquía o cargo.
* Estamento.
* Jornada.
* Modalidad de ejecución.
* Meses de prestación.
* Monto bruto mensual.
* Monto bruto total.

### D. Reglas de negocio

* No se permiten acciones de edición ni eliminación.

### E. Historia de usuario preliminar

**HU-P03-12:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar la nómina completa de funcionarios incorporados, para conocer la composición de la solicitud.

### F. Requerimientos funcionales preliminares

* **RF-PP03-030:** El sistema debe mostrar la nómina de funcionarios asociados.
* **RF-PP03-031:** El sistema debe mostrar sus datos principales de identificación, temporalidad y montos.
* **RF-PP03-032:** El sistema no debe permitir modificar la nómina desde esta pantalla.

---

# P03-B08 — Ficha detallada por funcionario

## Funcionalidad P03-F13 — Visualizar antecedentes identificatorios y laborales del funcionario

### A. Descripción funcional

El sistema debe permitir revisar el detalle completo de antecedentes laborales asociados a cada funcionario.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema por funcionario

* RUT.
* Nombre completo.
* Jerarquía.
* Estamento.
* Tipo de vinculación.
* Grado.
* Tipo de jornada.
* Horas de jornada.
* Contrato vigente seleccionado para la PDS.
* Antigüedad contractual cuando corresponda.
* Renta bruta y renta neta cuando sean parte de los antecedentes visibles o cálculos efectuados.

### D. Reglas de negocio

* Deben mostrarse los datos del contrato vigente seleccionado previamente.

### E. Historia de usuario preliminar

**HU-P03-13:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar los antecedentes laborales y contractuales del funcionario, para revisar la base utilizada en las validaciones del expediente.

### F. Requerimientos funcionales preliminares

* **RF-PP03-033:** El sistema debe mostrar antecedentes identificatorios y laborales del funcionario.
* **RF-PP03-034:** El sistema debe mostrar el contrato vigente seleccionado para la solicitud.
* **RF-PP03-035:** El sistema debe mostrar los datos contractuales utilizados en validaciones normativas y económicas.

---

## Funcionalidad P03-F14 — Visualizar actividad específica declarada para cada funcionario

### A. Descripción funcional

El sistema debe mostrar la actividad específica asociada a cada funcionario.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Descripción de la actividad específica.

### D. Reglas de negocio

* Debe distinguirse de la descripción general de la prestación.

### E. Historia de usuario preliminar

**HU-P03-14:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar la actividad específica asignada a cada funcionario, para evaluar su relación con la prestación solicitada.

### F. Requerimientos funcionales preliminares

* **RF-PP03-036:** El sistema debe mostrar la actividad específica registrada para cada funcionario.

---

# P03-B09 — Validaciones normativas previas por funcionario

## Funcionalidad P03-F15 — Visualizar resultado de validaciones de elegibilidad

### A. Descripción funcional

El sistema debe mostrar el resultado de las validaciones normativas aplicadas al funcionario en etapas previas.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Validaciones que deben exponerse

* Inhabilidad por cargo.
* Deudas pendientes.
* Formación Continua.
* Restricciones especiales por categoría, cuando aplique.
* Licencia médica, permiso sin goce de sueldo o vigencia del proyecto si se incorporan como reglas finales del flujo.

### D. Presentación esperada

Cada validación debería mostrar:

* Nombre de la regla.
* Resultado.
* Fuente de validación cuando corresponda.
* Detalle breve.

### E. Historia de usuario preliminar

**HU-P03-15:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar las validaciones de elegibilidad aplicadas a los funcionarios, para conocer los controles superados antes de mi revisión.

### F. Requerimientos funcionales preliminares

* **RF-PP03-037:** El sistema debe mostrar las validaciones normativas ejecutadas por funcionario.
* **RF-PP03-038:** El sistema debe distinguir visualmente validaciones cumplidas, alertas e incumplimientos.
* **RF-PP03-039:** El sistema debe mostrar detalle de cada validación cuando esté disponible.

---

# P03-B10 — Validaciones económicas y topes

## Funcionalidad P03-F16 — Visualizar cálculo de tope económico por funcionario

### A. Descripción funcional

El sistema debe mostrar el análisis económico utilizado para validar el monto solicitado.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Monto bruto mensual solicitado.
* Monto bruto total de la PDS.
* Tope aplicable.
* Regla utilizada para determinar el tope.
* Porcentaje utilizado del tope.
* Estado del resultado: Cumple / Cercano al límite / Excede.
* Prestaciones previas consideradas, cuando aplique.
* Límite acumulado utilizado, cuando corresponda.

### D. Reglas de negocio

Debe soportar la lógica definida para:

* Académicos.
* Plantas técnica, administrativa y auxiliar.
* Directores de Instituto Independiente.
* Jornadas parciales.
* Múltiples contratos.
* Excepciones ANID / DIUFRO / DITT cuando estén formalizadas.

### E. Historia de usuario preliminar

**HU-P03-16:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar los topes económicos aplicados a cada funcionario, para comprender la razonabilidad y cumplimiento del monto solicitado.

### F. Requerimientos funcionales preliminares

* **RF-PP03-040:** El sistema debe mostrar monto mensual y total por funcionario.
* **RF-PP03-041:** El sistema debe mostrar tope aplicable y regla utilizada.
* **RF-PP03-042:** El sistema debe mostrar porcentaje de uso del tope.
* **RF-PP03-043:** El sistema debe mostrar antecedentes acumulados o prestaciones previas cuando hayan sido utilizados en el cálculo.

---

# P03-B11 — Jornada, SEA y compensación

## Funcionalidad P03-F17 — Visualizar modalidad de ejecución dentro o fuera de jornada

### A. Descripción funcional

El sistema debe mostrar si la prestación se realizará dentro o fuera de la jornada laboral del funcionario.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Dentro de jornada.
* Fuera de jornada.

### D. Reglas de negocio

* Si se declaró ejecución dentro de jornada, deben mostrarse los antecedentes SEA o de compensación correspondientes.

### E. Historia de usuario preliminar

**HU-P03-17:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar la modalidad de jornada declarada, para revisar la coherencia del régimen de ejecución de la prestación.

### F. Requerimientos funcionales preliminares

* **RF-PP03-044:** El sistema debe mostrar si la prestación se ejecutará dentro o fuera de jornada.

---

## Funcionalidad P03-F18 — Visualizar condición SEA del funcionario académico

### A. Descripción funcional

Cuando el funcionario sea académico y la actividad se realice dentro de jornada, el sistema debe mostrar el resultado de evaluación SEA.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Condición SEA: Cumple / No cumple / No aplica.
* Relación con la exigencia o no exigencia de compensación horaria.

### D. Reglas de negocio

* La pantalla debe mostrar el resultado calculado en la etapa inicial.

### E. Historia de usuario preliminar

**HU-P03-18:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar la condición SEA de los académicos incorporados, para comprender la lógica aplicada a la ejecución dentro de jornada.

### F. Requerimientos funcionales preliminares

* **RF-PP03-045:** El sistema debe mostrar la condición SEA cuando corresponda.
* **RF-PP03-046:** El sistema debe mostrar si la condición SEA implicó o no la exigencia de compensación.

---

## Funcionalidad P03-F19 — Visualizar compensación horaria registrada

### A. Descripción funcional

Cuando la compensación haya sido exigida, el sistema debe mostrar el detalle declarado.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Día de compensación.
* Cantidad de horas por día.
* Total semanal o total registrado, cuando se defina.
* Resultado de la validación de límite máximo de 12 horas diarias.

### D. Historia de usuario preliminar

**HU-P03-19:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar la compensación horaria registrada, para revisar el cumplimiento operativo de las actividades declaradas dentro de jornada.

### E. Requerimientos funcionales preliminares

* **RF-PP03-047:** El sistema debe mostrar la compensación horaria registrada cuando corresponda.
* **RF-PP03-048:** El sistema debe mostrar el resultado de la validación del límite diario de horas.

---

# P03-B12 — Historial de prestaciones previas

## Funcionalidad P03-F20 — Visualizar historial de PDS previas consideradas

### A. Descripción funcional

El sistema debe permitir revisar las prestaciones previas utilizadas en cálculos o validaciones del expediente.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Datos que debe mostrar el sistema

* Periodo.
* Nº de contrato.
* Centro de Costo.
* Tipo de prestación.
* Monto bruto mensual.
* Monto neto mensual, si fue recuperado.
* Horas asignadas.
* Tipo de pago.
* Total pagado.
* Estado.
* Observaciones.

### D. Reglas de negocio

* Si no existen prestaciones previas, el sistema debe mostrarlo explícitamente.
* Si se utilizaron para cálculos o validaciones, debe quedar indicado.

### E. Historia de usuario preliminar

**HU-P03-20:** Como **Jefatura Directa / Dirección de Departamento**, quiero revisar las prestaciones previas consideradas, para comprender los antecedentes utilizados en validaciones económicas o de periodicidad.

### F. Requerimientos funcionales preliminares

* **RF-PP03-049:** El sistema debe mostrar historial de PDS previas cuando exista.
* **RF-PP03-050:** El sistema debe informar cuando no existan prestaciones previas.
* **RF-PP03-051:** El sistema debe identificar si el historial influyó en los cálculos o validaciones actuales.

---

# P03-B13 — Estado consolidado de validaciones de la solicitud

## Funcionalidad P03-F21 — Visualizar resumen global de cumplimiento previo

### A. Descripción funcional

El sistema debe mostrar un resumen global de cumplimiento de las validaciones que permitieron que la solicitud llegara hasta esta etapa.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Validaciones consolidadas que deberían mostrarse

* Centro de Costo validado.
* Financiamiento y decreto identificado.
* Evidencias comprometidas con fechas.
* Funcionarios válidamente incorporados.
* Deudas verificadas.
* Inhabilidades revisadas.
* Montos y topes cumplidos.
* Meses dentro del periodo válido.
* Compensación registrada cuando correspondía.
* Condición SEA evaluada cuando correspondía.
* Visación favorable del Jefe de Proyecto.

### D. Presentación esperada

Se recomienda una matriz o checklist con:

* Regla.
* Estado.
* Resultado.
* Observación breve.

### E. Historia de usuario preliminar

**HU-P03-21:** Como **Jefatura Directa / Dirección de Departamento**, quiero visualizar un resumen global de cumplimiento previo, para revisar el expediente de manera consolidada antes de tomar una decisión.

### F. Requerimientos funcionales preliminares

* **RF-PP03-052:** El sistema debe mostrar un resumen consolidado de validaciones previas.
* **RF-PP03-053:** El sistema debe distinguir validaciones cumplidas, no aplicables y alertas informativas.
* **RF-PP03-054:** El sistema debe incorporar la visación previa del Jefe de Proyecto dentro del resumen de cumplimiento.

---

# P03-B14 — Decisión de visación

## Funcionalidad P03-F22 — Aprobar solicitud y derivar a DGDP

### A. Descripción funcional

La Jefatura Directa / Dirección de Departamento debe poder aprobar la solicitud cuando la considera pertinente y formalmente consistente.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Acción disponible

* Botón: **Aprobar y continuar** o equivalente.

### D. Reglas de negocio

* La aprobación debe registrar:

  * Usuario aprobador.
  * Rol.
  * Fecha y hora.
  * Estado resultante.
* La solicitud aprobada debe avanzar a la etapa siguiente: **DGDP**.

### E. Historia de usuario preliminar

**HU-P03-22:** Como **Jefatura Directa / Dirección de Departamento**, quiero aprobar una solicitud correcta, para que continúe hacia la revisión normativa de DGDP.

### F. Requerimientos funcionales preliminares

* **RF-PP03-055:** El sistema debe permitir aprobar la solicitud desde esta pantalla.
* **RF-PP03-056:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
* **RF-PP03-057:** El sistema debe derivar la solicitud aprobada a DGDP.

---

## Funcionalidad P03-F23 — Devolver solicitud al Solicitante con comentarios

### A. Descripción funcional

La Jefatura Directa / Dirección de Departamento debe poder devolver la solicitud al Solicitante cuando detecte elementos que deban ser corregidos antes de continuar.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Acción disponible

* Botón: **Devolver al Solicitante**.

### D. Datos de entrada requeridos

* Comentario de devolución obligatorio.

### E. Reglas de negocio

* La devolución debe obligar a registrar comentarios.
* La solicitud debe cambiar a un estado equivalente a **Devuelta al Solicitante para corrección**.
* El flujo debe retornar a la Pantalla 01 con edición habilitada.
* Los comentarios deben quedar visibles para el Solicitante y registrados en la trazabilidad.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Jefatura Directa / Dirección de Departamento), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P03-23:** Como **Jefatura Directa / Dirección de Departamento**, quiero devolver la solicitud con comentarios, para que el Solicitante corrija los puntos observados.

### G. Requerimientos funcionales preliminares

* **RF-PP03-058:** El sistema debe permitir devolver la solicitud al Solicitante.
* **RF-PP03-059:** El sistema debe exigir comentario obligatorio al devolver.
* **RF-PP03-060:** El sistema debe registrar la devolución con usuario, rol, fecha, hora y comentario.
* **RF-PP03-061:** El sistema debe cambiar el estado a devuelta para corrección.
* **RF-PP03-062:** El sistema debe habilitar nuevamente la edición al Solicitante.
* **RF-PP03-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones jerárquicas y comentarios correspondientes.
* **RF-PP03-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P03-F24 — Rechazar definitivamente la solicitud

### A. Descripción funcional

La Jefatura Directa / Dirección de Departamento debe poder rechazar definitivamente la solicitud cuando determine que no corresponde su continuidad.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Acción disponible

* Botón: **Rechazar**.

### D. Datos de entrada requeridos

* Comentario de rechazo obligatorio.

### E. Reglas de negocio

* El rechazo debe obligar a registrar comentarios.
* La solicitud debe quedar en estado **Rechazada por Jefatura Directa / Dirección de Departamento** o equivalente.
* La solicitud no debe continuar a etapas posteriores.
* El motivo de rechazo debe quedar registrado en la trazabilidad.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Jefatura Directa / Dirección de Departamento), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones jerárquicas), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P03-24:** Como **Jefatura Directa / Dirección de Departamento**, quiero rechazar definitivamente una solicitud no pertinente, para cerrar su tramitación sin que avance a DGDP.

### G. Requerimientos funcionales preliminares

* **RF-PP03-063:** El sistema debe permitir rechazar definitivamente la solicitud.
* **RF-PP03-064:** El sistema debe exigir comentario obligatorio al rechazar.
* **RF-PP03-065:** El sistema debe registrar el rechazo con usuario, rol, fecha, hora y comentario.
* **RF-PP03-066:** El sistema debe cerrar la continuidad del flujo para solicitudes rechazadas en esta etapa.
* **RF-PP03-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P03-B15 — Confirmación y transición de estado

## Funcionalidad P03-F25 — Confirmar decisión antes de ejecutarla

### A. Descripción funcional

Antes de aplicar una aprobación, devolución o rechazo, el sistema debe solicitar confirmación.

### B. Actor principal

Jefatura Directa / Dirección de Departamento.

### C. Acciones que requieren confirmación

* Aprobar.
* Devolver.
* Rechazar.

### D. Reglas de negocio

* La confirmación debe permitir cancelar la acción antes de modificar el estado.
* En devolución y rechazo, el comentario obligatorio debe estar registrado antes de confirmar.

### E. Historia de usuario preliminar

**HU-P03-25:** Como **Jefatura Directa / Dirección de Departamento**, quiero confirmar mi decisión antes de ejecutarla, para evitar modificar por error el estado del expediente.

### F. Requerimientos funcionales preliminares

* **RF-PP03-067:** El sistema debe solicitar confirmación antes de ejecutar una decisión de visación.
* **RF-PP03-068:** El sistema debe permitir cancelar la acción antes de confirmar.

---

## Funcionalidad P03-F26 — Registrar trazabilidad de la decisión

### A. Descripción funcional

El sistema debe generar un registro automático y auditable en el historial de la solicitud (`sg_esol`) cada vez que la Jefatura Directa / Dirección de Departamento ejecute una acción de gestión (Aprobar, Devolver o Rechazar).

### B. Actor principal
Sistema.

### C. Datos de trazabilidad a registrar
*   **Identificador**: Código único de la solicitud.
*   **Evento**: Acción realizada (Aprobación, Devolución o Rechazo).
*   **Autoría**: RUT/Usuario y Rol (Jefe de Proyecto).
*   **Temporalidad**: Fecha y hora exacta del servidor.
*   **Comentario**: Observación técnica ingresada (obligatoria en Devolución/Rechazo).
*   **Transición**: Estado anterior y Estado resultante del expediente.
*   **Envío de Correo**: Confirmación del envío del correo electrónico de notificación (devolución o rechazo) con fecha, hora y destinatario.

### D. Reglas de negocio
*   **Integridad del PDS**: La información técnica y económica de la prestación (montos, meses, funcionarios) guardada en la Pantalla 01 **no debe ser modificada** por este proceso; solo se actualiza el estado del flujo.
*   **Expediente Digital**: El registro debe ser persistente y quedar disponible para la consulta de todos los aprobadores posteriores (Etapas 03 a 15).
*   **Obligatoriedad**: No se puede cambiar el estado de la solicitud en la base de datos sin generar simultáneamente el registro de trazabilidad.
*   **Registro de Envío**: El sistema debe dejar registro del envío del correo electrónico en la trazabilidad del expediente.

### E. Historia de usuario preliminar
**HU-P03-26**: Como **Sistema**, debo registrar la decisión de la Jefatura Directa / Dirección de Departamento en el historial de estados, para garantizar la transparencia y auditabilidad de la tramitación sin alterar los datos de origen de la prestación.

### F. Requerimientos funcionales preliminares
*   **RF-PP03-069**: El sistema debe insertar un registro en la tabla de historial cada vez que se modifique el estado de la solicitud en esta etapa.
*   **RF-PP03-070**: El registro de trazabilidad debe capturar el estado anterior, el nuevo estado, el usuario, la fecha, la hora y el comentario asociado, manteniendo la integridad de los datos de la PDS.
* **RF-PP03-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

---

# 7. Estados de salida de la Pantalla 03

| Acción de la Jefatura Directa / Dirección de Departamento | Estado resultante de la solicitud                                                | Destino del flujo                            |
| --------------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------------------- |
| Aprobar                                                   | Aprobada por Jefatura Directa / Dirección de Departamento / En revisión por DGDP | Etapa 04 — DGDP                              |
| Devolver al Solicitante con comentarios                   | Devuelta al Solicitante para corrección                                          | Regresa a Pantalla 01 con edición habilitada |
| Rechazar definitivamente                                  | Rechazada por Jefatura Directa / Dirección de Departamento                       | Cierre del flujo para ese expediente         |

---

# 8. Reglas globales de comportamiento de la Pantalla 03

| Código     | Regla                                                                                       |
| ---------- | ------------------------------------------------------------------------------------------- |
| RG-P03-001 | La Pantalla 03 es de revisión y decisión; no permite editar la información de la solicitud. |
| RG-P03-002 | Debe mostrar los datos generados y validados en la Pantalla 01.                             |
| RG-P03-003 | Debe mostrar la aprobación previa del Jefe de Proyecto.                                     |
| RG-P03-004 | La devolución al Solicitante requiere comentario obligatorio.                               |
| RG-P03-005 | El rechazo definitivo requiere comentario obligatorio.                                      |
| RG-P03-006 | Toda acción debe quedar registrada en la trazabilidad del expediente.                       |
| RG-P03-007 | La solicitud aprobada debe avanzar a DGDP.                                                  |
| RG-P03-008 | La solicitud devuelta debe reabrirse para edición del Solicitante.                          |
| RG-P03-009 | La solicitud rechazada no debe avanzar a etapas posteriores.                                |
| RG-P03-010 | La pantalla no debe incorporar opción de Aprobación con Alcance.                            |
| **RG-PP03-011** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 9. Requerimientos no funcionales preliminares aplicables a la Pantalla 03

| Código          | Requerimiento no funcional  | Detalle                                                                                                                                       |
| --------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **RNF-P03-001** | Legibilidad de revisión     | La pantalla debe permitir revisar grandes volúmenes de información manteniendo clara la relación entre proyecto, funcionarios y validaciones. |
| **RNF-P03-002** | Trazabilidad                | Toda decisión debe quedar registrada y ser consultable en etapas posteriores.                                                                 |
| **RNF-P03-003** | Integridad de datos         | Los datos mostrados deben corresponder exactamente a la versión aprobada por el Jefe de Proyecto.                                             |
| **RNF-P03-004** | Solo lectura                | Los datos de la solicitud deben presentarse en modo no editable.                                                                              |
| **RNF-P03-005** | Claridad de estados         | La pantalla debe diferenciar visaciones cumplidas, etapa actual y pasos pendientes.                                                           |
| **RNF-P03-006** | Seguridad por rol           | Solo usuarios autorizados como Jefatura Directa o Dirección de Departamento deben acceder a esta vista.                                       |
| **RNF-P03-007** | Confirmación de acciones    | Las acciones que modifican el estado deben solicitar confirmación previa.                                                                     |
| **RNF-P03-008** | Comentarios obligatorios    | El sistema debe impedir devolución o rechazo si el comentario no ha sido ingresado.                                                           |
| **RNF-P03-009** | Consistencia del expediente | La vista debe mantener coherencia entre resumen ejecutivo, tablas de personal, evidencias, validaciones y trazabilidad.                       |

---

# 10. Inventario consolidado de funcionalidades de la Pantalla 03

| Código  | Funcionalidad                                                         |
| ------- | --------------------------------------------------------------------- |
| P03-F01 | Visualizar identificación de la solicitud.                            |
| P03-F02 | Visualizar estado actual del expediente.                              |
| P03-F03 | Visualizar antecedentes de creación y envío.                          |
| P03-F04 | Visualizar aprobación previa del Jefe de Proyecto.                    |
| P03-F05 | Visualizar línea de avance del flujo hasta la etapa actual.           |
| P03-F06 | Visualizar datos clave de la PDS.                                     |
| P03-F07 | Visualizar información completa del Centro de Costo.                  |
| P03-F08 | Visualizar datos del proyecto y responsables asociados.               |
| P03-F09 | Visualizar descripción general de la actividad de PDS.                |
| P03-F10 | Visualizar tipo de prestación declarado.                              |
| P03-F11 | Visualizar evidencias seleccionadas y fechas estimadas.               |
| P03-F12 | Visualizar nómina general de funcionarios.                            |
| P03-F13 | Visualizar antecedentes identificatorios y laborales del funcionario. |
| P03-F14 | Visualizar actividad específica declarada para cada funcionario.      |
| P03-F15 | Visualizar resultado de validaciones de elegibilidad.                 |
| P03-F16 | Visualizar cálculo de tope económico por funcionario.                 |
| P03-F17 | Visualizar modalidad de ejecución dentro o fuera de jornada.          |
| P03-F18 | Visualizar condición SEA del funcionario académico.                   |
| P03-F19 | Visualizar compensación horaria registrada.                           |
| P03-F20 | Visualizar historial de PDS previas consideradas.                     |
| P03-F21 | Visualizar resumen global de cumplimiento previo.                     |
| P03-F22 | Aprobar solicitud y derivar a DGDP.                                   |
| P03-F23 | Devolver solicitud al Solicitante con comentarios.                    |
| P03-F24 | Rechazar definitivamente la solicitud.                                |
| P03-F25 | Confirmar decisión antes de ejecutarla.                               |
| P03-F26 | Registrar trazabilidad de la decisión.                                |

---


---

