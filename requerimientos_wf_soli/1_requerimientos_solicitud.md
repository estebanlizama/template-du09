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
4. Declare la modalidad de prestación y la planificación de evidencias verificables.
5. Registre la descripción general y periodo de ejecución de la actividad.
6. Busque y seleccione al funcionario que recibirá la prestación.
7. Visualice y valide sus antecedentes contractuales, normativos y financieros.
8. Declare la modalidad de ejecución dentro o fuera de jornada.
9. Registre compensación horaria cuando corresponda.
10. Defina meses de ejecución y monto bruto total.
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
| P01-B04 | Evidencias verificables                    | Registrar entregables exigibles para la etapa de pago.                                          |
| **P01-B05** | Descripción y periodo de ejecución         | Registrar actividad general y fechas de inicio/término.                                         |
| **P01-B06** | Búsqueda y selección de funcionario        | Localizar al funcionario que será incorporado a la PDS.                                         |
| **P01-B07** | Validaciones preventivas del funcionario   | Revisar formación continua, inhabilidades, deudas, elegibilidad y antecedentes complementarios. |
| **P01-B08** | Datos contractuales y actividad específica | Mostrar perfil laboral y registrar la actividad individual del funcionario.                     |
| P01-B09 | Modalidad de ejecución y montos            | Definir meses, monto bruto total, total PDS y visualizar control de topes.                      |
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
* Modalidad de prestación asociada al flujo seleccionado.
* Identificador de modalidad de prestación (`id_modprse`), cuando corresponda.

### D. Datos o cambios que debe mostrar el sistema

* Activación del formulario D9.
* Ocultamiento del formulario tradicional.
* Cambio de textos de acción, especialmente el botón final de envío.
* Visualización del bloque informativo de elegibilidad D9.

### E. Reglas de negocio

* La solicitud debe quedar asociada a un único flujo.
* La modalidad de prestación debe quedar registrada en la solicitud mediante el identificador vigente definido para PDS (`id_modprse`).
* Para el flujo D9, la modalidad registrada debe corresponder al maestro vigente de modalidades de prestación (`sg_tmod`).
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
* **RF-P01-003A:** El sistema debe persistir la modalidad de prestación asociada a la solicitud.

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
* La actividad no debe corresponder a Formación Continua. Diplomados, cursos, postítulos, postgrados, especialidades u otras actividades de educación/formación continua deben tramitarse por el flujo de Docentes Especiales, no por DU288/D9.

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
* Control presupuestario, Saldo Inicial del Centro de Costos (antes de la imputación de la solicitud) y Saldo de la Solicitud actual.
* Saldo Actual/Remanente proyectado del Centro de Costos (Saldo Inicial - Saldo de la Solicitud).
* Historial de saldos (Saldo Inicial, Saldo Solicitud, Saldo Actual) registrado e historizado para cada una de las etapas del workflow de tramitación.
* Saldo disponible por ítem presupuestario asociado al cargo o clasificación del funcionario.
* Indicador visual si el Centro de Costo o la actividad corresponden a Formación Continua.
* Tabla informativa de distribución de Ítems Directivos asociados al Centro de Costo.

### E. Reglas de negocio levantadas

* El Centro de Costo debe verificarse respecto de su condición estructural.
* Debe verificarse su vigencia.
* Debe verificarse su habilitación.
* **Trazabilidad Presupuestaria por Etapa**: El sistema debe registrar e historizar el Saldo Inicial del Centro de Costos, el Saldo de la Solicitud actual y el Saldo Actual/Remanente proyectado en cada etapa del flujo de tramitación y aprobación (Jefe de Proyecto, Decano, Finanzas de Facultad, Finanzas Central, etc.).
* **Consistencia de Aprobación**: Cada etapa del workflow de aprobación debe visualizar el saldo del Centro de Costo vigente en ese preciso momento, permitiendo detectar si hubo imputaciones concurrentes que afecten la viabilidad presupuestaria.
* Debe obtenerse el saldo disponible.
* Debe obtenerse el saldo disponible por ítem presupuestario cuando la validación dependa del cargo, contrato o asignación del funcionario.
* El tipo de financiamiento debe corresponder a **21 - Fondos Propios** o **44 - Terceros**, según lo definido para el flujo.
* Debe identificarse el decreto afecto.
* Debe identificarse si el Centro de Costo posee decreto afecto y peaje regularizado cuando corresponda.
* Debe identificarse si corresponde a Formación Continua. Si se identifica como Formación Continua, el flujo DU288/D9 no debe permitir continuar y debe orientar al usuario al flujo de Docentes Especiales.
* Mientras no exista una fuente normalizada para determinar Formación Continua desde Centro de Costo, decreto afecto u otra clasificación institucional, el sistema debe mostrar el estado como “no determinado” y dejar trazabilidad de la validación pendiente.
* Los Centros de Costo deben obtenerse desde fuentes institucionales vigentes e integradas con la información financiera/resolutiva correspondiente.
* Si el monto solicitado supera el saldo disponible, debe generarse una alerta informativa, pero esa condición no necesariamente bloquea el envío según lo previamente definido.
* **Solo para flujo D9**: La actividad no debe corresponder a Formación Continua.
* **TODO: pendiente ANID.** La identificación de Centros de Costo ANID queda pendiente hasta que Finanzas entregue la información normalizada que deberá consumir el sistema.

### F. Validaciones

| Código        | Validación                                    | Efecto esperado                             |
| ------------- | --------------------------------------------- | ------------------------------------------- |
| VAL-P01-CC-01 | Centro de Costo no estructural cuando aplique | Mostrar cumplimiento o alerta.              |
| VAL-P01-CC-02 | Centro de Costo habilitado                    | Mostrar cumplimiento o incumplimiento.      |
| VAL-P01-CC-03 | Centro de Costo vigente                       | Mostrar cumplimiento o incumplimiento.      |
| VAL-P01-CC-04 | Saldo disponible consultado                   | Mostrar saldo inicial, de solicitud y proyectado. |
| VAL-P01-CC-05 | Tipo de financiamiento compatible             | Mostrar cumplimiento o alerta.              |
| VAL-P01-CC-06 | Decreto afecto identificado                   | Cargar dato en formulario.                  |
| VAL-P01-CC-07 | Formación Continua identificada               | Si corresponde a Formación Continua, bloquear DU288/D9 e informar que debe tramitarse por Docentes Especiales. Si no existe fuente normalizada, mostrar “no determinado”. |
| VAL-P01-CC-08 | Saldo por ítem presupuestario consultado      | Mostrar saldo disponible del ítem aplicable. |
| VAL-P01-CC-09 | Decreto afecto y peaje identificado           | Mostrar dato normalizado cuando aplique.    |

### G. Historia de usuario preliminar

**HU-P01-04:** Como **Solicitante**, quiero que el sistema valide automáticamente el Centro de Costo seleccionado, para conocer su vigencia, habilitación, financiamiento y disponibilidad presupuestaria antes de continuar.

### H. Requerimientos funcionales preliminares

* **RF-P01-009:** El sistema debe validar la condición estructural del Centro de Costo.
* **RF-P01-010:** El sistema debe validar la vigencia del Centro de Costo.
* **RF-P01-011:** El sistema debe validar la habilitación del Centro de Costo.
* **RF-P01-012:** El sistema debe consultar y mostrar el saldo disponible (Saldo Inicial, Saldo de la Solicitud y Saldo Proyectado Remanente).
* **RF-P01-012A:** El sistema debe capturar, almacenar e historizar los saldos (inicial, de la solicitud y proyectado) de forma independiente en cada etapa del workflow de tramitación.
* **RF-P01-013:** El sistema debe mostrar alertas cuando el Centro de Costo no cumpla reglas aplicables.
* **RF-P01-013A:** El sistema debe consultar y mostrar el saldo disponible por ítem presupuestario cuando corresponda.
* **RF-P01-013B:** El sistema debe consumir la información normalizada de decreto afecto, peaje y condición ANID cuando dichas fuentes estén disponibles.
* **RF-P01-013C:** El sistema debe mostrar explícitamente que Formación Continua no es admisible en DU288/D9 y debe bloquear el avance cuando la fuente institucional identifique esa condición.
* **RF-P01-013D:** Si la condición de Formación Continua no puede determinarse automáticamente por falta de fuente normalizada, el sistema debe mostrar la validación como pendiente/no determinada y no afirmarla como cumplida.

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
* Condición de peaje, cuando aplique.
* Condición ANID normalizada, cuando exista fuente oficial disponible.

### E. Reglas de negocio

* Los datos deben obtenerse automáticamente desde la fuente institucional correspondiente.
* Estos campos deben ser de solo lectura para el solicitante, salvo que el negocio defina excepciones posteriores.
* **TODO: pendiente ANID.** La condición ANID no debe inferirse desde texto libre; debe cargarse desde la fuente normalizada que defina Finanzas.
* **TODO: pendiente Formación Continua.** La condición de Formación Continua no debe inferirse desde texto libre ni solo desde la descripción del decreto afecto; debe cargarse desde una fuente institucional normalizada o desde una regla formal validada por Finanzas/DGDP.

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
* **RF-P01-018A:** El sistema debe cargar la condición de peaje asociada al Centro de Costo cuando exista.
* **RF-P01-018B:** El sistema debe cargar la condición ANID solo cuando Finanzas disponga la fuente normalizada correspondiente.

---

## Funcionalidad P01-F05b — Resolución Automática de Delegación (Backend)

### A. Descripción funcional

El sistema resuelve en el backend (Sybase/API) de manera automática si existe una delegación de responsables vigente asociada al Centro de Costo, sin requerir intervención ni visualización manual por parte del solicitante.

### B. Actor principal

Sistema (Backend).

### C. Datos gestionados por el sistema

* RUT de quien delega.
* RUT del delegado.
* RUT del usuario solicitante.
* Centros de Costo habilitados por delegación.
* Vigencia de la delegación.

### D. Reglas de negocio

* **No se muestra visualmente en el formulario del solicitante.**
* El backend inyectará los datos transaccionales de la delegación automáticamente al guardar la solicitud, para dirigir las aprobaciones correspondientes en las etapas posteriores del flujo.
* La resolución de delegación debe utilizar el RUT del usuario solicitante para determinar responsable, delegante y Centros de Costo disponibles.
* Al guardar la solicitud debe persistirse la trazabilidad de quién recibió la delegación y de quién derivó la función.

---

# P01-B04 — Evidencias verificables


## Funcionalidad P01-F07 — Registrar evidencias verificables

### A. Descripción funcional

El solicitante debe planificar desde el inicio las evidencias que respaldarán la prestación, asociando el tipo de evidencia requerida para la etapa de pago. Las evidencias se definen para la solicitud y deben poder quedar asociadas al funcionario incorporado a la PDS cuando corresponda. (No se requiere ingresar fecha estimada).

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Acta firmada.
* Informe con evidencias.
* Base de datos entregada.
* Otra, con descripción.

### D. Reglas de negocio

* Debe seleccionarse al menos una evidencia.
* Si se selecciona “Otra”, debe ingresarse su descripción.
* Las evidencias deben quedar asociadas a la solicitud desde su creación para ser utilizadas en etapas posteriores de control y pago.
* En la etapa de pago, la carga documental debe habilitarse por cada tipo de evidencia solicitada al funcionario.
* El registro de evidencia debe considerar el documento cargado, fecha/hora de creación y RUT del usuario o funcionario que sube la evidencia.

### E. Validaciones

| Código         | Validación                                  | Efecto                      |
| -------------- | ------------------------------------------- | --------------------------- |
| VAL-P01-EVI-01 | Al menos una evidencia seleccionada         | Bloquea envío si no cumple. |
| VAL-P01-EVI-03 | Descripción de evidencia “Otra”             | Bloquea envío si falta.     |

### F. Historia de usuario preliminar

**HU-P01-07:** Como **Solicitante**, quiero registrar las evidencias que respaldarán la prestación, para dejar planificado el cumplimiento documental exigido en la etapa de pago.

### G. Requerimientos funcionales preliminares

* **RF-P01-022:** El sistema debe permitir seleccionar tipos de evidencia.
* **RF-P01-024:** El sistema debe exigir al menos una evidencia para el flujo D9.
* **RF-P01-025:** El sistema debe exigir detalle cuando se seleccione la opción “Otra”.
* **RF-P01-025A:** El sistema debe conservar la relación entre evidencias solicitadas y funcionario asociado a la PDS cuando corresponda.
* **RF-P01-025B:** El sistema debe dejar disponible la planificación de evidencias para la etapa de pago, incluyendo referencia al documento, fecha/hora de carga y RUT de quien sube la evidencia.

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

Este periodo general puede representar la vigencia completa de la PDS, actividad, proyecto o convenio, incluso cuando abarque varios meses del año. No debe confundirse con los meses efectivos que se asignan a cada funcionario para pago.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Fecha de inicio de ejecución.
* Fecha de término de ejecución.

### D. Reglas de negocio

* La fecha de término no puede ser anterior a la fecha de inicio.
* Los meses seleccionados para el pago del funcionario deben estar contenidos dentro del rango de ejecución.
* El periodo general de la prestación no habilita por sí solo el pago de todos los meses; el límite normativo se controla a nivel de funcionario, actividad y año calendario.

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

* Parentesco (Informativo).
* Cargos no habilitados por modalidad.
* Inhabilidad por cargo.
* Deudas pendientes.

### D. Reglas de negocio previamente levantadas

* Si el funcionario mantiene deudas no regularizadas, no debe poder avanzar.
* Si el PA determina que el cargo no está habilitado para DU288/D9, no debe poder incorporarse.
* La inhabilidad por cargo se determina desde SISPER mediante el PA: los cargos con `sp_carg.cod_tipcar = 5` se consideran directivos y quedan no habilitados.
* Si el Centro de Costo cumple condición ANID o condición institucional definida por PA, la excepción permitida se limita al cargo `cod_cargo = 3120`.
* La verificación de parentesco es únicamente informativa y no determina por sí sola si se puede generar la solicitud.
* Deben considerarse restricciones especiales para Decanos, Directores de Instituto Independiente y Académicos con funciones directivas.

### E. Validaciones requeridas

| Código         | Validación                                   | Efecto                                                        |
| -------------- | -------------------------------------------- | ------------------------------------------------------------- |
| VAL-P01-FUN-01 | Verificación de Parentesco                   | Informativo. Mostrar relaciones familiares si existen, no bloquea envío. |
| VAL-P01-FUN-02 | Verificación de cargo habilitado por PA      | Bloquea incorporación si el PA informa cargo no habilitado. Regla base: `sp_carg.cod_tipcar = 5`; excepción por CCTO ANID/definido solo para `cod_cargo = 3120`. |
| VAL-P01-FUN-03 | Verificación de deudas pendientes            | Bloquea incorporación y envío si no cumple.                   |
| VAL-P01-FUN-04 | Verificación de situación de licencia médica | Debe incorporarse si forma parte de la regla normativa final. |
| VAL-P01-FUN-05 | Verificación de permiso sin goce de sueldo   | Debe incorporarse si forma parte de la regla normativa final. |
| VAL-P01-FUN-06 | Proyecto formalmente vigente                 | Debe incorporarse si forma parte de la regla normativa final. |

### F. Historia de usuario preliminar

**HU-P01-11:** Como **Solicitante**, quiero que el sistema valide automáticamente si el funcionario cumple las condiciones normativas básicas, para evitar incorporar personas no elegibles.

### G. Requerimientos funcionales preliminares

* **RF-P01-034:** El sistema debe validar si la prestación se encuentra asociada a Formación Continua.
  Si la prestación corresponde a Formación Continua, debe bloquearse el flujo DU288/D9 y orientar la tramitación al flujo de Docentes Especiales.
* **RF-P01-035:** El sistema debe validar si el funcionario presenta inhabilidad por cargo según el PA de cargo habilitado, sin depender de una tabla local de cargos excluidos.
* **RF-P01-035A:** El PA debe considerar no habilitados los cargos con `sp_carg.cod_tipcar = 5`.
* **RF-P01-035B:** Si el Centro de Costo cumple condición ANID o condición institucional definida, el PA debe permitir únicamente la excepción `cod_cargo = 3120`.
* **RF-P01-036:** El sistema debe validar si el funcionario presenta deudas pendientes.
* **RF-P01-037:** El sistema debe mostrar el resultado de cada validación preventiva al solicitante.
* **RF-P01-037A:** El sistema debe mostrar parentescos detectados como antecedente informativo, sin bloquear la solicitud por este solo resultado.

---

# P01-B07b — Asignaciones de rol vigentes del funcionario

## Funcionalidad P01-F11b — Consultar y visualizar asignaciones de rol activas

### A. Descripción funcional

Junto con la carga de sus contratos vigentes, el sistema debe obtener y mostrar las **asignaciones de rol vigentes** del funcionario. Una asignación de rol es una designación formal (no contractual) que le otorga al funcionario un cargo o función especial dentro de la institución, por ejemplo: Director de Departamento, Decano (s), Encargado de Unidad, etc.

Esta información es relevante porque un funcionario puede tener un contrato base de tipo académico, pero estar ejerciendo actualmente un cargo directivo por asignación. En ese caso, dicha asignación directiva **invalida** su participación en la PDS, independientemente de su contrato base.

### B. Actor principal

Sistema, visible para el Solicitante.

### C. Datos que debe mostrar el sistema

| Campo | Descripción |
| :--- | :--- |
| Código de asignación | Identificador interno de la asignación. |
| Tipo / Rol asignado | Descripción del cargo o función asignada (ej: Director de Departamento). |
| Unidad / Centro | Unidad organizacional donde ejerce el rol. |
| Vigencia desde | Fecha de inicio de la asignación. |
| Vigencia hasta | Fecha de término (o "Indefinida"). |
| Tipo de ítem directivo | Clasificación presupuestaria asociada al rol (30000 Directivos, 30300 Académicos, 30600 No Académicos). |
| Estado de inhabilitación | Indicador visual: si la asignación bloquea la PDS (Inhabilitado) o no (Permitido). |

### D. Reglas de negocio

- Si el funcionario tiene **al menos una asignación de rol vigente de tipo directivo** (ítem 30000), queda **inhabilitado** para ser incorporado a la PDS.
- La asignación de rol tiene precedencia sobre el contrato base: aunque el contrato sea de académico, si la asignación es directiva, el funcionario no puede participar.
- Si el funcionario no tiene asignaciones de rol vigentes, el contrato base es el único criterio para determinar el ítem directivo.
- Las asignaciones de tipo académico (30300) o no académico (30600) no bloquean la PDS por sí solas; se evalúan junto al resto de validaciones normativas.

### E. Validaciones

| Código | Validación | Efecto esperado |
| :--- | :--- | :--- |
| **VAL-P01-ASIG-01** | Funcionario tiene asignación de rol directivo (ítem 30000) vigente. | Bloquea la incorporación a la PDS. Muestra alerta roja con el nombre del cargo asignado. |
| **VAL-P01-ASIG-02** | Funcionario no tiene asignaciones vigentes. | Sin efecto bloqueante; se continúa con el contrato base. |
| **VAL-P01-ASIG-03** | Asignación directiva vence dentro de los próximos 30 días. | Muestra advertencia amarilla (no bloquea): "La asignación directiva está próxima a vencer". |

### F. Historia de usuario preliminar

**HU-P01-11b:** Como **Solicitante**, quiero visualizar las asignaciones de rol vigentes del funcionario, para conocer si tiene alguna función directiva activa que le impida participar en la PDS antes de intentar incorporarlo.

### G. Requerimientos funcionales preliminares

- **RF-P01-034b:** El sistema debe consultar las asignaciones de rol vigentes del funcionario al momento de su selección.
- **RF-P01-035b:** El sistema debe mostrar la lista de asignaciones vigentes en una tabla de solo lectura.
- **RF-P01-036b:** El sistema debe identificar si alguna asignación es de tipo directivo (ítem 30000).
- **RF-P01-037b:** El sistema debe bloquear la incorporación del funcionario si existe una asignación directiva vigente.
- **RF-P01-038b:** El sistema debe mostrar una alerta clara indicando el motivo de inhabilitación (nombre del cargo directivo asignado).
- **RF-P01-039b:** El sistema debe advertir si una asignación directiva vence en los próximos 30 días, sin bloquear.

---


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
* Tipo de Ítem Directivo del contrato (ej. 30000, 30300, 30600).
* Renta bruta.
* Renta neta.
* Horas de jornada.
* Tipo de vinculación.
* Grado.
* Antigüedad contractual.
* Condición SEA calculada por sistema.

### E. Reglas de negocio

* Debe seleccionarse un único contrato vigente para asociar la PDS.
* El contrato seleccionado debe quedar asociado al funcionario de la solicitud para cálculo de tope, clasificación presupuestaria y trazabilidad posterior.
* La condición SEA debe calcularse cuando corresponda.

### F. Historia de usuario preliminar

**HU-P01-12:** Como **Solicitante**, quiero visualizar los antecedentes laborales y contractuales del funcionario seleccionado, para revisar su perfil antes de incorporarlo a la prestación.

### G. Requerimientos funcionales preliminares

* **RF-P01-038:** El sistema debe mostrar jerarquía, estamento y tipo de jornada del funcionario.
* **RF-P01-039:** El sistema debe consultar los contratos vigentes del funcionario.
* **RF-P01-040:** El sistema debe permitir seleccionar un único contrato vigente para la PDS.
* **RF-P01-041:** El sistema debe calcular y mostrar la condición SEA cuando corresponda.
* **RF-P01-041A:** El sistema debe persistir el contrato seleccionado como contrato afecto del funcionario incorporado a la PDS.

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

El solicitante debe seleccionar los meses del año en que se ejecutará la prestación del funcionario (máximo 2). En esta etapa de Solicitud no se requiere asignar cuotas por mes, eso ocurrirá en la etapa de Pago.

La selección de meses se realiza por funcionario y por actividad asociada a la PDS. Aunque la prestación tenga un periodo general mayor, el funcionario solo puede quedar asociado a los meses permitidos por la normativa.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Meses del año seleccionados.

### D. Reglas de negocio

* Se permite seleccionar como máximo dos meses por año calendario para una misma actividad por funcionario, según lo previamente definido.
* Los meses de ejecución pueden ser distintos entre funcionarios dentro de una misma solicitud.
* Los meses deben encontrarse dentro del rango entre la fecha de inicio y término de la prestación.
* El sistema debe considerar los meses ya aprobados o en trámite para el mismo funcionario y actividad dentro del año calendario, no solo los meses seleccionados en la solicitud actual.
* Si la actividad del funcionario requiere más de dos meses, la solicitud debe bloquear esa asignación e informar que corresponde evaluar otra modalidad contractual según normativa.
* La etapa de solicitud solo registra los meses de ejecución asociados al funcionario; la definición de cuotas y pagos proporcionales corresponde a la etapa de pago cuando sea definida.

### E. Validaciones

| Código         | Validación                          | Efecto                                  |
| -------------- | ----------------------------------- | --------------------------------------- |
| VAL-P01-MES-01 | Al menos un mes seleccionado        | Bloquea agregar funcionario.            |
| VAL-P01-MES-02 | Máximo dos meses                    | Bloquea una tercera selección.          |
| VAL-P01-MES-03 | Mes dentro del periodo de ejecución | Bloquea selección o envío si no cumple. |
| VAL-P01-MES-04 | Otras prestaciones activas o en trámite para el mismo periodo | Bloquea selección o envío si se supera el límite de 2 meses por año. |
| VAL-P01-MES-05 | Acumulado anual por funcionario y actividad | Bloquea si el funcionario ya alcanza el máximo anual permitido. |

### F. Historia de usuario preliminar

**HU-P01-14:** Como **Solicitante**, quiero seleccionar los meses de ejecución de la prestación, para distribuir el pago dentro del periodo permitido.

### G. Requerimientos funcionales preliminares

* **RF-P01-044:** El sistema debe permitir seleccionar meses de ejecución.
* **RF-P01-045:** El sistema debe impedir seleccionar más de dos meses cuando aplique la regla general.
* **RF-P01-046:** El sistema debe validar que los meses seleccionados estén dentro del periodo de ejecución.
* **RF-P01-046A:** El sistema debe validar el acumulado anual de meses por funcionario y actividad considerando solicitudes previas, vigentes o en trámite.
* **RF-P01-046B:** El sistema debe permitir que cada funcionario de la solicitud tenga meses de ejecución propios.

---

## Funcionalidad P01-F15 — Asignar monto bruto total y calcular total PDS

### A. Descripción funcional

El solicitante debe ingresar el **Monto Bruto Total a Pagar** por la prestación completa del funcionario. En la etapa de Solicitud no se dividen cuotas mensuales, solo se registra el costo global que se ejecutará en los meses seleccionados.

### B. Actor principal

Solicitante y Sistema.

### C. Datos de entrada

* Monto Bruto Total de la prestación para el funcionario.

### D. Datos calculados

* Total PDS del funcionario.
* Total PDS de la solicitud como sumatoria de los montos brutos totales de los funcionarios incorporados.

### E. Reglas de negocio

* El Monto Bruto Total debe ser numérico y mayor a cero.
* El monto corresponde al total a pagar al funcionario por la actividad, sin importar si los pagos se proporcionarán distinto por mes en la etapa posterior.

### F. Historia de usuario preliminar

**HU-P01-15:** Como **Solicitante**, quiero ingresar el monto bruto total de la prestación del funcionario y visualizar el total calculado, para revisar correctamente el costo de la PDS antes de enviarla.

### G. Requerimientos funcionales preliminares

* **RF-P01-047:** El sistema debe permitir ingresar el Monto Bruto Total de la prestación.
* **RF-P01-048:** El sistema debe bloquear el ingreso de montos por mes o cuotas en la etapa de Solicitud.

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

* El sistema debe consultar la tabla de topes fijos (`sg_trca`) y el PA de cargo habilitado.
* Si el cargo tiene un tope fijo mensual (ej. Planta técnica, administrativa, auxiliar), se aplica ese límite exacto.
* Si el cargo NO tiene un tope fijo asignado o si corresponde a un académico, el sistema debe calcular su límite basándose en el 50% de su sueldo posible (Renta Bruta del contrato seleccionado).
* Directores de Institutos Independientes: regla especial según resolución anual.
* Jornadas parciales: tope proyectado a jornada completa según regla institucional.
* Múltiples contratos: debe utilizarse la regla definida para el contrato de mayor grado o renta/se debe seleccionar contrato por el usuario dando pie al solicitante seleccionar uno de sus contratos para tope.
* **TODO: pendiente ANID.** Queda pendiente definir cómo se identificará oficialmente si el Centro de Costo pertenece a ANID y qué regla específica se aplicará.

### E. Validaciones

| Código          | Validación                         | Efecto                                 |
| --------------- | ---------------------------------- | -------------------------------------- |
| VAL-P01-TOPE-01 | Tope aplicable calculado           | Debe mostrarse al usuario.             |
| VAL-P01-TOPE-02 | Monto mensual dentro del límite    | Permite seguir.                        |
| VAL-P01-TOPE-03 | Monto mensual sobre límite         | Bloquea incorporación del funcionario. |
| VAL-P01-TOPE-04 | Excepción ANID / DITT identificada | **TODO: pendiente ANID.** Aplica regla especial o exención cuando exista definición formal. |

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
* La definición dentro/fuera de jornada debe persistirse por funcionario asociado a la PDS.

### E. Historia de usuario preliminar

**HU-P01-17:** Como **Solicitante**, quiero indicar si la prestación se realizará dentro o fuera de jornada, para que el sistema aplique correctamente las reglas de compensación.

### F. Requerimientos funcionales preliminares

* **RF-P01-053:** El sistema debe permitir indicar si la actividad se ejecutará dentro o fuera de jornada.
* **RF-P01-054:** El sistema debe activar validaciones adicionales cuando se seleccione trabajo dentro de jornada.
* **RF-P01-054A:** El sistema debe persistir la condición dentro/fuera de jornada por funcionario incorporado a la PDS.



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

Cuando corresponda compensar, el sistema debe permitir ingresar compensaciones por funcionario usando el día del mes seleccionado y rango horario. La cantidad de horas no se ingresa como dato principal; si se requiere mostrarla, se calcula desde la hora de inicio y la hora de término.

### B. Actor principal

Solicitante.

### C. Datos de entrada

* Día de compensación dentro del mes seleccionado.
* Hora de inicio.
* Hora de término.
* Acción agregar/eliminar fila.

### D. Reglas de negocio

* Administrativo dentro de jornada: compensa siempre.
* Académico dentro de jornada sin SEA: compensa.
* Académico dentro de jornada con SEA: no requiere compensar.
* La suma de jornada base y tramo de compensación no puede superar 12 horas de trabajo diario.
* La compensación horaria debe registrarse por funcionario y conservar el detalle de mes, día, hora de inicio y hora de término.
* La duración de la compensación debe derivarse del rango horario; no debe capturarse como cantidad manual de horas.

### E. Validaciones

| Código          | Validación                                  | Efecto                                |
| --------------- | ------------------------------------------- | ------------------------------------- |
| VAL-P01-COMP-01 | Compensación obligatoria cuando corresponda | Bloquea agregar funcionario si falta. |
| VAL-P01-COMP-02 | Día de compensación seleccionado            | Bloquea fila inválida.                |
| VAL-P01-COMP-03 | Rango horario registrado                    | Bloquea fila incompleta.              |
| VAL-P01-COMP-04 | Total diario no supera 12 horas             | Bloquea exceso.                       |
| VAL-P01-COMP-05 | Hora de término mayor que hora de inicio    | Bloquea rango inválido.               |

### F. Historia de usuario preliminar

**HU-P01-19:** Como **Solicitante**, quiero registrar el día y tramo horario de compensación cuando la normativa lo exige, para acreditar adecuadamente la ejecución dentro de jornada.

### G. Requerimientos funcionales preliminares

* **RF-P01-057:** El sistema debe permitir agregar filas de compensación horaria.
* **RF-P01-058:** El sistema debe permitir eliminar filas de compensación horaria.
* **RF-P01-059:** El sistema debe exigir compensación cuando la regla normativa lo determine.
* **RF-P01-060:** El sistema debe validar que no se superen 12 horas totales de trabajo diario.
* **RF-P01-060A:** El sistema debe conservar el detalle de compensación horaria asociado al funcionario de la PDS.
* **RF-P01-060B:** El sistema debe registrar día del mes, hora de inicio y hora de término de cada compensación.
* **RF-P01-060C:** El sistema debe calcular la duración desde el rango horario, sin exigir ingreso manual de cantidad de horas.

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
* Modalidad de prestación definida.
* Evidencia seleccionada.
* Descripción general de actividad.
* Fechas de ejecución.
* Funcionario seleccionado.
* Contrato vigente seleccionado cuando corresponda.
* Validaciones de deudas, inhabilidades y restricciones cumplidas.
* Actividad específica del funcionario registrada.
* Meses de ejecución seleccionados.
* Monto bruto total ingresado.
* Tope aplicable cumplido.
* Modalidad de jornada declarada.
* SEA evaluado cuando corresponda.
* Compensación horaria ingresada cuando corresponda.

### E. Resultado esperado

* El funcionario se incorpora a la tabla resumen de la solicitud.
* El funcionario queda asociado a la modalidad de prestación, contrato seleccionado, condición dentro/fuera de jornada, meses de ejecución, monto bruto total, evidencias y compensaciones cuando correspondan.
* El formulario de funcionario puede limpiarse para permitir agregar otro funcionario, si el flujo lo permite.

### F. Historia de usuario preliminar

**HU-P01-20:** Como **Solicitante**, quiero agregar a la solicitud un funcionario que ya fue validado, para construir la nómina de personas asociadas a la PDS.

### G. Requerimientos funcionales preliminares

* **RF-P01-061:** El sistema debe permitir agregar un funcionario validado a la solicitud.
* **RF-P01-062:** El sistema debe impedir agregar funcionarios con validaciones pendientes o incumplidas.
* **RF-P01-063:** El sistema debe mostrar mensajes detallados de incumplimiento cuando no sea posible agregar al funcionario.
* **RF-P01-063A:** El sistema debe persistir los datos normativos y financieros asociados al funcionario incorporado a la PDS.

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
* Detalle de compensación horaria: mes, día, hora de inicio y hora de término.
* Decreto afecto.
* Vigencias.
* Modalidad de prestación.
* Monto bruto.
* Tipo de jornada.
* Tipo de evidencia.
* Fecha/hora de carga de evidencia en etapa de pago, cuando corresponda.
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

# 6. Prellenado desde Solicitud PDS Previa

## 6.1 Objetivo funcional

La pantalla debe permitir iniciar una nueva solicitud PDS usando como base una solicitud previa registrada, con el fin de evitar redigitar informacion de la prestacion y de los funcionarios cuando el nuevo tramite sea similar o corresponda a una regularizacion.

El prellenado no debe depender exclusivamente del usuario creador anterior. Debe poder buscarse por Centro de Costo y por solicitudes PDS asociadas a ese Centro de Costo, siempre que el usuario tenga permisos sobre dicho ambito.

## 6.2 Casos de uso esperados

| Caso | Comportamiento esperado |
| :--- | :--- |
| Crear nueva PDS similar a una anterior | El usuario selecciona una solicitud previa y copia datos base de prestacion. |
| Regularizar funcionario rechazado | Se crea una nueva solicitud usando datos de la PDS original, pero seleccionando solo el funcionario regularizado. |
| Repetir prestacion por nuevo periodo | Se copian datos base y se actualizan fechas, meses y montos segun corresponda. |
| Reutilizar grupo de funcionarios | Se copian funcionarios seleccionados desde una PDS previa, no necesariamente todos. |
| Usar solicitudes del mismo Centro de Costo | El modal lista solicitudes previas asociadas al Centro de Costo autorizado. |

## 6.3 Datos que se pueden prellenar

| Grupo | Datos posibles | Regla |
| :--- | :--- | :--- |
| Prestacion | Actividad, modalidad, centro de costo, unidad financiera, proyecto global, jefe de proyecto. | Deben quedar editables antes de enviar, segun permisos. |
| Periodo | Fechas generales de inicio/termino. | Deben revisarse porque pueden cambiar en la nueva solicitud. |
| Evidencias requeridas | Tipos de evidencia comprometida para pago. | Se pueden copiar como requerimientos, no como documentos cargados. |
| Funcionarios | RUT, cargo, contrato sugerido, item, monto mensual, periodo, jornada, compensacion. | El usuario debe poder seleccionar uno, varios o todos. |
| Meses | Meses previamente definidos por funcionario. | Deben recalcularse o confirmarse para el nuevo periodo. |

## 6.4 Datos que no se deben copiar automaticamente

| Dato | Motivo |
| :--- | :--- |
| Estado de la solicitud anterior | La nueva solicitud debe iniciar como borrador. |
| Historial de aprobaciones | Pertenece al tramite anterior. |
| Resolucion firmada anterior | Solo puede mostrarse como referencia, no como resolucion de la nueva solicitud. |
| Evidencias ya cargadas para pago | Corresponden a ejecucion anterior. |
| Estados de cuota o pago | Pertenecen al flujo de pagos anterior. |
| Indicadores de rechazo anteriores | Deben evaluarse nuevamente, salvo que se quiera mostrar como advertencia. |

## 6.5 Busqueda y seleccion de solicitud previa

La pantalla debe incorporar una opcion tipo **"Crear desde solicitud previa"**.

Filtros minimos:

| Filtro | Uso |
| :--- | :--- |
| Centro de Costo | Listar solicitudes asociadas al Centro de Costo autorizado. |
| Numero de PDS | Buscar una solicitud especifica. |
| Resolucion | Buscar por acto administrativo formalizado. |
| Funcionario | Encontrar solicitudes donde participo un funcionario. |
| Periodo | Filtrar por anio, mes o rango de prestacion. |
| Estado | Priorizar PDS aprobadas/formalizadas, pero permitir borradores si negocio lo autoriza. |

## 6.6 Reglas de seguridad y permisos

1. El usuario solo puede usar como base solicitudes de Centros de Costo sobre los que tenga permiso directo o delegado.
2. Si la solicitud previa pertenece a otro responsable, debe validarse delegacion o autorizacion.
3. La copia debe registrar la solicitud origen para trazabilidad si negocio lo requiere.
4. Los datos copiados deben quedar como borrador y pasar nuevamente por validaciones.
5. El sistema debe advertir si un funcionario copiado tiene nuevas restricciones: cargo no habilitado, deuda, parentesco, contrato no vigente u otra validacion critica.

## 6.7 Impacto en modelo de datos

La funcionalidad puede implementarse inicialmente como procedimiento de consulta/copia sin agregar campos nuevos.

Si se requiere trazabilidad explicita de origen, se recomienda evaluar un campo opcional:

| Tabla | Campo sugerido | Uso |
| :--- | :--- | :--- |
| `sg_prse` | `nro_solori int null` | Referencia a la PDS usada como origen de prellenado o regularizacion. |

Regla: `nro_solori` no reemplaza a `nro_solici`; solo permite saber de que solicitud se tomaron datos base.

## 6.8 Preguntas pendientes

| Pregunta | Por que importa |
| :--- | :--- |
| Se permite copiar desde cualquier PDS del Centro de Costo o solo desde PDS formalizadas? | Define filtros y permisos. |
| Se debe poder copiar solo datos de prestacion sin funcionarios? | Define opciones del modal. |
| Se debe poder copiar un funcionario especifico desde una PDS previa? | Apoya regularizacion sin redigitar. |
| Se debe guardar `nro_solori` en la nueva PDS? | Define trazabilidad estructural. |
| Que validaciones deben ejecutarse nuevamente al copiar? | Evita aprobar datos desactualizados. |

---

# 7. Inventario consolidado de funcionalidades de la Pantalla 01

| Código  | Funcionalidad                                            |
| ------- | -------------------------------------------------------- |
| P01-F01 | Seleccionar tipo de flujo.                               |  
| P01-F02 | Consultar información de elegibilidad normativa.         |
| P01-F03 | Buscar y seleccionar Centro de Costo.                    |
| P01-F04 | Validar Centro de Costo seleccionado.                    |
| P01-F05 | Cargar datos del proyecto asociados al Centro de Costo.  |
| P01-F07 | Registrar evidencias verificables.                       |
| P01-F08 | Registrar descripción general de la actividad.           |
| P01-F09 | Registrar fechas de inicio y término de ejecución.       |
| P01-F10 | Buscar funcionario.                                      |
| P01-F11 | Ejecutar escaneo normativo inicial del funcionario.      |
| P01-F12 | Mostrar datos laborales y contractuales del funcionario. |
| P01-F13 | Registrar actividad específica del funcionario.          |
| P01-F14 | Seleccionar meses de ejecución.                          |
| P01-F15 | Asignar monto bruto total y calcular total PDS.          |
| P01-F16 | Visualizar y validar tope aplicable.                     |
| P01-F17 | Definir modalidad dentro o fuera de jornada.             |
| P01-F18 | Evaluar condición SEA para académicos.                   |
| P01-F19 | Registrar compensación horaria.                          |
| P01-F20 | Incorporar funcionario a la solicitud.                   |
| P01-F21 | Visualizar resumen de funcionarios agregados.            |
| P01-F22 | Eliminar funcionario de la solicitud.                    |
| P01-F23 | Guardar solicitud como borrador.                         |
| P01-F24 | Enviar solicitud a validación.                           |

---

# 8. TODO controlado por dependencias de datos institucionales

La primera vista de solicitud DU288/D9 cubre el flujo operativo principal. Los siguientes puntos quedan documentados como pendientes porque dependen de PA, fuentes normalizadas o definiciones institucionales externas al formulario.

| TODO | Dependencia | Uso esperado |
| :--- | :--- | :--- |
| TODO PA10 - Deudas | Procedimiento/consulta institucional de deudas regularizadas y no regularizadas. | Integrar validacion automatica de deuda cuando el PA quede confirmado. Hasta entonces no debe bloquear silenciosamente el ingreso del funcionario. |
| TODO Parentesco | Consulta SISPER `sp_par1` / `sp_par2` y regla institucional de autorizacion. | Detectar parentesco y definir si bloquea o permite continuar con `Constancia/autorizacion por parentesco`. |
| TODO Asignaciones bloqueantes | Normalizacion de reglas/cargos/asignaciones que impiden participar en DU288. | Ampliar la validacion actual para cubrir todos los tipos bloqueantes, no solo la asignacion directiva detectada en la vista. |
| TODO ANID | Fuente normalizada para identificar proyectos ANID/DIUFRO/DITT y excepciones normativas. | Aplicar excepciones de decanos/proyectos con financiamiento externo certificado cuando exista dato institucional. |
| TODO Saldos | PA/modelo para saldo disponible, saldo por item e historizacion por etapa. | Mostrar y registrar saldo inicial, saldo solicitud y saldo remanente por cada etapa del workflow. |
| TODO Licencias, permisos y receso | Fuente institucional para situaciones administrativas vigentes. | Dejar como constancias/evidencias en esta pantalla; la validacion automatica queda para integracion posterior. |

Regla general: estos TODO no impiden mantener operativa la vista actual. Deben incorporarse como validaciones reales solo cuando exista fuente de datos confiable y trazabilidad definida.


base para solicitud vista 


Solicitudes
 Inicio

 Prestación de servicios
Nueva solicitud
Solicitudes en espera
Solicitudes Históricas

Nueva solicitud
Prestación de servicios
Nueva solicitud
 Programa Docente Especiales
 Normativo D.U. 288

Normativa y Regulaciones aplicables a la Solicitud (DU288)
Centro de costo
7110-11 - FONDO PREINVERSION Y DES.PROG.
Proyecto
FONDO PREINVERSION Y DESARROLLO DE PROGRAMAS
Jefe de proyecto
JOSIAS GAMALIEL ZAPATA SALAZAR
RUT jefe de proyecto
055968039
Unidad ejecutora
7110 - DEPARTAMENTO DE INGENIERIA DE SISTEMAS
Centro de costo vigente
Responsable vigente
Financiamiento compatible DU288
Decreto afecto: 2 - No Afecto
No corresponde a Formación Continua
Tipos de evidencia verificable *
Evidencias

Acta firmada

Informe con evidencias

Base de datos entregada
Constancias

Constancia por licencia medica

Constancia por permiso

Constancia por receso
2 tipos seleccionados.
Inicio de ejecución *
martes, 2 de junio de 2026Seleccionada
Término de ejecución *
viernes, 31 de julio de 2026Seleccionada
Descripción general de la actividad *
asdasddddddddddddddddddddddddd
RUT: 169500576
Nombre: NEFTALI JONATHAN HUICHAPAN ANCAVIL
Correo: No informado
Tope mensual: $382.519
Tope fijo por cargo/planta
Contratos vigentes o en trámite informados (Seleccione uno)
Sel.	Contrato	Principal	Vinculación	Cargo	Estamento	Jornada	Horas	Tope mensual	Vigencia
	45098	Principal	04 - CONTRATA	5160 - AUXILIAR	3 - ADMINISTRATIVO	01 - J/C	44 hrs	$382.519	Vigente
Datos Laborales del Contrato Seleccionado
ID Contrato
45098
Vinculación
04 - CONTRATA
Cargo
5160 - AUXILIAR
Unidad
09010000 - DECANATO FACULTAD DE AGRONOMIA
Estamento
3 - ADMINISTRATIVO
Jerarquía
53 - AUXILIAR
Grado
Grado 8
Jornada
01 - J/C
Horas
44 Hrs
Inicio
01-01-2009
Término decreto
31-12-2009
Término contrato
Sin término
Antigüedad
17 años
Datos de la Solicitud del Funcionario
Actividad específica *
asdasdasdasdasdasdasd
Monto bruto total *
300.000
Tope bruto total
$382.519 (1 mes)
Meses a pagar * (Máximo 2 meses por año)
Ene
Feb
Mar
Abr
May
Jun
Jul
Ago
Sep
Oct
Nov
Dic
Modalidad de jornada *

Fuera de jornada
Contrato vigente
Contrato principal
Cargo habilitado
Modalidad: fuera de jornada
SEA: no aplica
Compensación: no requerida
Buscar
Funcionario	Contrato	Jornada / regla	Solicitud	Compensación	Monto	Acciones
NEFTALI JONATHAN HUICHAPAN ANCAVIL
RUT: 169500576
 Editando	
#No aplica
Vigente
No aplica
AUXILIAR
No aplica · No aplica · 0 hrs
Fuera de jornada
SEA no aplica
Tope pendiente
Tope: pendiente
Meses:
Actividad:
asdasdasdasdasdasdasd
No requerida
No aplica
$300.000	
Total solicitud: $300.000
 
Editar funcionario
