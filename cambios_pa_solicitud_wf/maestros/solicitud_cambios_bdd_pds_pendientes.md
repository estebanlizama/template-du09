# Solicitud de Cambios BDD PDS DU288-D09/2026 Pendientes

Este documento resume solo los cambios BDD pendientes o evolutivos necesarios para completar el flujo PDS DU288-D09/2026. No incluye cambios ya integrados, como `sg_prse.cod_modprs`, `sg_tmod`, `sg_efun` o los campos DU288 ya agregados a `sg_fups`.

## Diagrama Resumido

```mermaid
erDiagram
    %% sg_fups: tabla existente modificada - solo muestra el campo nuevo
    sg_fups {
        int id_trca FK "NUEVO - FK a sg_trca"
    }

    %% Tablas nuevas a crear (resaltadas en amarillo)
    sg_fume {
        int id_funmes PK
        int id_funprse FK
        tinyint nro_mes
        smallint anio
        char vigente
    }

    sg_fucu {
        int id_funcuo PK
        int id_funmes FK
        tinyint nro_cuota
        tinyint tot_cuotas
        decimal mto_cuota
        smallint cod_estcuo FK
        int id_docum
        datetime f_gencuo
        datetime f_pago
        datetime f_ultmodif
        char vigente
    }

    sg_ecuo {
        smallint cod_estcuo PK
        varchar des_estcuo
        char vigente
    }

    sg_fuco {
        int id_funcom PK
        int id_funprse FK
        smallint anio
        tinyint nro_mes
        tinyint nro_dia
        datetime hora_inicio
        datetime hora_termino
        char vigente
    }

    sg_trca {
        int id_trca PK
        tinyint cod_modprs
        smallint cod_cargo
        smallint cod_jerpln
        varchar cod_jerpla
        varchar cod_niv_gr
        char cod_unidad
        decimal mto_base_haber
        decimal pct_aplicado
        char cod_forcal
        decimal mto_tope
        smallint ano_vigen
        datetime f_inicio
        datetime f_termino
        char vigente
    }

    sg_trca |o--o{ sg_fups : "id_trca"
    sg_fups ||--o{ sg_fume : "id_funprse"
    sg_fups ||--o{ sg_fuco : "id_funprse"
    sg_fume ||--o{ sg_fucu : "id_funmes"
    sg_ecuo ||--o{ sg_fucu : "cod_estcuo"

    classDef newTable fill:#fff3cd,stroke:#e65100,stroke-width:2px,color:#4a1a00

    class sg_fume,sg_fucu,sg_ecuo,sg_fuco,sg_trca newTable
```

## Resumen de Tablas y Cambios a Pedir

| Tabla | Accion solicitada | Descripcion funcional | Motivo |
| :--- | :--- | :--- | :--- |
| `sg_fups` | Modificar | Funcionario asociado a la PDS. Ya existe, pero falta agregar la referencia a la regla de tope aplicada. | Permite saber que registro de `sg_trca` se uso para calcular/congelar el tope del funcionario. |
| `sg_fume` | Crear | Meses de ejecucion aprobados por funcionario PDS. | Normaliza los meses aprobados y permite generar cuotas por mes al formalizar la PDS. |
| `sg_fucu` | Crear | Cuota habilitada por mes aprobado del funcionario. | Deja preparado el registro consultable por pagos, sin crear aun la solicitud formal de pago. |
| `sg_ecuo` | Crear | Maestro de estados de cuota. | Parametriza estados de vida de cada cuota habilitada. |
| `sg_fuco` | Reemplazar/evolucionar estructura actual | Tramos de compensacion horaria por funcionario y fecha calendario real. | La estructura actual por `dia_semana` y `cant_horas` no permite registrar fecha exacta, cruce de anio/mes ni multiples tramos. |
| `sg_trca` | Crear | Maestro de reglas y topes DU288 por modalidad, cargo, jerarquia, nivel, unidad y vigencia. | Permite resolver topes fijos, calculados y especiales con trazabilidad historica. |

## Detalle de Atributos por Tabla

### `sg_fups` - Funcionario Asociado a PDS

| Atributo | Tipo sugerido | Null | Descripcion |
| :--- | :--- | :--- | :--- |
| `id_trca` | `int` | `NULL` | FK logica a `sg_trca.id_trca`. Identifica la regla/tope exacto aplicado al funcionario. |

### `sg_fume` - Meses de Ejecucion PDS

| Atributo | Tipo sugerido | Null | Descripcion |
| :--- | :--- | :--- | :--- |
| `id_funmes` | `int identity` | `NOT NULL` | PK. Identificador del mes aprobado. |
| `id_funprse` | `int` | `NOT NULL` | FK a `sg_fups.id_funprse`. Funcionario PDS asociado. |
| `nro_mes` | `tinyint` | `NOT NULL` | Numero de mes calendario aprobado, de 1 a 12. |
| `anio` | `smallint` | `NOT NULL` | Anio del mes de ejecucion aprobado. |
| `vigente` | `char(1)` | `NOT NULL` | Vigencia logica del mes aprobado. Valores esperados: `S` / `N`. |


### `sg_fucu` - Cuota Habilitada por Mes PDS

| Atributo | Tipo sugerido | Null | Descripcion |
| :--- | :--- | :--- | :--- |
| `id_funcuo` | `int identity` | `NOT NULL` | PK. Identificador de la cuota habilitada. |
| `id_funmes` | `int` | `NOT NULL` | FK a `sg_fume.id_funmes`. Mes aprobado desde el cual nace la cuota. |
| `nro_cuota` | `tinyint` | `NOT NULL` | Numero de cuota del funcionario dentro de la PDS. |
| `tot_cuotas` | `tinyint` | `NOT NULL` | Total de cuotas generadas para el funcionario dentro de la PDS. |
| `mto_cuota` | `decimal(19,2)` | `NOT NULL` | Monto de la cuota. Al formalizar la PDS debe quedar en `0`; el monto real se asigna en el flujo posterior de pago. |
| `cod_estcuo` | `smallint` | `NOT NULL` | FK a `sg_ecuo.cod_estcuo`. Estado actual de la cuota. |
| `id_docum` | `int` | `NULL` | Documento/evidencia asociado en etapa posterior de pago, si corresponde. |
| `f_gencuo` | `datetime` | `NOT NULL` | Fecha y hora de generacion de la cuota al formalizar/archivar la PDS. |
| `f_pago` | `datetime` | `NULL` | Fecha y hora en que la cuota queda pagada, si aplica. |
| `f_ultmodif` | `datetime` | `NOT NULL` | Fecha y hora de ultima actualizacion de la cuota. |
| `vigente` | `char(1)` | `NOT NULL` | Vigencia logica de la cuota. Valores esperados: `S` / `N`. |


### `sg_ecuo` - Estado de Cuota

| Atributo | Tipo sugerido | Null | Descripcion |
| :--- | :--- | :--- | :--- |
| `cod_estcuo` | `smallint` | `NOT NULL` | PK. Codigo de estado de cuota. |
| `des_estcuo` | `varchar(100)` | `NOT NULL` | Descripcion del estado de cuota. |
| `vigente` | `char(1)` | `NOT NULL` | Vigencia del estado. Valores esperados: `S` / `N`. |

Datos iniciales:

| cod_estcuo | des_estcuo | vigente |
| ---: | :--- | :--- |
| 1 | Generada | S |
| 2 | Disponible | S |
| 3 | Solicitada | S |
| 4 | Autorizada | S |
| 5 | Pagada | S |
| 6 | Rechazada | S |
| 7 | Bloqueada | S |

### `sg_fuco` - Compensacion Horaria por Fecha

| Atributo | Tipo sugerido | Null | Descripcion |
| :--- | :--- | :--- | :--- |
| `id_funcom` | `int identity` | `NOT NULL` | PK. Identificador del tramo de compensacion. |
| `id_funprse` | `int` | `NOT NULL` | FK a `sg_fups.id_funprse`. Funcionario PDS asociado. |
| `anio` | `smallint` | `NOT NULL` | Anio calendario real de la compensacion. |
| `nro_mes` | `tinyint` | `NOT NULL` | Mes calendario real de la compensacion, de 1 a 12. |
| `nro_dia` | `tinyint` | `NOT NULL` | Dia calendario real de la compensacion. |
| `hora_inicio` | `datetime` | `NOT NULL` | Hora de inicio del tramo compensado. En Sybase 12 puede usarse `datetime` usando la porcion horaria. |
| `hora_termino` | `datetime` | `NOT NULL` | Hora de termino del tramo compensado. En Sybase 12 puede usarse `datetime` usando la porcion horaria. |
| `vigente` | `char(1)` | `NOT NULL` | Vigencia logica del tramo. Valores esperados: `S` / `N`. |


### `sg_trca` - Reglas y Topes DU288

| Atributo | Tipo sugerido | Null | Descripcion |
| :--- | :--- | :--- | :--- |
| `id_trca` | `int identity` | `NOT NULL` | PK. Identificador de la regla/tope. |
| `cod_modprs` | `tinyint` | `NOT NULL` | Modalidad PDS. Para DU288-D09/2026 usar `2`. |
| `cod_cargo` | `smallint` | `NULL` | Cargo SISPER cuando la regla aplica a un cargo especifico. Ejemplo: `3120`. |
| `cod_jerpln` | `smallint` | `NULL` | Grupo/planta normalizada desde `sp_jpfu.cod_jerpln`. |
| `cod_jerpla` | `varchar(3)` | `NULL` | Jerarquia/planta especifica desde `sp_jpfu.cod_jerpla`. |
| `cod_niv_gr` | `varchar(3)` | `NULL` | Nivel/grado cuando la regla se amarra a escala especifica. |
| `cod_unidad` | `char(8)` | `NULL` | Unidad/instituto cuando el tope depende de unidad especifica. |
| `mto_base_haber` | `decimal(12,0)` | `NULL` | Total haber/base de calculo usada como referencia. |
| `pct_aplicado` | `decimal(5,2)` | `NULL` | Porcentaje aplicado sobre la base, cuando corresponde. |
| `cod_forcal` | `char(1)` | `NOT NULL` | Forma de calculo: `F` fijo, `C` calculado, `S` especial. |
| `mto_tope` | `decimal(12,0)` | `NULL` | Tope mensual final. Obligatorio para `F`; `NULL` para `C`. |
| `ano_vigen` | `smallint` | `NOT NULL` | Anio de vigencia normativa/presupuestaria. |
| `f_inicio` | `datetime` | `NOT NULL` | Fecha desde la cual aplica la regla. |
| `f_termino` | `datetime` | `NULL` | Fecha hasta la cual aplica la regla. `NULL` indica vigencia abierta. |
| `vigente` | `char(1)` | `NOT NULL` | Vigencia del registro. Valores esperados: `S` / `N`. |

Datos iniciales base:

| id_trca | cod_modprs | cod_cargo | cod_jerpln | cod_jerpla | cod_niv_gr | cod_unidad | mto_base_haber | pct_aplicado | cod_forcal | mto_tope | ano_vigen | f_inicio | f_termino | vigente |
| ---: | ---: | :--- | ---: | :--- | :--- | :--- | :--- | ---: | :--- | :--- | ---: | :--- | :--- | :--- |
| 1 | 2 | null | 7 | null | null | null | null | 50.00 | C | null | 2026 | 2026-01-01 | null | S |
| 2 | 2 | null | 7 | 01 | 1 | null | 4720149 | 50.00 | F | 2360075 | 2026 | 2026-01-01 | null | S |
| 3 | 2 | null | 7 | 02 | 4 | null | 3508060 | 50.00 | F | 1754030 | 2026 | 2026-01-01 | null | S |
| 4 | 2 | null | 7 | 03 | 7 | null | 2653174 | 50.00 | F | 1326587 | 2026 | 2026-01-01 | null | S |
| 5 | 2 | null | 7 | 04 | 11 | null | 1723206 | 50.00 | F | 861603 | 2026 | 2026-01-01 | null | S |
| 6 | 2 | null | 3 | null | null | null | 1243268 | 50.00 | F | 621634 | 2026 | 2026-01-01 | null | S |
| 7 | 2 | null | 4 | null | null | null | 1106158 | 50.00 | F | 553079 | 2026 | 2026-01-01 | null | S |
| 8 | 2 | null | 5 | null | null | null | 765038 | 50.00 | F | 382519 | 2026 | 2026-01-01 | null | S |
| 9 | 2 | 3120 | 1 | 11 | 156 | 16150000 | 5291266 | 35.00 | F | 1851943 | 2026 | 2026-01-01 | null | S |
| 10 | 2 | 3120 | 1 | 11 | 156 | pendiente | 5291266 | 50.00 | F | 2645633 | 2026 | 2026-01-01 | null | S |
| 11 | 2 | 3120 | 1 | 11 | 156 | pendiente | 5291266 | 48.50 | F | 2566751 | 2026 | 2026-01-01 | null | S |
| 12 | 2 | 3120 | 1 | 11 | 156 | pendiente | 5291266 | 48.30 | F | 2554357 | 2026 | 2026-01-01 | null | S |
| 13 | 2 | 3120 | 1 | 11 | 156 | pendiente | 5291266 | 46.70 | F | 2471469 | 2026 | 2026-01-01 | null | S |
| 14 | 2 | 3120 | 1 | 11 | 156 | pendiente | 5291266 | 45.30 | F | 2397930 | 2026 | 2026-01-01 | null | S |


