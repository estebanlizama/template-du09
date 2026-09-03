# Base de certificación DU288

Paquete de ambientación limitado a la Prestación de Servicios DU288. Los datos se separaron por ámbito y cada script tiene una copia `.txt` ejecutable con contenido idéntico.

## Catastro de estructura y uso

Resumen de tablas a crear/modificar, atributos y relaciones:
[Tablas necesarias para DU288](../tablas_necesarias_crear_modificar_du288.md).

La comparación entre el esquema anterior y el actualizado está en
[Catastro de cambios y uso de tablas DU288](../catastro_cambios_y_uso_tablas_du288.md).
Identifica las 67 tablas del esquema actualizado: 13 nuevas, 3 modificadas y 51 sin cambios.

Para conservar el código revisado se requieren 9 tablas nuevas propias de DU288
y 3 dependencias de consulta: `sg_fume`, `sg_ecuo` y `sg_fuc2`.
El PA `sg_fupssSecgen17` las consulta desde el comparador de prestaciones anteriores,
aunque la solicitud no genere cuotas ni pagos. Sus estructuras deben existir;
no corresponde generar filas de pago con este paquete.
`sg_fum2` queda fuera de las altas DU288 por no tener uso encontrado en el código revisado.

Los seis scripts de esta carpeta cargan datos en 15 tablas SECGEN y 3 de Sistema.
No sustituyen la revisión de estructura ni ambientan todos los controles existentes:
también deben comprobarse `sg_parm` (correlativos) y `sg_prm1` (año de proceso).
El catastro se basa en archivos locales; falta contrastarlo con los objetos instalados
en certificación.

## Archivos y orden de ejecución

| Orden | Ámbito | Archivo SQL | Tablas intervenidas |
|---:|---|---|---|
| 1 | Roles y permisos DU288 | `01_roles_permisos_du288.sql` | `sistema_db.dbo.bd_per1`, `bd_prvg`, `bd_pepr` |
| 2 | Catálogos y estados SECGEN | `02_catalogos_estados_du288.sql` | `sg_tsol`, `sg_tmod`, `sg_tpps`, `sg_esol`, `sg_eapr`, `sg_efun`, `sg_ersl`, `sg_tacc` |
| 3 | Topes normativos 2026 | `03_topes_cargo_du288.sql` | `sg_toca` |
| 4 | Plantilla de resolución | `04_plantilla_resolucion_du288.sql` | `sg_plse`, `sg_plre`, `sg_plde` |
| 5 | Flujos y etapas | `05_flujos_etapas_du288.sql` | `sg_tfls`, `sg_eta1` |
| 6 | Transiciones de workflow | `06_transiciones_flujo_du288.sql` | `sg_eta2` |

Los archivos `.txt` tienen el mismo nombre base y deben conservarse junto al SQL correspondiente para la entrega a certificación.

## IDs DU288 preservados

### Perfiles

Se ambientan únicamente los perfiles DU288 de `SG/SISSOLIC`:

`6`, `7`, `8`, `9`, `10`, `12`, `13`, `14`, `15`, `16`, `17`, `18`, `21`, `22`, `23`, `24`, `25`, `26`, `27`, `28`, `29`, `30`, `31` y `32`.

Los perfiles `9 financial_officer`, `21 chief_person` y `24 applicant_head`
se conservan como base de compatibilidad PDS, aunque no representen una etapa
propia dentro de las 99 etapas del motor DU288.

Los perfiles nuevos mantienen los IDs definidos:

| ID | Perfil |
|---:|---|
| 25 | `project_head` |
| 26 | `project_department_head` |
| 27 | `dean` |
| 28 | `comptroller_officer` |
| 29 | `vipre` |
| 30 | `ditt_director` |
| 31 | `institute_director` |
| 32 | `research_director` |

### Privilegios

Se ambientan solamente los privilegios PDS utilizados por DU288:

`65`, `66`, `67`, `68`, `69`, `70`, `71`, `81`, `83`, `84`, `85`, `86`, `87` y `91`.

El script carga la matriz completa esperada por rol. No elimina permisos institucionales que ya existan.

El privilegio `72` no se carga ni se asigna: en la base vigente corresponde a
`scientific-productivity-incentives-document-read`, por lo que pertenece a otro
ámbito funcional y no a Prestación de Servicios DU288.

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

`05_flujos_etapas_du288` carga los ocho flujos y sus 99 etapas. `06_transiciones_flujo_du288` carga las 265 transiciones correspondientes:

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

Las etapas conservan sus IDs y perfiles definidos. Los actores dinámicos `6`, `25` y `26`, junto con las autoridades dependientes de la unidad, mantienen `cod_organi = NULL`. Las autoridades institucionales fijas se cargan con los códigos vigentes documentados. El archivo 05 debe ejecutarse antes del 06.

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
- Las asociaciones de permisos se insertan solo si no existen.
- Los flujos, etapas y transiciones se actualizan cuando existen y se insertan cuando faltan.
- No se crean ni modifican estructuras de tablas.
- No se eliminan registros.
- Todos los scripts están preparados para Sybase ASE y usan los IDs previamente definidos para DU288.
