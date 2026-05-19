# PDS Normativo D9 / DU288 / DU09

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
