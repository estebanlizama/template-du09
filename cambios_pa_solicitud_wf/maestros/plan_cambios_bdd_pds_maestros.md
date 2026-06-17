# Plan de Cambios BDD - Solicitud PDS Fase 2

Este documento contiene solo el alcance de base de datos para la **solicitud PDS**: diagrama vigente, cambios estructurales y descripcion de tablas. No incluye perfilamiento, roles ni etapa de pagos.

El modelo se alinea con `bdd_maestros.md`, tomando solo las tablas que corresponden al flujo de solicitud PDS.

---

## 2. Modificaciones Estructurales

### 2.1 Diagrama vigente del flujo de solicitud PDS

> [!IMPORTANT]
> Este diagrama no incluye la etapa de pagos ni las tablas `sg_paso`, `sg_fucu` o `sg_pade`.

```mermaid
erDiagram
    %% =====================================================
    %% 1. Cabecera comun y trazabilidad existente
    %% =====================================================
    sg_tsol ||--o{ sg_soli : "cod_tipsol"
    sg_esol ||--o{ sg_soli : "cod_estsol"
    sg_rslc ||--o{ sg_soli : "ano_resolu/nro_resolu"
    sg_soli ||--o{ sg_apso : "nro_solici"
    sg_eapr ||--o{ sg_apso : "cod_estapr"

    %% =====================================================
    %% 2. Solicitud PDS: cabecera especifica
    %% =====================================================
    sg_soli ||--|| sg_prse : "PDS nro_solici"
    sg_tmod ||--o{ sg_prse : "id_modprse"

    %% =====================================================
    %% 3. Funcionarios, estado individual y periodos
    %% =====================================================
    sg_prse ||--o{ sg_fups : "nro_solici"
    sg_efun ||--o{ sg_fups : "cod_estfun"
    sg_fups ||--o{ sg_fume : "id_funprse"
    sg_fups ||--o{ sg_fuco : "id_funprse"

    %% =====================================================
    %% 4. Maestros y reglas propias de PDS
    %% =====================================================
    sg_tmod ||--o{ sg_caex : "id_modprse"
    sg_trca ||..o{ sg_fups : "id_trca"

    %% =====================================================
    %% 5. Evidencias PDS por funcionario
    %% =====================================================
    sg_tevi ||--o{ sg_fuev : "cod_tievi"
    sg_fups ||--o{ sg_fuev : "id_funprse"
    sg_fume ||..o{ sg_fuev : "id_funmes"

    %% =====================================================
    %% 6. Referencias externas logicas
    %% =====================================================
    es_ccto ||..o{ sg_prse : "cod_unifin/cod_ccto"
    sp_carg ||..o{ sg_fups : "cod_cargo"
    sp_carg ||..o{ sg_caex : "cod_cargo"
    sp_carg ||..o{ sg_trca : "cod_cargo"
    sp_par1 ||--o{ sp_par2 : "rut_parent"

    %% =====================================================
    %% Colores por tipo de tabla
    %% =====================================================
    classDef existing fill:#f1f3f4,stroke:#5f6368,stroke-width:1px
    classDef modified fill:#fef7e0,stroke:#b06000,stroke-width:2px
    classDef pds fill:#e6f4ea,stroke:#137333,stroke-width:2px
    classDef shared fill:#e0f2f1,stroke:#00796b,stroke-width:2px
    classDef external fill:#e8f0fe,stroke:#1a73e8,stroke-width:1px

    class sg_soli,sg_esol,sg_tsol,sg_rslc,sg_apso,sg_eapr existing
    class sg_prse,sg_fups modified
    class sg_fume,sg_fuco,sg_tmod,sg_caex,sg_trca,sg_efun pds
    class sg_fuev,sg_tevi pds
    class es_ccto,sp_carg,sp_par1,sp_par2 external

    %% =====================================================
    %% Entidades existentes reutilizadas
    %% =====================================================
    sg_soli {
        int nro_solici PK "EXISTENTE/COMUN"
        tinyint cod_tipsol FK "EXISTENTE"
        char rut_solici "EXISTENTE"
        datetime f_solicit "EXISTENTE"
        tinyint cod_estsol FK "EXISTENTE"
        datetime f_ultmodif "EXISTENTE"
        smallint ano_resolu FK "EXISTENTE"
        int nro_resolu FK "EXISTENTE"
        datetime f_creacion "EXISTENTE"
        smallint ano_proces "EXISTENTE"
    }

    sg_esol {
        tinyint cod_estsol PK "EXISTENTE"
        varchar des_estsol "EXISTENTE"
    }

    sg_tsol {
        tinyint cod_tipsol PK "EXISTENTE"
        varchar des_tipsol "EXISTENTE"
        tinyint nro_orden "EXISTENTE"
        char vigente "EXISTENTE"
    }

    sg_rslc {
        smallint ano_resolu PK "EXISTENTE"
        int nro_resolu PK "EXISTENTE"
        varchar respon_res "EXISTENTE"
        datetime f_resolucio "EXISTENTE"
        smallint id_planti "EXISTENTE"
        tinyint cod_estres FK "EXISTENTE"
        datetime f_archivad "EXISTENTE"
        char rut_archiv "EXISTENTE"
        int id_docum "EXISTENTE"
        varchar codigo_sdg "EXISTENTE"
        int num_resolu "EXISTENTE"
    }

    sg_apso {
        int nro_aproba PK "EXISTENTE"
        int nro_solici FK "EXISTENTE"
        char rut_usua "EXISTENTE"
        tinyint cod_estapr FK "EXISTENTE"
        text comentario "EXISTENTE"
        datetime f_aprobac "EXISTENTE"
        datetime f_creacion "EXISTENTE"
        datetime f_ultmodif "EXISTENTE"
    }

    sg_eapr {
        tinyint cod_estapr PK "EXISTENTE"
        varchar des_estapr "EXISTENTE"
    }

    %% =====================================================
    %% Entidades PDS modificadas
    %% =====================================================
    sg_prse {
        int nro_solici PK "PDS MODIFICADA"
        varchar actividad "PDS"
        datetime per_desde "PDS"
        datetime per_hasta "PDS"
        char rut_jefpro "PDS"
        smallint cod_unifin "PDS"
        smallint cod_ccto "PDS"
        varchar cc_global "PDS"
        varchar pry_global "PDS"
        tinyint id_modprse FK "PDS FASE 2"
    }

    sg_fups {
        int id_funprse PK "PDS MODIFICADA"
        int nro_solici FK "PDS"
        char rut "PDS"
        smallint cod_cargo "PDS"
        varchar cod_sitm "PDS"
        varchar itm_global "PDS"
        varchar motivo "PDS"
        tinyint periodos "PDS"
        decimal monto_mes "PDS"
        decimal mto_total "PDS"
        tinyint cod_moneda "PDS"
        int cod_tpps FK "PDS"
        datetime f_inicio "PDS"
        datetime f_termino "PDS"
        char dentro_jor "PDS FASE 2"
        int id_contrato "PDS FASE 2"
        smallint cod_estfun FK "PDS FASE 2"
        int id_trca FK "PDS FASE 2"
        varchar mes_haber_ref "PDS FASE 2"
        decimal mto_haber_ref "PDS FASE 2"
        decimal mto_tope_mes "PDS FASE 2"
        datetime f_calculo_tope "PDS FASE 2"
    }

    %% =====================================================
    %% Entidades PDS nuevas o confirmadas
    %% =====================================================
    sg_fume {
        int id_funmes PK "PDS FASE 2"
        int id_funprse FK "PDS FASE 2"
        tinyint nro_mes "PDS FASE 2"
        smallint anio "PDS FASE 2"
        char vigente "PDS FASE 2"
    }

    sg_fuco {
        int id_funcom PK "PDS FASE 2"
        int id_funprse FK "PDS FASE 2"
        tinyint nro_dia "PDS FASE 2"
        decimal can_horas "PDS FASE 2"
    }

    %% =====================================================
    %% Evidencias PDS por funcionario
    %% =====================================================
    sg_fuev {
        int id_funevi PK "PDS"
        int id_funprse FK "PDS"
        int id_funmes FK "PDS"
        smallint cod_tievi FK "PDS"
        int id_docum "PDS"
        char rut_carga "PDS"
        datetime f_carga "PDS"
        char vigente "PDS"
    }

    sg_tevi {
        smallint cod_tievi PK "PDS"
        varchar des_tievi "PDS"
        int id_docu "PDS"
        char vigente "PDS"
    }

    %% =====================================================
    %% Maestros PDS
    %% =====================================================
    sg_tmod {
        tinyint id_modprse PK "PDS FASE 2"
        varchar des_modprse "PDS FASE 2"
    }

    sg_caex {
        smallint cod_cargo PK "PDS FASE 2"
        tinyint id_modprse PK "PDS FASE 2"
    }

    sg_trca {
        int id_trca PK "PDS FASE 2"
        smallint cod_cargo "PDS FASE 2"
        tinyint id_modprse "PDS FASE 2"
        smallint ano_vigen "PDS FASE 2"
        datetime f_inicio "PDS FASE 2"
        datetime f_termino "PDS FASE 2"
        char cod_forcal "PDS FASE 2"
        decimal mto_tope "PDS FASE 2"
        char vigente "PDS FASE 2"
    }

    sg_efun {
        smallint cod_estfun PK "PDS FASE 2"
        varchar des_estfun "PDS FASE 2"
        char vigente "PDS FASE 2"
    }

    %% =====================================================
    %% Referencias externas logicas
    %% =====================================================
    es_ccto {
        smallint cod_ccto PK "EXTERNO FIN21"
        smallint cod_unifin PK "EXTERNO FIN21"
        char vigente "EXTERNO FIN21"
        char bloqueo "EXTERNO FIN21"
        varchar cc_global "EXTERNO FIN21"
        varchar pry_global "EXTERNO FIN21"
    }

    sp_carg {
        smallint cod_cargo PK "EXTERNO SISPER"
        varchar nom_cargo "EXTERNO SISPER"
        char vigente "EXTERNO SISPER"
    }

    sp_par1 {
        char rut_parent PK "EXTERNO SISPER"
        varchar ape_paterno "EXTERNO SISPER"
        varchar ape_materno "EXTERNO SISPER"
        varchar nombres "EXTERNO SISPER"
    }

    sp_par2 {
        char rut_person PK "EXTERNO SISPER"
        char rut_parent PK, FK "EXTERNO SISPER"
        smallint cod_parent "EXTERNO SISPER"
        char vigente "EXTERNO SISPER"
    }
```

---

## 3. Cambios y Descripcion de Tablas

### 3.1 `sg_prse` - Prestacion de servicios

**Accion:** modificar tabla existente.

**Objetivo:** representar la cabecera especifica de una PDS, usando `sg_soli` como cabecera comun.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `id_modprse` | `tinyint null` | Agregar | Modalidad de prestacion para separar DU288-D09/2026 del flujo legacy. |

Reglas:

1. `sg_prse.nro_solici` sigue siendo PK/FK hacia `sg_soli`.
2. `sg_prse` no debe guardar datos de pago.
3. La PDS queda habilitada para pagos solo despues de formalizarse.

### 3.2 `sg_fups` - Funcionario asociado a PDS

**Accion:** modificar tabla existente.

**Objetivo:** mantener los funcionarios asociados a la PDS y agregar datos requeridos para Fase 2, incluyendo la captura minima del tope aplicado al momento de registrar el funcionario.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `dentro_jor` | `char(1) null` | Agregar | Indica si la prestacion se ejecuta dentro de jornada. |
| `id_contrato` | `int null` | Agregar | Contrato SISPER asociado a la prestacion. |
| `cod_estfun` | `smallint null` | Agregar FK | Codigo de estado del funcionario dentro de la solicitud PDS. La descripcion se obtiene desde `sg_efun`. |
| `id_trca` | `int null` | Agregar FK | Registro de regla/tope aplicado desde `sg_trca`, cuando exista regla parametrizada. |
| `mes_haber_ref` | `varchar(10) null` | Agregar | Mes de haberes usado como referencia para calcular el tope cuando aplica remuneracion efectiva. |
| `mto_haber_ref` | `decimal(12,0) null` | Agregar | Total de haberes/remuneracion efectiva usado como base de calculo del tope. |
| `mto_tope_mes` | `decimal(12,0) null` | Agregar | Tope mensual final aplicado al funcionario al momento de registrar la solicitud. |
| `f_calculo_tope` | `datetime null` | Agregar | Fecha en que se calculo y congelo el tope mensual aplicado. |

Campos existentes que se reutilizan:

| Campo | Uso |
| :--- | :--- |
| `monto_mes` | Monto mensual aprobado PDS. |
| `mto_total` | Monto total aprobado PDS. |
| `cod_sitm` | Item/subitem presupuestario asociado. |
| `itm_global` | Item global presupuestario. |
| `cod_cargo` | Cargo para validaciones de tope e inhabilidad. |
| `cod_tpps` | Tipo/periodicidad existente del modelo actual. |

Reglas:

1. El estado del funcionario se controla con `cod_estfun`, no con un indicador `S/N`.
2. `cod_estfun` debe apuntar a la tabla maestra `sg_efun`; no se guarda la descripcion del estado directamente en `sg_fups`.
3. Si el funcionario queda en estado rechazado, excluido o no incorporable, no debe generar meses en `sg_fume`.
4. Solo funcionarios en estado habilitado/aprobado deben continuar a formalizacion PDS.
5. El registro no se elimina; queda como trazabilidad de la solicitud.
6. `mto_tope_mes` congela el tope mensual usado al momento de registrar el funcionario, para evitar que cambios futuros en `sg_trca` alteren la validacion historica.
7. `mes_haber_ref` y `mto_haber_ref` solo se informan cuando el calculo requiere remuneracion efectiva; para topes fijos pueden quedar `NULL`.
8. Validaciones como SEA, compensacion requerida, cargo habilitado, asignacion bloqueante y deuda se recalculan dinamicamente desde contrato, `sg_fuco`, `sg_caex`, PA09 y PA10.
9. Los datos de parentesco se validan contra SISPER (`sp_par1` / `sp_par2`); no se copian como atributos nuevos en `sg_fups` en esta etapa.

### 3.3 `sg_fume` - Meses de ejecucion PDS

**Accion:** crear/confirmar tabla PDS.

**Objetivo:** normalizar los meses de ejecucion aprobados por funcionario.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `id_funmes` | `int identity` | Crear PK | Identificador del mes aprobado. |
| `id_funprse` | `int` | Crear FK | Funcionario de la PDS. |
| `nro_mes` | `tinyint` | Crear | Numero del mes calendario de ejecucion. |
| `anio` | `smallint` | Crear | Anio del mes de ejecucion. |
| `vigente` | `char(1)` | Crear | Vigencia del periodo. |

Reglas:

1. Cada mes seleccionado para el funcionario genera un registro independiente en `sg_fume`.
2. `sg_fume` no guarda montos. El monto aprobado permanece en `sg_fups`.
3. `sg_fume` no guarda evidencias ni constancias; estas se registran en `sg_fuev`.
4. Si una evidencia o constancia corresponde a un mes especifico, `sg_fuev.id_funmes` apunta a `sg_fume.id_funmes`.
5. Si una evidencia aplica al funcionario completo, `sg_fuev.id_funmes` queda `NULL`.

### 3.4 `sg_fuco` - Compensacion horaria

**Accion:** crear tabla PDS.

**Objetivo:** registrar compensacion horaria para prestaciones ejecutadas dentro de jornada.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `id_funcom` | `int identity` | Crear PK | Identificador de compensacion. |
| `id_funprse` | `int` | Crear FK | Funcionario de la PDS. |
| `nro_dia` | `tinyint` | Crear | Dia registrado. |
| `can_horas` | `decimal(4,2)` | Crear | Cantidad de horas compensadas. |

### 3.5 `sg_fuev` - Evidencia y constancia por funcionario

**Accion:** crear/normalizar tabla PDS para evidencias y constancias comprometidas por funcionario.

**Objetivo:** guardar evidencias y constancias tipificadas, siempre asociadas a un funcionario de la prestacion.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `id_funevi` | `int identity` | Crear PK | Identificador de evidencia o constancia. |
| `id_funprse` | `int` | Crear FK | Funcionario de la prestacion. Obligatorio. |
| `id_funmes` | `int null` | Agregar FK | Mes de ejecucion asociado, si aplica. |
| `cod_tievi` | `smallint` | Agregar FK | Tipo de evidencia o constancia. |
| `id_docum` | `int null` | Crear | Documento en repositorio documental. |
| `rut_carga` | `char(9)` | Crear | Usuario que carga el documento. |
| `f_carga` | `datetime` | Crear | Fecha de carga. |
| `vigente` | `char(1)` | Agregar | Vigencia del respaldo. |

Reglas:

1. Toda evidencia debe estar asociada a `id_funprse`.
2. Si la evidencia corresponde a un mes especifico, debe informar `id_funmes`.
3. Si la evidencia aplica al funcionario completo, `id_funmes` queda `NULL`.
4. La evidencia nunca debe quedar solo a nivel de solicitud; siempre debe apuntar a `id_funprse`.
5. No se crea estado propio de evidencia en esta etapa.
6. La revision de la evidencia se controla por el estado de la solicitud o del funcionario, segun el punto del flujo PDS.

Campos descartados respecto a versiones previas:

| Campo | Motivo |
| :--- | :--- |
| `cod_estevi` | No se requiere estado documental independiente. |
| `des_evid` | El tipo se normaliza en `sg_tevi.des_tievi`. |
| `rut_funcio` | El funcionario se obtiene desde `sg_fuev.id_funprse -> sg_fups.rut`. |

### 3.6 `sg_tevi` - Tipo de evidencia

**Accion:** crear catalogo PDS.

**Objetivo:** clasificar evidencias y constancias.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `cod_tievi` | `smallint` | Crear PK | Tipo de evidencia/constancia. |
| `des_tievi` | `varchar(100)` | Crear | Descripcion del tipo. |
| `id_docu` | `int null` | Crear | Documento, plantilla o requisito documental asociado al tipo, si aplica. |
| `vigente` | `char(1)` | Crear | Vigencia del tipo. |

Datos iniciales esperados:

| `cod_tievi` | `des_tievi` | Uso esperado |
| :--- | :--- | :--- |
| `1` | Acta firmada | Documento firmado que respalda aprobacion, compromiso o conformidad. |
| `2` | Informe con evidencias | Informe de ejecucion con evidencias del trabajo realizado. |
| `3` | Base de datos entregada | Archivo, planilla o base de datos comprometida como entregable. |
| `10` | Constancia por licencia medica | Constancia firmada cuando existe licencia medica en el periodo. |
| `11` | Constancia por permiso | Constancia por permiso sin goce u otra condicion similar. |
| `12` | Constancia por receso | Constancia de trabajo efectivo durante receso universitario. |
| `13` | Constancia por ausencia | Constancia por ausencia u otra situacion especial. |
| `14` | Constancia/autorizacion por parentesco | Documento que permite continuar el flujo cuando existe parentesco validado/autorizado. |

### 3.7 `sg_tmod` - Modalidad de prestacion

**Accion:** crear tabla maestra PDS.

**Objetivo:** parametrizar modalidades de prestacion.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `id_modprse` | `tinyint` | Crear PK | Modalidad de prestacion. |
| `des_modprse` | `varchar(50)` | Crear | Descripcion de modalidad. |

Datos iniciales:

| id | Descripcion |
| :--- | :--- |
| `1` | Docentes Especiales |
| `2` | DU288-D09/2026 |

### 3.8 `sg_caex` - Cargos excluidos por modalidad

**Accion:** crear tabla de configuracion PDS.

**Objetivo:** parametrizar cargos no habilitados por modalidad de prestacion.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `cod_cargo` | `smallint` | Crear PK | Cargo excluido. |
| `id_modprse` | `tinyint` | Crear PK | Modalidad a la que aplica la exclusion. |

### 3.9 `sg_trca` - Reglas de tope por cargo

**Accion:** crear tabla maestra PDS.

**Objetivo:** definir la regla de tope mensual aplicable a cada cargo SISPER por modalidad, anio y rango de vigencia. La tabla permite versionar reajustes dentro del mismo anio y distinguir topes fijos, topes calculados, cargos excluidos y reglas especiales.

La carga inicial debe construirse cruzando:

1. `sisper_db.dbo.sp_carg`: identifica `cod_cargo`, `nom_cargo`, `cod_tipcar`, `cod_jerpla` y vigencia del cargo.
2. Escala de Remuneraciones vigente para el anio: entrega la remuneracion base de jornada completa por planta/grado.
3. Reglas DU288-D09/2026: define si el tope es fijo, porcentaje de remuneracion efectiva, exclusion o regla especial.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `id_trca` | `int identity` | Crear PK | Identificador unico de la regla/tope. |
| `cod_cargo` | `smallint` | Crear | Cargo SISPER al que aplica la regla. |
| `id_modprse` | `tinyint` | Crear | Modalidad de prestacion. Para DU288-D09/2026 usar `2`. |
| `ano_vigen` | `smallint` | Crear | Anio de referencia normativa o presupuestaria. |
| `f_inicio` | `datetime` | Crear | Fecha desde la cual aplica la regla/tope. |
| `f_termino` | `datetime null` | Crear | Fecha hasta la cual aplica la regla/tope. Si queda `NULL`, se considera vigencia abierta. |
| `cod_forcal` | `char(1)` | Crear | Forma de calculo: `F` fijo, `C` calculo por remuneracion efectiva, `E` excluido, `S` especial. |
| `mto_tope` | `decimal(12,0) null` | Crear | Monto tope mensual cuando la regla es fija. Para reglas calculadas, excluidas o especiales puede quedar `0` o `NULL`. |
| `vigente` | `char(1)` | Crear | Vigencia del registro. |

Valores esperados para `cod_forcal`:

| Codigo | Uso | Como se valida |
| :--- | :--- | :--- |
| `F` | Tope fijo configurado por planta/cargo. | Comparar monto mensual solicitado contra `mto_tope`. |
| `C` | Tope calculado con remuneracion efectiva. | Obtener remuneracion efectiva PA11 y aplicar la regla DU288 vigente. |
| `E` | Cargo excluido/no habilitado. | Bloquear o advertir segun regla de la modalidad. |
| `S` | Regla especial no resuelta solo con tabla. | Exigir PA/regla complementaria antes de aprobar. |

Reglas de carga inicial para DU288-D09/2026:

| Caso | Regla `sg_trca` | Campos clave |
| :--- | :--- | :--- |
| Academicos o cargos cuyo tope se calcula contra remuneracion efectiva | `cod_forcal = 'C'` | `mto_tope = 0` o `NULL`; el monto final se calcula con PA11 y se congela en `sg_fups.mto_tope_mes`. |
| Planta tecnica | `cod_forcal = 'F'` | `mto_tope = 621634` segun escala vigente para el rango `f_inicio`/`f_termino`. |
| Planta administrativa/profesional | `cod_forcal = 'F'` | `mto_tope = 553079` segun escala vigente para el rango `f_inicio`/`f_termino`. |
| Planta auxiliar | `cod_forcal = 'F'` | `mto_tope = 382519` segun escala vigente para el rango `f_inicio`/`f_termino`. |
| Honorarios (`cod_cargo = 0` o calidad honorarios) | `cod_forcal = 'E'` | No habilitado para DU288. |
| Rector, vicerrectores, contralor, decanos y otros cargos excluidos | `cod_forcal = 'E'` | Mantener ademas en `sg_caex` si se requiere bloqueo por modalidad. |
| Director instituto independiente u otra excepcion normativa | `cod_forcal = 'S'` | Requiere PA/regla complementaria anual. |

Notas de implementacion:

1. Debe existir una fila por `cod_cargo`, modalidad y rango de vigencia aplicable.
2. Un mismo cargo puede tener mas de una fila dentro del mismo anio si existe reajuste o cambio normativo durante el periodo.
3. Para topes fijos, `mto_tope` guarda el monto mensual aplicable.
4. Para topes calculados, `cod_forcal = 'C'` identifica que el monto se obtiene con PA11; el resultado final se guarda en `sg_fups.mto_tope_mes`.
5. La regla aplicable se busca por `cod_cargo`, `id_modprse`, fecha de solicitud/registro dentro de `f_inicio` y `f_termino`, y `vigente = 'S'`.
6. `sg_fups.id_trca` debe guardar el registro exacto de `sg_trca` usado para calcular/congelar el tope.
7. `sp_carg` debe seguir siendo la fuente del nombre/codigo del cargo; `sg_trca` solo parametriza la regla de tope aplicable.

### 3.10 `sg_efun` - Estado de funcionario PDS

**Accion:** crear tabla maestra PDS.

**Objetivo:** parametrizar en una tabla separada los estados individuales que puede tomar cada funcionario dentro de una solicitud PDS, permitiendo rechazo parcial sin afectar al resto de funcionarios.

| Campo | Tipo sugerido | Cambio | Uso |
| :--- | :--- | :--- | :--- |
| `cod_estfun` | `smallint` | Crear PK | Codigo de estado del funcionario en la PDS. |
| `des_estfun` | `varchar(100)` | Crear | Descripcion del estado. |
| `vigente` | `char(1)` | Crear | Vigencia del estado. |

Datos iniciales esperados:

| `cod_estfun` | `des_estfun` | Uso esperado |
| :--- | :--- | :--- |
| `1` | Pendiente de revision | Funcionario ingresado, pendiente de validacion. |
| `2` | Observado | Funcionario requiere correccion o antecedente adicional. |
| `3` | Aprobado | Funcionario cumple validaciones y puede continuar a formalizacion PDS. |
| `4` | Rechazado | Funcionario no puede continuar en esta PDS. |
| `5` | Excluido | Funcionario se retira de esta PDS sin eliminar el registro. |

Regla: si un funcionario queda `RECHAZADO` o `EXCLUIDO`, los demas funcionarios de la PDS pueden continuar su proceso.

---

## 4. Referencias Externas

| Tabla | Origen | Uso |
| :--- | :--- | :--- |
| `es_ccto` | FIN21 | Centro de costo, unidad financiera, vigencia, bloqueo, CC global y proyecto global. |
| `sp_carg` | SISPER | Cargo del funcionario, validacion de vigencia, cargos excluidos y topes. |
| `sp_par1` | SISPER | Persona relacionada para validacion de parentesco. |
| `sp_par2` | SISPER | Relacion de parentesco vigente entre funcionario y persona relacionada. |

---

## 5. Reglas Generales del Modelo PDS

1. `sg_soli` sigue siendo la cabecera comun de la solicitud.
2. `sg_prse` es la tabla hija especifica de PDS.
3. `sg_fups` mantiene los funcionarios de la PDS.
4. `sg_efun` controla el estado individual del funcionario dentro de la PDS.
5. `sg_fume` normaliza los meses por funcionario.
6. `sg_fuco` registra compensacion horaria cuando corresponde.
7. `sg_fuev` registra evidencias y constancias siempre por funcionario.
8. `sg_tevi` tipifica evidencias y constancias.
9. `sg_tmod`, `sg_caex` y `sg_trca` parametrizan reglas propias de Fase 2.
10. Las tablas externas se consultan como referencia logica y no se modifican.
11. El flujo de pagos queda fuera de este documento.
