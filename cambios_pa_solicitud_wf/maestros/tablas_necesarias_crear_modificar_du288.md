# Tablas necesarias para crear y modificar — DU288

Base: `diagrama_secgen.md`. Tipos y nulabilidad: `diagrama_secgen_actualizado.md`.

**Alcance: 12 tablas para crear si faltan y 3 tablas existentes para modificar.** Todas pertenecen a `secgen_db.dbo`, salvo las referencias externas indicadas. Las relaciones lógicas entre bases no implican crear FK ni duplicar tablas externas.

## 1. Crear: tablas de solicitud y workflow

### 1.1. `sg_tmod` — Modalidades de prestación

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_modprs` | `tinyint` | No |
| `des_modprs` | `varchar(60)` | No |

**PK:** `(cod_modprs)`.

| Relación | Origen | Destino |
|---|---|---|
| Referencia desde | `sg_prse.cod_modprs` | `sg_tmod.cod_modprs` |

### 1.2. `sg_efun` — Estados del funcionario

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_estfun` | `tinyint` | No |
| `des_estfun` | `varchar(60)` | No |

**PK:** `(cod_estfun)`.

| Relación | Origen | Destino |
|---|---|---|
| Referencia desde | `sg_fups.cod_estfun` | `sg_efun.cod_estfun` |

### 1.3. `sg_tfls` — Flujos de solicitud

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_flusol` | `tinyint` | No |
| `des_flusol` | `varchar(60)` | No |
| `abr_flusol` | `varchar(10)` | No |
| `vigente` | `char(1)` | No |
| `f_creacion` | `datetime` | Sí |
| `f_ultmodif` | `datetime` | Sí |

**PK:** `(cod_flusol)`.

| Relación | Origen | Destino |
|---|---|---|
| Referencia desde | `sg_eta1.cod_flusol` | `sg_tfls.cod_flusol` |

### 1.4. `sg_eta1` — Etapas del flujo

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_flusol` | `tinyint` | No |
| `cod_etapa` | `tinyint` | No |
| `des_etapa` | `varchar(100)` | No |
| `cod_sistem` | `char(2)` | No |
| `cod_modulo` | `varchar(8)` | No |
| `cod_perfil` | `smallint` | No |
| `est_final` | `char(1)` | Sí |
| `vigente` | `char(1)` | Sí |
| `cod_organi` | `int` | Sí |

**PK:** `(cod_flusol, cod_etapa)`.

| Relación | Origen | Destino |
|---|---|---|
| FK | `sg_eta1.cod_flusol` | `sg_tfls.cod_flusol` |
| Lógica, entre bases | `sg_eta1.(cod_sistem, cod_modulo, cod_perfil)` | `sistema_db.bd_per1.(cod_sistem, cod_modulo, cod_perfil)` |
| Lógica, entre bases | `sg_eta1.cod_organi` | `ufro_db.es_orga.cod_organi` |

### 1.5. `sg_eta2` — Transiciones entre etapas

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_flusol` | `tinyint` | No |
| `cod_etapa1` | `tinyint` | No |
| `cod_etapa2` | `tinyint` | No |
| `id_tipacc` | `tinyint` | No |
| `cod_estsol` | `tinyint` | Sí |

**PK:** `(cod_flusol, cod_etapa1, cod_etapa2)`.

| Relación | Origen | Destino |
|---|---|---|
| FK compuesta | `sg_eta2.(cod_flusol, cod_etapa1)` | `sg_eta1.(cod_flusol, cod_etapa)` |
| FK compuesta | `sg_eta2.(cod_flusol, cod_etapa2)` | `sg_eta1.(cod_flusol, cod_etapa)` |
| FK | `sg_eta2.id_tipacc` | `sg_tacc.id_tipacc` |
| FK | `sg_eta2.cod_estsol` | `sg_esol.cod_estsol` |

### 1.6. `sg_toca` — Topes por cargo y unidad

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_cargo` | `smallint` | No |
| `cod_unidad` | `char(8)` | No |
| `f_inicio` | `datetime` | No |
| `f_termino` | `datetime` | Sí |
| `mto_tope` | `int` | No |
| `vigente` | `char(1)` | Sí |

**PK:** `(cod_cargo, cod_unidad, f_inicio)`.

| Relación | Origen | Destino |
|---|---|---|
| Lógica, entre bases | `sg_toca.cod_cargo` | `sisper_db.sp_carg.cod_cargo` |
| Lógica, entre bases | `sg_toca.cod_unidad` | `ufro_db.es_unid.cod_unidad` |

### 1.7. `sg_fuho` — Horario semanal de ejecución

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `id_funprse` | `int` | No |
| `cod_diasem` | `tinyint` | No |
| `correlativ` | `tinyint` | No |
| `hora_ini` | `time(3)` | No |
| `hora_ter` | `time(3)` | No |

**PK:** `(id_funprse, cod_diasem, correlativ)`.

| Relación | Origen | Destino |
|---|---|---|
| FK | `sg_fuho.id_funprse` | `sg_fups.id_funprse` |

### 1.8. `sg_fuco` — Compensación registrada en la solicitud

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `id_funprse` | `int` | No |
| `fec_compro` | `datetime` | No |
| `hora_ini` | `time(3)` | No |
| `hora_ter` | `time(3)` | No |

**PK:** `(id_funprse, fec_compro)`.

| Relación | Origen | Destino |
|---|---|---|
| FK | `sg_fuco.id_funprse` | `sg_fups.id_funprse` |

`fec_compro` conserva la fecha y hora de inicio del tramo para permitir varias compensaciones en un mismo día.

### 1.9. `sg_his2` — Historial de estado del funcionario

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `id_funprse` | `int` | No |
| `f_visacion` | `datetime` | No |
| `rut_visado` | `char(9)` | No |
| `cod_estact` | `tinyint` | No |
| `cod_estnue` | `tinyint` | No |

**PK:** `(id_funprse, f_visacion)`.

| Relación | Origen | Destino |
|---|---|---|
| FK | `sg_his2.id_funprse` | `sg_fups.id_funprse` |

## 2. Crear: dependencias de consulta de prestaciones anteriores

Estas tres estructuras son necesarias porque `sg_fupssSecgen17` las consulta desde DU288. La solicitud no genera cuotas ni pagos en ellas.

### 2.1. `sg_ecuo` — Estados de cuota

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_estcuo` | `tinyint` | No |
| `des_estcuo` | `varchar(60)` | No |

**PK:** `(cod_estcuo)`.

| Relación | Origen | Destino |
|---|---|---|
| Referencia desde | `sg_fume.cod_estcuo` | `sg_ecuo.cod_estcuo` |

### 2.2. `sg_fume` — Cuotas y pagos

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `id_funprse` | `int` | No |
| `nro_cuota` | `tinyint` | No |
| `ano_prop` | `smallint` | No |
| `mes_prop` | `tinyint` | No |
| `cod_estcuo` | `tinyint` | No |
| `ano_ejec` | `smallint` | Sí |
| `mes_ejec` | `tinyint` | Sí |
| `mto_apagar` | `int` | Sí |
| `id_evidenc` | `int` | Sí |
| `val_licmed` | `char(1)` | Sí |
| `val_inabili` | `char(1)` | Sí |
| `val_singoce` | `char(1)` | Sí |
| `val_ciecc` | `char(1)` | Sí |
| `fec_valida` | `datetime` | Sí |
| `rut_autori` | `char(9)` | Sí |
| `fec_autori` | `datetime` | Sí |
| `fec_envrem` | `datetime` | Sí |
| `fec_pago` | `datetime` | Sí |
| `ano_pago` | `smallint` | Sí |
| `mes_pago` | `tinyint` | Sí |

**PK:** `(id_funprse, nro_cuota)`.

| Relación | Origen | Destino |
|---|---|---|
| FK | `sg_fume.id_funprse` | `sg_fups.id_funprse` |
| FK | `sg_fume.cod_estcuo` | `sg_ecuo.cod_estcuo` |

### 2.3. `sg_fuc2` — Compensación efectiva por cuota

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `id_funprse` | `int` | No |
| `nro_cuota` | `tinyint` | No |
| `fec_comrea` | `datetime` | No |
| `hora_ini` | `time(3)` | No |
| `hora_ter` | `time(3)` | No |

**PK:** `(id_funprse, nro_cuota, fec_comrea)`.

| Relación | Origen | Destino |
|---|---|---|
| FK compuesta | `sg_fuc2.(id_funprse, nro_cuota)` | `sg_fume.(id_funprse, nro_cuota)` |

## 3. Modificar: tablas existentes

Se agregan **16 atributos**. Se conservan las columnas, PK, índices y relaciones existentes; las siguientes relaciones son las incorporaciones del cambio.

### 3.1. `sg_prse` — Prestación de servicios

Agregar únicamente los siguientes atributos:

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_modprs` | `tinyint` | Sí |
| `cod_flusol` | `tinyint` | Sí |
| `cod_etapa` | `tinyint` | Sí |

**PK existente:** `(nro_solici)`.

| Relación | Origen | Destino |
|---|---|---|
| FK nueva | `sg_prse.cod_modprs` | `sg_tmod.cod_modprs` |
| FK compuesta nueva | `sg_prse.(cod_flusol, cod_etapa)` | `sg_eta1.(cod_flusol, cod_etapa)` |

### 3.2. `sg_fups` — Funcionario de la prestación

Agregar únicamente los siguientes atributos:

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_estfun` | `tinyint` | Sí |
| `dentro_jor` | `char(1)` | Sí |
| `cod_contra` | `int` | Sí |
| `mes_haber` | `tinyint` | Sí |
| `ano_haber` | `smallint` | Sí |
| `mto_haber` | `int` | Sí |
| `mto_tope` | `int` | Sí |
| `f_cal_tope` | `datetime` | Sí |
| `tot_cuotas` | `tinyint` | Sí |

**PK existente:** `(id_funprse)`.

| Relación | Origen | Destino |
|---|---|---|
| FK nueva | `sg_fups.cod_estfun` | `sg_efun.cod_estfun` |
| Lógica, entre bases | `sg_fups.(rut, cod_contra)` | `sisper_db.sp_cont.(rut_person, cod_contra)` |

`tot_cuotas` se conserva porque los PA actuales lo referencian; en DU288 se guarda `NULL`.

### 3.3. `sg_apso` — Tareas de aprobación

Agregar únicamente los siguientes atributos:

| Atributo | Tipo | Permite NULL |
|---|---|---|
| `cod_flusol` | `tinyint` | Sí |
| `cod_etapa` | `tinyint` | Sí |
| `rut_autori` | `char(9)` | Sí |
| `id_funprse` | `int` | Sí |

**PK existente:** `(nro_aproba)`.

| Relación | Origen | Destino |
|---|---|---|
| FK compuesta nueva | `sg_apso.(cod_flusol, cod_etapa)` | `sg_eta1.(cod_flusol, cod_etapa)` |
| FK nueva | `sg_apso.id_funprse` | `sg_fups.id_funprse` |

Las relaciones con `sg_eta1` son compuestas por flujo y etapa; se presentan normalizadas para corregir la agrupación inconsistente de la exportación.

`sg_fum2` queda fuera: no se encontró uso en el código DU288 revisado. Las tablas existentes sin cambios se reutilizan.

Referencia de uso: [catastro_cambios_y_uso_tablas_du288.md](catastro_cambios_y_uso_tablas_du288.md). La existencia efectiva de cada objeto debe comprobarse en el ambiente antes de crearlo o modificarlo.

