# Base de certificación DU288

Paquete de ambientación limitado a la Prestación de Servicios DU288. Los datos se separaron por ámbito y cada script tiene una copia `.txt` ejecutable con contenido idéntico.

## Archivos y orden de ejecución

| Orden | Ámbito | Archivo SQL | Tablas intervenidas |
|---:|---|---|---|
| 1 | Roles y permisos DU288 | `01_roles_permisos_du288.sql` | `sistema_db.dbo.bd_per1`, `bd_prvg`, `bd_pepr` |
| 2 | Catálogos y estados SECGEN | `02_catalogos_estados_du288.sql` | `sg_tsol`, `sg_tmod`, `sg_tpps`, `sg_esol`, `sg_eapr`, `sg_efun`, `sg_ersl`, `sg_tacc` |
| 3 | Topes normativos 2026 | `03_topes_cargo_du288.sql` | `sg_toca` |
| 4 | Plantilla de resolución | `04_plantilla_resolucion_du288.sql` | `sg_plse`, `sg_plre`, `sg_plde` |
| 5 | Transiciones de workflow | `05_transiciones_flujo_du288.sql` | `sg_eta2` |

Los archivos `.txt` tienen el mismo nombre base y deben conservarse junto al SQL correspondiente para la entrega a certificación.

## IDs DU288 preservados

### Perfiles

Se ambientan únicamente los perfiles DU288 de `SG/SISSOLIC`:

`6`, `8`, `10`, `12`, `13`, `14`, `15`, `16`, `17`, `18`, `22`, `23`, `25`, `26`, `27` y `28`.

Los perfiles nuevos mantienen los IDs definidos:

| ID | Perfil |
|---:|---|
| 25 | `project_head` |
| 26 | `project_department_head` |
| 27 | `dean` |
| 28 | `comptroller_officer` |

### Privilegios

Se ambientan solamente los privilegios PDS utilizados por DU288:

`65`, `66`, `67`, `68`, `69`, `70`, `71`, `81`, `83`, `84`, `85`, `86` y `91`.

El script carga la matriz completa esperada por rol. No elimina permisos institucionales que ya existan.

### Catálogos SECGEN

- Tipo de solicitud: `sg_tsol.cod_tipsol = 1`.
- Modalidad normativa: `sg_tmod.cod_modprs = 2`.
- Periodicidad: `sg_tpps` códigos `1` y `2`.
- Estados de solicitud: `sg_esol` códigos `1` a `11`; no se carga `12 Agrupada` porque no pertenece a DU288.
- Estados de tarea: `sg_eapr` códigos `1` a `11`.
- Estados de funcionario: `sg_efun` códigos `1` a `5`.
- Estados de resolución: `sg_ersl` códigos `1`, `2`, `3` y `5` a `12`; no se inventa el código `4`.
- Acciones DU288: `sg_tacc` códigos `1` a `15`, `28` y `29`.

### Topes y plantilla

- Cargo de topes: `3120`.
- Unidades: `16100000`, `16110000`, `16120000`, `16130000`, `16140000` y `16150000`.
- Inicio de vigencia: `2026-01-01`.
- Plantilla: `sg_plre.id_planti = 7`.
- Sección: `sg_plse.cod_tipsec = 1`.
- Detalles: IDs `31` a `44`, conservando `44` para `CONSIDERANDO - 10` y `41`, `42`, `43` para `RESUELVO`.

### Workflow

`05_transiciones_flujo_du288` conserva los identificadores definidos para los ocho flujos:

| Flujo | Ámbito |
|---:|---|
| 1 | Facultad |
| 2 | Investigación |
| 3 | DITT |
| 4 | Instituto |
| 5 | VRAF |
| 6 | VRAC |
| 7 | VIPRE |
| 8 | VRIP |

La carga de `sg_eta2` exige que las filas institucionales correspondientes ya existan en `sg_tfls` y `sg_eta1`. El repositorio no contiene una carga aprobada y completa para recrear esas dos tablas desde cero; por eso no se inventaron perfiles, cargos ni etapas. Antes de ejecutar el archivo 05 se debe respaldar y validar esa configuración en certificación.

## Exclusiones deliberadas

Este paquete no contiene:

- estados o tablas del flujo de pagos, incluido `sg_ecuo`;
- tablas de Finanzas, SISPER, UFRO, Archivo u otros sistemas externos;
- perfiles o privilegios de otros módulos de Solicitudes;
- transacciones de prueba (`sg_soli`, `sg_prse`, `sg_fups`, tareas, historiales o resoluciones reales);
- usuarios personales en `sg_uspe` ni duplicación de perfiles en `sg_perf`.

En DU288, el actor dinámico se determina por la etapa y el RUT asignado en `sg_apso`. `sg_uspe` se reserva para roles globales institucionales y no debe poblarse con solicitantes, jefes de proyecto o jefaturas dinámicas.

## Comportamiento de los scripts

- Los catálogos, roles, privilegios, topes y plantilla se actualizan cuando el ID ya existe y se insertan cuando falta.
- Las asociaciones de permisos y transiciones se insertan solo si no existen.
- No se crean ni modifican estructuras de tablas.
- No se eliminan registros.
- Todos los scripts están preparados para Sybase ASE y usan los IDs previamente definidos para DU288.

