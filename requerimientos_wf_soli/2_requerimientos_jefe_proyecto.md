

## Pantalla 02 — Visación de Solicitud por Jefe de Proyecto

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 02: Visación de Solicitud — Perfil Jefe de Proyecto** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

La pantalla se documenta a partir de:

1. La lógica definida para el flujo del **PDS Normativo**.
2. La información generada y validada en la **Pantalla 01 — Solicitante**.
3. La maqueta de referencia de la vista de visación del aprobador.
4. El criterio funcional indicado: el **Jefe de Proyecto no edita la solicitud**, sino que la **revisa integralmente** y toma una decisión.



---

# 2. Identificación general de la pantalla

| Elemento                       | Descripción                                                                                                                                                                                                                                            |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Código de pantalla**         | P02                                                                                                                                                                                                                                                    |
| **Nombre**                     | Visación de Solicitud de Prestación de Servicios                                                                                                                                                                                                       |
| **Perfil principal**           | Jefe de Proyecto                                                                                                                                                                                                                                       |
| **Etapa del flujo**            | Etapa 02 — Revisión y visación del Jefe de Proyecto                                                                                                                                                                                                    |
| **Estado de entrada esperado** | Solicitud enviada por el Solicitante / En revisión por Jefe de Proyecto                                                                                                                                                                                |
| **Objetivo principal**         | Permitir que el Jefe de Proyecto revise la solicitud completa, junto con los datos ingresados y validaciones ejecutadas en la etapa anterior, para decidir si aprueba, devuelve al solicitante con comentarios o rechaza definitivamente la solicitud. |
| **Resultado posible**          | Aprobada y derivada a la etapa siguiente; devuelta al Solicitante para corrección; o rechazada definitivamente.                                                                                                                                        |

---

# 3. Principio funcional de la Pantalla 02

La Pantalla 02 debe operar como una **vista de revisión, validación y decisión**, no como una pantalla de captura de datos.

## 3.1 Funciones que sí debe cumplir

* Mostrar todos los datos relevantes de la solicitud generada en la etapa anterior.
* Exponer las validaciones preventivas ya ejecutadas por el sistema.
* Permitir al Jefe de Proyecto revisar la coherencia entre:

  * Proyecto.
  * Centro de Costo.
  * Actividad solicitada.
  * Funcionarios incorporados.
  * Montos.
  * Topes.
  * Evidencias.
  * Jornada, SEA y compensaciones.
* Permitir registrar una decisión de visación.

## 3.2 Funciones que no debe cumplir

* No debe permitir editar campos de la solicitud.
* No debe permitir incorporar nuevos funcionarios.
* No debe permitir cambiar montos, topes, meses, evidencias o periodos.
* No debe permitir modificar la información proveniente de SISPER, Centro de Costo o validaciones automáticas.
* No debe incorporar la opción de **Aprobación con Alcance** para esta etapa, ya que la decisión esperada del Jefe de Proyecto se limita a:

  1. Aprobar.
  2. Devolver al solicitante con comentarios.
  3. Rechazar definitivamente.

---

# 4. Objetivo funcional de la Pantalla 02

La pantalla debe permitir que el Jefe de Proyecto:

1. Identifique la solicitud que debe revisar.
2. Visualice el estado actual del expediente.
3. Conozca quién creó la solicitud y cuándo fue enviada.
4. Revise el contexto presupuestario y administrativo del proyecto.
5. Revise la descripción general de la actividad de PDS.
6. Revise el tipo de prestación seleccionado.
7. Revise las evidencias comprometidas y sus fechas estimadas.
8. Visualice la nómina de funcionarios incorporados.
9. Revise por cada funcionario:

   * Identificación.
   * Perfil contractual.
   * Actividad específica.
   * Meses de ejecución.
   * Montos mensuales y totales.
   * Modalidad dentro/fuera de jornada.
   * SEA o compensación horaria.
   * Resultado de validaciones normativas previas.
   * Validación de topes económicos.
10. Revise las validaciones ejecutadas en la etapa del Solicitante.
11. Tome una decisión de visación.
12. Registre comentarios obligatorios cuando devuelva o rechace.
13. Confirme la acción antes de que el sistema modifique el estado de la solicitud.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 02 debe organizarse en los siguientes bloques funcionales:

| Código      | Bloque de pantalla                                 | Propósito                                                                                   |
| ----------- | -------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| **P02-B01** | Encabezado de expediente y estado                  | Identificar la solicitud, su estado, fecha de creación y rol revisor.                       |
| **P02-B02** | Resumen ejecutivo de la solicitud                  | Mostrar los datos clave de la PDS para una lectura inicial rápida.                          |
| **P02-B03** | Contexto y origen de fondos                        | Exponer la información completa del Centro de Costo y proyecto validado.                    |
| **P02-B04** | Actividad general y tipo de prestación             | Mostrar el propósito general de la PDS y su clasificación.                                  |
| **P02-B05** | Evidencias comprometidas                           | Visualizar entregables seleccionados y fechas estimadas de entrega.                         |
| **P02-B06** | Resumen de personal incorporado                    | Mostrar la nómina de funcionarios agregados a la solicitud.                                 |
| **P02-B07** | Ficha detallada por funcionario                    | Exponer todos los antecedentes funcionales, contractuales y operativos de cada funcionario. |
| **P02-B08** | Validaciones normativas previas por funcionario    | Mostrar el resultado de los controles preventivos aplicados en la Pantalla 01.              |
| **P02-B09** | Validaciones económicas y topes                    | Mostrar el análisis de montos, topes y acumulados utilizados para habilitar la solicitud.   |
| **P02-B10** | Jornada, SEA y compensación                        | Mostrar la modalidad de ejecución y compensaciones registradas cuando corresponda.          |
| **P02-B11** | Historial de prestaciones previas                  | Mostrar antecedentes de PDS previas utilizados en validaciones o cálculos.                  |
| **P02-B12** | Estado consolidado de validaciones de la solicitud | Presentar una lectura global de cumplimiento antes de la decisión del Jefe de Proyecto.     |
| **P02-B13** | Decisión de visación                               | Permitir aprobar, devolver con comentarios o rechazar definitivamente.                      |
| **P02-B14** | Confirmación y transición de estado                | Confirmar la acción, persistir decisión y derivar la solicitud según corresponda.           |

---

# 6. Desglose detallado por bloque y funcionalidad

---

# P02-B01 — Encabezado de expediente y estado

## Funcionalidad P02-F01 — Visualizar identificación de la solicitud

### A. Descripción funcional

El sistema debe mostrar de forma visible la identificación única de la solicitud que el Jefe de Proyecto revisa.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Número o código de solicitud.
* Título general de revisión.
* Flujo asociado: PDS Normativo D9 / DU288 / DU09.

### D. Reglas de negocio

* La solicitud debe estar asociada a un identificador único.
* El identificador debe permanecer visible durante la revisión para facilitar trazabilidad.

### E. Historia de usuario preliminar

**HU-P02-01:** Como **Jefe de Proyecto**, quiero visualizar el identificador de la solicitud que reviso, para reconocer el expediente y mantener trazabilidad en mi decisión.

### F. Requerimientos funcionales preliminares

* **RF-PP02-001:** El sistema debe mostrar el código único de la solicitud.
* **RF-PP02-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo cuando aplique.

---

## Funcionalidad P02-F02 — Visualizar estado actual del expediente

### A. Descripción funcional

El sistema debe mostrar el estado de la solicitud al momento de su revisión por el Jefe de Proyecto.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Estado: **En revisión — Jefe de Proyecto**.
* Etapa actual del flujo.

### D. Reglas de negocio

* Solo deben mostrarse para revisión las solicitudes que hayan sido enviadas desde la etapa del Solicitante.
* Mientras se encuentre en esta etapa, la solicitud no debe quedar disponible para edición por el Solicitante, salvo que sea devuelta.

### E. Historia de usuario preliminar

**HU-P02-02:** Como **Jefe de Proyecto**, quiero conocer el estado actual del expediente, para saber que me corresponde revisar y decidir sobre la solicitud.

### F. Requerimientos funcionales preliminares

* **RF-PP02-003:** El sistema debe mostrar el estado actual de la solicitud.
* **RF-PP02-004:** El sistema debe identificar que la solicitud se encuentra en revisión del Jefe de Proyecto.

---

## Funcionalidad P02-F03 — Visualizar antecedentes de creación y envío

### A. Descripción funcional

El sistema debe mostrar quién creó la solicitud y la fecha de generación o envío al flujo.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Nombre del solicitante.
* Fecha de creación.
* Fecha de envío a revisión, si se distingue de la fecha de creación.

### D. Reglas de negocio

* Los datos de origen deben ser de solo lectura.
* Deben formar parte de la trazabilidad de la solicitud.

### E. Historia de usuario preliminar

**HU-P02-03:** Como **Jefe de Proyecto**, quiero saber quién creó la solicitud y cuándo fue enviada, para contextualizar la revisión del expediente.

### F. Requerimientos funcionales preliminares

* **RF-PP02-005:** El sistema debe mostrar el nombre del Solicitante que generó la solicitud.
* **RF-PP02-006:** El sistema debe mostrar la fecha de creación de la solicitud.
* **RF-PP02-007:** El sistema debe mostrar la fecha de envío a revisión cuando esté disponible.

---

# P02-B02 — Resumen ejecutivo de la solicitud

## Funcionalidad P02-F04 — Visualizar datos clave de la PDS

### A. Descripción funcional

El sistema debe presentar un resumen de alto nivel con los datos más relevantes del expediente, permitiendo al Jefe de Proyecto comprender rápidamente el alcance de la solicitud.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Centro de Costo.
* Nombre resumido del proyecto o unidad asociada.
* Tipo de fondo.
* Periodo general de prestación.
* Monto total acumulado de la solicitud.
* Cantidad total de funcionarios incorporados.

### D. Reglas de negocio

* Los valores del resumen deben corresponder exactamente a los datos ingresados y calculados en la etapa anterior.
* El monto total debe representar la suma de los totales de PDS de todos los funcionarios incorporados.

### E. Historia de usuario preliminar

**HU-P02-04:** Como **Jefe de Proyecto**, quiero visualizar un resumen ejecutivo de la solicitud, para comprender rápidamente su alcance presupuestario y operativo.

### F. Requerimientos funcionales preliminares

* **RF-PP02-008:** El sistema debe mostrar el Centro de Costo asociado.
* **RF-PP02-009:** El sistema debe mostrar el tipo de fondo o financiamiento.
* **RF-PP02-010:** El sistema debe mostrar el periodo general de la prestación.
* **RF-PP02-011:** El sistema debe mostrar el monto total de la solicitud.
* **RF-PP02-012:** El sistema debe mostrar la cantidad de funcionarios incorporados.

---

# P02-B03 — Contexto y origen de fondos

## Funcionalidad P02-F05 — Visualizar información completa del Centro de Costo

### A. Descripción funcional

El sistema debe mostrar al Jefe de Proyecto los datos asociados al Centro de Costo seleccionados y validados en la etapa anterior.

### B. Actor principal

Jefe de Proyecto.

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

* La pantalla debe mostrar la información del Centro de Costo con la misma consistencia con que fue utilizada para permitir el envío de la solicitud.
* Si existieron alertas informativas no bloqueantes durante la etapa anterior, deben mantenerse visibles para la revisión.

### E. Historia de usuario preliminar

**HU-P02-05:** Como **Jefe de Proyecto**, quiero revisar la información completa del Centro de Costo validado, para confirmar que la solicitud se asocia correctamente al proyecto y origen de fondos correspondiente.

### F. Requerimientos funcionales preliminares

* **RF-PP02-013:** El sistema debe mostrar todos los datos del Centro de Costo seleccionados en la solicitud.
* **RF-PP02-014:** El sistema debe mostrar el estado de las validaciones aplicadas al Centro de Costo.
* **RF-PP02-015:** El sistema debe mostrar las alertas informativas no bloqueantes registradas durante la creación de la solicitud.

---

## Funcionalidad P02-F06 — Visualizar datos del proyecto y responsables asociados

### A. Descripción funcional

El sistema debe mostrar la información institucional del proyecto vinculada al Centro de Costo.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Nombre del proyecto.
* Unidad ejecutora.
* RUT del Jefe de Proyecto vinculado al Centro de Costo.
* Nombre del Jefe de Proyecto vinculado al Centro de Costo.
* Decreto afecto.
* Tipo de financiamiento.

### D. Reglas de negocio

* Los datos deben mostrarse en solo lectura.
* Deben corresponder a los datos cargados automáticamente desde la etapa de origen.

### E. Historia de usuario preliminar

**HU-P02-06:** Como **Jefe de Proyecto**, quiero visualizar los datos institucionales asociados al proyecto, para verificar que la solicitud corresponde a mi ámbito de revisión.

### F. Requerimientos funcionales preliminares

* **RF-PP02-016:** El sistema debe mostrar el nombre del proyecto.
* **RF-PP02-017:** El sistema debe mostrar la unidad ejecutora asociada.
* **RF-PP02-018:** El sistema debe mostrar el RUT y nombre del Jefe de Proyecto registrado.
* **RF-PP02-019:** El sistema debe mostrar el decreto afecto y tipo de financiamiento.

---

# P02-B04 — Actividad general y tipo de prestación

## Funcionalidad P02-F07 — Visualizar descripción general de la actividad de PDS

### A. Descripción funcional

El sistema debe mostrar la descripción general de la actividad de prestación de servicios ingresada por el Solicitante.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Descripción general de la actividad de prestación.

### D. Reglas de negocio

* La descripción debe ser de solo lectura.
* Debe distinguirse de las actividades específicas registradas por funcionario.

### E. Historia de usuario preliminar

**HU-P02-07:** Como **Jefe de Proyecto**, quiero leer la descripción general de la actividad solicitada, para evaluar su pertinencia respecto del proyecto.

### F. Requerimientos funcionales preliminares

* **RF-PP02-020:** El sistema debe mostrar la descripción general de la actividad de la PDS.

---

## Funcionalidad P02-F08 — Visualizar tipo de prestación declarado

### A. Descripción funcional

El sistema debe mostrar los tipos de prestación seleccionados por el Solicitante en la etapa anterior.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Asistencia Técnica.
* Investigación.
* Otro, con descripción, si fue seleccionado.
* Uno o más tipos de prestación, según configuración del flujo.

### D. Reglas de negocio

* Deben mostrarse todos los tipos de prestación registrados.
* Si se seleccionó “Otro”, su texto descriptivo debe estar visible.

### E. Historia de usuario preliminar

**HU-P02-08:** Como **Jefe de Proyecto**, quiero revisar el tipo de prestación declarado, para validar que la solicitud se encuentre correctamente categorizada.

### F. Requerimientos funcionales preliminares

* **RF-PP02-021:** El sistema debe mostrar todos los tipos de prestación seleccionados.
* **RF-PP02-022:** El sistema debe mostrar la descripción complementaria cuando se haya seleccionado la opción “Otro”.

---

# P02-B05 — Evidencias comprometidas

## Funcionalidad P02-F09 — Visualizar evidencias seleccionadas y fechas estimadas

### A. Descripción funcional

El sistema debe mostrar la planificación de evidencias comprometidas por el Solicitante en la etapa anterior.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Evidencias seleccionadas:

  * Acta firmada.
  * Informe con evidencias.
  * Base de datos entregada.
  * Otra, con detalle.
* Fecha estimada de entrega por cada evidencia seleccionada.

### D. Reglas de negocio

* La visualización debe permitir distinguir con claridad qué entregables fueron comprometidos.
* Las fechas de entrega deben mostrarse vinculadas a cada evidencia seleccionada.

### E. Historia de usuario preliminar

**HU-P02-09:** Como **Jefe de Proyecto**, quiero revisar las evidencias comprometidas y sus fechas estimadas, para saber qué respaldos se esperan posteriormente para la prestación.

### F. Requerimientos funcionales preliminares

* **RF-PP02-023:** El sistema debe mostrar las evidencias seleccionadas en la solicitud.
* **RF-PP02-024:** El sistema debe mostrar la fecha estimada de entrega asociada a cada evidencia.
* **RF-PP02-025:** El sistema debe mostrar el detalle ingresado para evidencias de tipo “Otra”.

---

# P02-B06 — Resumen de personal incorporado

## Funcionalidad P02-F10 — Visualizar nómina general de funcionarios

### A. Descripción funcional

El sistema debe mostrar una tabla o listado resumido con todos los funcionarios incorporados a la solicitud.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema a nivel de resumen

* Nombre completo del funcionario.
* RUT.
* Jerarquía o cargo.
* Estamento.
* Jornada.
* Modalidad de ejecución.
* Meses de prestación.
* Monto bruto mensual.
* Monto bruto total.

### D. Reglas de negocio

* La tabla debe mostrar a todos los funcionarios agregados por el Solicitante.
* No debe permitir editar ni eliminar registros.

### E. Historia de usuario preliminar

**HU-P02-10:** Como **Jefe de Proyecto**, quiero revisar la nómina completa de funcionarios incorporados, para conocer quiénes participan en la prestación y con qué condiciones generales.

### F. Requerimientos funcionales preliminares

* **RF-PP02-026:** El sistema debe mostrar la nómina de funcionarios asociados a la solicitud.
* **RF-PP02-027:** El sistema debe mostrar para cada funcionario su identificación, perfil general, temporalidad y montos principales.
* **RF-PP02-028:** El sistema no debe permitir modificar la nómina desde esta pantalla.

---

# P02-B07 — Ficha detallada por funcionario

## Funcionalidad P02-F11 — Visualizar antecedentes identificatorios y laborales del funcionario

### A. Descripción funcional

El sistema debe permitir al Jefe de Proyecto visualizar el detalle completo de los antecedentes laborales del funcionario incorporado.

### B. Actor principal

Jefe de Proyecto.

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
* Antigüedad contractual cuando haya sido utilizada en validaciones.
* Renta bruta y renta neta cuando sean parte de los cálculos de tope o antecedentes visibles del flujo.

### D. Reglas de negocio

* Los datos deben corresponder al contrato vigente seleccionado por el Solicitante en la etapa anterior.
* La pantalla debe mostrar los antecedentes utilizados para las validaciones de topes, SEA y elegibilidad.

### E. Historia de usuario preliminar

**HU-P02-11:** Como **Jefe de Proyecto**, quiero visualizar los antecedentes laborales y contractuales del funcionario, para revisar con claridad la base utilizada por el sistema en sus validaciones.

### F. Requerimientos funcionales preliminares

* **RF-PP02-029:** El sistema debe mostrar los antecedentes identificatorios y laborales del funcionario.
* **RF-PP02-030:** El sistema debe mostrar el contrato vigente seleccionado para la solicitud.
* **RF-PP02-031:** El sistema debe mostrar los datos contractuales utilizados en validaciones normativas y económicas.

---

## Funcionalidad P02-F12 — Visualizar actividad específica declarada para cada funcionario

### A. Descripción funcional

El sistema debe mostrar la actividad específica que se asignó a cada funcionario dentro de la solicitud.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Descripción de la actividad específica del funcionario.

### D. Reglas de negocio

* La actividad específica debe distinguirse de la descripción general de la prestación.

### E. Historia de usuario preliminar

**HU-P02-12:** Como **Jefe de Proyecto**, quiero revisar la actividad específica asignada a cada funcionario, para evaluar su pertinencia dentro del proyecto.

### F. Requerimientos funcionales preliminares

* **RF-PP02-032:** El sistema debe mostrar la actividad específica registrada para cada funcionario.

---

# P02-B08 — Validaciones normativas previas por funcionario

## Funcionalidad P02-F13 — Visualizar resultado de validaciones de elegibilidad

### A. Descripción funcional

El sistema debe mostrar al Jefe de Proyecto el resultado de las validaciones preventivas ejecutadas en la etapa del Solicitante.

### B. Actor principal

Jefe de Proyecto.

### C. Validaciones que deben exponerse

* Validación de inhabilidad por cargo.
* Validación de deudas pendientes.
* Validación asociada a Formación Continua.
* Restricciones especiales por categoría, cuando aplique.
* Verificaciones complementarias definidas para licencia médica, permiso sin goce de sueldo o vigencia del proyecto, cuando se incorporen como reglas finales del flujo.

### D. Presentación esperada

Cada validación debería mostrar:

* Nombre de la regla evaluada.
* Resultado: Cumple / No aplica / Advertencia / Incumple.
* Fuente de la validación cuando corresponda.
* Breve detalle del resultado.

### E. Historia de usuario preliminar

**HU-P02-13:** Como **Jefe de Proyecto**, quiero ver el resultado de las validaciones de elegibilidad aplicadas al funcionario, para revisar con transparencia por qué la solicitud pudo avanzar hasta mi etapa.

### F. Requerimientos funcionales preliminares

* **RF-PP02-033:** El sistema debe mostrar el resultado de las validaciones normativas ejecutadas por funcionario.
* **RF-PP02-034:** El sistema debe distinguir visualmente validaciones cumplidas, alertas e incumplimientos.
* **RF-PP02-035:** El sistema debe mostrar el detalle asociado a cada validación cuando esté disponible.

---

# P02-B09 — Validaciones económicas y topes

## Funcionalidad P02-F14 — Visualizar cálculo de tope económico por funcionario

### A. Descripción funcional

El sistema debe mostrar el análisis económico utilizado para determinar si el monto solicitado se mantiene dentro del tope normativo aplicable.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Monto bruto mensual solicitado.
* Monto bruto total de la PDS.
* Tope aplicable.
* Regla utilizada para determinar el tope.
* Porcentaje utilizado del tope.
* Estado del resultado: Cumple / Cercano al límite / Excede.
* Prestaciones previas consideradas en el cálculo, cuando aplique.
* Límite acumulado utilizado, cuando corresponda.

### D. Reglas de negocio

* La visualización debe soportar los distintos tipos de tope definidos para la Pantalla 01:

  * 50% de renta bruta para académicos.
  * Topes fijos por planta técnica, administrativa y auxiliar.
  * Regla especial para Directores de Instituto Independiente.
  * Regla asociada a jornadas parciales.
  * Criterio para múltiples contratos.
  * Excepciones ANID / DIUFRO / DITT, cuando estén definidas.

### E. Historia de usuario preliminar

**HU-P02-14:** Como **Jefe de Proyecto**, quiero revisar el cálculo del tope económico aplicado a cada funcionario, para conocer la base presupuestaria y normativa que habilitó el monto solicitado.

### F. Requerimientos funcionales preliminares

* **RF-PP02-036:** El sistema debe mostrar el monto bruto mensual y total de cada funcionario.
* **RF-PP02-037:** El sistema debe mostrar el tope económico aplicable y la regla utilizada.
* **RF-PP02-038:** El sistema debe mostrar el porcentaje de uso del tope.
* **RF-PP02-039:** El sistema debe mostrar los antecedentes acumulados o prestaciones previas utilizados en el cálculo, cuando corresponda.

---

# P02-B10 — Jornada, SEA y compensación

## Funcionalidad P02-F15 — Visualizar modalidad de ejecución dentro o fuera de jornada

### A. Descripción funcional

El sistema debe mostrar si la prestación del funcionario fue registrada como ejecutada dentro o fuera de la jornada laboral.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Dentro de jornada.
* Fuera de jornada.

### D. Reglas de negocio

* La modalidad debe corresponder a la registrada por el Solicitante.
* Si se indicó ejecución dentro de jornada, deben mostrarse también las validaciones de SEA o compensación asociadas.

### E. Historia de usuario preliminar

**HU-P02-15:** Como **Jefe de Proyecto**, quiero visualizar la modalidad de jornada definida para cada funcionario, para revisar si la ejecución de la PDS fue correctamente declarada.

### F. Requerimientos funcionales preliminares

* **RF-PP02-040:** El sistema debe mostrar si la actividad se realizará dentro o fuera de jornada.

---

## Funcionalidad P02-F16 — Visualizar condición SEA del funcionario académico

### A. Descripción funcional

Cuando el funcionario sea académico y la actividad se realice dentro de jornada, el sistema debe mostrar el resultado de evaluación SEA utilizado en la etapa anterior.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Indicador de condición SEA: Cumple / No cumple / No aplica.
* Regla utilizada para su determinación cuando corresponda.

### D. Reglas de negocio

* La condición SEA debe corresponder al resultado calculado en la Pantalla 01.
* Si el funcionario tiene SEA y trabaja dentro de jornada, debe mostrarse que no se exigió compensación horaria.
* Si el funcionario no tiene SEA y trabaja dentro de jornada, debe mostrarse que se exigió compensación horaria.

### E. Historia de usuario preliminar

**HU-P02-16:** Como **Jefe de Proyecto**, quiero revisar la condición SEA de los académicos incorporados, para entender la lógica aplicada a la compensación dentro de jornada.

### F. Requerimientos funcionales preliminares

* **RF-PP02-041:** El sistema debe mostrar la condición SEA asociada al funcionario académico cuando corresponda.
* **RF-PP02-042:** El sistema debe mostrar si la condición SEA eliminó o mantuvo la exigencia de compensación horaria.

---

## Funcionalidad P02-F17 — Visualizar compensación horaria registrada

### A. Descripción funcional

Cuando se haya exigido compensación horaria, el sistema debe mostrar al Jefe de Proyecto el detalle declarado por el Solicitante.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Día de compensación.
* Cantidad de horas por día.
* Total semanal o total registrado, cuando se defina.
* Resultado de la validación de límite máximo de 12 horas totales de trabajo diario.

### D. Reglas de negocio

* La compensación debe mostrarse solo cuando corresponda.
* El detalle debe quedar vinculado al funcionario específico.

### E. Historia de usuario preliminar

**HU-P02-17:** Como **Jefe de Proyecto**, quiero visualizar la compensación horaria registrada para los funcionarios que la requieren, para revisar su consistencia antes de aprobar la solicitud.

### F. Requerimientos funcionales preliminares

* **RF-PP02-043:** El sistema debe mostrar la tabla de compensación horaria por funcionario cuando corresponda.
* **RF-PP02-044:** El sistema debe mostrar el resultado de la validación de límite diario de horas.

---

# P02-B11 — Historial de prestaciones previas

## Funcionalidad P02-F18 — Visualizar historial de PDS previas consideradas en la etapa anterior

### A. Descripción funcional

El sistema debe permitir revisar el historial de prestaciones previas del funcionario cuando esta información haya sido utilizada para validaciones de topes, periodicidad o antecedentes acumulados.

### B. Actor principal

Jefe de Proyecto.

### C. Datos que debe mostrar el sistema

* Periodo de la prestación previa.
* Número de contrato.
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

* Si no existen prestaciones previas, el sistema debe indicarlo explícitamente.
* Si las prestaciones previas influyeron en el cálculo del monto o tope, debe hacerse visible esa relación.

### E. Historia de usuario preliminar

**HU-P02-18:** Como **Jefe de Proyecto**, quiero revisar las prestaciones previas consideradas para cada funcionario, para comprender los antecedentes utilizados en las validaciones económicas y de periodicidad.

### F. Requerimientos funcionales preliminares

* **RF-PP02-045:** El sistema debe mostrar el historial de prestaciones previas del funcionario cuando exista.
* **RF-PP02-046:** El sistema debe informar cuando no existan prestaciones previas.
* **RF-PP02-047:** El sistema debe identificar si el historial fue utilizado para cálculos o validaciones de la solicitud actual.

---

# P02-B12 — Estado consolidado de validaciones de la solicitud

## Funcionalidad P02-F19 — Visualizar resumen global de cumplimiento previo

### A. Descripción funcional

El sistema debe mostrar un resumen global de las validaciones que permitieron que la solicitud avanzara desde el Solicitante hasta el Jefe de Proyecto.

### B. Actor principal

Jefe de Proyecto.

### C. Validaciones consolidadas que deberían mostrarse

* Centro de Costo consultado y validado.
* Financiamiento y decreto identificado.
* Evidencias seleccionadas con fechas definidas.
* Funcionarios seleccionados y validados.
* Deudas pendientes verificadas.
* Inhabilidades revisadas.
* Montos y topes cumplidos.
* Meses de prestación dentro del periodo definido.
* Compensaciones registradas cuando correspondía.
* Condición SEA evaluada cuando correspondía.

### D. Presentación esperada

Se recomienda una matriz o checklist de cumplimiento con:

* Regla.
* Estado.
* Resultado.
* Observación breve.

### E. Historia de usuario preliminar

**HU-P02-19:** Como **Jefe de Proyecto**, quiero ver un resumen global de las validaciones ya cumplidas por la solicitud, para revisar el expediente sin tener que reconstruir manualmente toda la lógica de control anterior.

### F. Requerimientos funcionales preliminares

* **RF-PP02-048:** El sistema debe mostrar un resumen consolidado de validaciones ejecutadas en la etapa anterior.
* **RF-PP02-049:** El sistema debe distinguir validaciones cumplidas, no aplicables y alertas informativas.

---

# P02-B13 — Decisión de visación

## Funcionalidad P02-F20 — Aprobar solicitud y derivar a la etapa siguiente

### A. Descripción funcional

El Jefe de Proyecto debe poder aprobar la solicitud cuando estime que la prestación es pertinente y coherente con el proyecto.

### B. Actor principal

Jefe de Proyecto.

### C. Acción disponible

* Botón: **Aprobar y continuar** o equivalente.

### D. Reglas de negocio

* La aprobación debe registrar:

  * Usuario aprobador.
  * Rol.
  * Fecha y hora.
  * Estado resultante.
* La condición de jornada determina únicamente la participación de la **Jefatura Directa**:
  * `dentro_jor IN ('S', 'D')`: la solicitud debe asignarse a la Jefatura Directa vigente del funcionario.
  * `dentro_jor = 'N'`: la etapa de Jefatura Directa no aplica y debe omitirse automáticamente, sin crear una visación ficticia.
* Cuando se omita la Jefatura Directa, el sistema debe registrar el motivo en la trazabilidad y continuar a la siguiente etapa organizacional aplicable.

### E. Historia de usuario preliminar

**HU-P02-20:** Como **Jefe de Proyecto**, quiero aprobar una solicitud que considero correcta, para que continúe a la siguiente etapa de revisión.

### F. Requerimientos funcionales preliminares

* **RF-PP02-050:** El sistema debe permitir aprobar la solicitud desde la pantalla del Jefe de Proyecto.
* **RF-PP02-051:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora/ acorde alo definido en el proyecto.
* **RF-PP02-052:** El sistema debe derivar la solicitud aprobada a Jefatura Directa cuando la prestación se realiza dentro de jornada, o a la siguiente etapa organizacional cuando se realiza fuera de jornada.
* **RF-PP02-053:** El Jefe de Proyecto debe participar siempre, independientemente de la condición de jornada declarada para la prestación.

---

## Funcionalidad P02-F21 — Devolver solicitud al Solicitante con comentarios

### A. Descripción funcional

El Jefe de Proyecto debe poder devolver la solicitud al Solicitante cuando detecte inconsistencias, falta de precisión o antecedentes que deben corregirse antes de continuar.

### B. Actor principal

Jefe de Proyecto.

### C. Acción disponible

* Botón: **Devolver al Solicitante**.

### D. Datos de entrada requeridos

* Comentario de devolución obligatorio.

### E. Reglas de negocio

* La devolución debe obligar a registrar comentarios.
* La solicitud debe cambiar a un estado equivalente a **Devuelta al Solicitante para corrección**.
* El flujo debe retornar a la Pantalla y estado de solicitud, permitiendo al Solicitante editar la solicitud.
* Los comentarios deben quedar visibles para el Solicitante y almacenados en la trazabilidad.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Jefe de Proyecto), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P02-21:** Como **Jefe de Proyecto**, quiero devolver la solicitud con comentarios, para que el Solicitante pueda corregir los puntos observados antes de continuar.

### G. Requerimientos funcionales preliminares

* **RF-PP02-053:** El sistema debe permitir devolver la solicitud al Solicitante.
* **RF-PP02-054:** El sistema debe exigir comentario obligatorio al devolver.
* **RF-PP02-055:** El sistema debe registrar la devolución con datos adicionales definido en el proyecto.
* **RF-PP02-056:** El sistema debe cambiar el estado de la solicitud a devuelta para corrección.
* **RF-PP02-057:** El sistema debe habilitar nuevamente la edición al Solicitante una vez devuelta.
* **RF-PP02-TEMP_DEV1**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones técnicas y comentarios correspondientes.
* **RF-PP02-TEMP_DEV2**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

## Funcionalidad P02-F22 — Rechazar definitivamente la solicitud

### A. Descripción funcional

El Jefe de Proyecto debe poder rechazar definitivamente la solicitud cuando estime que no corresponde su continuidad dentro del flujo.

### B. Actor principal

Jefe de Proyecto.

### C. Acción disponible

* Botón: **Rechazar**.

### D. Datos de entrada requeridos

* Comentario de rechazo obligatorio.

### E. Reglas de negocio

* El rechazo debe obligar a registrar comentarios.
* La solicitud debe quedar en estado **Rechazada por Jefe de Proyecto** o equivalente.
* La solicitud no debe continuar a etapas posteriores del flujo.
* El motivo de rechazo debe quedar registrado en la trazabilidad.
* Debe definirse si el Solicitante solo visualiza el rechazo o si puede clonar la solicitud en un nuevo expediente; esta definición corresponde a una decisión funcional posterior.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (Jefe de Proyecto), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones técnicas), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### F. Historia de usuario preliminar

**HU-P02-22:** Como **Jefe de Proyecto**, quiero rechazar definitivamente una solicitud no pertinente, para cerrar su tramitación sin que avance a las etapas posteriores.

### G. Requerimientos funcionales preliminares

* **RF-PP02-058:** El sistema debe permitir rechazar definitivamente la solicitud.
* **RF-PP02-059:** El sistema debe exigir comentario obligatorio al rechazar.
* **RF-PP02-060:** El sistema debe registrar el rechazo con usuario, rol, fecha, hora y comentario.
* **RF-PP02-061:** El sistema debe cerrar la continuidad del flujo para solicitudes rechazadas en esta etapa.
* **RF-PP02-TEMP_REJ1**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

# P02-B14 — Confirmación y transición de estado

## Funcionalidad P02-F23 — Confirmar decisión antes de ejecutarla

### A. Descripción funcional

Antes de aplicar una acción de aprobación, devolución o rechazo, el sistema debe solicitar confirmación al Jefe de Proyecto.

### B. Actor principal

Jefe de Proyecto.

### C. Acciones que requieren confirmación

* Aprobar.
* Devolver al Solicitante.
* Rechazar definitivamente.

### D. Reglas de negocio

* La confirmación debe permitir cancelar la acción antes de modificar el estado de la solicitud.
* En devolución y rechazo, el comentario obligatorio debe estar registrado antes de confirmar.

### E. Historia de usuario preliminar

**HU-P02-23:** Como **Jefe de Proyecto**, quiero confirmar mi decisión antes de aplicarla, para evitar ejecutar por error una acción irreversible o de impacto en el flujo.

### F. Requerimientos funcionales preliminares

* **RF-PP02-062:** El sistema debe solicitar confirmación antes de ejecutar una decisión de visación.
* **RF-PP02-063:** El sistema debe permitir cancelar la acción antes de confirmar.

---

## Funcionalidad P02-F24 — Registrar trazabilidad de la decisión

### A. Descripción funcional
El sistema debe generar un registro automático y auditable en el historial de la solicitud (`sg_esol`) cada vez que el Jefe de Proyecto ejecute una acción de gestión (Aprobar, Devolver o Rechazar).

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
**HU-P02-24**: Como **Sistema**, debo registrar la decisión del Jefe de Proyecto en el historial de estados, para garantizar la transparencia y auditabilidad de la tramitación sin alterar los datos de origen de la prestación.

### F. Requerimientos funcionales preliminares
*   **RF-PP02-064**: El sistema debe insertar un registro en la tabla de historial cada vez que se modifique el estado de la solicitud en esta etapa.
*   **RF-PP02-065**: El registro de trazabilidad debe capturar el estado anterior, el nuevo estado, el usuario, la fecha, la hora y el comentario asociado, manteniendo la integridad de los datos de la PDS.
* **RF-PP02-TEMP_TRA1**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

# 7. Estados de salida de la Pantalla 02

| Acción del Jefe de Proyecto             | Estado resultante de la solicitud                                | Destino del flujo                                       |
| --------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------- |
| Aprobar, prestación dentro de jornada   | Aprobada por Jefe de Proyecto / En revisión por Jefatura Directa | Etapa 03 — Jefatura Directa                              |
| Aprobar, prestación fuera de jornada    | Aprobada por Jefe de Proyecto / En revisión organizacional       | Se omite Jefatura Directa y continúa a la etapa aplicable |
| Devolver al Solicitante con comentarios | Devuelta al Solicitante para corrección                          | Regresa a Pantalla 01 con edición habilitada            |
| Rechazar definitivamente                | Rechazada por Jefe de Proyecto                                   | Cierre del flujo para ese expediente                    |

---

# 8. Reglas globales de comportamiento de la Pantalla 02

| Código     | Regla                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------- |
| RG-P02-001 | La Pantalla 02 es de revisión y decisión; no permite editar información ingresada en la etapa anterior. |
| RG-P02-002 | Debe mostrar todos los datos relevantes validados o utilizados en la Pantalla 01.                       |
| RG-P02-003 | La devolución al Solicitante requiere comentario obligatorio.                                           |
| RG-P02-004 | El rechazo definitivo requiere comentario obligatorio.                                                  |
| RG-P02-005 | La aprobación no requiere edición ni recalculación manual por parte del Jefe de Proyecto.               |
| RG-P02-006 | Toda acción debe quedar registrada en la trazabilidad del expediente.                                   |
| RG-P02-007 | La solicitud devuelta debe reabrirse para edición del Solicitante.                                      |
| RG-P02-008 | La solicitud rechazada no debe avanzar a etapas posteriores.                                            |
| RG-P02-009 | La solicitud aprobada debe pasar a la etapa siguiente de visación.                                      |
| RG-P02-010 | La jornada solo condiciona la etapa de Jefatura Directa; no condiciona la revisión del Jefe de Proyecto. |
| **RG-PP02-011** | Toda acción de devolución o rechazo debe gatillar un correo electrónico automático de notificación al Solicitante (y destinatarios correspondientes si aplica) y dejar registro auditable en trazabilidad. |

---

# 9. Requerimientos no funcionales preliminares aplicables a la Pantalla 02

| Código          | Requerimiento no funcional  | Detalle                                                                                                                                |
| --------------- | --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| **RNF-P02-001** | Legibilidad de revisión     | La pantalla debe permitir revisar grandes volúmenes de información sin perder la relación entre proyecto, funcionarios y validaciones. |
| **RNF-P02-002** | Trazabilidad                | Toda decisión del Jefe de Proyecto debe quedar registrada y ser consultable en etapas posteriores.                                     |
| **RNF-P02-003** | Integridad de datos         | Los datos mostrados deben corresponder a la versión de solicitud enviada por el Solicitante.                                           |
| **RNF-P02-004** | Solo lectura                | Los datos de la solicitud deben presentarse en modo no editable.                                                                       |
| **RNF-P02-005** | Claridad de estados         | La pantalla debe diferenciar visualmente estados de cumplimiento, alertas y observaciones.                                             |
| **RNF-P02-006** | Seguridad por rol           | Solo usuarios con rol Jefe de Proyecto autorizado para la solicitud deben acceder a esta vista de decisión.                            |
| **RNF-P02-007** | Confirmación de acciones    | Las acciones que modifican el estado del expediente deben solicitar confirmación previa.                                               |
| **RNF-P02-008** | Comentarios obligatorios    | El sistema debe impedir devolución o rechazo si el comentario requerido no ha sido ingresado.                                          |
| **RNF-P02-009** | Consistencia del expediente | La vista debe mantener coherencia entre resumen ejecutivo, tablas de personal, evidencias y validaciones.                              |

---

# 10. Inventario consolidado de funcionalidades de la Pantalla 02

| Código  | Funcionalidad                                                         |
| ------- | --------------------------------------------------------------------- |
| P02-F01 | Visualizar identificación de la solicitud.                            |
| P02-F02 | Visualizar estado actual del expediente.                              |
| P02-F03 | Visualizar antecedentes de creación y envío.                          |
| P02-F04 | Visualizar datos clave de la PDS.                                     |
| P02-F05 | Visualizar información completa del Centro de Costo.                  |
| P02-F06 | Visualizar datos del proyecto y responsables asociados.               |
| P02-F07 | Visualizar descripción general de la actividad de PDS.                |
| P02-F08 | Visualizar tipo de prestación declarado.                              |
| P02-F09 | Visualizar evidencias seleccionadas y fechas estimadas.               |
| P02-F10 | Visualizar nómina general de funcionarios.                            |
| P02-F11 | Visualizar antecedentes identificatorios y laborales del funcionario. |
| P02-F12 | Visualizar actividad específica declarada para cada funcionario.      |
| P02-F13 | Visualizar resultado de validaciones de elegibilidad.                 |
| P02-F14 | Visualizar cálculo de tope económico por funcionario.                 |
| P02-F15 | Visualizar modalidad de ejecución dentro o fuera de jornada.          |
| P02-F16 | Visualizar condición SEA del funcionario académico.                   |
| P02-F17 | Visualizar compensación horaria registrada.                           |
| P02-F18 | Visualizar historial de PDS previas consideradas.                     |
| P02-F19 | Visualizar resumen global de cumplimiento previo.                     |
| P02-F20 | Aprobar solicitud y derivar a la etapa siguiente.                     |
| P02-F21 | Devolver solicitud al Solicitante con comentarios.                    |
| P02-F22 | Rechazar definitivamente la solicitud.                                |
| P02-F23 | Confirmar decisión antes de ejecutarla.                               |
| P02-F24 | Registrar trazabilidad de la decisión.                                |

