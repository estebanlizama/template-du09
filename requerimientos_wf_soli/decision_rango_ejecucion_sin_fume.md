# Decisión funcional: rango de ejecución PDS sin generación de `sg_fume`

**Fecha:** 2026-08-04  
**Ámbito:** Workflow de solicitud PDS D9 / DU288 / DU09  
**Estado:** Decisión funcional para incorporar al diseño de BDD, PA, backend y frontend.

## 1. Decisión

Durante la creación, tramitación, resolución y formalización de la prestación no se deben generar meses ni cuotas en `sg_fume`.

La solicitud debe registrar como fuente oficial:

- El rango aprobado de ejecución por funcionario.
- El monto total aprobado.
- El monto o referencia mensual cuando corresponda.
- El tope normativo congelado o la excepción formal aplicable.
- Las compensaciones horarias registradas en `sg_fuco`, cuando correspondan.

La resolución debe informar el rango de ejecución aprobado, pero no debe crear una cuota por cada mes incluido en ese rango.

## 2. Información que permanece en la solicitud

La información base por funcionario se mantiene en `sg_fups`:

| Campo | Uso esperado |
| :--- | :--- |
| `id_funprse` | Identificador del funcionario en la PDS. |
| `f_inicio` | Inicio aprobado de la ejecución. |
| `f_termino` | Término aprobado de la ejecución. |
| `mto_total` | Monto máximo total aprobado para el funcionario. |
| `monto_mes` | Valor o referencia mensual, si el cálculo lo requiere. |
| `mto_tope` | Tope congelado utilizado para las validaciones posteriores. |
| `id_contrato` | Contrato SISPER utilizado en la validación. |

La cantidad de meses contenidos en el rango no determina la cantidad de cuotas financieras.

## 3. Compensación horaria

`sg_fuco` continúa siendo la fuente de las fechas y rangos horarios de compensación.

Cada fecha de compensación debe cumplir:

```text
sg_fups.f_inicio <= sg_fuco.fec_compro <= sg_fups.f_termino
```

El mes que se presenta en pantalla para identificar la compensación se obtiene desde la fecha registrada en `sg_fuco`; no requiere una fila en `sg_fume`.

## 4. Resolución

La resolución debe mostrar por funcionario el periodo de ejecución, el monto total aprobado y las condiciones o topes aplicables.

La generación o firma de la resolución no debe:

- Crear cuotas de pago.
- Determinar automáticamente una cuota por mes.
- Insertar registros en `sg_fume`.
- Fijar el mes real en que Finanzas realizará el pago.

## 5. Ejemplo acordado

```text
Rango de ejecución: enero a abril
Valor referencial: $100 por mes
Monto total aprobado: $400
Cantidad de meses de ejecución: 4
Cantidad posterior de cuotas de pago: 2
```

La solicitud y la resolución conservan el rango y el total de $400. Las dos cuotas de $200 se crean posteriormente en el workflow de pago.

## 6. Impacto en la implementación actual

Se debe revisar y retirar del flujo de solicitud:

1. La ejecución de `sg_fumeuSecgen01` al crear o modificar funcionarios.
2. La consulta obligatoria de `sg_fumesSecgen01` para reconstruir la solicitud.
3. La generación automática de `nro_cuota` desde los meses seleccionados.
4. La dependencia frontend de `worker.months` o `installments` para definir cuotas.
5. Los cálculos que interpreten `periodos` como cantidad de cuotas de pago.

Los meses visibles pueden derivarse del rango de ejecución o de las fechas de `sg_fuco`, según el contexto.

## 7. Reglas de integridad

1. `f_inicio` debe ser menor o igual a `f_termino`.
2. El rango debe estar dentro de la vigencia de la actividad o proyecto.
3. Una modificación del rango después de la resolución requiere el mecanismo formal definido por negocio.
4. El monto total aprobado no puede ser alterado por una solicitud de pago.
5. Las cuotas y pagos posteriores siempre deben apuntar a `id_funprse` y a una PDS formalizada.

## 8. Criterios de aceptación

- Es posible registrar una prestación con cuatro meses de duración sin crear cuatro cuotas.
- La resolución se genera correctamente usando solo el rango aprobado.
- `sg_fuco` registra compensaciones dentro del rango sin depender de `sg_fume`.
- La cantidad de cuotas permanece sin definir hasta iniciar el workflow de pago.
- No se pierde el monto total aprobado ni el tope utilizado en la evaluación normativa.

## 9. Relación con pagos

La creación dinámica de cuotas, la selección del periodo cubierto y la validación del monto se documentan en:

[Decisión funcional: cuotas creadas en la solicitud de pago](../../template_wf_pagos/requerimientos_wf/decision_cuotas_creadas_en_pago.md)

