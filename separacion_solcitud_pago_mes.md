Correcto. El ejemplo de resolución confirma que lo formalizado es:
El rango de ejecución.
El horario de la prestación.
El monto bruto total autorizado.
Las condiciones y validaciones normativas.
No aparecen meses de ejecución discretos, número de cuotas ni monto mensual distribuido. Por tanto, asociar la resolución con FUME sería innecesario y además impediría que ejecución y pago fueran independientes.
Separación definitiva
SOLICITUD / RESOLUCIÓN
- Rango de ejecución
- Horario FUHO
- Compensación FUCO
- Monto total autorizado
- Tope mensual calculado
- Disponibilidad presupuestaria

PAGO
- Mes efectivo de pago
- Una o más cuotas
- Monto de cada cuota
- Periodo ejecutado que respalda el pago
- Evidencias
- Validación final del tope mensual
En el ejemplo, el “Período en que se desarrolla o ejecuta” es del 1 al 15 de abril de 2026 y el monto total es $121.440, como se observa en [texto_resolucion_ejemplo.md (line 132)](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/reglas/ejemplo_resolucion/texto_resolucion_ejemplo.md:132).
Cambio en el cálculo de montos
Actualmente el frontend realiza este cálculo:
monto mensual = monto total / cantidad de meses seleccionados
Luego valida:
monto mensual <= tope mensual
Eso deja de ser correcto, porque supone una distribución igual entre meses de ejecución y pago. Está implementado en [PdsDu288RequestForm.vue (line 2518)](D:/trabajo_ufro_2026/sg-solicitudes-frontend/components/services-provision/PdsDu288RequestForm.vue:2518).
La nueva validación debería separar autorización y pago.
En la solicitud
Se debe ingresar:
mto_total = monto bruto total autorizado
mto_tope  = tope máximo mensual calculado
No se debe ingresar:
monto_mes
meses de pago
cantidad de cuotas
distribución mensual
Aunque no se creen cuotas, es posible validar si el total podría pagarse respetando el máximo de meses de pago permitido:
mínimo_meses_pago =
    CEILING(mto_total / mto_tope)
Regla general:
mínimo_meses_pago <= máximo_meses_pago_permitidos
Si la regla permite como máximo dos meses de pago:
monto_máximo_autorizable = mto_tope × 2
Ejemplos:
Total autorizado	Tope mensual	Mínimo de meses requeridos	Resultado
$400.000	$400.000	1	Válido
$700.000	$400.000	2	Válido
$900.000	$400.000	3	Rechazado, salvo excepción

Este cálculo es solo una validación normativa. No crea cuotas ni determina los meses efectivos de pago.
Para proyectos ANID u otra excepción formal:
Puede no aplicarse el tope monetario.
Puede permitirse más de dos meses.
Se debe guardar la regla o excepción aplicada.
Validación durante el pago
Cuando se cree una solicitud de pago se debe calcular:
saldo_total =
    monto_total_autorizado
  - monto_pagado
  - monto_vigente_en_trámite
cupo_disponible_mes =
    tope_aplicable_mes_pago
  - pagos_del_funcionario_en_ese_mes
  - pagos_vigentes_en_trámite_en_ese_mes
monto_máximo_pagable = MIN(
    saldo_total,
    cupo_disponible_mes,
    monto_habilitado_por_ejecución,
    saldo_presupuestario_disponible
)
Esto permite, por ejemplo:
Ejecución: enero a abril
Monto autorizado: $400.000
Tope mensual: $400.000

Pago 1 en abril: $200.000
Pago 2 en mayo:  $200.000
La ejecución dura cuatro meses, pero el pago se distribuye en dos meses distintos.
Si se agregan varias cuotas dentro de una misma solicitud y corresponden al mismo mes de remuneración, deben sumarse para validar el tope:
SUM(cuotas del mismo mes) <= tope mensual disponible
Por lo tanto, dividir artificialmente un pago en varias cuotas dentro del mismo mes no permite superar el tope.
Información que debe conservar sg_fups
Para el flujo DU288:
Campo	Uso
f_inicio	Inicio autorizado de ejecución
f_termino	Término autorizado de ejecución
mto_total	Monto máximo total autorizado
mto_tope	Tope mensual calculado
f_cal_tope	Fecha del cálculo
id_trca	Regla aplicada
mes_haber / ano_haber	Remuneración usada como referencia
mto_haber	Base utilizada para calcular el tope
cod_contra	Contrato evaluado

En la BDD vigente, `periodos` y `monto_mes` son `NOT NULL`. Por compatibilidad
se almacenan `periodos = 1` y `monto_mes = mto_total` para DU288, pero no se
utilizan para crear cuotas ni para determinar meses de pago. La fuente oficial
continúa siendo `mto_total`. `tot_cuotas` permanece nulo.
Totales de la solicitud
El cálculo general debe ser:
total_solicitud =
    SUM(sg_fups.mto_total de funcionarios vigentes)
Si DGDP excluye un funcionario:
total_vigente =
    SUM(mto_total de funcionarios que continúan activos)
No se debe calcular:
SUM(periodos × monto_mes)
Todavía existen cálculos antiguos de ese tipo en:
[resolution-document.vue (line 280)](D:/trabajo_ufro_2026/sg-solicitudes-frontend/pages/services-provision/_id/resolution-document.vue:280)
[resolution-format-normative.vue (line 456)](D:/trabajo_ufro_2026/sg-solicitudes-frontend/pages/services-provision/_id/resolution-format-normative.vue:456)
[index.vue (line 450)](D:/trabajo_ufro_2026/sg-solicitudes-frontend/pages/services-provision/_id/index.vue:450)
Todos deberían utilizar total o mto_total como fuente oficial.
Ajustes en la resolución
El ejemplo utiliza la columna “PERÍODO A PAGAR”, pero contiene realmente el rango de ejecución. Al separar ejecución y pago, recomiendo cambiarla por:
PERÍODO DE EJECUCIÓN
La plantilla actual tiene ese encabezado en [prse-resolution.document.html (line 484)](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/pdf/prse-resolution.document.html:484).
También convendría revisar jurídicamente estas expresiones:
Actual:
“para ser pagado con la remuneración del mes correspondiente”

Propuesta:
“para ser pagado con la remuneración del o de los meses que correspondan,
sujeto al cumplimiento de los topes y validaciones aplicables”
Y reemplazar:
“el monto propuesto no excede el límite máximo mensual”
por una redacción que permita un monto total autorizado superior a un solo tope mensual:
“la distribución mensual del pago deberá respetar el límite máximo
mensual aplicable”
Validaciones que permanecen en la resolución
Aunque se eliminen meses y FUME, se mantienen:
Rango del prestador dentro del rango general.
Rango cubierto por la vigencia contractual.
Actividad y proyecto vigentes.
FUHO válido y sin horarios superpuestos.
FUCO válido cuando corresponda.
Inhabilidades personales.
Regla del 50% o tope fijo.
Excepción ANID, si existe.
Disponibilidad presupuestaria.
Centro de costo habilitado.
Monto total mayor que cero.
Suma de montos por funcionario consistente.
Congelamiento de la regla y tope utilizados.
La solicitud debería comprometer presupuestariamente el mto_total completo. Posteriormente, cada pago valida nuevamente ingresos efectivos, saldo presupuestario y tope mensual.
Inconsistencia que debe corregirse
El documento actual de reglas indica que si la labor supera dos meses debe tramitarse mediante honorarios. Eso contradice la nueva decisión de permitir cuatro meses de ejecución pagados en dos meses.
La regla debe quedar reformulada como:
La ejecución puede abarcar un rango superior a dos meses.

La restricción general de dos meses corresponde a los meses efectivos
de pago o prorrateo, no a la duración de la ejecución.
Esto debe actualizarse en [reglas_restricciones_du288_d09.md (line 61)](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/reglas/reglas_restricciones_du288_d09.md:61).
En conclusión, el monto oficial de la resolución debe ser mto_total. El tope mensual se conserva como regla de control, pero la distribución y los meses efectivos se determinan en el pago. Así se elimina correctamente FUME sin perder las validaciones financieras.

## Estado de implementación — 2026-08-05

Aplicado en SG Solicitudes:

- DU288 registra rango de ejecución, FUHO, FUCO, monto total, tope y antecedentes de remuneración; no solicita meses ni genera FUME/cuotas.
- `periodos` y `monto_mes` utilizan valores de compatibilidad exigidos por la BDD; `tot_cuotas` queda nulo y no se crean cuotas.
- El monto total se valida contra el máximo general pagable en dos meses, conservando la excepción ANID a nivel de la solicitud.
- La resolución usa el rango de ejecución, el monto total y los tramos semanales de FUHO.
- FUCO se limita al rango autorizado y respeta la estructura vigente, que permite un solo tramo por fecha.
- Se prepararon los PA Sybase sin incorporar columnas nuevas a `sg_fuco`.

Pendiente fuera de este repositorio:

- Implementar en la aplicación de pagos la creación de cuotas, selección de periodos cubiertos, evidencias y validación transaccional de saldo/tope. En este workspace solo existe su especificación/prototipo, no el backend/frontend productivo de pagos.
