# PDS Normativo D9 / DU288 / DU09

> **Decisión complementaria vigente:** [Rango de ejecución PDS sin generación de `sg_fume`](./decision_rango_ejecucion_sin_fume.md). Esta decisión separa el rango aprobado de las cuotas financieras creadas posteriormente en el workflow de pago.

## Pantalla 01 — Solicitante

### Estructura base de requerimientos por pantalla y funcionalidad

---

# 1. Propósito de esta sección

Este documento organiza la **Pantalla 01: Formulario de Solicitud — Perfil Solicitante** como base formal para la etapa de requerimientos del proyecto **Modernización del Módulo PDS — Fase 2**.

La pantalla se documenta a partir de:

1. Los requerimientos funcionales y reglas de negocio previamente levantadas.
2. La maqueta visual entregada para la vista de creación de solicitud.
3. El enfoque de documentación por **pantalla → sección → funcionalidad → datos → reglas → validaciones → requerimientos**.

> **Alcance de este documento:** Esta versión estructura la pantalla y define sus funcionalidades. A partir de esta base se deben elaborar, en una siguiente iteración, los **casos de uso formales** y la **matriz completa de requerimientos funcionales/no funcionales** por funcionalidad.

---

# 2. Identificación general de la pantalla

| Elemento                   | Descripción                                                                                                                                                      |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Código de pantalla**     | P01                                                                                                                                                              |
| **Nombre**                 | Formulario de Solicitud de Prestación de Servicios                                                                                                               |
| **Perfil principal**       | Solicitante                                                                                                                                                      |
| **Flujo asociado**         | PDS Tradicional / PDS Normativo D9-DU288-DU09                                                                                                                    |
| **Estado inicial visible** | Borrador                                                                                                                                                         |
| **Objetivo principal**     | Permitir que el solicitante genere una solicitud de PDS Normativo completa, validada preventivamente y lista para ser enviada a aprobación del Jefe de Proyecto. |
| **Resultado esperado**     | Solicitud creada, con personal incorporado, validaciones ejecutadas y estado “Enviada” al confirmar su despacho.                                                 |

---

# 3. Objetivo funcional de la Pantalla 01

La pantalla debe permitir que el solicitante:

1. Defina el flujo de tramitación de la solicitud.
2. Seleccione un Centro de Costo compatible con el flujo normativo.
3. Visualice los antecedentes asociados al proyecto y su origen presupuestario.
4. Declare el tipo de prestación y la planificación de evidencias verificables.
5. Registre la descripción general y periodo de ejecución de la actividad.
6. Busque y seleccione al funcionario que recibirá la prestación.
7. Visualice y valide sus antecedentes contractuales, normativos y financieros.
8. Declare la modalidad de ejecución dentro o fuera de jornada.
9. Registre compensación horaria cuando corresponda.
10. Defina meses de ejecución y monto bruto mensual.
11. Verifique el tope aplicable y el total de la PDS.
12. Agregue al funcionario a la tabla de resumen de personal.
13. Guarde la solicitud como borrador o la envíe a validación.

---

# 4. Estructura funcional general de la pantalla

La Pantalla 01 debe organizarse en los siguientes bloques funcionales:

| Código      | Bloque de pantalla                         | Propósito                                                                                       |
| ----------- | ------------------------------------------ | ----------------------------------------------------------------------------------------------- |
| **P01-B01** | Selección de flujo de tramitación          | Definir si la solicitud corresponde al flujo tradicional o al flujo normativo D9.               |
| **P01-B02** | Información de elegibilidad D9             | Informar quiénes pueden o no pueden participar en solicitudes D9.                               |
| **P01-B03** | Contexto y origen de fondos                | Seleccionar Centro de Costo y cargar datos asociados al proyecto.                               |
| **P01-B04** | Tipo de prestación y evidencias            | Registrar clasificación de la prestación y entregables exigibles.                               |
| **P01-B05** | Descripción y periodo de ejecución         | Registrar actividad general y fechas de inicio/término.                                         |
| **P01-B06** | Búsqueda y selección de funcionario        | Localizar al funcionario que será incorporado a la PDS.                                         |
| **P01-B07** | Validaciones preventivas del funcionario   | Revisar formación continua, inhabilidades, deudas, elegibilidad y antecedentes complementarios. |
| **P01-B08** | Datos contractuales y actividad específica | Mostrar perfil laboral y registrar la actividad individual del funcionario.                     |
| **P01-B09** | Modalidad de ejecución y montos            | Definir meses, monto bruto, total PDS y visualizar control de topes.                            |
| **P01-B10** | Jornada y compensación horaria             | Definir trabajo dentro/fuera de jornada y compensación si aplica.                               |
| **P01-B11** | Agregar funcionario                        | Incorporar al funcionario validado a la solicitud.                                              |
| **P01-B12** | Tabla resumen de funcionarios              | Visualizar los funcionarios incorporados y sus datos principales.                               |
| **P01-B13** | Acciones finales                           | Guardar borrador o enviar solicitud a la etapa siguiente.                                       |

---

# 5. Desglose detallado por bloque y funcionalidad

---

# P01-B01 — Selección de flujo de tramitación

## Funcionalidad P01-F01 — Seleccionar tipo de flujo

### A. Descripción funcional

El sistema debe permitir al solicitante seleccionar el tipo de flujo bajo el cual se construirá la solicitud:

* **Programa Docente Especiales / flujo tradicional.**
* **Flujo Normativo D9 / DU288 / DU09.**

Al seleccionar el flujo D9, la pantalla debe mostrar las secciones, campos y validaciones propias de la Fase 2.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Opción de flujo seleccionada.

### D. Datos o cambios que debe mostrar el sistema

* Activación del formulario D9.
* Ocultamiento del formulario tradicional.
* Cambio de textos de acción, especialmente el botón final de envío.
* Visualización del bloque informativo de elegibilidad D9.

### E. Reglas de negocio

* La solicitud debe quedar asociada a un único flujo.
* Si se selecciona D9, se deben activar exclusivamente las reglas normativas asociadas a ese flujo.

### F. Validaciones

| Tipo      | Validación                                                     |
| --------- | -------------------------------------------------------------- |
| Funcional | Debe existir una opción de flujo activa.                       |
| Interfaz  | El formulario visible debe corresponder al flujo seleccionado. |

### G. Historia de usuario preliminar

**HU-P01-01:** Como **Solicitante**, quiero seleccionar el flujo de tramitación de la solicitud, para que el sistema habilite los campos y reglas correspondientes.

### H. Requerimientos funcionales preliminares

* **RF-P01-001:** El sistema debe permitir seleccionar entre flujo Tradicional y flujo Normativo D9.
* **RF-P01-002:** El sistema debe mostrar dinámicamente los campos y secciones del flujo seleccionado.
* **RF-P01-003:** El sistema debe modificar la acción final de envío según el flujo activo.

---

# P01-B02 — Información de elegibilidad D9

## Funcionalidad P01-F02 — Consultar información de elegibilidad normativa

### A. Descripción funcional

Al activar el flujo D9, el sistema debe mostrar un bloque informativo desplegable que explique:

* Quiénes pueden ser incorporados en solicitudes D9.
* Quiénes están inhabilitados normativamente.
* Condiciones adicionales de exclusión o restricción.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Acción de desplegar u ocultar el detalle informativo.

### D. Datos que debe mostrar el sistema

#### Habilitados, según información entregada

* Académicos con contrato vigente.
* Personal administrativo, técnico y auxiliar.
* Docentes con nombramiento activo.
* Directores de Instituto Independiente de Facultad.
* Académicos con encomendación de funciones directivas, cuando la actividad se relacione con su función académica.
* Decanos/as en proyectos ANID, DIUFRO o DITT con financiamiento externo certificado.

#### Inhabilitados, según información entregada

* Rector o Rectora.
* Vicerrectores/as.
* Contralor/a Universitario/a.
* Personal de Contraloría Universitaria.
* Secretario/a General.
* Directivos/as administrativos/as.
* Decanos/as, salvo excepción normativa regulada.

#### Condiciones adicionales informadas

* No mantener deudas no regularizadas con la Universidad.
* No encontrarse en licencia médica.
* No estar en permiso sin goce de sueldo.
* El proyecto no debe haber finalizado formalmente.
* La actividad no debe corresponder a Formación Continua.

### E. Reglas de negocio

* Este bloque es informativo para el solicitante; la validación efectiva debe realizarse automáticamente en las secciones posteriores.

### F. Validaciones

No aplica como validación bloqueante. Corresponde a un componente informativo.

### G. Historia de usuario preliminar

**HU-P01-02:** Como **Solicitante**, quiero visualizar las condiciones generales de elegibilidad del flujo D9, para conocer anticipadamente los criterios normativos aplicables.

### H. Requerimientos funcionales preliminares

* **RF-P01-004:** El sistema debe mostrar información de elegibilidad D9 al seleccionar dicho flujo.
* **RF-P01-005:** El bloque de elegibilidad debe poder desplegarse y contraerse.

---

# P01-B03 — Contexto y origen de fondos

## Funcionalidad P01-F03 — Buscar y seleccionar Centro de Costo

### A. Descripción funcional

El solicitante debe poder buscar y seleccionar un Centro de Costo mediante una ventana modal. La búsqueda debe permitir filtrar por código o nombre del Centro de Costo.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Código del Centro de Costo.
* Nombre o parte del nombre del Centro de Costo.

### D. Datos que debe mostrar el sistema en resultados

* Código del Centro de Costo.
* Nombre del Centro de Costo.
* Tipo de financiamiento.
* Decreto asociado.
* Unidad ejecutora.
* Jefe de Proyecto.
* Acción “Seleccionar”.

### E. Reglas de negocio

* Solo los Centros de Costo compatibles con el flujo D9 deben poder utilizarse efectivamente en la solicitud.
* La búsqueda no reemplaza la validación; el sistema debe validar el Centro de Costo una vez seleccionado.

### F. Validaciones

| Tipo      | Validación                                                                                |
| --------- | ----------------------------------------------------------------------------------------- |
| Operativa | La búsqueda debe devolver resultados vinculados al criterio ingresado.                    |
| Funcional | La selección de un Centro de Costo debe cargar su información en el formulario principal. |

### G. Historia de usuario preliminar

**HU-P01-03:** Como **Solicitante**, quiero buscar y seleccionar un Centro de Costo, para asociar la solicitud a su origen presupuestario y unidad responsable.

### H. Requerimientos funcionales preliminares

* **RF-P01-006:** El sistema debe permitir buscar Centros de Costo por código o nombre.
* **RF-P01-007:** El sistema debe mostrar una tabla de resultados con los datos relevantes del Centro de Costo.
* **RF-P01-008:** El sistema debe permitir seleccionar un Centro de Costo desde la tabla de resultados.

---

## Funcionalidad P01-F04 — Validar Centro de Costo seleccionado

### A. Descripción funcional

Luego de seleccionar un Centro de Costo, el sistema debe ejecutar validaciones automáticas y mostrar indicadores de cumplimiento o alerta.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Datos de entrada

* Centro de Costo seleccionado.

### D. Información que debe mostrarse

* Indicador de Centro de Costo estructural o no estructural.
* Indicador de habilitación del Centro de Costo.
* Indicador de vigencia.
* Control presupuestario y saldo disponible.

### E. Reglas de negocio levantadas

* El Centro de Costo debe verificarse respecto de su condición estructural.
* Debe verificarse su vigencia.
* Debe verificarse su habilitación.
* Debe obtenerse el saldo disponible.
* El tipo de financiamiento debe corresponder a **21 - Fondos Propios** o **44 - Terceros**, según lo definido para el flujo.
* Debe identificarse el decreto afecto.
* Debe identificarse si corresponde a Formación Continua.
* Si el monto solicitado supera el saldo disponible, debe generarse una alerta informativa, pero esa condición no necesariamente bloquea el envío según lo previamente definido.
* **Solo para flujo D9**: La actividad no debe corresponder a Formación Continua.

### F. Validaciones

| Código        | Validación                                    | Efecto esperado                             |
| ------------- | --------------------------------------------- | ------------------------------------------- |
| VAL-P01-CC-01 | Centro de Costo no estructural cuando aplique | Mostrar cumplimiento o alerta.              |
| VAL-P01-CC-02 | Centro de Costo habilitado                    | Mostrar cumplimiento o incumplimiento.      |
| VAL-P01-CC-03 | Centro de Costo vigente                       | Mostrar cumplimiento o incumplimiento.      |
| VAL-P01-CC-04 | Saldo disponible consultado                   | Mostrar saldo vigente.                      |
| VAL-P01-CC-05 | Tipo de financiamiento compatible             | Mostrar cumplimiento o alerta.              |
| VAL-P01-CC-06 | Decreto afecto identificado                   | Cargar dato en formulario.                  |
| VAL-P01-CC-07 | Formación Continua identificada               | Registrar resultado para control posterior. |

### G. Historia de usuario preliminar

**HU-P01-04:** Como **Solicitante**, quiero que el sistema valide automáticamente el Centro de Costo seleccionado, para conocer su vigencia, habilitación, financiamiento y disponibilidad presupuestaria antes de continuar.

### H. Requerimientos funcionales preliminares

* **RF-P01-009:** El sistema debe validar la condición estructural del Centro de Costo.
* **RF-P01-010:** El sistema debe validar la vigencia del Centro de Costo.
* **RF-P01-011:** El sistema debe validar la habilitación del Centro de Costo.
* **RF-P01-012:** El sistema debe consultar y mostrar el saldo disponible.
* **RF-P01-013:** El sistema debe mostrar alertas cuando el Centro de Costo no cumpla reglas aplicables.

---

## Funcionalidad P01-F05 — Cargar datos del proyecto asociados al Centro de Costo

### A. Descripción funcional

Una vez seleccionado el Centro de Costo, el sistema debe autocompletar los datos institucionales y presupuestarios asociados al proyecto.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Datos de entrada

* Centro de Costo seleccionado.

### D. Datos que debe mostrar el sistema

* RUT del Jefe de Proyecto.
* Nombre del Jefe de Proyecto.
* Nombre del Proyecto.
* Unidad Ejecutora.
* Tipo de Financiamiento.
* Decreto Afecto.

### E. Reglas de negocio

* Los datos deben obtenerse automáticamente desde la fuente institucional correspondiente.
* Estos campos deben ser de solo lectura para el solicitante, salvo que el negocio defina excepciones posteriores.

### F. Validaciones

| Validación                                                     | Efecto                                                                            |
| -------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| Todos los datos obligatorios asociados al CC deben recuperarse | Si falta información crítica, debe informarse que la validación quedó incompleta. |

### G. Historia de usuario preliminar

**HU-P01-05:** Como **Solicitante**, quiero que el sistema cargue automáticamente la información del proyecto y del Jefe de Proyecto desde el Centro de Costo, para evitar el ingreso manual y mantener consistencia institucional.

### H. Requerimientos funcionales preliminares

* **RF-P01-014:** El sistema debe cargar RUT y nombre del Jefe de Proyecto asociado al Centro de Costo.
* **RF-P01-015:** El sistema debe cargar el nombre del Proyecto.
* **RF-P01-016:** El sistema debe cargar la Unidad Ejecutora.
* **RF-P01-017:** El sistema debe cargar el Tipo de Financiamiento.
* **RF-P01-018:** El sistema debe cargar el Decreto Afecto.

---

# P01-B04 — Tipo de prestación y evidencias

## Funcionalidad P01-F06 — Registrar tipo de prestación

### A. Descripción funcional

El solicitante debe indicar el tipo de prestación asociada al proyecto.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Asistencia Técnica.
* Investigación.
* Otro, con texto descriptivo.

### D. Reglas de negocio

* La opción “Otro” debe habilitar un texto explicativo obligatorio.
* Debe definirse si el modelo permite seleccionar uno o más tipos de prestación; la maqueta muestra selección múltiple.

### E. Validaciones

| Validación                                               | Efecto                                            |
| -------------------------------------------------------- | ------------------------------------------------- |
| Debe existir al menos un tipo de prestación seleccionado | Error bloqueante al agregar funcionario o enviar. |
| Puede existir más de un tipo de prestación seleccionado  | Checkbox, permitir mas de uno                     |
| Si se selecciona “Otro”, debe ingresarse detalle         | Error bloqueante si queda vacío.                  |

### F. Historia de usuario preliminar

**HU-P01-06:** Como **Solicitante**, quiero seleccionar el tipo de prestación y especificar una alternativa distinta cuando corresponda, para clasificar adecuadamente la solicitud.

### G. Requerimientos funcionales preliminares

* **RF-P01-019:** El sistema debe permitir una o más de seleccionar el tipo de prestación.
* **RF-P01-020:** El sistema debe permitir registrar una prestación de tipo “Otro”.
* **RF-P01-021:** El sistema debe exigir texto descriptivo cuando se seleccione “Otro”.

---

## Funcionalidad P01-F07 — Registrar evidencias verificables

### A. Descripción funcional

El solicitante debe planificar desde el inicio las evidencias que respaldarán la prestación, asociando cada evidencia seleccionada a una fecha estimada de entrega.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Acta firmada.
* Informe con evidencias.
* Base de datos entregada.
* Otra, con descripción.
* Fecha estimada de entrega para cada evidencia seleccionada.

### D. Reglas de negocio

* Debe seleccionarse al menos una evidencia.
* Cada evidencia seleccionada debe contar con una fecha estimada de entrega.
* Si se selecciona “Otra”, debe ingresarse su descripción.
* Las evidencias deben quedar asociadas a la solicitud desde su creación para ser utilizadas en etapas posteriores de control y pago.

### E. Validaciones

| Código         | Validación                                  | Efecto                      |
| -------------- | ------------------------------------------- | --------------------------- |
| VAL-P01-EVI-01 | Al menos una evidencia seleccionada         | Bloquea envío si no cumple. |
| VAL-P01-EVI-02 | Fecha de entrega por evidencia seleccionada | Bloquea envío si falta.     |
| VAL-P01-EVI-03 | Descripción de evidencia “Otra”             | Bloquea envío si falta.     |

### F. Historia de usuario preliminar

**HU-P01-07:** Como **Solicitante**, quiero registrar las evidencias que respaldarán la prestación y su fecha de entrega, para dejar planificado el cumplimiento documental exigido.

### G. Requerimientos funcionales preliminares

* **RF-P01-022:** El sistema debe permitir seleccionar tipos de evidencia.
* **RF-P01-023:** El sistema debe permitir ingresar fecha estimada de entrega por evidencia seleccionada.
* **RF-P01-024:** El sistema debe exigir al menos una evidencia para el flujo D9.
* **RF-P01-025:** El sistema debe exigir detalle cuando se seleccione la opción “Otra”.

---

# P01-B05 — Descripción y periodo de ejecución

## Funcionalidad P01-F08 — Registrar descripción general de la actividad

### A. Descripción funcional

El solicitante debe ingresar una descripción general de la actividad de prestación de servicios asociada al proyecto.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Descripción textual de la actividad.

### D. Reglas de negocio

* La descripción debe quedar almacenada como parte de la solicitud.
* Debe distinguirse de la “actividad específica del funcionario”, que se registra posteriormente.

### E. Validaciones

| Validación        | Efecto                               |
| ----------------- | ------------------------------------ |
| Campo obligatorio | Bloquea avance final si queda vacío. |

### F. Historia de usuario preliminar

**HU-P01-08:** Como **Solicitante**, quiero describir la actividad general de la PDS, para dejar claramente definido el propósito de la solicitud.

### G. Requerimientos funcionales preliminares

* **RF-P01-026:** El sistema debe permitir registrar la descripción general de la actividad.
* **RF-P01-027:** El sistema debe exigir la descripción como campo obligatorio.

---

## Funcionalidad P01-F09 — Registrar fechas de inicio y término de ejecución

### A. Descripción funcional

El solicitante debe definir el periodo de ejecución de la prestación a nivel general del proyecto.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Fecha de inicio de ejecución.
* Fecha de término de ejecución.

### D. Reglas de negocio

* La fecha de término no puede ser anterior a la fecha de inicio.
* Los meses seleccionados para el pago del funcionario deben estar contenidos dentro del rango de ejecución.

### E. Validaciones

| Código         | Validación                          | Efecto      |
| -------------- | ----------------------------------- | ----------- |
| VAL-P01-FEC-01 | Inicio requerido                    | Bloqueante. |
| VAL-P01-FEC-02 | Término requerido                   | Bloqueante. |
| VAL-P01-FEC-03 | Término igual o posterior al inicio | Bloqueante. |

### F. Historia de usuario preliminar

**HU-P01-09:** Como **Solicitante**, quiero registrar la fecha de inicio y término de la prestación, para delimitar el periodo válido de ejecución.

### G. Requerimientos funcionales preliminares

* **RF-P01-028:** El sistema debe permitir registrar fecha de inicio de ejecución.
* **RF-P01-029:** El sistema debe permitir registrar fecha de término de ejecución.
* **RF-P01-030:** El sistema debe validar la coherencia cronológica del periodo.

---

# P01-B06 — Búsqueda y selección de funcionario

## Funcionalidad P01-F10 — Buscar funcionario

### A. Descripción funcional

El sistema debe permitir buscar funcionarios mediante una ventana modal.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* RUT.
* Nombre.
* Apellido paterno.
* Apellido materno.

### D. Datos que debe mostrar el sistema

* RUT.
* Nombre completo.
* Acción “Seleccionar”.
* Paginación o control de cantidad de resultados, si aplica.

### E. Reglas de negocio

* La búsqueda debe permitir encontrar al funcionario que se asociará a la PDS.
* La selección del funcionario debe iniciar las validaciones preventivas del flujo D9.

### F. Validaciones

| Validación             | Efecto                                                |
| ---------------------- | ----------------------------------------------------- |
| Resultado seleccionado | Debe cargar RUT y nombre del funcionario en pantalla. |

### G. Historia de usuario preliminar

**HU-P01-10:** Como **Solicitante**, quiero buscar un funcionario por sus datos de identificación, para seleccionarlo e incorporarlo a la solicitud.

### H. Requerimientos funcionales preliminares

* **RF-P01-031:** El sistema debe permitir buscar funcionarios por RUT, nombre y apellidos.
* **RF-P01-032:** El sistema debe mostrar resultados de búsqueda en una tabla seleccionable.
* **RF-P01-033:** El sistema debe permitir seleccionar un funcionario desde la tabla de resultados.

---

# P01-B07 — Validaciones preventivas del funcionario

## Funcionalidad P01-F11 — Ejecutar escaneo normativo inicial del funcionario

### A. Descripción funcional

Tras seleccionar al funcionario, el sistema debe ejecutar un escaneo preventivo junto a la obtención de información del funcionario y visualizar la aprobación o rechazo de cada validación.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Validaciones visibles en la maqueta

* Formación Continua.
* Inhabilidad por cargo.
* Deudas pendientes.

### D. Reglas de negocio previamente levantadas

* Si el funcionario mantiene deudas no regularizadas, no debe poder avanzar.
* Si pertenece a un cargo inhabilitado, no debe poder incorporarse.
* Deben considerarse restricciones especiales para Decanos, Directores de Instituto Independiente y Académicos con funciones directivas.

### E. Validaciones requeridas

| Código         | Validación                                   | Efecto esperado                                               |
| -------------- | -------------------------------------------- | ------------------------------------------------------------- |
| VAL-P01-FUN-01 | Verificación de Formación Continua           | Bloquear o alertar según regla normativa definida.            |
| VAL-P01-FUN-02 | Verificación de inhabilidad por cargo        | Bloquea incorporación si no cumple.                           |
| VAL-P01-FUN-03 | Verificación de deudas pendientes            | Bloquea incorporación y envío si no cumple.                   |
| VAL-P01-FUN-04 | Verificación de situación de licencia médica | Debe incorporarse si forma parte de la regla normativa final. |
| VAL-P01-FUN-05 | Verificación de permiso sin goce de sueldo   | Debe incorporarse si forma parte de la regla normativa final. |
| VAL-P01-FUN-06 | Proyecto formalmente vigente                 | Debe incorporarse si forma parte de la regla normativa final. |

### F. Historia de usuario preliminar

**HU-P01-11:** Como **Solicitante**, quiero que el sistema valide automáticamente si el funcionario cumple las condiciones normativas básicas, para evitar incorporar personas no elegibles.

### G. Requerimientos funcionales preliminares

* **RF-P01-034:** El sistema debe validar si la prestación se encuentra asociada a Formación Continua.
* **RF-P01-035:** El sistema debe validar si el funcionario presenta inhabilidad por cargo.
* **RF-P01-036:** El sistema debe validar si el funcionario presenta deudas pendientes.
* **RF-P01-037:** El sistema debe mostrar el resultado de cada validación preventiva al solicitante.

---

# P01-B08 — Datos contractuales y actividad específica

## Funcionalidad P01-F12 — Mostrar datos laborales del funcionario

### A. Descripción funcional

Luego de seleccionar al funcionario, el sistema debe mostrar sus datos laborales básicos en campos de solo lectura.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Datos que muestra la maqueta

* Jerarquía.
* Estamento.
* Tipo de Jornada.

### D. Datos adicionales levantados en requerimientos previos que deben incorporarse

* Contratos vigentes.
* Selección de un contrato vigente.
* Renta bruta.
* Renta neta.
* Horas de jornada.
* Tipo de vinculación.
* Grado.
* Antigüedad contractual.
* Condición SEA calculada por sistema.

### E. Reglas de negocio

* Debe seleccionarse un único contrato vigente para asociar la PDS.
* La condición SEA debe calcularse cuando corresponda.

### F. Historia de usuario preliminar

**HU-P01-12:** Como **Solicitante**, quiero visualizar los antecedentes laborales y contractuales del funcionario seleccionado, para revisar su perfil antes de incorporarlo a la prestación.

### G. Requerimientos funcionales preliminares

* **RF-P01-038:** El sistema debe mostrar jerarquía, estamento y tipo de jornada del funcionario.
* **RF-P01-039:** El sistema debe consultar los contratos vigentes del funcionario.
* **RF-P01-040:** El sistema debe permitir seleccionar un único contrato vigente para la PDS.
* **RF-P01-041:** El sistema debe calcular y mostrar la condición SEA cuando corresponda.

---

## Funcionalidad P01-F13 — Registrar actividad específica del funcionario

### A. Descripción funcional

El solicitante debe registrar la actividad específica que realizará el funcionario dentro del marco general de la prestación.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Descripción textual de las tareas técnicas o funciones concretas del funcionario.

### D. Reglas de negocio

* Esta actividad es específica por funcionario, no necesariamente idéntica a la descripción general de la solicitud.

### E. Validaciones

| Validación                                    | Efecto                          |
| --------------------------------------------- | ------------------------------- |
| Campo obligatorio para agregar al funcionario | Bloquea incorporación si falta. |

### F. Historia de usuario preliminar

**HU-P01-13:** Como **Solicitante**, quiero describir la actividad específica que realizará el funcionario, para precisar su participación dentro de la prestación solicitada.

### G. Requerimientos funcionales preliminares

* **RF-P01-042:** El sistema debe permitir registrar una actividad específica por funcionario.
* **RF-P01-043:** El sistema debe exigir que la actividad específica esté completa antes de agregar al funcionario.

---

# P01-B09 — Modalidad de ejecución y montos

## Funcionalidad P01-F14 — Seleccionar meses de ejecución

### A. Descripción funcional

El solicitante debe seleccionar los meses del año en que se ejecutará y pagará la prestación del funcionario.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Meses del año seleccionados.

### D. Reglas de negocio

* Se permite seleccionar como máximo dos meses por año calendario para una misma actividad o proyecto, según lo previamente definido.
* Los meses deben encontrarse dentro del rango entre la fecha de inicio y término de la prestación.

### E. Validaciones

| Código         | Validación                          | Efecto                                  |
| -------------- | ----------------------------------- | --------------------------------------- |
| VAL-P01-MES-01 | Al menos un mes seleccionado        | Bloquea agregar funcionario.            |
| VAL-P01-MES-02 | Máximo dos meses                    | Bloquea una tercera selección.          |
| VAL-P01-MES-03 | Mes dentro del periodo de ejecución | Bloquea selección o envío si no cumple. |
| VAL-P01-MES-04 | Se valida que no tenga otras prestaciones activas en el mismo periodo  | Bloquea selección o envío si no cumple el limite de 2 meses por año. |

### F. Historia de usuario preliminar

**HU-P01-14:** Como **Solicitante**, quiero seleccionar los meses de ejecución de la prestación, para distribuir el pago dentro del periodo permitido.

### G. Requerimientos funcionales preliminares

* **RF-P01-044:** El sistema debe permitir seleccionar meses de ejecución.
* **RF-P01-045:** El sistema debe impedir seleccionar más de dos meses cuando aplique la regla general.
* **RF-P01-046:** El sistema debe validar que los meses seleccionados estén dentro del periodo de ejecución.

---

## Funcionalidad P01-F15 — Registrar monto bruto mensual y calcular total PDS

### A. Descripción funcional

El solicitante debe ingresar el monto bruto mensual de la prestación. El sistema debe calcular automáticamente el total de la PDS conforme a la cantidad de meses seleccionados.

### B. Actor principal

Solicitante y Sistema.

### C. Datos de entrada

* Monto bruto mensual.
* Meses seleccionados.

### D. Datos calculados

* Total PDS = Monto bruto mensual × cantidad de meses seleccionados.

### E. Reglas de negocio

* El monto debe ser numérico y mayor o igual a cero, según definición final del negocio.
* El total debe actualizarse cada vez que cambie el monto o la cantidad de meses.

### F. Historia de usuario preliminar

**HU-P01-15:** Como **Solicitante**, quiero ingresar el monto bruto mensual y visualizar el total calculado de la prestación, para conocer el valor económico completo antes de agregar al funcionario.

### G. Requerimientos funcionales preliminares

* **RF-P01-047:** El sistema debe permitir ingresar el monto bruto mensual.
* **RF-P01-048:** El sistema debe calcular automáticamente el total de la PDS.
* **RF-P01-049:** El sistema debe actualizar el total cuando cambien el monto o los meses seleccionados.

---

## Funcionalidad P01-F16 — Visualizar y validar tope aplicable

### A. Descripción funcional

El sistema debe mostrar un control visual del límite permitido de percepción y validar que el monto ingresado no infrinja los topes aplicables.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Elementos visibles en la maqueta

* Indicador de estado: “Cumple 50%”, “Cercano al límite” o “Excede límite”.
* Barra de progreso de uso del tope.
* Monto acumulado en Prestaciones previas.
* Total del contrato vigente
* Monto solicitado
* Porcentaje acumulado
* Límite acumulado calculado.

### D. Reglas de negocio previamente levantadas

* Personal académico: tope del 50% de la remuneración bruta.
* Planta técnica: tope fijo definido.
* Planta administrativa: tope fijo definido.
* Planta auxiliar: tope fijo definido.
* Directores de Institutos Independientes: regla especial según resolución anual.
* Jornadas parciales: tope proyectado a jornada completa según regla institucional.
* Múltiples contratos: debe utilizarse la regla definida para el contrato de mayor grado o renta/se debe seleccionar contrato por el usuario dando pie al solicitante seleccionar uno de sus contratos para tope.
* Proyectos ANID //TODO: Por definir como indentificar si pertenece o no a un proyecto ANID, una vez identificado debe aplicarse las reglas definidas.

### E. Validaciones

| Código          | Validación                         | Efecto                                 |
| --------------- | ---------------------------------- | -------------------------------------- |
| VAL-P01-TOPE-01 | Tope aplicable calculado           | Debe mostrarse al usuario.             |
| VAL-P01-TOPE-02 | Monto mensual dentro del límite    | Permite seguir.                        |
| VAL-P01-TOPE-03 | Monto mensual sobre límite         | Bloquea incorporación del funcionario. |
//TODO: Deben definirse 
| VAL-P01-TOPE-04 | Excepción ANID / DITT identificada | Aplica regla especial o exención.      |

### F. Historia de usuario preliminar

**HU-P01-16:** Como **Solicitante**, quiero visualizar el tope económico aplicable al funcionario y saber si el monto ingresado lo cumple, para evitar enviar una solicitud inviable.

### G. Requerimientos funcionales preliminares

* **RF-P01-050:** El sistema debe calcular el tope aplicable según el perfil del funcionario.
* **RF-P01-051:** El sistema debe mostrar el nivel de utilización del tope mediante un indicador visual.
* **RF-P01-052:** El sistema debe bloquear la incorporación del funcionario si el monto excede el tope permitido.

---

# P01-B10 — Jornada y compensación horaria

## Funcionalidad P01-F17 — Definir modalidad dentro o fuera de jornada

### A. Descripción funcional

El solicitante debe indicar si la actividad será realizada dentro o fuera de la jornada laboral del funcionario.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Dentro de jornada.
* Fuera de jornada.

### D. Reglas de negocio

* Si la actividad se realiza fuera de jornada, no se activa la compensación horaria en el mismo sentido regulado para trabajo dentro de jornada.
* Si la actividad se realiza dentro de jornada, el sistema debe evaluar si corresponde compensación o imputación directa por SEA.
* Segun la jornada obtenida de la información del funcionario en la ficha del funcionario se debe validar automaticamente el llenado de este campo.

### E. Historia de usuario preliminar

**HU-P01-17:** Como **Solicitante**, quiero indicar si la prestación se realizará dentro o fuera de jornada, para que el sistema aplique correctamente las reglas de compensación.

### F. Requerimientos funcionales preliminares

* **RF-P01-053:** El sistema debe permitir indicar si la actividad se ejecutará dentro o fuera de jornada.
* **RF-P01-054:** El sistema debe activar validaciones adicionales cuando se seleccione trabajo dentro de jornada.



## Funcionalidad P01-F18 — Evaluar condición SEA para académicos

### A. Descripción funcional

Cuando el funcionario sea académico y la actividad se ejecute dentro de jornada, el sistema debe evaluar si pertenece o no al Sistema de Evaluación Académica (SEA), conforme a la regla definida en requerimientos previos.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Regla levantada

Se considera SEA cuando el funcionario:

1. Es académico.
2. Tiene más de 11 horas de jornada.
3. Posee contrato de al menos 1 año de antigüedad.

### D. Resultado esperado

* Si tiene SEA vigente: no se exige compensación horaria para trabajo dentro de jornada.
* Si no tiene SEA vigente: se exige compensación horaria.

### E. Historia de usuario preliminar

**HU-P01-18:** Como **Solicitante**, quiero que el sistema determine si un académico pertenece a SEA, para saber si corresponde compensación horaria al trabajar dentro de jornada.

### F. Requerimientos funcionales preliminares

* **RF-P01-055:** El sistema debe calcular si el académico cumple la condición SEA.
* **RF-P01-056:** El sistema debe usar la condición SEA para determinar si exige compensación horaria.

---

## Funcionalidad P01-F19 — Registrar compensación horaria

### A. Descripción funcional

Cuando corresponda compensar, el sistema debe permitir ingresar los días y horas de compensación por funcionario.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Día de compensación.
* Cantidad de horas.
* Acción agregar/eliminar fila.

### D. Reglas de negocio

* Administrativo dentro de jornada: compensa siempre.
* Académico dentro de jornada sin SEA: compensa.
* Académico dentro de jornada con SEA: no requiere compensar.
* La suma de horas de jornada base y compensación no puede superar 12 horas de trabajo diario.

### E. Validaciones

| Código          | Validación                                  | Efecto                                |
| --------------- | ------------------------------------------- | ------------------------------------- |
| VAL-P01-COMP-01 | Compensación obligatoria cuando corresponda | Bloquea agregar funcionario si falta. |
| VAL-P01-COMP-02 | Día seleccionado                            | Bloquea fila inválida.                |
| VAL-P01-COMP-03 | Horas registradas                           | Bloquea fila incompleta.              |
| VAL-P01-COMP-04 | Total diario no supera 12 horas             | Bloquea exceso.                       |

### F. Historia de usuario preliminar

**HU-P01-19:** Como **Solicitante**, quiero registrar los días y horas de compensación cuando la normativa lo exige, para acreditar adecuadamente la ejecución dentro de jornada.

### G. Requerimientos funcionales preliminares

* **RF-P01-057:** El sistema debe permitir agregar filas de compensación horaria.
* **RF-P01-058:** El sistema debe permitir eliminar filas de compensación horaria.
* **RF-P01-059:** El sistema debe exigir compensación cuando la regla normativa lo determine.
* **RF-P01-060:** El sistema debe validar que no se superen 12 horas totales de trabajo diario.

---

# P01-B11 — Agregar funcionario

## Funcionalidad P01-F20 — Incorporar funcionario a la solicitud

### A. Descripción funcional

Una vez completados los datos y superadas las validaciones, el solicitante debe poder agregar al funcionario a la solicitud.

### B. Actor principal

Solicitante.

### C. Acción disponible

* Botón: **Agregar Funcionario D9**.

### D. Condiciones previas para agregar

El sistema debe verificar que estén completos y válidos dinamico en la pagina con todos los datos cargados, como mínimo:

* Centro de Costo seleccionado y validado.
* Datos de proyecto cargados.
* Tipo de prestación definido.
* Evidencia seleccionada y fechada.
* Descripción general de actividad.
* Fechas de ejecución.
* Funcionario seleccionado.
* Contrato vigente seleccionado cuando corresponda.
* Validaciones de deudas, inhabilidades y restricciones cumplidas.
* Actividad específica del funcionario registrada.
* Meses de ejecución seleccionados.
* Monto bruto mensual ingresado.
* Tope aplicable cumplido.
* Modalidad de jornada declarada.
* SEA evaluado cuando corresponda.
* Compensación horaria ingresada cuando corresponda.

### E. Resultado esperado

* El funcionario se incorpora a la tabla resumen de la solicitud.
* El formulario de funcionario puede limpiarse para permitir agregar otro funcionario, si el flujo lo permite.

### F. Historia de usuario preliminar

**HU-P01-20:** Como **Solicitante**, quiero agregar a la solicitud un funcionario que ya fue validado, para construir la nómina de personas asociadas a la PDS.

### G. Requerimientos funcionales preliminares

* **RF-P01-061:** El sistema debe permitir agregar un funcionario validado a la solicitud.
* **RF-P01-062:** El sistema debe impedir agregar funcionarios con validaciones pendientes o incumplidas.
* **RF-P01-063:** El sistema debe mostrar mensajes detallados de incumplimiento cuando no sea posible agregar al funcionario.

---

# P01-B12 — Tabla resumen de funcionarios

## Funcionalidad P01-F21 — Visualizar resumen de funcionarios agregados

### A. Descripción funcional

El sistema debe mostrar una tabla resumen con los funcionarios ya incorporados a la solicitud.

### B. Actor principal

Solicitante.

### C. Columnas visibles en la maqueta

* Funcionario / Jerarquía.
* Perfil Laboral.
* Modalidad D9.
* Temporalidad.
* Finanzas.
* Acciones.

### D. Datos adicionales definidos previamente que deberán conservarse internamente o mostrarse en una vista extendida

* RUT.
* Nombre completo.
* Estamento.
* Tipo de vinculación.
* Grado.
* Jornada.
* Centro de Costo.
* Actividad.
* Inicio y término de prestación.
* Jefe de Proyecto.
* Unidad Ejecutora.
* Monto neto.
* Horas de compensación.
* Decreto afecto.
* Vigencias.
* Tipo de prestación.
* Monto bruto.
* Tipo de jornada.
* Tipo de evidencia.
* Fecha de entrega de evidencia.
* Evidencia seleccionada.
* Validaciones aplicadas.

### E. Historia de usuario preliminar

**HU-P01-21:** Como **Solicitante**, quiero visualizar un resumen de los funcionarios agregados, para revisar la composición de la solicitud antes de enviarla.

### F. Requerimientos funcionales preliminares

* **RF-P01-064:** El sistema debe mostrar una tabla resumen con los funcionarios incorporados.
* **RF-P01-065:** El sistema debe conservar todos los datos detallados asociados a cada funcionario agregado.

---

## Funcionalidad P01-F22 — Eliminar funcionario de la solicitud

### A. Descripción funcional

El solicitante debe poder eliminar un funcionario incorporado a la tabla resumen antes del envío.

### B. Actor principal

Solicitante.

### C. Acción disponible

* Botón eliminar en la columna “Acciones”.

### D. Regla de negocio

* La eliminación debe realizarse antes del envío formal de la solicitud.

### E. Historia de usuario preliminar

**HU-P01-22:** Como **Solicitante**, quiero eliminar un funcionario de la solicitud antes de enviarla, para corregir la nómina cuando sea necesario.

### F. Requerimientos funcionales preliminares

* **RF-P01-066:** El sistema debe permitir eliminar funcionarios agregados mientras la solicitud se encuentre editable.
* **RF-P01-067:** El sistema debe solicitar confirmación antes de eliminar el registro.

---



## Funcionalidad P01-F23 — Editar información del Funcionario de la Solicitud

### A. Descripción funcional

El solicitante debe poder editar la información de un funcionario agregado a la solicitud.

### B. Actor principal

Solicitante.

### C. Acción disponible

* Botón: **Editar**.

### D. Reglas de negocio

* El solicitante puede editar la información de un funcionario agregado a la solicitud.
* Debe persistirse el avance registrado hasta ese momento.

### E. Historia de usuario preliminar

**HU-P01-23:** Como **Solicitante**, quiero editar la información de un funcionario agregado a la solicitud, para corregir errores o completar datos faltantes.

### F. Requerimientos funcionales preliminares

* **RF-P01-068:** El sistema debe permitir editar la información de un funcionario agregado a la solicitud.
* **RF-P01-069:** El sistema debe recuperar los datos guardados para edición posterior.

---

# P01-B14 — Acciones finales

## Funcionalidad P01-F23

### A. Descripción funcional

El solicitante debe poder Guardar la solicitud como borrador.

### B. Actor principal

Solicitante.

### C. Acción disponible

* Botón: **Guardar Borrador**.

### D. Reglas de negocio

* El solicitante puede guardar la solicitud como borrador.
* Debe persistirse el avance registrado hasta ese momento.

### E. Historia de usuario preliminar

**HU-P01-24:** Como **Solicitante**, quiero guardar la solicitud como borrador, para retomarla y completarla posteriormente.

### F. Requerimientos funcionales preliminares

* **RF-P01-070:** El sistema debe permitir editar la información de un funcionario agregado a la solicitud.
* **RF-P01-071:** El sistema debe recuperar los datos guardados para edición posterior.


## Funcionalidad P01-F24 — Enviar solicitud a validación

### A. Descripción funcional    

El solicitante debe poder enviar la solicitud al flujo de aprobación una vez que toda la información cumpla las reglas y validaciones requeridas.

### B. Actor principal

Solicitante.

### C. Acción disponible

* Botón: **Enviar validación D9**.

### D. Reglas de negocio

* El envío debe reejecutar las validaciones críticas.
* Si existen errores, el sistema no debe avanzar la solicitud.
* Si no existen errores, la solicitud debe cambiar a estado **Enviada** y pasar a la etapa de **Jefe de Proyecto**.

### E. Validaciones previas de envío

* Existencia de flujo D9 seleccionado.
* Centro de Costo seleccionado y validado.
* Datos generales de proyecto completos.
* Evidencias completas.
* Al menos un funcionario agregado.
* Todos los funcionarios agregados cumplen sus validaciones.
* Montos y topes válidos.
* Compensaciones requeridas completas.
* Fechas y meses consistentes.

### F. Historia de usuario preliminar

**HU-P01-25:** Como **Solicitante**, quiero enviar la solicitud una vez validada, para iniciar formalmente el flujo de aprobación del PDS Normativo.

### G. Requerimientos funcionales preliminares

* **RF-P01-075:** El sistema debe permitir enviar la solicitud cuando todas las validaciones críticas se encuentren cumplidas.
* **RF-P01-076:** El sistema debe revalidar toda la solicitud antes de enviarla.
* **RF-P01-077:** El sistema debe impedir el envío y mostrar errores detallados si existen incumplimientos.
* **RF-P01-078:** El sistema debe cambiar el estado de la solicitud a “Enviada” cuando el despacho sea exitoso.
* **RF-P01-079:** El sistema debe derivar la solicitud a la etapa de Jefe de Proyecto.

---



---

# 6. Inventario consolidado de funcionalidades de la Pantalla 01

| Código  | Funcionalidad                                            |
| ------- | -------------------------------------------------------- |
| P01-F01 | Seleccionar tipo de flujo.                               |  
| P01-F02 | Consultar información de elegibilidad normativa.         |
| P01-F03 | Buscar y seleccionar Centro de Costo.                    |
| P01-F04 | Validar Centro de Costo seleccionado.                    |
| P01-F05 | Cargar datos del proyecto asociados al Centro de Costo.  |
| P01-F06 | Registrar tipo de prestación.                            |
| P01-F07 | Registrar evidencias verificables.                       |
| P01-F08 | Registrar descripción general de la actividad.           |
| P01-F09 | Registrar fechas de inicio y término de ejecución.       |
| P01-F10 | Buscar funcionario.                                      |
| P01-F11 | Ejecutar escaneo normativo inicial del funcionario.      |
| P01-F12 | Mostrar datos laborales y contractuales del funcionario. |
| P01-F13 | Registrar actividad específica del funcionario.          |
| P01-F14 | Seleccionar meses de ejecución.                          |
| P01-F15 | Registrar monto bruto mensual y calcular total PDS.      |
| P01-F16 | Visualizar y validar tope aplicable.                     |
| P01-F17 | Definir modalidad dentro o fuera de jornada.             |
| P01-F18 | Evaluar condición SEA para académicos.                   |
| P01-F19 | Registrar compensación horaria.                          |
| P01-F20 | Incorporar funcionario a la solicitud.                   |
| P01-F21 | Visualizar resumen de funcionarios agregados.            |
| P01-F22 | Eliminar funcionario de la solicitud.                    |
| P01-F23 | Guardar solicitud como borrador.                         |
| P01-F24 | Enviar solicitud a validación.                           |


----------------------------------------------------------------------------------------

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

* **RF-P02-001:** El sistema debe mostrar el código único de la solicitud.
* **RF-P02-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo cuando aplique.

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

* **RF-P02-003:** El sistema debe mostrar el estado actual de la solicitud.
* **RF-P02-004:** El sistema debe identificar que la solicitud se encuentra en revisión del Jefe de Proyecto.

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

* **RF-P02-005:** El sistema debe mostrar el nombre del Solicitante que generó la solicitud.
* **RF-P02-006:** El sistema debe mostrar la fecha de creación de la solicitud.
* **RF-P02-007:** El sistema debe mostrar la fecha de envío a revisión cuando esté disponible.

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

* **RF-P02-008:** El sistema debe mostrar el Centro de Costo asociado.
* **RF-P02-009:** El sistema debe mostrar el tipo de fondo o financiamiento.
* **RF-P02-010:** El sistema debe mostrar el periodo general de la prestación.
* **RF-P02-011:** El sistema debe mostrar el monto total de la solicitud.
* **RF-P02-012:** El sistema debe mostrar la cantidad de funcionarios incorporados.

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

* **RF-P02-013:** El sistema debe mostrar todos los datos del Centro de Costo seleccionados en la solicitud.
* **RF-P02-014:** El sistema debe mostrar el estado de las validaciones aplicadas al Centro de Costo.
* **RF-P02-015:** El sistema debe mostrar las alertas informativas no bloqueantes registradas durante la creación de la solicitud.

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

* **RF-P02-016:** El sistema debe mostrar el nombre del proyecto.
* **RF-P02-017:** El sistema debe mostrar la unidad ejecutora asociada.
* **RF-P02-018:** El sistema debe mostrar el RUT y nombre del Jefe de Proyecto registrado.
* **RF-P02-019:** El sistema debe mostrar el decreto afecto y tipo de financiamiento.

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

* **RF-P02-020:** El sistema debe mostrar la descripción general de la actividad de la PDS.

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

* **RF-P02-021:** El sistema debe mostrar todos los tipos de prestación seleccionados.
* **RF-P02-022:** El sistema debe mostrar la descripción complementaria cuando se haya seleccionado la opción “Otro”.

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

* **RF-P02-023:** El sistema debe mostrar las evidencias seleccionadas en la solicitud.
* **RF-P02-024:** El sistema debe mostrar la fecha estimada de entrega asociada a cada evidencia.
* **RF-P02-025:** El sistema debe mostrar el detalle ingresado para evidencias de tipo “Otra”.

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

* **RF-P02-026:** El sistema debe mostrar la nómina de funcionarios asociados a la solicitud.
* **RF-P02-027:** El sistema debe mostrar para cada funcionario su identificación, perfil general, temporalidad y montos principales.
* **RF-P02-028:** El sistema no debe permitir modificar la nómina desde esta pantalla.

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

* **RF-P02-029:** El sistema debe mostrar los antecedentes identificatorios y laborales del funcionario.
* **RF-P02-030:** El sistema debe mostrar el contrato vigente seleccionado para la solicitud.
* **RF-P02-031:** El sistema debe mostrar los datos contractuales utilizados en validaciones normativas y económicas.

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

* **RF-P02-032:** El sistema debe mostrar la actividad específica registrada para cada funcionario.

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

* **RF-P02-033:** El sistema debe mostrar el resultado de las validaciones normativas ejecutadas por funcionario.
* **RF-P02-034:** El sistema debe distinguir visualmente validaciones cumplidas, alertas e incumplimientos.
* **RF-P02-035:** El sistema debe mostrar el detalle asociado a cada validación cuando esté disponible.

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

* **RF-P02-036:** El sistema debe mostrar el monto bruto mensual y total de cada funcionario.
* **RF-P02-037:** El sistema debe mostrar el tope económico aplicable y la regla utilizada.
* **RF-P02-038:** El sistema debe mostrar el porcentaje de uso del tope.
* **RF-P02-039:** El sistema debe mostrar los antecedentes acumulados o prestaciones previas utilizados en el cálculo, cuando corresponda.

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

* **RF-P02-040:** El sistema debe mostrar si la actividad se realizará dentro o fuera de jornada.

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

* **RF-P02-041:** El sistema debe mostrar la condición SEA asociada al funcionario académico cuando corresponda.
* **RF-P02-042:** El sistema debe mostrar si la condición SEA eliminó o mantuvo la exigencia de compensación horaria.

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

* **RF-P02-043:** El sistema debe mostrar la tabla de compensación horaria por funcionario cuando corresponda.
* **RF-P02-044:** El sistema debe mostrar el resultado de la validación de límite diario de horas.

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

* **RF-P02-045:** El sistema debe mostrar el historial de prestaciones previas del funcionario cuando exista.
* **RF-P02-046:** El sistema debe informar cuando no existan prestaciones previas.
* **RF-P02-047:** El sistema debe identificar si el historial fue utilizado para cálculos o validaciones de la solicitud actual.

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

* **RF-P02-048:** El sistema debe mostrar un resumen consolidado de validaciones ejecutadas en la etapa anterior.
* **RF-P02-049:** El sistema debe distinguir validaciones cumplidas, no aplicables y alertas informativas.

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
* La solicitud aprobada debe avanzar a la etapa siguiente del flujo: **Jefatura Directa / Dirección de Departamento**.

### E. Historia de usuario preliminar

**HU-P02-20:** Como **Jefe de Proyecto**, quiero aprobar una solicitud que considero correcta, para que continúe a la siguiente etapa de revisión.

### F. Requerimientos funcionales preliminares

* **RF-P02-050:** El sistema debe permitir aprobar la solicitud desde la pantalla del Jefe de Proyecto.
* **RF-P02-051:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora/ acorde alo definido en el proyecto.
* **RF-P02-052:** El sistema debe derivar la solicitud aprobada a la etapa siguiente del flujo que es Jefatura Directa o Direccion de Departamento.

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

* **RF-P02-053:** El sistema debe permitir devolver la solicitud al Solicitante.
* **RF-P02-054:** El sistema debe exigir comentario obligatorio al devolver.
* **RF-P02-055:** El sistema debe registrar la devolución con datos adicionales definido en el proyecto.
* **RF-P02-056:** El sistema debe cambiar el estado de la solicitud a devuelta para corrección.
* **RF-P02-057:** El sistema debe habilitar nuevamente la edición al Solicitante una vez devuelta.
* **RF-PP02-001**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones técnicas y comentarios correspondientes.
* **RF-PP02-002**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

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

* **RF-P02-058:** El sistema debe permitir rechazar definitivamente la solicitud.
* **RF-P02-059:** El sistema debe exigir comentario obligatorio al rechazar.
* **RF-P02-060:** El sistema debe registrar el rechazo con usuario, rol, fecha, hora y comentario.
* **RF-P02-061:** El sistema debe cerrar la continuidad del flujo para solicitudes rechazadas en esta etapa.
* **RF-PP02-003**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

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

* **RF-P02-062:** El sistema debe solicitar confirmación antes de ejecutar una decisión de visación.
* **RF-P02-063:** El sistema debe permitir cancelar la acción antes de confirmar.

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
*   **RF-P02-064**: El sistema debe insertar un registro en la tabla de historial cada vez que se modifique el estado de la solicitud en esta etapa.
*   **RF-P02-065**: El registro de trazabilidad debe capturar el estado anterior, el nuevo estado, el usuario, la fecha, la hora y el comentario asociado, manteniendo la integridad de los datos de la PDS.
* **RF-PP02-004**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

---

# 7. Estados de salida de la Pantalla 02

| Acción del Jefe de Proyecto             | Estado resultante de la solicitud                                | Destino del flujo                                       |
| --------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------- |
| Aprobar                                 | Aprobada por Jefe de Proyecto / En revisión por Jefatura Directa | Etapa 03 — Jefatura Directa / Dirección de Departamento |
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

---

------------------------------------------------------------------------------------------------------

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

* **RF-P03-001:** El sistema debe mostrar el código único de la solicitud.
* **RF-P03-002:** El sistema debe indicar que la solicitud corresponde al flujo PDS Normativo cuando aplique.

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

* **RF-P03-003:** El sistema debe mostrar el estado actual de la solicitud.
* **RF-P03-004:** El sistema debe identificar que la solicitud se encuentra en revisión por la Jefatura Directa / Dirección de Departamento.

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

* **RF-P03-005:** El sistema debe mostrar el nombre del Solicitante.
* **RF-P03-006:** El sistema debe mostrar la fecha de creación de la solicitud.
* **RF-P03-007:** El sistema debe mostrar la fecha de envío a revisión cuando esté disponible.

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

* **RF-P03-008:** El sistema debe mostrar que la solicitud fue aprobada por el Jefe de Proyecto.
* **RF-P03-009:** El sistema debe mostrar fecha, hora y usuario responsable de la visación previa.

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

* **RF-P03-010:** El sistema debe mostrar una línea de trazabilidad del expediente.
* **RF-P03-011:** El sistema debe diferenciar hitos cumplidos, etapa actual e hitos pendientes.

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

* **RF-P03-012:** El sistema debe mostrar el Centro de Costo asociado.
* **RF-P03-013:** El sistema debe mostrar el tipo de fondo o financiamiento.
* **RF-P03-014:** El sistema debe mostrar el periodo general de la prestación.
* **RF-P03-015:** El sistema debe mostrar el monto total de la solicitud.
* **RF-P03-016:** El sistema debe mostrar la cantidad de funcionarios incorporados.

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

* **RF-P03-017:** El sistema debe mostrar los datos del Centro de Costo seleccionados en la solicitud.
* **RF-P03-018:** El sistema debe mostrar el estado de las validaciones aplicadas al Centro de Costo.
* **RF-P03-019:** El sistema debe mostrar alertas informativas no bloqueantes registradas previamente.

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

* **RF-P03-020:** El sistema debe mostrar el nombre del proyecto.
* **RF-P03-021:** El sistema debe mostrar la unidad ejecutora.
* **RF-P03-022:** El sistema debe mostrar RUT y nombre del Jefe de Proyecto.
* **RF-P03-023:** El sistema debe mostrar decreto afecto y tipo de financiamiento.

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

* **RF-P03-024:** El sistema debe mostrar la descripción general de la actividad de la PDS.

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

* **RF-P03-025:** El sistema debe mostrar los tipos de prestación seleccionados.
* **RF-P03-026:** El sistema debe mostrar el texto descriptivo cuando se haya seleccionado “Otro”.

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

* **RF-P03-027:** El sistema debe mostrar las evidencias seleccionadas.
* **RF-P03-028:** El sistema debe mostrar la fecha estimada asociada a cada evidencia.
* **RF-P03-029:** El sistema debe mostrar el detalle de evidencias de tipo “Otra”.

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

* **RF-P03-030:** El sistema debe mostrar la nómina de funcionarios asociados.
* **RF-P03-031:** El sistema debe mostrar sus datos principales de identificación, temporalidad y montos.
* **RF-P03-032:** El sistema no debe permitir modificar la nómina desde esta pantalla.

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

* **RF-P03-033:** El sistema debe mostrar antecedentes identificatorios y laborales del funcionario.
* **RF-P03-034:** El sistema debe mostrar el contrato vigente seleccionado para la solicitud.
* **RF-P03-035:** El sistema debe mostrar los datos contractuales utilizados en validaciones normativas y económicas.

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

* **RF-P03-036:** El sistema debe mostrar la actividad específica registrada para cada funcionario.

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

* **RF-P03-037:** El sistema debe mostrar las validaciones normativas ejecutadas por funcionario.
* **RF-P03-038:** El sistema debe distinguir visualmente validaciones cumplidas, alertas e incumplimientos.
* **RF-P03-039:** El sistema debe mostrar detalle de cada validación cuando esté disponible.

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

* **RF-P03-040:** El sistema debe mostrar monto mensual y total por funcionario.
* **RF-P03-041:** El sistema debe mostrar tope aplicable y regla utilizada.
* **RF-P03-042:** El sistema debe mostrar porcentaje de uso del tope.
* **RF-P03-043:** El sistema debe mostrar antecedentes acumulados o prestaciones previas cuando hayan sido utilizados en el cálculo.

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

* **RF-P03-044:** El sistema debe mostrar si la prestación se ejecutará dentro o fuera de jornada.

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

* **RF-P03-045:** El sistema debe mostrar la condición SEA cuando corresponda.
* **RF-P03-046:** El sistema debe mostrar si la condición SEA implicó o no la exigencia de compensación.

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

* **RF-P03-047:** El sistema debe mostrar la compensación horaria registrada cuando corresponda.
* **RF-P03-048:** El sistema debe mostrar el resultado de la validación del límite diario de horas.

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

* **RF-P03-049:** El sistema debe mostrar historial de PDS previas cuando exista.
* **RF-P03-050:** El sistema debe informar cuando no existan prestaciones previas.
* **RF-P03-051:** El sistema debe identificar si el historial influyó en los cálculos o validaciones actuales.

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

* **RF-P03-052:** El sistema debe mostrar un resumen consolidado de validaciones previas.
* **RF-P03-053:** El sistema debe distinguir validaciones cumplidas, no aplicables y alertas informativas.
* **RF-P03-054:** El sistema debe incorporar la visación previa del Jefe de Proyecto dentro del resumen de cumplimiento.

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

* **RF-P03-055:** El sistema debe permitir aprobar la solicitud desde esta pantalla.
* **RF-P03-056:** El sistema debe registrar la aprobación con usuario, rol, fecha y hora.
* **RF-P03-057:** El sistema debe derivar la solicitud aprobada a DGDP.

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

* **RF-P03-058:** El sistema debe permitir devolver la solicitud al Solicitante.
* **RF-P03-059:** El sistema debe exigir comentario obligatorio al devolver.
* **RF-P03-060:** El sistema debe registrar la devolución con usuario, rol, fecha, hora y comentario.
* **RF-P03-061:** El sistema debe cambiar el estado a devuelta para corrección.
* **RF-P03-062:** El sistema debe habilitar nuevamente la edición al Solicitante.
* **RF-PP03-001**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones jerárquicas y comentarios correspondientes.
* **RF-PP03-002**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

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

* **RF-P03-063:** El sistema debe permitir rechazar definitivamente la solicitud.
* **RF-P03-064:** El sistema debe exigir comentario obligatorio al rechazar.
* **RF-P03-065:** El sistema debe registrar el rechazo con usuario, rol, fecha, hora y comentario.
* **RF-P03-066:** El sistema debe cerrar la continuidad del flujo para solicitudes rechazadas en esta etapa.
* **RF-PP03-003**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

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

* **RF-P03-067:** El sistema debe solicitar confirmación antes de ejecutar una decisión de visación.
* **RF-P03-068:** El sistema debe permitir cancelar la acción antes de confirmar.

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
*   **RF-P03-069**: El sistema debe insertar un registro en la tabla de historial cada vez que se modifique el estado de la solicitud en esta etapa.
*   **RF-P03-070**: El registro de trazabilidad debe capturar el estado anterior, el nuevo estado, el usuario, la fecha, la hora y el comentario asociado, manteniendo la integridad de los datos de la PDS.
* **RF-PP03-004**: El sistema debe registrar en la bitácora de trazabilidad el hito de generación y envío del correo de notificación correspondiente.

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

------------------------------------------------------------------------------------------------------

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
| **Objetivo principal** | Permitir que DGDP revalide integralmente la solicitud, revise el cumplimiento normativo de cada funcionario y decida si aprueba la continuidad del expediente, devuelve la solicitud al Solicitante, rechaza definitivamente o excluye funcionarios específicos por incumplimiento. |
| **Resultado posible** | Aprobada y derivada a la etapa siguiente; aprobada con exclusión de uno o más funcionarios; devuelta al Solicitante; o rechazada definitivamente. |

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
- Revise la actividad general, tipo de prestación y evidencias comprometidas.
- Visualice la nómina completa de funcionarios incorporados.
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
- Aprobar la solicitud con los funcionarios que cumplen, si la exclusión de otros no impide la continuidad del expediente.
- Devolver la solicitud completa al Solicitante con comentarios.
- Rechazar definitivamente la solicitud completa con comentarios.
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
8. Revise la ficha completa de cada funcionario.
9. Consulte la cantidad de contratos asociados al funcionario y el detalle de cada uno.
10. Revise el contrato seleccionado para la PDS.
11. Verifique nuevamente inhabilidades, deudas y demás condiciones normativas.
12. Consulte el historial de PDS anteriores y pagos asociados.
13. Revise el cálculo de topes salariales y montos acumulados.
14. Revise la modalidad de jornada, condición SEA y compensación horaria.
15. Visualice posibles familiares o incompatibilidades cuando la fuente de datos y la regla normativa sean definidas.
16. Revise si existe condición ANID / DIUFRO / DITT cuando la forma de validación se formalice.
17. Determine si cada funcionario cumple o no cumple con la normativa.
18. Excluya funcionarios que no cumplan, dejando trazabilidad y motivo de la decisión.
19. Notifique por correo la exclusión del funcionario.
20. Apruebe la solicitud si quedan funcionarios válidos y el expediente mantiene condiciones para continuar.
21. Devuelva la solicitud al Solicitante si requiere correcciones generales.
22. Rechace definitivamente la solicitud si el incumplimiento afecta al expediente completo.
23. Confirme cualquier acción antes de ejecutarla.
24. Registre la trazabilidad completa de las decisiones DGDP.

---

# 5. Estructura funcional general de la pantalla

La Pantalla 04 debe organizarse en los siguientes bloques funcionales:

| Código | Bloque de pantalla | Propósito |
|---|---|---|
| **P04-B01** | Encabezado de expediente y estado DGDP | Identificar la solicitud, su estado actual y el perfil revisor. |
| **P04-B02** | Trazabilidad de aprobaciones previas | Mostrar las decisiones emitidas por Jefe de Proyecto y Jefatura Directa / Dirección de Departamento. |
| **P04-B03** | Resumen ejecutivo de la solicitud | Presentar los datos principales del expediente antes de la auditoría detallada. |
| **P04-B04** | Centro de Costo, proyecto y origen de fondos | Mostrar todos los datos presupuestarios, administrativos y normativos disponibles. |
| **P04-B05** | //TODO:Aun se esta viendo la forma de identificar ccto perteneciente ANID. Validación especial ANID / DIUFRO / DITT | Mostrar la condición del proyecto externo cuando se defina la regla y mecanismo de identificación. |
| **P04-B06** | Actividad general, tipo de prestación y evidencias | Revisar el contenido técnico declarado por el Solicitante. |
| **P04-B07** | Nómina general y estado de revisión de funcionarios | Mostrar todos los funcionarios incorporados y su estado de validación DGDP. |
| **P04-B08** | Ficha contractual integral por funcionario | Mostrar identificación, contratos, vínculo, estamento, grado, jornada y datos asociados. |
| **P04-B09** | Revalidación normativa de elegibilidad | Revisar inhabilidades, deudas, licencias, permisos y demás restricciones. |
| **P04-B10** | Historial de prestaciones previas | Mostrar PDS históricas y validar recurrencia o reglas de periodicidad. |
| **P04-B11** | Historial de pagos e información financiera | Mostrar acumulados de pagos, montos previos y proyección asociada al funcionario. |
| **P04-B12** | Validación de topes económicos | Recalcular y mostrar el cumplimiento de topes según perfil y prestaciones acumuladas. |
| **P04-B13** | Jornada, SEA y compensación horaria | Revalidar la ejecución dentro/fuera de jornada y el cumplimiento de compensaciones. |
| **P04-B14** | Parentescos e incompatibilidades | Mostrar posibles familiares y definir posteriormente si su existencia es condicionante. |
| **P04-B15** | Exclusión individual de funcionarios | Permitir quitar funcionarios que no cumplen, sin detener por sí sola a toda la solicitud. |
| **P04-B16** | Notificación por exclusión | Generar comunicación al Solicitante con el motivo de la exclusión. |
| **P04-B17** | Resumen consolidado de cumplimiento DGDP | Mostrar el resultado global de la revisión, considerando funcionarios aprobados y excluidos. |
| **P04-B18** | Decisión global de DGDP | Permitir aprobar, devolver o rechazar la solicitud. |
| **P04-B19** | Confirmación, transición de estado y trazabilidad | Confirmar decisiones y registrar todos los eventos en el historial del expediente. |

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

- **RF-P04-001:** El sistema debe mostrar el código único de la solicitud.
- **RF-P04-002:** El sistema debe indicar que el expediente corresponde al flujo PDS Normativo.

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

- **RF-P04-003:** El sistema debe mostrar el estado actual de revisión DGDP.
- **RF-P04-004:** El sistema debe mostrar la fecha de ingreso de la solicitud a esta etapa.

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

- **RF-P04-005:** El sistema debe mostrar cronológicamente las acciones previas del expediente.
- **RF-P04-006:** El sistema debe mostrar usuario, rol, fecha, hora y comentario cuando corresponda.

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

- **RF-P04-007:** El sistema debe mostrar una línea de trazabilidad del flujo.
- **RF-P04-008:** El sistema debe diferenciar visualmente etapas cumplidas, etapa actual y etapas pendientes.

---

# P04-B03 — Resumen ejecutivo de la solicitud

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
- Cantidad de funcionarios aún habilitados tras revisión DGDP.
- Cantidad de funcionarios excluidos por DGDP, si aplica.

### D. Reglas de negocio

- El monto total de la solicitud debe recalcularse si DGDP excluye uno o más funcionarios.
- Debe diferenciarse entre:
  - Monto original recibido desde etapas previas.
  - Monto vigente posterior a exclusiones DGDP, si aplica.

### E. Historia de usuario preliminar

**HU-P04-05:** Como **DGDP**, quiero visualizar un resumen ejecutivo del expediente, para conocer de inmediato su alcance económico, institucional y la cantidad de funcionarios en revisión.

### F. Requerimientos funcionales preliminares

- **RF-P04-009:** El sistema debe mostrar los datos clave de la solicitud.
- **RF-P04-010:** El sistema debe mostrar el monto total original y el monto actualizado cuando existan exclusiones.
- **RF-P04-011:** El sistema debe mostrar el número de funcionarios iniciales, habilitados y excluidos.

---

# P04-B04 — Centro de Costo, proyecto y origen de fondos

## Funcionalidad P04-F06 — Visualizar información completa del Centro de Costo

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

### E. Historia de usuario preliminar

**HU-P04-06:** Como **DGDP**, quiero revisar toda la información del Centro de Costo y del proyecto, para contrastar el origen presupuestario con las reglas normativas aplicables.

### F. Requerimientos funcionales preliminares

- **RF-P04-012:** El sistema debe mostrar todos los datos disponibles del Centro de Costo y proyecto asociado.
- **RF-P04-013:** El sistema debe mostrar las validaciones previas aplicadas al Centro de Costo.
- **RF-P04-014:** El sistema debe conservar visibles las alertas informativas detectadas en etapas anteriores.

---

## Funcionalidad P04-F07 — Revalidar condiciones del Centro de Costo

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

**HU-P04-07:** Como **DGDP**, quiero revisar nuevamente las condiciones del Centro de Costo, para verificar que el expediente mantiene coherencia normativa al momento de la auditoría central.

### E. Requerimientos funcionales preliminares

- **RF-P04-015:** El sistema debe mostrar el resultado vigente de las validaciones críticas del Centro de Costo.
- **RF-P04-016:** El sistema debe distinguir entre validación previa y validación revisada en DGDP cuando corresponda.

---

# P04-B05 — Validación especial ANID / DIUFRO / DITT

## Funcionalidad P04-F08 — Visualizar y validar condición de proyecto ANID / DIUFRO / DITT

//TODO:Aun se esta viendo la forma de identificar ccto perteneciente ANID, DIUFRO, DITT.
### A. Descripción funcional

DGDP debe contar con un espacio funcional para revisar si el proyecto corresponde a una condición especial asociada a ANID, DIUFRO o DITT, cuando esta verificación sea formalmente definida dentro del proceso.

### B. Actor principal

DGDP.

### C. Estado actual de definición

> **TODO:** Definir fuente, mecanismo de identificación, respaldo exigido y efectos normativos de la condición ANID / DIUFRO / DITT.

### D. Elementos que debería permitir visualizar cuando la regla quede definida

- Indicador de si el proyecto pertenece o no a ANID / DIUFRO / DITT.
- Fuente de la validación.
- Documento o certificación de respaldo, si aplica.
- Regla especial o excepción asociada.
- Efecto sobre:
  - Topes salariales.
  - Elegibilidad de cargos restringidos.
  - Otras condiciones del flujo.

### E. Historia de usuario preliminar

**HU-P04-08:** Como **DGDP**, quiero visualizar si una solicitud corresponde a un proyecto ANID / DIUFRO / DITT, para aplicar correctamente las condiciones especiales que se definan para estos casos.

### F. Requerimientos funcionales preliminares

- **RF-P04-017:** El sistema debe reservar una validación específica para proyectos ANID / DIUFRO / DITT.
- **RF-P04-018:** El sistema debe mostrar el estado de dicha validación cuando se definan sus reglas.
- **RF-P04-019:** El sistema debe permitir asociar documentación o fuente de respaldo cuando el proceso lo requiera.

---

# P04-B06 — Actividad general, tipo de prestación y evidencias

## Funcionalidad P04-F09 — Visualizar actividad general, tipo de prestación y periodo

### A. Descripción funcional

DGDP debe visualizar el contenido técnico sleccionado en la solicitud  tal como fue ingresado por el Solicitante.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Descripción general de la actividad.
- Tipo o tipos de prestación seleccionados.
- Descripción de “Otro”, si fue utilizada.
- Fecha de inicio de la prestación.
- Fecha de término de la prestación.

### D. Historia de usuario preliminar

**HU-P04-09:** Como **DGDP**, quiero revisar la actividad general y clasificación de la prestación, para contextualizar la auditoría normativa del expediente.

### E. Requerimientos funcionales preliminares

- **RF-P04-020:** El sistema debe mostrar la descripción general de la prestación.
- **RF-P04-021:** El sistema debe mostrar los tipos de prestación seleccionados.
- **RF-P04-022:** El sistema debe mostrar el periodo de inicio y término de la solicitud.

---

## Funcionalidad P04-F10 — Visualizar evidencias comprometidas

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

**HU-P04-10:** Como **DGDP**, quiero revisar las evidencias comprometidas en la solicitud, para conocer los respaldos documentales que sustentan la prestación.

### E. Requerimientos funcionales preliminares

- **RF-P04-023:** El sistema debe mostrar las evidencias comprometidas.
- **RF-P04-024:** El sistema debe mostrar la fecha estimada de entrega de cada evidencia.
- **RF-P04-025:** El sistema debe mostrar el detalle de evidencias de tipo “Otra”.

---

# P04-B07 — Nómina general y estado de revisión de funcionarios

## Funcionalidad P04-F11 — Visualizar nómina completa de funcionarios en revisión

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

### E. Historia de usuario preliminar

**HU-P04-11:** Como **DGDP**, quiero visualizar la nómina completa de funcionarios y su estado de revisión, para identificar quiénes cumplen y quiénes requieren una decisión de exclusión.

### F. Requerimientos funcionales preliminares

- **RF-P04-026:** El sistema debe mostrar la nómina completa de funcionarios enviados a DGDP.
- **RF-P04-027:** El sistema debe mostrar el estado de revisión normativa por funcionario.
- **RF-P04-028:** El sistema debe mantener visibles los funcionarios excluidos con su motivo asociado.

---

# P04-B08 — Ficha contractual integral por funcionario

## Funcionalidad P04-F12 — Visualizar datos identificatorios y laborales completos

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

**HU-P04-12:** Como **DGDP**, quiero visualizar la ficha laboral completa del funcionario, para revisar los antecedentes que sustentan la validación normativa.

### E. Requerimientos funcionales preliminares

- **RF-P04-029:** El sistema debe mostrar los datos identificatorios y laborales completos por funcionario.
- **RF-P04-030:** El sistema debe mostrar los datos salariales que se utilicen en cálculos normativos.

---

## Funcionalidad P04-F13 — Visualizar cantidad de contratos y detalle contractual

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

**HU-P04-13:** Como **DGDP**, quiero revisar todos los contratos vigentes del funcionario y distinguir el contrato asociado a la PDS, para verificar que los cálculos y condiciones se aplicaron sobre la información correcta.

### F. Requerimientos funcionales preliminares

- **RF-P04-031:** El sistema debe mostrar la cantidad de contratos vigentes del funcionario.
- **RF-P04-032:** El sistema debe listar el detalle de todos los contratos vigentes.
- **RF-P04-033:** El sistema debe identificar visualmente el contrato seleccionado para la solicitud.

---

# P04-B09 — Revalidación normativa de elegibilidad

## Funcionalidad P04-F14 — Revalidar inhabilidades por cargo

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

**HU-P04-14:** Como **DGDP**, quiero revisar nuevamente la inhabilidad o restricción por cargo del funcionario, para decidir si puede mantenerse dentro del expediente.

### F. Requerimientos funcionales preliminares

- **RF-P04-034:** El sistema debe mostrar el resultado actualizado de la validación de inhabilidades.
- **RF-P04-035:** El sistema debe distinguir cargos habilitados, restringidos e inhabilitados.

---

## Funcionalidad P04-F15 — Revalidar estado de deudas institucionales

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

**HU-P04-15:** Como **DGDP**, quiero revisar el estado de deudas institucionales por funcionario, para determinar si cumple con las condiciones requeridas para continuar.

### F. Requerimientos funcionales preliminares

- **RF-P04-036:** El sistema debe mostrar el estado de deuda por funcionario.
- **RF-P04-037:** El sistema debe mostrar el detalle y motivo asociado a una deuda detectada.
- **RF-P04-038:** El sistema debe permitir utilizar la deuda como causal de exclusión individual cuando aplique.

---

## Funcionalidad P04-F16 — Revalidar licencia médica, permiso sin goce de sueldo u otras restricciones administrativas

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

**HU-P04-16:** Como **DGDP**, quiero revisar las restricciones administrativas vigentes del funcionario, para aplicar correctamente las reglas del flujo cuando estas condiciones estén formalmente definidas.

### F. Requerimientos funcionales preliminares

- **RF-P04-039:** El sistema debe disponer de un espacio de revisión para restricciones administrativas complementarias.
- **RF-P04-040:** El sistema debe mostrar el efecto de cada restricción cuando la regla de negocio sea definida.

---

# P04-B10 — Historial de prestaciones previas

## Funcionalidad P04-F17 — Visualizar historial de PDS anteriores por funcionario

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

**HU-P04-17:** Como **DGDP**, quiero revisar el historial de prestaciones previas del funcionario, para verificar si la nueva solicitud cumple con las reglas de periodicidad y acumulación.

### F. Requerimientos funcionales preliminares

- **RF-P04-041:** El sistema debe mostrar el historial de PDS previas por funcionario.
- **RF-P04-042:** El sistema debe identificar las PDS del año calendario actual.
- **RF-P04-043:** El sistema debe indicar cuando el historial influye en una validación normativa.

---

## Funcionalidad P04-F18 — Validar cumplimiento de regla de meses de prestación

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

**HU-P04-18:** Como **DGDP**, quiero revisar el uso acumulado de meses de prestación del funcionario, para verificar si la solicitud respeta la periodicidad permitida.

### E. Requerimientos funcionales preliminares

- **RF-P04-044:** El sistema debe calcular la cantidad de meses de PDS acumulados por funcionario.
- **RF-P04-045:** El sistema debe contrastar los meses previos con los meses solicitados actualmente.
- **RF-P04-046:** El sistema debe indicar si la regla de periodicidad se cumple o se excede.

---

# P04-B11 — Historial de pagos e información financiera

## Funcionalidad P04-F19 — Visualizar historial de pagos por funcionario

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

**HU-P04-19:** Como **DGDP**, quiero visualizar el historial de pagos del funcionario, para revisar su comportamiento financiero previo y su impacto en la validación del expediente.

### E. Requerimientos funcionales preliminares

- **RF-P04-047:** El sistema debe mostrar el historial de pagos asociados a PDS previas.
- **RF-P04-048:** El sistema debe mostrar montos brutos, netos y acumulados cuando estén disponibles.
- **RF-P04-049:** El sistema debe vincular el historial financiero con las validaciones económicas actuales.

---

## Funcionalidad P04-F20 — Visualizar resumen financiero actual por funcionario

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

**HU-P04-20:** Como **DGDP**, quiero visualizar el resumen financiero de la PDS actual por funcionario, para revisar el monto solicitado en relación con sus antecedentes previos.

### E. Requerimientos funcionales preliminares

- **RF-P04-050:** El sistema debe mostrar los montos actuales de la PDS por funcionario.
- **RF-P04-051:** El sistema debe mostrar la suma de montos previos y actuales cuando intervengan en el cálculo normativo.

---

# P04-B12 — Validación de topes económicos

## Funcionalidad P04-F21 — Recalcular y mostrar tope aplicable por funcionario

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

**HU-P04-21:** Como **DGDP**, quiero revisar el cálculo normativo de topes económicos por funcionario, para verificar que el monto solicitado se encuentra dentro de los límites aplicables.

### F. Requerimientos funcionales preliminares

- **RF-P04-052:** El sistema debe calcular y mostrar el tope económico aplicable por funcionario.
- **RF-P04-053:** El sistema debe mostrar la base de cálculo utilizada.
- **RF-P04-054:** El sistema debe mostrar el margen disponible y el porcentaje de utilización.
- **RF-P04-055:** El sistema debe indicar si el funcionario cumple o excede el tope.

---

# P04-B13 — Jornada, SEA y compensación horaria

## Funcionalidad P04-F22 — Revalidar modalidad dentro o fuera de jornada

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

**HU-P04-22:** Como **DGDP**, quiero revisar la modalidad de jornada declarada, para verificar que la solicitud aplicó correctamente las reglas de ejecución.

### E. Requerimientos funcionales preliminares

- **RF-P04-056:** El sistema debe mostrar la modalidad de ejecución por funcionario.
- **RF-P04-057:** El sistema debe mostrar la validación asociada a dicha modalidad.

---

## Funcionalidad P04-F23 — Revalidar condición SEA del funcionario académico

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

**HU-P04-23:** Como **DGDP**, quiero revisar la condición SEA aplicada al funcionario académico, para verificar si la exigencia o exención de compensación fue correctamente determinada.

### E. Requerimientos funcionales preliminares

- **RF-P04-058:** El sistema debe mostrar el resultado SEA por funcionario académico.
- **RF-P04-059:** El sistema debe mostrar las variables utilizadas en la evaluación SEA.
- **RF-P04-060:** El sistema debe mostrar su efecto sobre la compensación horaria.

---

## Funcionalidad P04-F24 — Revisar compensación horaria registrada

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

**HU-P04-24:** Como **DGDP**, quiero revisar la compensación horaria registrada, para comprobar que se ajusta a las condiciones de jornada definidas para el flujo.

### E. Requerimientos funcionales preliminares

- **RF-P04-061:** El sistema debe mostrar la compensación horaria registrada por funcionario.
- **RF-P04-062:** El sistema debe mostrar el resultado de la validación del límite de 12 horas diarias.
- **RF-P04-063:** El sistema debe permitir usar un incumplimiento de compensación como causal de exclusión individual cuando corresponda.

---

# P04-B14 — Parentescos e incompatibilidades

## Funcionalidad P04-F25 — Visualizar posibles vínculos familiares e incompatibilidades

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

**HU-P04-25:** Como **DGDP**, quiero visualizar posibles vínculos familiares o incompatibilidades relacionadas con el funcionario, para aplicar la revisión que corresponda cuando esta regla quede formalizada.

### F. Requerimientos funcionales preliminares

- **RF-P04-064:** El sistema debe disponer de una sección para mostrar vínculos familiares o incompatibilidades cuando exista información disponible.
- **RF-P04-065:** El sistema debe mostrar el estado de revisión del vínculo familiar.
- **RF-P04-066:** El sistema debe permitir configurar posteriormente el efecto normativo de esta validación.

---

# P04-B15 — Exclusión individual de funcionarios

## Funcionalidad P04-F26 — Excluir funcionario que no cumple condiciones normativas

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
- Si todos los funcionarios son excluidos, el sistema debe impedir aprobar la solicitud y forzar una decisión global de:
  - Devolver al Solicitante.
  - Rechazar definitivamente.

### F. Historia de usuario preliminar

**HU-P04-26:** Como **DGDP**, quiero excluir de la solicitud a los funcionarios que no cumplen la normativa, para permitir que el expediente continúe únicamente con quienes sí resultan habilitados.

### G. Requerimientos funcionales preliminares

- **RF-P04-067:** El sistema debe permitir excluir uno o más funcionarios desde la vista DGDP.
- **RF-P04-068:** El sistema debe exigir motivo y comentario obligatorio para cada exclusión.
- **RF-P04-069:** El sistema debe conservar visible al funcionario excluido con su estado y motivo.
- **RF-P04-070:** El sistema debe recalcular el monto total del expediente al excluir funcionarios.
- **RF-P04-071:** El sistema debe impedir aprobar la solicitud si no queda ningún funcionario habilitado.

---

## Funcionalidad P04-F27 — Confirmar exclusión de funcionario

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

**HU-P04-27:** Como **DGDP**, quiero confirmar la exclusión de un funcionario antes de ejecutarla, para evitar retirarlo de la solicitud por error.

### E. Requerimientos funcionales preliminares

- **RF-P04-072:** El sistema debe solicitar confirmación antes de excluir a un funcionario.
- **RF-P04-073:** El sistema debe mostrar el impacto de la exclusión antes de confirmar.
- **RF-P04-074:** El sistema debe permitir cancelar la exclusión sin modificar el expediente.

---

# P04-B16 — Notificación por exclusión

## Funcionalidad P04-F28 — Generar correo al Solicitante por exclusión de funcionario

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
### E. Historia de usuario preliminar

**HU-P04-28:** Como **sistema**, debo notificar al Solicitante cuando DGDP excluya a un funcionario, para dejar constancia del motivo y del impacto de la decisión.

### F. Requerimientos funcionales preliminares

- **RF-P04-075:** El sistema debe generar un correo automático al Solicitante por cada funcionario excluido.
- **RF-P04-076:** El correo debe incluir el motivo y comentario técnico de exclusión.
- **RF-P04-077:** El sistema debe registrar que la notificación fue generada.

---

# P04-B17 — Resumen consolidado de cumplimiento DGDP

## Funcionalidad P04-F29 — Visualizar resultado global de la auditoría DGDP

### A. Descripción funcional

El sistema debe presentar un resumen global de la revisión DGDP, diferenciando la situación de la solicitud y la de cada funcionario.

### B. Actor principal

DGDP.

### C. Datos que debe mostrar el sistema

- Cantidad total de funcionarios recibidos.
- Cantidad de funcionarios que cumplen.
- Cantidad de funcionarios excluidos.
- Monto original de la solicitud.
- Monto vigente posterior a exclusiones.
- Validaciones globales del expediente.
- Validaciones críticas por funcionario.
- Alertas pendientes, si existen.
- Estado de preparación para decisión final.

### D. Historia de usuario preliminar

**HU-P04-29:** Como **DGDP**, quiero visualizar un resumen consolidado de mi auditoría, para decidir si la solicitud puede aprobarse, devolverse o rechazarse.

### E. Requerimientos funcionales preliminares

- **RF-P04-078:** El sistema debe mostrar un resumen global de cumplimiento DGDP.
- **RF-P04-079:** El sistema debe diferenciar funcionarios habilitados y excluidos.
- **RF-P04-080:** El sistema debe mostrar el monto actualizado de la solicitud luego de exclusiones.

---

# P04-B18 — Decisión global de DGDP

## Funcionalidad P04-F30 — Aprobar solicitud y derivar a la etapa siguiente

### A. Descripción funcional

DGDP debe poder aprobar la solicitud cuando el expediente cumple las condiciones globales y existe al menos un funcionario habilitado para continuar.

### B. Actor principal

DGDP.

### C. Acción disponible

- Botón: **Aprobar y continuar** o equivalente.

### D. Reglas de negocio

- La aprobación debe considerar únicamente a los funcionarios vigentes dentro de la solicitud.
- Si hubo exclusiones, estas deben mantenerse registradas, y la solicitud debe continuar con la nómina actualizada.
- Si no quedan funcionarios habilitados, la aprobación debe quedar bloqueada.
- La solicitud aprobada debe avanzar a la etapa siguiente definida en el flujo.

### E. Historia de usuario preliminar

**HU-P04-30:** Como **DGDP**, quiero aprobar la solicitud con los funcionarios que cumplen, para permitir su continuidad en el flujo sin arrastrar a quienes fueron excluidos por incumplimiento.

### F. Requerimientos funcionales preliminares

- **RF-P04-081:** El sistema debe permitir aprobar la solicitud cuando exista al menos un funcionario habilitado.
- **RF-P04-082:** El sistema debe derivar el expediente aprobado a la siguiente etapa del flujo.
- **RF-P04-083:** El sistema debe mantener registro de las exclusiones realizadas antes de la aprobación.

---

## Funcionalidad P04-F31 — Devolver solicitud al Solicitante con comentarios

### A. Descripción funcional

DGDP debe poder devolver la solicitud al Solicitante cuando detecte inconsistencias generales que deben corregirse en el origen.

### B. Actor principal

DGDP.

### C. Datos de entrada requeridos

- Comentario obligatorio de devolución.
- Motivo o categoría de devolución, si se define un catálogo.

### D. Reglas de negocio

- La devolución afecta a la solicitud completa.
- El expediente debe quedar en estado **Devuelto al Solicitante por DGDP**.
- El Solicitante debe poder volver a editar lo que corresponda.
- Los comentarios deben quedar visibles y trazables.

### E. Historia de usuario preliminar

**HU-P04-31:** Como **DGDP**, quiero devolver la solicitud al Solicitante cuando requiera correcciones generales, para que el expediente pueda ser subsanado antes de continuar.

### F. Requerimientos funcionales preliminares

- **RF-P04-084:** El sistema debe permitir devolver la solicitud completa al Solicitante.
- **RF-P04-085:** El sistema debe exigir comentario obligatorio para devolver.
- **RF-P04-086:** El sistema debe registrar la devolución y habilitar la corrección por parte del Solicitante.

---

## Funcionalidad P04-F32 — Rechazar definitivamente la solicitud completa

### A. Descripción funcional

DGDP debe poder rechazar definitivamente el expediente completo cuando el incumplimiento detectado afecta la continuidad integral de la solicitud.

### B. Actor principal

DGDP.

### C. Datos de entrada requeridos

- Comentario obligatorio de rechazo.
- Motivo o categoría de rechazo, si se define un catálogo.

### D. Reglas de negocio

- El rechazo definitivo afecta a toda la solicitud.
- La solicitud no debe continuar a etapas posteriores.
- Los funcionarios incluidos o excluidos hasta ese momento deben conservarse en trazabilidad.
- El motivo de rechazo debe quedar disponible para consulta posterior.
* **Notificación de Devolución**: Toda devolución con comentario por observaciones debe generar el envío automático de un correo electrónico al Solicitante para avisar que se generaron observaciones que requieren revisión y corrección.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (DGDP), acción ejecutada (Devolución con comentarios), observaciones ingresadas, fecha/hora y la instrucción correspondiente de corrección.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### E. Historia de usuario preliminar

**HU-P04-32:** Como **DGDP**, quiero rechazar definitivamente una solicitud que presenta incumplimientos globales insalvables, para cerrar su tramitación con trazabilidad del motivo.

### F. Requerimientos funcionales preliminares

- **RF-P04-087:** El sistema debe permitir rechazar definitivamente la solicitud completa.
- **RF-P04-088:** El sistema debe exigir comentario obligatorio para rechazar.
- **RF-P04-089:** El sistema debe cerrar la continuidad del expediente rechazado.
* **RF-PP04-001**: El sistema debe generar y enviar de forma automática un correo electrónico al Solicitante al registrar la devolución de la solicitud, incluyendo las causales o observaciones de cumplimiento normativo o previsional y comentarios correspondientes.
* **RF-PP04-002**: El sistema debe desplegar un aviso visible (Toast o modal de éxito) confirmando la generación y envío del correo de notificación.

---

# P04-B19 — Confirmación, transición de estado y trazabilidad

## Funcionalidad P04-F33 — Confirmar decisión global antes de ejecutarla

### A. Descripción funcional

Antes de aprobar, devolver o rechazar globalmente la solicitud, el sistema debe solicitar confirmación explícita a DGDP.

### B. Actor principal

DGDP.

### C. Acciones que requieren confirmación

- Aprobar solicitud.
- Devolver al Solicitante.
- Rechazar definitivamente.

### D. Reglas de negocio

- La confirmación debe permitir cancelar la acción sin modificar el expediente.
- Devolución y rechazo requieren comentario ingresado antes de confirmar.
- La aprobación debe verificar que existe al menos un funcionario habilitado.
* **Notificación de Rechazo**: Todo rechazo definitivo debe notificar por correo automático al Solicitante.
* **Contenido mínimo del correo**: Código de solicitud, etapa origen (DGDP), acción ejecutada (Rechazo definitivo), motivo de rechazo (observaciones de cumplimiento normativo o previsional), comentarios detallados, y fecha y hora de la acción.
* **Aviso visible**: La pantalla no debe desplegar el cuerpo completo del correo, bastando con mostrar un aviso de confirmación de envío exitoso (Toast/modal).

### E. Historia de usuario preliminar

**HU-P04-33:** Como **DGDP**, quiero confirmar mi decisión global antes de ejecutarla, para evitar cambios de estado erróneos en el expediente.

### F. Requerimientos funcionales preliminares

- **RF-P04-090:** El sistema debe solicitar confirmación antes de aprobar, devolver o rechazar.
- **RF-P04-091:** El sistema debe permitir cancelar la decisión antes de ejecutarla.
- **RF-P04-092:** El sistema debe impedir aprobar si no existe al menos un funcionario habilitado.
* **RF-PP04-003**: El sistema debe enviar un correo automático al Solicitante al registrar el rechazo definitivo de la solicitud, informando el motivo y cierre de la misma.

---

## Funcionalidad P04-F34 — Registrar trazabilidad integral de decisiones DGDP

### A. Descripción funcional

El sistema debe registrar de forma automática y auditable todas las acciones ejecutadas por DGDP durante la revisión del expediente.

### B. Actor principal

Sistema.

### C. Eventos que deben registrarse

- Aprobación global.
- Devolución al Solicitante.
- Rechazo definitivo.
- Exclusión individual de funcionario.
- Confirmación de notificación por exclusión.

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

**HU-P04-34:** Como **sistema**, debo registrar cada decisión y exclusión realizada por DGDP, para mantener una trazabilidad completa de la auditoría normativa del expediente.

### G. Requerimientos funcionales preliminares

- **RF-P04-093:** El sistema debe registrar toda acción ejecutada por DGDP.
- **RF-P04-094:** El sistema debe distinguir eventos globales del expediente y eventos individuales por funcionario.
- **RF-P04-095:** El sistema debe registrar el motivo y comentario asociado a exclusiones, devoluciones y rechazos.
- **RF-P04-096:** El sistema debe registrar la generación de correos de notificación por exclusión.

---

# 7. Estados de salida de la Pantalla 04

| Acción DGDP | Estado resultante de la solicitud | Destino del flujo |
|---|---|---|
| Aprobar sin exclusiones | Aprobada por DGDP / En revisión por etapa siguiente | Continúa el flujo institucional |
| Aprobar con exclusión de uno o más funcionarios | Aprobada por DGDP con exclusiones registradas / En revisión por etapa siguiente | Continúa el flujo con nómina depurada |
| Devolver al Solicitante con comentarios | Devuelta al Solicitante por DGDP | Regresa a edición del Solicitante |
| Rechazar definitivamente | Rechazada por DGDP | Cierre definitivo del expediente |

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
| **RG-P04-010** | La devolución de la solicitud completa requiere comentario obligatorio. |
| **RG-P04-011** | El rechazo definitivo de la solicitud completa requiere comentario obligatorio. |
| **RG-P04-012** | Toda acción de DGDP debe quedar registrada en trazabilidad. |
| **RG-P04-013** | La condición ANID / DIUFRO / DITT queda marcada como **TODO** hasta definir fuente, respaldo y efecto normativo. |
| **RG-P04-014** | La revisión de parentescos e incompatibilidades queda marcada como **TODO** hasta definir si es una validación informativa, condicionante o bloqueante. |
| **RG-P04-015** | La pantalla no debe incorporar opción de Aprobación con Alcance. |

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

---

# 11. Inventario consolidado de funcionalidades de la Pantalla 04

| Código | Funcionalidad |
|---|---|
| **P04-F01** | Visualizar identificación de la solicitud. |
| **P04-F02** | Visualizar estado actual del expediente. |
| **P04-F03** | Visualizar visaciones previas del flujo. |
| **P04-F04** | Visualizar línea de avance del expediente. |
| **P04-F05** | Visualizar resumen general del expediente. |
| **P04-F06** | Visualizar información completa del Centro de Costo. |
| **P04-F07** | Revalidar condiciones del Centro de Costo. |
| **P04-F08** | Visualizar y validar condición ANID / DIUFRO / DITT. |
| **P04-F09** | Visualizar actividad general, tipo de prestación y periodo. |
| **P04-F10** | Visualizar evidencias comprometidas. |
| **P04-F11** | Visualizar nómina completa de funcionarios en revisión. |
| **P04-F12** | Visualizar datos identificatorios y laborales completos. |
| **P04-F13** | Visualizar cantidad de contratos y detalle contractual. |
| **P04-F14** | Revalidar inhabilidades por cargo. |
| **P04-F15** | Revalidar estado de deudas institucionales. |
| **P04-F16** | Revalidar licencia médica, permiso sin goce de sueldo u otras restricciones administrativas. |
| **P04-F17** | Visualizar historial de PDS anteriores por funcionario. |
| **P04-F18** | Validar cumplimiento de regla de meses de prestación. |
| **P04-F19** | Visualizar historial de pagos por funcionario. |
| **P04-F20** | Visualizar resumen financiero actual por funcionario. |
| **P04-F21** | Recalcular y mostrar tope aplicable por funcionario. |
| **P04-F22** | Revalidar modalidad dentro o fuera de jornada. |
| **P04-F23** | Revalidar condición SEA del funcionario académico. |
| **P04-F24** | Revisar compensación horaria registrada. |
| **P04-F25** | Visualizar posibles vínculos familiares e incompatibilidades. |
| **P04-F26** | Excluir funcionario que no cumple condiciones normativas. |
| **P04-F27** | Confirmar exclusión de funcionario. |
| **P04-F28** | Generar correo al Solicitante por exclusión de funcionario. |
| **P04-F29** | Visualizar resultado global de la auditoría DGDP. |
| **P04-F30** | Aprobar solicitud y derivar a la etapa siguiente. |
| **P04-F31** | Devolver solicitud al Solicitante con comentarios. |
| **P04-F32** | Rechazar definitivamente la solicitud completa. |
| **P04-F33** | Confirmar decisión global antes de ejecutarla. |
| **P04-F34** | Registrar trazabilidad integral de decisiones DGDP. |
