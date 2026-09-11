# Decisiones de Arquitectura: Calendario Institucional y Feriados

## 1. Visión General

El cálculo y la asignación de horarios de prestación de servicios debe coexistir con el calendario oficial de la Universidad de La Frontera. Para esto, se integró el repositorio institucional de feriados (`es_cfer`) con una clasificación precisa de efectos legales vs institucionales.

---

## 2. Estructura de la Tabla `es_cfer` y Procedimiento `es_cfersSecgen01`

El procedimiento `es_cfersSecgen01` consulta el calendario oficial para el rango de fechas del servicio:

```sql
/* Procedimiento : es_cfersSecgen01
   Entrada :
   @f_inicio   -> Fecha de inicio del periodo. (Obligatorio)
   @f_termino  -> Fecha de termino del periodo. (Obligatorio)
   
   Retorno :
   f_feriado   (datetime) -> Fecha institucional.
   cod_tipfer  (smallint) -> Codigo de tipo de fecha.
   des_tipfer  (varchar)  -> Descripcion normalizada del tipo.
*/
```

**Contrato implementado:** el PA consulta `ufro_db.dbo.es_cfer` por rango
inclusivo y solo retorna los tipos `1`, `2` y `3`. En el ambiente revisado
no existe o no está disponible `ufro_db.dbo.es_tipfer`; por eso
`des_tipfer` se resuelve dentro del PA con un `CASE cod_tipfer`. No se debe
restaurar un `JOIN` obligatorio a `es_tipfer` sin confirmar previamente la
existencia, propietario y permisos del objeto.

---

## 3. Tipología Trimodal de Feriados (`cod_tipfer`)

| `cod_tipfer` | Denominación | Naturaleza | Comportamiento en Sistema | Impacto en Compensaciones (`sg_fuco`) |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **Feriado Nacional** | Legal / Irrenunciable | **Bloquea ejecución y compensación** | **Estrictamente Prohibido.** No genera horas efectivas de ejecución y el SP `sg_fucoiSecgen01` rechaza la compensación. |
| **2** | **Feriado Universitario** | Institucional (UFRO) | **Informativo** | **Permitido.** Se muestra la etiqueta del tipo, sin bloquear ni descontar horas. |
| **3** | **Suspensión de Actividades Lectivas** | Institucional | **Informativo** | **Permitido.** Se muestra la etiqueta del tipo, sin bloquear ni descontar horas. |

---

## 4. Reglas de Validación en Base de Datos

### Validación en `sg_fucoiSecgen01` (Compensaciones):
Antes de insertar un registro de compensación horaria en `sg_fuco`, el procedimiento ejecuta la siguiente verificación:

```sql
IF EXISTS (
    SELECT 1
    FROM ufro_db.dbo.es_cfer c
    WHERE c.cod_tipfer = 1
      AND (
          datediff(day, c.f_feriado, @inicio_dt) = 0
          OR (
              datediff(day, @inicio_dt, @termino_dt) > 0
              AND datepart(hh, @hora_ter) * 60 + datepart(mi, @hora_ter) > 0
              AND datediff(day, c.f_feriado, @termino_dt) = 0
          )
      )
)
BEGIN
    SELECT 'Error: La fecha seleccionada corresponde a un feriado nacional y no admite compensacion' AS msg
    RETURN
END
```

> **Principio de Seguridad:** Nótese que el mensaje de error es semántico y no menciona nombres de tablas (`es_cfer`) ni columnas internas, cumpliendo el estándar OWASP.

---

## 5. Reglas de Visualización en Frontend (Nuxt / Vue)

1. **Cuadrícula Semanal (`StaffExecutionWeeklyGrid.vue`):**
   - Muestra el patrón de ejecución de lunes a viernes.
   - En cada día con tramos declara la fecha exacta de los feriados nacionales que lo afectan y las horas que no se consideran.
   - Los tipos 2 y 3 no descuentan horas ni bloquean la ejecución; se muestran como información solamente donde exista una fecha concreta que revisar.
2. **Cero Tablas Redundantes:**
   - Se eliminó la proyección estadística intermedia que listaba "Días excluidos: 0" o "Horas no ejecutadas: 0".
   - La información se presenta en el punto donde produce una decisión: tarjeta semanal de ejecución o día del calendario de compensación.
3. **Calendario de compensación:**
   - Un feriado nacional aparece identificado y deshabilitado para crear nuevos tramos.
   - Los tipos 2 y 3 muestran su descripción, pero permanecen habilitados.
   - Una compensación histórica que ahora cae en una fecha no habilitada continúa seleccionable exclusivamente para revisarla o eliminarla. Esto no habilita nuevos tramos en esa fecha.

---

## 6. Disponibilidad de la Fuente y Operación Cerrada (ADR-013, `APLICADO`)

El calendario solo es confiable cuando el frontend recibe una fuente explícita
(`database` o `fallback`) y no existe una carga o error pendiente.

El rango consultado corresponde al período individual de actividad del
funcionario cuando ambas fechas son válidas. Mientras ese período esté
incompleto, se utiliza temporalmente el período general de la solicitud. Cada
cambio de rango dispara una consulta forzada; las peticiones simultáneas del
mismo rango se consolidan para evitar duplicados.

| Estado | Comportamiento |
| :--- | :--- |
| Cargando | Se informa una sola vez antes de FUHO/compensación y las fechas no se habilitan. |
| Error | Se bloquean edición/guardado dependientes del calendario y se ofrece reintento. |
| Sin fuente confirmada | Se trata como estado no disponible; nunca equivale a «sin feriados». |
| Fuente `database` | Se usan las fechas retornadas por `es_cfersSecgen01`, incluso si la lista está vacía. |
| Fuente `fallback` | Solo se acepta cuando el PA no existe y el rango completo está cubierto por el respaldo estático; se informa su uso. |
| Fallback incompleto u otro error | El backend responde indisponibilidad y el flujo permanece bloqueado. |

Esta política corrige el caso en que el `01/01/2026` aparecía como
«Disponible» antes de terminar la consulta. La ausencia de datos todavía no es
evidencia de que el día sea hábil.

---

## 7. Impacto en Horas y Montos

* Solo `cod_tipfer = 1` se excluye del total de **horas efectivas esperadas**.
* Los tipos `2` y `3` conservan las horas programadas.
* Un feriado nacional no modifica por sí solo el monto autorizado, el tipo de
  pago ni las cuotas. Su efecto se limita a la ejecución efectiva y al total de
  horas que deben compensarse.
* Frontend, backend y PA deben validar nuevamente el calendario al guardar o
  enviar; la deshabilitación visual no reemplaza la autoridad del servidor.
