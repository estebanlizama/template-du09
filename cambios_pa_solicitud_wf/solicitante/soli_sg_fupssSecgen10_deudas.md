# Requerimientos de SP sg_fupssSecgen10 y Morosidad/Deudas del Funcionario

## Objetivo

Obtener el estado de morosidad y el detalle de deudas pendientes asociadas a un funcionario candidato a una solicitud de Prestación de Servicios Normativa (DU288).

Este Stored Procedure (SP) se ejecuta al consultar los datos de un funcionario para verificar que no mantenga deudas pendientes con la Universidad antes de autorizar su postulación (regla de negocio aplicable desde el 1 de enero de 2027).

---

## Parámetro de Entrada

| Parámetro | Tipo | Descripción |
| :--- | :--- | :--- |
| `@rut` | `char(9)` | RUT del funcionario, sin puntos, sin guion y con dígito verificador. |

---

## Mapeo de Campos (Variables y Racional)

Al no disponer de la estructura física final de la tabla de Cobranzas o Tesorería, se definen los siguientes campos necesarios que debe retornar el procedimiento almacenado para la integración con el Backend (LoopBack 4):

| Campo en SP (Sybase) | Propiedad Backend (LB4) | Descripción / Por qué se requiere |
| :--- | :--- | :--- |
| `rut` | `rut` | Identificador único del funcionario para asociación y control de la solicitud. |
| `flag_tiene_deuda` | `tieneDeuda` | Indicador consolidado ('S' o 'N') que determina de forma rápida si el funcionario posee deudas pendientes y bloquea la postulación. |
| `monto_deuda` | `montoDeuda` | Monto bruto adeudado de la obligación pendiente. |
| `concepto_deuda` | `conceptoDeuda` | Descripción o concepto de la deuda (ej. Matrícula, Fondo Solidario, Arancel, Pérdida de Bienes, etc.). |
| `anio_deuda` | `anioDeuda` | Año de origen del compromiso financiero. |
| `estado_deuda` | `estadoDeuda` | Estado administrativo de la deuda (ej. Vencida, Convenio Incumplido, Cobranza Judicial, etc.). |
| `fecha_vencimiento` | `fechaVencimiento` | Fecha límite en la que debió pagarse la obligación. |

---

## Reglas de Filtrado y Negocio (Base de Datos)

1. **Filtro de Obligaciones Pendientes:**
   - La consulta del SP debe retornar únicamente las deudas que se encuentren en estado de mora, vencidas o impagas. Se deben excluir explícitamente los compromisos financieros ya pagados, al día, condonados o regularizados.
2. **Determinación del Flag Consolidado:**
   - Si la consulta retorna una o más filas con montos impagos, el campo `flag_tiene_deuda` debe ser retornado como `'S'`.
   - Si el funcionario no posee registros de deudas pendientes en el sistema, el SP debe retornar una fila con `flag_tiene_deuda = 'N'` y el resto de los campos financieros en nulo o cero.
3. **Validación de Parámetro Obligatorio (Fail Fast):**
   - Si `@rut` no se especifica o está vacío, el SP retorna un mensaje descriptivo y detiene su ejecución inmediatamente.
4. **Ordenamiento de Resultados:**
   - Las deudas se deben ordenar cronológicamente de forma descendente por la fecha de vencimiento.

---
