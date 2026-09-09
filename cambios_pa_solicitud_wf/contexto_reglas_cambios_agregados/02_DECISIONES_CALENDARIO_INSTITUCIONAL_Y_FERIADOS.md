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
   f_feriado   (datetime) -> Fecha del feriado.
   des_feriado (varchar)  -> Descripcion oficial.
   cod_tipfer  (smallint) -> Codigo de tipo de feriado.
   des_tipfer  (varchar)  -> Descripcion del tipo de feriado.
*/
```

---

## 3. Tipología Trimodal de Feriados (`cod_tipfer`)

| `cod_tipfer` | Denominación | Naturaleza | Comportamiento en Sistema | Impacto en Compensaciones (`sg_fuco`) |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **Feriado Nacional** | Legal / Irrenunciable | **Bloqueante** | **Estrictamente Prohibido.** El SP `sg_fucoiSecgen01` rechaza la asignación. |
| **2** | **Feriado Universitario** | Institucional (UFRO) | **Informativo** | **Permitido.** Se muestra advertencia visual pero no bloquea la asignación de horas. |
| **3** | **Suspensión de Actividades** | Administrativo (Receso) | **Informativo** | **Permitido.** Notifica al solicitante que no hay actividades académicas/administrativas regulares. |

---

## 4. Reglas de Validación en Base de Datos

### Validación en `sg_fucoiSecgen01` (Compensaciones):
Antes de insertar un registro de compensación horaria en `sg_fuco`, el procedimiento ejecuta la siguiente verificación:

```sql
IF EXISTS (
    SELECT 1 
    FROM es_cfer 
    WHERE f_feriado = @f_compensacion 
      AND cod_tipfer = 1
)
BEGIN
    SELECT 'La fecha seleccionada coincide con un feriado nacional no ejecutable' AS msg
    RETURN 1
END
```

> **Principio de Seguridad:** Nótese que el mensaje de error es semántico y no menciona nombres de tablas (`es_cfer`) ni columnas internas, cumpliendo el estándar OWASP.

---

## 5. Reglas de Visualización en Frontend (Nuxt / Vue)

1. **Cuadrícula Semanal (`StaffExecutionWeeklyGrid.vue`):**
   - Muestra las columnas de Lunes a Domingo con anchos fijos y scroll horizontal.
   - Si una fecha del calendario coincide con feriado nacional, se resalta con badge rojo (`badge-danger`).
   - Si coincide con feriado universitario o suspensión, se resalta con badge azul o ámbar (`badge-info` / `badge-warning`).
2. **Cero Tablas Redundantes:**
   - Se eliminó la proyección estadística intermedia que listaba "Días excluidos: 0" o "Horas no ejecutadas: 0".
   - El usuario solo necesita saber si un día específico está habilitado o deshabilitado al hacer clic.
