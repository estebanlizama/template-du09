# Certificación DU288 — 03/09/2026

## Contenido del paquete

La preparación para certificación reúne dos carpetas de scripts, sin mezclar la carga de datos con las definiciones de PA:

```text
certificacion_03_09_2026/
├── entrega/                       85 PA: 85 SQL + 85 TXT
├── datos_base/                     6 cargas: 6 SQL + 6 TXT
├── TABLAS_REQUERIDAS_DU288.txt       Estructuras y dependencias
└── README.md                      Alcance, orden y pendientes
```

Ambas carpetas contienen únicamente archivos SQL y TXT. Los archivos de trabajo y respaldos fuera de `certificacion_03_09_2026/` no forman parte del envío.

[Tablas involucradas en DU288](TABLAS_REQUERIDAS_DU288.txt) contiene únicamente información de las tablas: nombres, campos, tipos, nulabilidad, claves, relaciones y función de las tablas base y externas.

## Carpeta de entrega

`entrega/` es la única carpeta destinada al envío de PA: **85 SQL y 85 TXT**, sin subcarpetas ni documentos adicionales. Cada TXT contiene el mismo código que su SQL; son formatos alternativos, no dos scripts para ejecutar consecutivamente.

Incluye los PA disponibles para solicitud, funcionarios, validaciones, flujo, aprobaciones, resolución, firma, archivo e historial. La selección se revisó contra el código local del backend y sus consumidores, no contra una base de datos en ejecución. **El cierre de dependencias sigue pendiente** según la sección siguiente.

La carpeta anterior `solicitante/ENTREGA_PA_DU288_SOLI_02_09_2026` se trasladó aquí. Los SQL de trabajo siguen en `solicitante/`; no son otra entrega.

## Pendientes antes de considerar completo el paquete

| PA | Evidencia y acción pendiente |
| --- | --- |
| `sg_apresSecgen03` | La página `resolution-document-normative.vue` carga firmas con alcance mediante `resolution-base/selectSignatureWithScopeInfo` y `ResolutionRepository.getResolutionSignaturesWithScope`. No se encontró su SQL/TXT local: obtener la definición vigente y agregar ambos formatos. |
| `sg_solisSecgen19` | `ParametricRecordsRepository.getAnoProcessByResolution` se usa como respaldo para recuperar el año en operaciones compartidas de resolución/archivo. La copia histórica disponible contiene `COMMIT TRAN` sin `BEGIN TRAN`; no se incorporó esa versión sin validar. Obtener la definición vigente. |

Verificar también los PA de servicios comunes que ya deben existir en el ambiente. Por ejemplo, la descarga común de Archivo Universitario consulta `ar_doc1sSecgen02`, cuya definición no está disponible localmente. No se ha certificado aquí una instalación de SG-Solicitudes desde cero, ni se han reemplazado PA institucionales con definiciones supuestas.

`sg_prm1sSecgen01` sí se agregó: el servicio DU288 lo consume para obtener el año de proceso al generar la resolución. Se tomó la definición de `contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_prm1sSecgen01.sql`, conservando su consulta, transacción y permisos; solo se normalizó la presentación y se retiró el ejemplo comentado.

## PA fuera de esta entrega

Los siguientes nueve pares se conservaron en `solicitante/no_incluidos_du288/`, fuera de la carpeta de envío. No se eliminaron de la base de datos ni del código de la aplicación.

| PA | Motivo |
| --- | --- |
| `sg_eapriSecgen01` | Auxiliar de carga sin llamada desde la aplicación ni desde los PA entregados. El estado 11 se carga mediante `02_catalogos_estados_du288`. |
| `sg_fumesSecgen01`, `sg_fumeuSecgen01` | Consultas de meses/cuotas declaradas sin consumidores en el backend actual. DU288 no genera cuotas en la solicitud. |
| `sg_fupssSecgen01` | `selectStaffById` no tiene consumidores; la solicitud consulta su personal mediante `sg_fupssSecgen02`. |
| `sg_prsesSecgen10` | `selectResolutionsForRequestByRequestType` no tiene consumidores. |
| `sg_prsesSecgen06`, `sg_prsesSecgen07` | Métodos de consulta general/por estado sin llamadas desde el flujo actual. Las bandejas usan consultas específicas. |
| `sg_histsSecgen01` | Sin llamadas al método de historial PDS; mantiene consumidores en otros módulos. Se conservan los PA de historial usados por DU288. |
| `sg_apsosSecgen04` | Su método `selectBasicApproversRoleByRequestIdDBConn` no tiene consumidores. No confundirlo con el selector homónimo de firmantes, que usa `sg_apresSecgen01`. |

`sg_cctosSecgen06` continúa excluido por la revisión anterior: su consulta informativa no se invoca desde la pantalla DU288 actual. Su SQL de trabajo permanece en `solicitante/`.

Se mantienen `sg_eta1sSecgen03`, `sg_prsesSecgen20` y `sp_orcosSecgen01`: son dependencias internas de `sg_etasSecgen01`, aunque no tengan una llamada directa desde TypeScript. También se conserva `bd_pri2sSecgen01`, usado por la comprobación compartida de usuarios de Archivo Universitario.

## Carga de datos base

`datos_base/` incorpora los seis scripts de ambientación DU288 en SQL y TXT. Son copias idénticas de los archivos de trabajo en `maestros/certificacion_db_base_du288/`; no se modificaron sus datos, IDs ni lógica de carga. La carpeta fuente se conserva para mantenimiento, no para ejecutarla nuevamente junto con estas copias.

| Orden | Nombre base: disponible como `.sql` y `.txt` | Base y datos cargados |
| --- | --- | --- |
| 01 | `01_roles_permisos_du288` | `sistema_db`: perfiles, privilegios y asociaciones de permisos DU288 (`bd_per1`, `bd_prvg`, `bd_pepr`). |
| 02 | `02_catalogos_estados_du288` | `secgen_db`: tipo de solicitud, modalidad, periodicidad, estados y acciones (`sg_tsol`, `sg_tmod`, `sg_tpps`, `sg_esol`, `sg_eapr`, `sg_efun`, `sg_ersl`, `sg_tacc`). |
| 03 | `03_topes_cargo_du288` | `secgen_db`: topes normativos 2026 (`sg_toca`). |
| 04 | `04_plantilla_resolucion_du288` | `secgen_db`: secciones, plantilla y detalles de resolución (`sg_plse`, `sg_plre`, `sg_plde`). |
| 05 | `05_flujos_etapas_du288` | `secgen_db`: ocho flujos y sus 99 etapas (`sg_tfls`, `sg_eta1`). |
| 06 | `06_transiciones_flujo_du288` | `secgen_db`: 265 transiciones de workflow (`sg_eta2`), después del archivo 05. |

La carga abarca **15 tablas de SECGEN y 3 de Sistema**, exclusivamente para DU288. Actualiza registros existentes e inserta faltantes; no es una carga vacía ni una instalación completa de todos los módulos de SG-Solicitudes.

### Orden de aplicación en certificación

1. Resolver los PA pendientes indicados arriba y respaldar los datos que se actualizarán. Contrastar las estructuras, columnas, claves y permisos del ambiente con [TABLAS_REQUERIDAS_DU288.txt](TABLAS_REQUERIDAS_DU288.txt) antes de aplicar las cargas.
2. Ejecutar las cargas de `datos_base/` en orden **01 → 02 → 03 → 04 → 05 → 06**. Elegir SQL **o** TXT para cada carga, no ambos. El cliente debe reconocer `GO` y conservar la misma sesión entre los lotes de cada archivo, porque se utilizan tablas temporales.
3. Comprobar los resultados de cada carga antes de continuar. Los archivos no incluyen una transacción global ni reversión automática del paquete; ante errores, detener la secuencia y revisar el estado aplicado.
4. Instalar los PA de `entrega/`, respetando sus dependencias. En particular, `sg_eta1sSecgen03`, `sg_prsesSecgen20` y `sp_orcosSecgen01` deben estar disponibles antes de `sg_etasSecgen01`.
5. Validar el recorrido funcional solicitud → aprobación → resolución → firma → archivo.

### Requisitos que no se cargan automáticamente

Estas cargas no crean ni alteran estructuras permanentes. Deben comprobarse también `sg_parm` (correlativos), `sg_prm1` (año de proceso), los usuarios/autoridades institucionales y las dependencias de Finanzas, SISPER, UFRO y Archivo. No se inventan usuarios, correlativos ni datos externos; tampoco se crean solicitudes, cuotas o pagos de prueba.

Estructuras requeridas: [TABLAS_REQUERIDAS_DU288.txt](TABLAS_REQUERIDAS_DU288.txt), incluido en este paquete. Detalle de los maestros e IDs: [README de la fuente](../maestros/certificacion_db_base_du288/README_certificacion_du288.md); esta última referencia de trabajo se resuelve desde el repositorio.

Si se actualiza un maestro en la carpeta fuente, sincronizar nuevamente su SQL y TXT en `datos_base/` y comprobar que los cuatro archivos sean idénticos antes de enviar.

## Comprobaciones

`ar_doc1iSecgen10`, `ar_doc1sSecgen01` y `valida_saldo_cc_cs` se trasladaron sin modificar su contenido. Los demás archivos trasladados también conservan sus bytes originales. No se cambiaron SQL de trabajo, backend, frontend ni datos maestros.

Antes de subir: resolver los pendientes, comprobar esquema/datos/permisos de certificación y recorrer solicitud → aprobación → resolución → firma → archivo. Esta organización no ejecutó scripts ni realizó pruebas contra Sybase.
