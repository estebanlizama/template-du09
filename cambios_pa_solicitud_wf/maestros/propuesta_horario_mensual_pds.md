# Propuesta: horario mensual de prestación de servicios

Buenas tardes Don Jaime, respecto a lo conversado, envío propuesta para revisar detalladamente la incorporación del horario de prestación de servicios por funcionario y por mes/cuota.

La propuesta considera registrar los tramos horarios en que se planifica ejecutar la prestación, permitiendo más de un tramo durante un mismo día. Esta información será independiente de la compensación horaria.

## Objetivo del cambio

Separar claramente las siguientes responsabilidades:

| Responsabilidad | Tabla propuesta |
|---|---|
| Identificar la solicitud PDS | `sg_prse` |
| Identificar al funcionario asociado | `sg_fups` |
| Identificar el mes/cuota de ejecución | `sg_fume` |
| Registrar el horario planificado de la PDS | Nueva `sg_fuho` |
| Registrar compensaciones por fecha y rango horario | `sg_fuco` |

El horario PDS no corresponde a una marcación ni a un registro de horas efectivamente trabajadas. Representa la planificación mensual informada en la solicitud.

## Tablas afectadas

| Tabla | Cambio | Objetivo |
|---|---|---|
| `sg_fups` | Sin cambio estructural adicional | Mantener el funcionario PDS y su condición de jornada (`dentro_jor`). |
| `sg_fume` | Se reutiliza como padre | Identificar el mes/cuota al que pertenece el horario. |
| `sg_fuho` | Nueva | Guardar uno o varios tramos horarios por día y por mes/cuota. |
| `sg_fuco` | Sin reutilización | Mantenerla separada para compensaciones con fecha calendario. |

## Relación propuesta

La relación se basa en la estructura vigente del diagrama actualizado:

```text
sg_prse
  └── sg_fups
        └── sg_fume (id_funprse, nro_cuota)
              └── sg_fuho (tramos horarios PDS)
```

En el diagrama actualizado, `sg_fume` identifica la cuota mediante la clave compuesta `(id_funprse, nro_cuota)`. Por lo tanto, `sg_fuho` debe mantener ambos campos como FK.

## Nueva tabla `sg_fuho`

| Columna | Tipo sugerido | Uso |
|---|---|---|
| `id_funprse` | `int` | Funcionario PDS asociado. |
| `nro_cuota` | `tinyint` | Mes/cuota de ejecución asociado. |
| `dia_semana` | `tinyint` | Día de la semana, de lunes a viernes. |
| `correlativo` | `tinyint` | Número del tramo dentro del día. |
| `hora_ini` | `time(3)` | Hora de inicio del tramo. |
| `hora_ter` | `time(3)` | Hora de término del tramo. |
| `vigente` | `char(1)` | Vigencia lógica del horario. |

La clave primaria propuesta es:

```text
(id_funprse, nro_cuota, dia_semana, correlativo)
```

La FK hacia `sg_fume` sería:

```text
(id_funprse, nro_cuota)
    -> sg_fume(id_funprse, nro_cuota)
```

## Ejemplo de registro

Para un funcionario y una cuota mensual:

| Día | Inicio | Término |
|---|---:|---:|
| Martes | 09:00 | 13:00 |
| Martes | 14:00 | 17:00 |
| Jueves | 09:00 | 13:00 |
| Jueves | 17:00 | 19:00 |

El sistema debe permitir dos o más tramos el mismo día. En este ejemplo, el martes tiene 7 horas planificadas, separadas en dos bloques.

## Reglas funcionales

1. El horario se registra por funcionario y por mes/cuota.
2. Se permiten múltiples tramos para un mismo día.
3. `hora_ter` debe ser posterior a `hora_ini`.
4. Los tramos de un mismo funcionario, cuota y día no pueden superponerse.
5. Solo se permiten días de lunes a viernes.
6. La cantidad total de horas se calcula a partir del rango horario; no se almacena como dato principal.
7. Si el horario cambia en otro mes, se registran los nuevos tramos en la cuota correspondiente.
8. No se deben crear registros de horario para funcionarios rechazados o excluidos.

## Diferencia con la compensación

| Horario PDS (`sg_fuho`) | Compensación (`sg_fuco`) |
|---|---|
| Planificación de la prestación. | Compensación del horario laboral. |
| Asociado a mes/cuota. | Asociada a una fecha calendario real. |
| Día de semana recurrente. | Año, mes y día específico. |
| Puede tener varios tramos por día. | Puede tener varios tramos por fecha, según el modelo definitivo. |
| No representa horas efectivamente trabajadas. | Registra el rango horario que se compensará. |

`sg_fuco` no debe reutilizarse para almacenar el horario PDS.

## Reglas según estamento y jornada

| Rol/estamento | Asigna horario PDS | Ejecuta PDS dentro de jornada | Registra compensación |
|---|---:|---:|---:|
| 0 - Sin estamento | Sí | No | No |
| 1 - Directivo | Sí | No | No |
| 2 - Académico | Sí | No | No |
| 3 - Administrativo (D) | Sí | Sí | Sí |
| 3 - Administrativo (F) | Sí | No | No |

La validación debe realizarse en backend utilizando la información del funcionario y el valor `dentro_jor` de `sg_fups`. El frontend solo debe reflejar la regla y habilitar o deshabilitar la sección de compensación.

## Alcance no incluido

Por el momento, esta propuesta no contempla registrar:

- marcación de entrada o salida;
- horas efectivamente ejecutadas;
- evidencia de desarrollo de la actividad;
- control de asistencia;
- modificación de la compensación horaria existente, salvo la necesaria para mantenerla separada.

La nueva información corresponde únicamente al horario planificado de la prestación.

Quedo atento a la revisión y a sus comentarios, especialmente respecto de la creación de `sg_fuho` y de la asociación mensual mediante `(id_funprse, nro_cuota)`.

Saludos cordiales.

