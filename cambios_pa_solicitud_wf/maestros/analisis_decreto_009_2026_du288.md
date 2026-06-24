# Analisis Decreto 009/2026 - Protocolo DU288

## 1. Objetivo del documento

Este documento resume las reglas implementables del Decreto 009/2026, que aprueba el protocolo sobre forma y condiciones de otorgamiento de asignacion de Prestacion de Servicios regulada por el D.U. 288/1991 y sus modificaciones.

El foco es identificar:

1. Que reglas debe validar el sistema.
2. Que datos deben obtenerse por PA.
3. Que datos deben guardarse en las tablas PDS.
4. Que calculos deben quedar congelados al momento de la solicitud.
5. Que puntos requieren definicion institucional o fuente externa.

## 2. Principios de implementacion

1. El sistema no debe calcular topes solo desde el cargo visible del funcionario; debe cruzar contrato, cargo, jerarquia/planta y modalidad.
2. Los topes aplicados deben congelarse en `sg_fups`, porque la escala o la regla pueden cambiar despues de registrada la solicitud.
3. `sg_trca` debe parametrizar la regla vigente, no repetir datos por cada funcionario.
4. La jornada parcial no reduce el tope aplicable; se debe usar la referencia de jornada completa cuando corresponda.
5. Las inhabilidades y validaciones bloqueantes deben resolverse por PA/backend, no por reglas quemadas en el frontend.
6. Las excepciones normativas deben quedar trazadas como condiciones del flujo, no mezcladas con reglas generales.

## 3. Reglas extraidas del decreto

### 3.1 Solicitud de asignacion

La solicitud debe indicar:

| Dato requerido | Uso en sistema |
| :--- | :--- |
| Actividad o funciones a desempenar | `sg_prse.actividad` y detalle visible de la solicitud. |
| Evidencias asociadas esperadas | En solicitud se declaran los tipos/entregables esperados; la evidencia efectiva pertenece al control/pago. |
| Periodo de ejecucion | `sg_prse.per_desde`, `sg_prse.per_hasta`, meses normalizados en `sg_fume`. |
| Centro de costo/proyecto | Validacion financiera y trazabilidad del origen de fondos. |
| Jefe de proyecto/unidad prestadora | Responsable de solicitud y etapas posteriores. |
| Hipotesis normativa aplicable | Debe quedar seleccionable o derivable para resolucion. |
| Acto administrativo que aprueba el proyecto/prestacion | Necesario para trazabilidad en resolucion. |

Si la prestacion se ejecuta dentro de jornada, debe indicarse dedicacion y compensacion formal cuando aplique.

### 3.2 Tope mensual DU288

Regla general:

> Mensualmente, la asignacion o suma de asignaciones de prestacion de servicios no puede exceder el 50% de la remuneracion bruta mensual del mes anterior a la solicitud, entendida como sueldo base mas asignaciones permanentes.

Reglas por tipo:

| Caso | Forma de calculo | Datos requeridos | Donde se guarda resultado |
| :--- | :--- | :--- | :--- |
| Academicos | 50% de remuneracion efectiva del mes anterior, proyectada a jornada completa si corresponde. | PA de haberes efectivos, contrato, horas, jornada. | `sg_fups.mto_haber_ref`, `sg_fups.mto_tope`. |
| Auxiliar, administrativa y tecnica del estamento administrativo | 50% de la remuneracion conformada por sueldo base y asignaciones permanentes del grado mas alto de la planta. | `sg_trca` con regla fija anual/rango vigente. | `sg_fups.id_trca`, `sg_fups.mto_tope`. |
| Jornada parcial | Usar tope correspondiente a jornada completa del mismo estamento. | Horas contrato y regla de planta/estamento. | Mismo `mto_tope`, sin prorratear. |
| Dos contratos | Administrativos: cargo con grado mas alto. Academicos: nivel de renta mas alto. | Lista de contratos PA, cargo, grado/jerarquia, remuneracion. | Contrato seleccionado y tope congelado en `sg_fups`. |
| Directores de Institutos Independientes | Base anual definida por VRAF, no puede exceder remuneracion bruta mensual de directivo nivel C jornada completa. | Resolucion anual VRAF + informe VRIP. | Regla especial en `sg_trca` o PA complementario. |
| Proyectos ANID u otros externos reconocidos DIUFRO/DITT | No aplican estos limites DU288, salvo limites propios del proyecto. | Identificacion/certificacion de proyecto externo reconocido. | Condicion de excepcion en validacion. |

#### Criterio especial para academicos por horas

El decreto indica que, para funcionarios con jornada parcial, el limite aplicable sera el correspondiente a una jornada completa del mismo estamento. Sin embargo, el texto del decreto no detalla por si solo la tabla de equivalencia entre cargos academicos por horas y niveles academicos de jornada completa.

Con los datos SISPER disponibles se puede inferir la jerarquia academica base:

| Cargo por horas | `sp_carg.cod_jerpla` | `sp_jpfu.des_jerpla` | Equivalencia de jerarquia |
| :--- | :--- | :--- | :--- |
| Profesor Titular Adjunto | `01` | Profesor Titular | Titular |
| Profesor Asociado Adjunto | `02` | Profesor Asociado | Asociado |
| Profesor Asistente Adjunto | `03` | Profesor Asistente | Asistente |
| Instructor Adjunto | `04` | Instructor | Instructor |

Lo que queda por definir institucionalmente es el nivel exacto de jornada completa dentro de cada jerarquia, por ejemplo:

| Jerarquia por horas | Posibles niveles jornada completa | Criterio que debe definir PA/regla |
| :--- | :--- | :--- |
| Profesor Titular Adjunto | Titular A, Titular B, Titular C | Si se usa siempre Titular A o si se obtiene un nivel especifico desde contrato/remuneracion. |
| Profesor Asociado Adjunto | Asociado A, Asociado B, Asociado C | Si se usa siempre Asociado A o un nivel especifico. |
| Profesor Asistente Adjunto | Asistente A, Asistente B, Asistente C | Si se usa siempre Asistente A o un nivel especifico. |
| Instructor Adjunto | Instructor | Tiene equivalencia directa en la escala actual. |

Lectura operativa recomendada:

1. No usar el valor hora como tope final directo.
2. Resolver primero la jerarquia academica desde `sp_carg.cod_jerpla -> sp_jpfu`.
3. Obtener desde PA o regla institucional el nivel de jornada completa aplicable.
4. Calcular el tope como el 50% del `Total Haber` de esa equivalencia de jornada completa.

Ejemplo si la regla institucional define usar el nivel superior de la jerarquia:

```text
Profesor Titular Adjunto -> Titular A jornada completa
Total Haber Titular A = 4.720.149
Tope mensual = 4.720.149 * 0.50 = 2.360.074
```

Este criterio debe quedar implementado en PA/backend, no solo en frontend, porque depende de una homologacion normativa de jerarquia y nivel.

### 3.3 Criterio para `sg_trca`

`sg_trca` debe guardar reglas de tope por modalidad, grupo/planta y vigencia.

Campos relevantes:

| Campo | Uso |
| :--- | :--- |
| `id_trca` | Regla exacta aplicada. Debe guardarse tambien en `sg_fups`. |
| `cod_modprs` | Modalidad. Para DU288 usar `2`. |
| `cod_jerpln` | Grupo/planta normalizada desde `sp_jpfu`. |
| `grado_ref` | Grado usado como referencia. Para topes fijos por grado mas alto normalmente sera `1`. |
| `mto_base_haber` | Total haber de la escala usado como base. |
| `pct_aplicado` | Porcentaje normativo, normalmente `50.00`. |
| `cod_forcal` | `F` fijo, `C` calculado por haberes efectivos, `S` especial. |
| `mto_tope` | Tope mensual final para reglas fijas. |
| `ano_vigen` | Ano normativo/presupuestario. |
| `f_inicio`, `f_termino` | Rango de vigencia, permite reajustes dentro del ano. |
| `vigente` | Registro activo. |

Ejemplo conceptual:

| id_trca | cod_modprs | cod_jerpln | grupo | grado_ref | mto_base_haber | pct_aplicado | cod_forcal | mto_tope | f_inicio | f_termino |
| ---: | ---: | ---: | :--- | :--- | ---: | ---: | :---: | ---: | :--- | :--- |
| 1 | 2 | 7 | Academico | NULL | NULL | 50.00 | C | NULL | 2026-01-01 | NULL |
| 2 | 2 | 3 | Tecnico | 1 | base vigente | 50.00 | F | tope tecnico | 2026-01-01 | NULL |
| 3 | 2 | 4 | Administrativo | 1 | base vigente | 50.00 | F | tope administrativo | 2026-01-01 | NULL |
| 4 | 2 | 5 | Auxiliar | 1 | base vigente | 50.00 | F | tope auxiliar | 2026-01-01 | NULL |
| 5 | 2 | 1 | Directivo especial | C | base nivel C | 50.00 | S | NULL | 2026-01-01 | NULL |

Notas:

1. Para topes fijos, si la resolucion anual indica el monto final, `mto_base_haber` puede registrar la base y `mto_tope` el resultado aprobado.
2. Para academicos, `sg_trca` identifica que el calculo es dinamico; el monto final se calcula por PA y se congela en `sg_fups`.
3. Para proyectos ANID/excepcionales, el sistema debe registrar la condicion de excepcion y no aplicar el limite DU288 general.

### 3.4 Compatibilidad con jornada del personal administrativo

Regla:

1. Las funciones asociadas a la asignacion deben realizarse fuera de la jornada ordinaria.
2. Si excepcionalmente se realizan dentro de la jornada, deben compensarse formalmente.

Impacto:

| Dato | Tabla/campo esperado |
| :--- | :--- |
| Dentro/fuera de jornada | `sg_fups.dentro_jor`. |
| Mes asociado | `sg_fume.id_funmes`. |
| Dia de compensacion | `sg_fuco.nro_dia`, asociado al mes. |
| Hora inicio/termino | `sg_fuco.hora_inicio`, `sg_fuco.hora_termino`. |

El sistema no necesita guardar cantidad manual de horas si puede calcularla desde hora inicio y hora termino.

### 3.5 Compatibilidad con jornada del personal academico

Para academicos, la actividad puede imputarse a jornada laboral si se relaciona con actividades reconocidas por el Reglamento de Evaluacion Academica.

Validaciones esperadas:

| Validacion | Tipo |
| :--- | :--- |
| Actividad SEA aplica/no aplica | PA o declaracion controlada. |
| No afecta carga academica regular | Validacion de etapa o declaracion responsable. |
| Financiamiento de reemplazo cuando corresponda | Validacion posterior/documental si aplica. |

### 3.6 Inhabilidades para percibir asignacion

No tienen derecho a la asignacion:

| Inhabilidad | Implementacion esperada |
| :--- | :--- |
| Rector/a | PA por cargo/tipo de cargo. |
| Vicerrectores/as | PA por cargo/tipo de cargo. |
| Contralor/a Universitario/a | PA por cargo/unidad. |
| Decanos/as | PA por cargo, con excepcion ANID/exterior reconocido. |
| Secretario/a General | PA por cargo. |
| Directivos administrativos | PA usando `sp_carg.cod_tipcar` o clasificacion oficial. |
| Personal de Contraloria Universitaria | PA por unidad/cargo. |
| Deuda no regularizada con la Universidad | PA de deudas. Rige desde 2027 segun disposicion transitoria. |

Excepciones:

| Excepcion | Regla |
| :--- | :--- |
| Directores/as de Institutos Independientes | Pueden percibir cuando la prestacion se relacione con funcion academica, con base anual definida. |
| Academicos con encomendacion de funciones directivas | No se inhabilitan si la prestacion se relaciona con su funcion academica. |
| Decanos/as en proyectos ANID/externos reconocidos | Permitido solo con certificacion DIUFRO/DITT. |

### 3.7 Distribucion del pago

Regla:

1. La asignacion por una misma actividad o proyecto solo puede prorratearse por maximo dos meses en cada ano calendario.
2. Para plazos superiores se debe usar contrato a honorarios con fondos del proyecto.
3. Excepcionalmente, DGDP puede autorizar distribucion mayor cuando el proyecto exige rendir gasto de personal mediante asignacion.

Impacto:

| Dato | Tabla/campo |
| :--- | :--- |
| Meses aprobados | `sg_fume`. |
| Cuotas generadas al formalizar | `sg_fucu`. |
| Estado de cuota | `sg_ecuo`. |
| Excepcion mas de dos meses | Requiere validacion/autorizacion de etapa. |

### 3.8 Procedencia cuando las labores son similares al contrato base

Para planta administrativa, puede autorizarse aun cuando las funciones sean similares al contrato base, siempre que exista autorizacion formal del jefe directo.

Impacto:

1. No bloquea automaticamente.
2. Debe gatillar requerimiento documental o aprobacion especifica en etapa de jefatura.
3. No requiere crear campo en `sg_fups` si se controla por flujo/aprobacion.

### 3.9 Formacion continua

No puede pagarse por DU288 la participacion en acciones de formacion continua, como postitulos, diplomados, cursos u otras acciones equivalentes.

Regla:

1. Si corresponde a formacion continua, debe usarse la modalidad de Prestacion de Servicios Docentes Especiales, no DU288.
2. En solicitud DU288 debe bloquearse o advertirse segun validacion del centro de costo/proyecto.

### 3.10 Periodos en que no se puede pagar

No corresponde pago durante:

| Periodo/condicion | Regla |
| :--- | :--- |
| Licencia medica | No pagar durante periodo afectado. |
| Permiso sin goce de sueldo | No pagar durante periodo afectado. |
| Despues del cierre del proyecto | No pagar. |
| Receso universitario | No pagar, salvo trabajo efectivo para el proyecto y costos asociados al proyecto. |

Estas validaciones pueden quedar para etapa de pago si los PA necesarios no estan disponibles en solicitud.

### 3.11 Cometidos funcionarios

Si el beneficiario debe realizar cometidos:

1. Se autorizan sin derecho a viatico, pasajes u otros gastos con cargo a presupuesto institucional.
2. Esos gastos deben cubrirse o reembolsarse por ingresos del centro de costo asociado.
3. Si se cubren con la misma asignacion, no procede pago diferenciado o reembolso.

Impacto:

1. No afecta directamente `sg_trca`.
2. Puede requerir control documental/presupuestario en pagos.

### 3.12 Control presupuestario

La disponibilidad debe verificarse antes de dictarse la resolucion que dispone el pago.

Reglas:

1. Debe existir centro de costo especifico asociado.
2. Debe contar con saldo disponible, sobregiro autorizado o capital de trabajo autorizado.
3. No puede usarse presupuesto estructural ni otros centros de costo ajenos al proyecto.
4. Aunque se apruebe la resolucion, el pago puede no proceder si al momento del pago no hay recursos.

Impacto:

| Momento | Validacion |
| :--- | :--- |
| Solicitud | Centro de costo vigente, responsable vigente, financiamiento compatible. |
| Visacion financiera | Disponibilidad/saldo/sobregiro/capital autorizado. |
| Pago | Nueva verificacion de disponibilidad antes de registrar en finanzas. |

### 3.13 Control posterior y respaldo

La DGDP controla cumplimiento durante o hasta cinco anos despues de finalizada la ejecucion.

Impacto:

1. Las evidencias y respaldos deben quedar trazables.
2. No toda evidencia debe vivir en la solicitud; la evidencia de ejecucion pertenece al pago/control.
3. La solicitud debe registrar lo comprometido y los datos base aprobados.

## 4. Datos que deben congelarse en `sg_fups`

| Dato | Motivo |
| :--- | :--- |
| `id_trca` | Saber que regla exacta estaba vigente al calcular. |
| `id_contrato` | Saber que contrato se uso para resolver cargo, jornada y tope. |
| `mto_haber_ref` | Base efectiva usada cuando aplica calculo por haberes. |
| `mes_haber_ref` | Mes anterior usado como referencia. |
| `mto_tope` / `mto_tope_mes` | Tope final aplicado al funcionario. |
| `f_calculo_tope` | Fecha en que se congelo el calculo. |
| `dentro_jor` | Determina si requiere compensacion. |
| `cod_estfun` | Estado individual del funcionario en la PDS. |

## 5. Datos que se calculan dinamicamente

| Validacion | Fuente esperada |
| :--- | :--- |
| Cargo habilitado | PA contra SISPER/cargo/tipo/unidad y excepciones. |
| Deuda vigente | PA de deudas. |
| Centro de costo vigente | PA FIN21/SECGEN. |
| Responsable vigente | PA centro de costo. |
| Financiamiento compatible | PA centro de costo. |
| Formacion continua | PA/regla centro de costo/proyecto. |
| Parentesco con jefe de proyecto | PA `sp_par1/sp_par2`. |
| Licencia/permiso/receso | PA futuros, principalmente etapa pago. |

## 6. Preguntas abiertas para cerrar con negocio/PA

1. Cual es la fuente oficial anual de los topes fijos para planta auxiliar, administrativa y tecnica: escala completa o resolucion exenta VRAF?
2. Para directores de Institutos Independientes, se parametrizara en `sg_trca` como regla especial anual o se resolvera por PA dedicado?
3. Como se identificara formalmente un proyecto ANID/externo reconocido por DIUFRO/DITT?
4. Que dato exacto identifica "personal de Contraloria Universitaria": cargo, unidad, centro de costo o combinacion?
5. La deuda no regularizada debe mostrarse antes de 2027 como advertencia o no se consulta hasta su vigencia normativa?
6. La autorizacion por labores similares al contrato base se resolvera con visacion de jefatura o con documento obligatorio?
7. La excepcion de mas de dos meses se controlara por estado/aprobacion DGDP o por documento adjunto?

## 7. Resumen de impacto sobre el modelo actual

| Tema | Decision |
| :--- | :--- |
| Topes por planta | `sg_trca` por grupo/planta, modalidad y vigencia. |
| Tope aplicado por funcionario | Congelar en `sg_fups`. |
| Jornada parcial | No prorratear tope fijo; proyectar remuneracion efectiva cuando el calculo sea academico/dinamico. |
| Inhabilidad por cargo | PA, no tabla local de cargos excluidos. |
| Compensacion | `sg_fuco` asociada al mes `sg_fume`, con dia y rango horario. |
| Evidencia de ejecucion | Pertenece a pago/control, no a solicitud PDS base. |
| Cuotas | Se generan desde meses aprobados al formalizar/archivar resolucion. |
| Disponibilidad presupuestaria | Debe validarse en solicitud/visacion y nuevamente en pago. |
