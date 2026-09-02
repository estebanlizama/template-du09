# Catastro de cambios y uso de tablas SECGEN — DU288

Fecha de revisión: 2026-09-02.

## 1. Resultado para decidir qué incorporar

La comparación documental pasa de **54 a 67 tablas**: **13 nuevas, 3 existentes modificadas, 51 sin cambios y ninguna eliminada**. En las tres modificadas se agregan **16 columnas**; no se eliminan columnas ni se cambian sus tipos respecto del archivo anterior.

Para actualizar un ambiente que ya tiene el esquema anterior y mantener el código revisado:

- incorporar **9 tablas nuevas propias de solicitud/workflow DU288**;
- conservar o incorporar **3 tablas nuevas de pagos consultadas desde DU288**: `sg_fume`, `sg_ecuo` y `sg_fuc2`;
- modificar **3 tablas existentes**: `sg_prse`, `sg_fups` y `sg_apso`;
- dejar **`sg_fum2` fuera de las incorporaciones de este paquete**: no se encontró consumidor en el código ni en los PA de solicitud revisados;
- reutilizar los maestros, transacciones y controles comunes existentes. No copiar las 67 tablas como si todas fueran nuevas.

**No generar pagos en DU288 no equivale a poder omitir físicamente sus tablas.** El formulario consulta prestaciones anteriores mediante `sg_fupssSecgen17`, que hace `LEFT JOIN` a `sg_fume`, `sg_ecuo` y `sg_fuc2`. El join admite tablas sin filas; requiere que las tablas existan. Para prescindir de ellas habría que cambiar primero ese contrato de consulta y sus consumidores.

Este catastro verifica archivos locales, no la base desplegada. “Nueva” significa ausente del primer diagrama, no necesariamente ausente de certificación. Antes de emitir DDL hay que contrastar el catálogo real y los PA instalados. No se ejecutó SQL contra una base de datos durante esta revisión.

## 2. Fuentes y criterio de uso

- Esquema anterior: [diagrama_secgen.md](D:/trabajo_ufro_2026/contexto_prestacion_servicios/diagrama_pre_wf/diagrama_secgen.md).
- Esquema actualizado: [diagrama_secgen_actualizado.md](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md).
- SQL vigente de solicitud y copia de entrega: [sg_fupssSecgen17.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupssSecgen17.sql) y su carpeta `ENTREGA_PA_DU288`.
- Backend: consultas Sybase, repositorios, servicio de workflow y controladores bajo `sg-solicitudes-backend/src`.
- Frontend: formulario DU288 y store de prestaciones.
- PA históricos de otros módulos: `contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp`. Su presencia acredita una dependencia documentada, no que ese PA esté instalado o que una ruta se ejecute en producción.
- Catastro operativo y fuentes externas: [catastro_tablas_certificacion_pds_du288.md](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/catastro_tablas_certificacion_pds_du288.md).
- Carga de datos de certificación: [README_certificacion_du288.md](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/certificacion_db_base_du288/README_certificacion_du288.md).

La búsqueda distingue referencias ejecutables, llamadas a PA y dependencias FK. No considera una propuesta Markdown, una definición de modelo, un comentario o una prueba como prueba suficiente de uso real. Tampoco considera la ausencia de un nombre en TypeScript como ausencia de uso: muchas tablas se leen dentro de PA.

## 3. Las 13 tablas nuevas

| Tabla | Función | Decisión para el código actual | Evidencia |
|---|---|---|---|
| [sg_ecuo](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:91) | Estados de cuota | Dependencia de consulta; estructura necesaria, sin carga de pagos en 01–06. | [sg_fupssSecgen17.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupssSecgen17.sql) |
| [sg_efun](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:105) | Estados de funcionario | Incorporar; cargar catálogo en 02. | [sg_fupsiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupsiSecgen01.sql) |
| [sg_tfls](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:321) | Flujos | Incorporar; configurar en 05. | [sg_flusSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_flusSecgen01.sql) |
| [sg_tmod](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:353) | Modalidades | Incorporar; cargar modalidad DU288 en 02. | [sg_prseiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_prseiSecgen01.sql) |
| [sg_toca](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:367) | Topes | Incorporar; cargar reglas en 03. | [sg_tocasSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_tocasSecgen01.sql) |
| [sg_eta1](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:444) | Etapas | Incorporar; configurar en 05. | [sg_eta1sSecgen03.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_eta1sSecgen03.sql) |
| [sg_eta2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:466) | Transiciones | Incorporar; configurar en 06. | [sg_eta2sSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_eta2sSecgen01.sql) |
| [sg_his2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1145) | Historial individual | Incorporar; filas creadas condicionalmente por el PA. | [sg_fupsuSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupsuSecgen01.sql) |
| [sg_fuco](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1217) | Compensación de solicitud | Incorporar; filas desde aplicación cuando corresponde compensar. | [sg_fucoiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fucoiSecgen01.sql) |
| [sg_fuho](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1234) | Horario semanal | Incorporar; filas desde aplicación. | [sg_fuhosiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fuhosiSecgen01.sql) |
| [sg_fume](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1252) | Cuotas/pagos históricos | Dependencia de consulta y limpieza legacy; no generar cuotas en solicitud. | [sg_fupssSecgen17.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupssSecgen17.sql) |
| [sg_fuc2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1286) | Compensación efectiva por cuota | Dependencia de lectura del comparador; no confundir con sg_fuco. | [sg_fupssSecgen17.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupssSecgen17.sql) |
| [sg_fum2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1304) | Historial de cuotas | Diferir; sin uso encontrado en backend, frontend ni PA de solicitud revisados. | Solo esquema; sin consumidor localizado. |

## 4. Las tres tablas modificadas

Todas las columnas agregadas son anulables en el diagrama actualizado. Se conservan las PK e índices de estas tres tablas.

| Tabla | Columnas agregadas, con tipo | Uso comprobado |
|---|---|---|
| [sg_prse](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:981) | `cod_modprs tinyint NULL`; `cod_flusol tinyint NULL`; `cod_etapa tinyint NULL` | Modalidad y posición del workflow; sg_prseiSecgen01 y sg_prseuSecgen02. |
| [sg_fups](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1106) | `cod_estfun tinyint NULL`; `dentro_jor char(1) NULL`; `cod_contra int NULL`; `mes_haber tinyint NULL`; `ano_haber smallint NULL`; `mto_haber int NULL`; `mto_tope int NULL`; `f_cal_tope datetime NULL`; `tot_cuotas tinyint NULL` | Estado, jornada, contrato y captura de tope; sg_fupsiSecgen01 / sg_fupsuSecgen01. tot_cuotas se mantiene por compatibilidad y se escribe NULL en DU288. |
| [sg_apso](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1186) | `cod_flusol tinyint NULL`; `cod_etapa tinyint NULL`; `rut_autori char(9) NULL`; `id_funprse int NULL` | Etapa de la tarea, actor que autoriza y funcionario opcional; sg_apsoiSecgen01 / sg_apsouSecgen03. |

También cambian las FK documentadas:

| Tabla | Relación que se agrega | Relación existente |
|---|---|---|
| `sg_prse` | Modalidad → `sg_tmod`; flujo/etapa → `sg_eta1`. | La FK a `sg_soli` conserva significado; cambia de nombre. |
| `sg_fups` | Estado → `sg_efun`. | Las FK a `sg_prse` y `sg_tpps` conservan significado; cambian de nombre. |
| `sg_apso` | Flujo/etapa → `sg_eta1`; funcionario → `sg_fups`. | La FK a `sg_soli` conserva significado; cambia de nombre. |

**El diagrama no es una migración lista para ejecutar.** Exporta las FK de `sg_apso` hacia la PK compuesta de `sg_eta1` como dos relaciones de una sola columna. En `sg_eta2` también aparecen relaciones mal agrupadas. Hay que validar la estructura real y expresar:

```text
sg_apso(cod_flusol, cod_etapa)  -> sg_eta1(cod_flusol, cod_etapa)
sg_eta2(cod_flusol, cod_etapa1) -> sg_eta1(cod_flusol, cod_etapa)
sg_eta2(cod_flusol, cod_etapa2) -> sg_eta1(cod_flusol, cod_etapa)
```

El resto de las 51 tablas se conserva igual en los dos archivos; eso no prueba que sus datos sean iguales. Los scripts 01–06 cambian datos, no el esquema.

## 5. Inventario de uso: núcleo y controles DU288 (28 tablas)

“Carga” remite al número del script de certificación. “No” significa sin carga maestra: las filas las genera la aplicación. “Revisión” significa reutilizar y comprobar datos existentes, sin inventar correlativos ni año.

| Tabla | Cambio de esquema | Grupo | Uso | Carga | Evidencia |
|---|---|---|---|---|---|
| [sg_tsol](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:427) | Sin cambios | Catálogo | Tipo de solicitud PDS; cargar solo código 1. | 02 | [sg_prsesSecgen13.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_prsesSecgen13.sql) |
| [sg_esol](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:147) | Sin cambios | Catálogo | Estados de solicitud y resultados de transición. | 02 | [sg_eta2sSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_eta2sSecgen01.sql) |
| [sg_tmod](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:353) | Nueva | Catálogo | Modalidad normativa 2 frente a modalidad legacy. | 02 | [sg_prseiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_prseiSecgen01.sql) |
| [sg_efun](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:105) | Nueva | Catálogo | Estado del funcionario; padre de sg_fups. | 02 | [sg_fupsiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupsiSecgen01.sql) |
| [sg_eapr](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:49) | Sin cambios | Catálogo | Estados de tareas y firmas. | 02 | [sg_apsoiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_apsoiSecgen01.sql) |
| [sg_tacc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:279) | Sin cambios | Catálogo | Acciones de transición e historial. | 02 | [sg_eta2sSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_eta2sSecgen01.sql) |
| [sg_tpps](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:399) | Sin cambios | Catálogo | Tipo de prestación; FK vigente desde sg_fups. | 02 | FK en el diagrama actualizado. |
| [sg_ersl](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:133) | Sin cambios | Catálogo | Estado de resolución; FK vigente desde sg_rslc. | 02 | FK en el diagrama actualizado. |
| [sg_tfls](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:321) | Nueva | Configuración | Ocho flujos del motor DU288. | 05 | [sg_flusSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_flusSecgen01.sql) |
| [sg_eta1](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:444) | Nueva | Configuración | Etapas, perfiles y cargos responsables. | 05 | [sg_eta1sSecgen03.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_eta1sSecgen03.sql) |
| [sg_eta2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:466) | Nueva | Configuración | Acción, etapa destino y estado resultante. | 06 | [sg_eta2sSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_eta2sSecgen01.sql) |
| [sg_toca](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:367) | Nueva | Configuración | Topes por cargo, unidad y vigencia. | 03 | [sg_tocasSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_tocasSecgen01.sql) |
| [sg_plse](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:251) | Sin cambios | Plantilla | Secciones para plantilla y resolución. | 04 | [sg_prsesSecgen10.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_prsesSecgen10.sql) |
| [sg_plre](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:529) | Sin cambios | Plantilla | Cabecera de plantilla DU288, ID 7. | 04 | [sg_prsesSecgen10.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_prsesSecgen10.sql) |
| [sg_plde](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:957) | Sin cambios | Plantilla | Texto y variables de la plantilla. | 04 | [sg_pldesSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_pldesSecgen01.sql) |
| [sg_soli](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:595) | Sin cambios | Transacción | Cabecera común de solicitud; generada por aplicación. | No | [sg_soliiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_soliiSecgen01.sql) |
| [sg_prse](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:981) | Modificada | Transacción | Prestación, modalidad, flujo y etapa actual. | No | [sg_prseiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_prseiSecgen01.sql) |
| [sg_fups](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1106) | Modificada | Transacción | Funcionario, contrato, monto total y tope capturado. | No | [sg_fupsiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupsiSecgen01.sql) |
| [sg_fuho](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1234) | Nueva | Transacción | Distribución semanal de horario; no cuotas mensuales. | No | [sg_fuhosiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fuhosiSecgen01.sql) |
| [sg_fuco](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1217) | Nueva | Transacción | Tramos de compensación registrados en la solicitud. | No | [sg_fucoiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fucoiSecgen01.sql) |
| [sg_apso](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1186) | Modificada | Transacción | Tarea por actor y etapa; registra quién autoriza. | No | [sg_apsoiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_apsoiSecgen01.sql) |
| [sg_hist](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:871) | Sin cambios | Transacción | Trazabilidad general de solicitud y resolución. | No | [sg_histiSecgen03.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_histiSecgen03.sql) |
| [sg_his2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1145) | Nueva | Transacción | Historial individual; escritura condicional al cambiar estado en sg_fupsuSecgen01. | No | [sg_fupsuSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupsuSecgen01.sql) |
| [sg_rslc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:569) | Sin cambios | Transacción | Cabecera y estado de resolución. | No | [sg_rslciSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_rslciSecgen01.sql) |
| [sg_rede](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1008) | Sin cambios | Transacción | Textos materializados de la resolución. | No | [sg_redeiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_redeiSecgen01.sql) |
| [sg_apre](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:674) | Sin cambios | Transacción | Firmantes y decisiones de firma. | No | [sg_apreiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_apreiSecgen01.sql) |
| [sg_parm](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:189) | Sin cambios | Control | Correlativos utilizados por los PA; revisar contra IDs existentes. | Revisión | [sg_soliiSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_soliiSecgen01.sql) |
| [sg_prm1](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:268) | Sin cambios | Control | Año de proceso requerido al preparar la resolución. | Revisión | [sg_prm1sSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_prm1sSecgen01.sql) |

`sg_prm1` es una dependencia omitida por el catastro anterior: [el workflow](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/services/service-provision-workflow.service.ts:723) llama `getLastAnoProcess()`; el repositorio ejecuta `sg_prm1sSecgen01`, cuyo SQL consulta `MAX(ano_proces)` de `sg_prm1`. El paquete 01–06 no la ambienta. Debe verificarse su dato antes de generar la resolución.

`sg_his2` tiene una escritura concreta en `sg_fupsuSecgen01` cuando cambia `cod_estfun`. Esto no acredita que todas las actualizaciones de estado del sistema historicien: existen actualizaciones directas de `sg_fups` que deben revisarse si se exige cobertura completa de auditoría.

## 6. Compatibilidad y soporte institucional (5 tablas)

| Tabla | Cambio | Uso y decisión |
|---|---|---|
| [sg_fume](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1252) | Nueva | Mantener estructura por consultas y borrados legacy. No crear cuotas al guardar/enviar DU288. |
| [sg_ecuo](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:91) | Nueva | Mantener estructura por consulta de prestaciones anteriores y catálogo de cuotas. No cargar estados de pago dentro de 01–06. |
| [sg_fuc2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1286) | Nueva | Mantener estructura por lectura de compensación efectiva del comparador. No generar registros desde la solicitud. |
| [sg_perf](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:203) | Sin cambios | Soporte legacy de perfiles: [sg_histsSecgen05.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_histsSecgen05.sql) lo consulta como alternativa a bd_per1. Conservar, sin duplicar roles dinámicos. |
| [sg_uspe](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:622) | Sin cambios | Soporte de roles globales/legacy; [sg_apsosSecgen04.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_apsosSecgen04.sql) lo consulta. No poblar con solicitantes o jefaturas dinámicas. |

Cadena concreta de la consulta de prestaciones anteriores:

1. [Formulario DU288](D:/trabajo_ufro_2026/sg-solicitudes-frontend/components/services-provision/PdsDu288RequestForm.vue:1914) carga los antecedentes.
2. [Store de prestaciones](D:/trabajo_ufro_2026/sg-solicitudes-frontend/store/provision-request.js:133) solicita el endpoint correspondiente.
3. [Controlador](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/controllers/service-provision/service-provision-request.controller.ts:1653) llama al repositorio.
4. [Repositorio](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/repositories/storedProcedures/service-provision-request-procedures.repository.ts:1730) ejecuta `selectStaffPreviousProvisions`.
5. [Query](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/db-assets/sybase-assets/queries/service-provision-request/service-provision-request.ts:344) invoca [sg_fupssSecgen17](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/sg_fupssSecgen17.sql:135), que cruza las tres tablas de pagos.

Además, [deleteStaffMonths](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/db-assets/sybase-assets/queries/service-provision-request/service-provision-request.ts:131) borra de `sg_fume` y tiene consumidor en la limpieza de funcionarios antiguos de una solicitud DU288. Que [updateInstallmentStatusesByRequest](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/repositories/storedProcedures/service-provision-request-procedures.repository.ts:2725) sea un método vacío no elimina esas dependencias.

## 7. Tablas existentes fuera del cambio DU288 (33 tablas)

Todas estaban en el diagrama anterior y no cambiaron. No requieren alta ni carga nueva por este cambio DU288. Varias pertenecen a módulos activos del mismo SG-Solicitudes; otras solo tienen evidencia de esquema/PA histórico. **Esta clasificación no autoriza eliminarlas del sistema completo.**

| Tabla | Ámbito | Evidencia / decisión |
|---|---|---|
| [sg_anso](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:7) | Apertura de centro de costo | Catálogo de antecedentes de sg_apcc. [sg_apccsSecgen02.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_apccsSecgen02.sql) |
| [sg_caju](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:21) | Bases de concurso | Calidad jurídica del cargo. [sg_bacosSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_bacosSecgen01.sql) |
| [sg_ccbc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:35) | Catálogo de categorías | Sin referencia encontrada en backend/PA revisados. No se puede declarar prescindible institucionalmente. Ver esquema. |
| [sg_earc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:63) | Archivo legacy | Padre por FK de sg_rear; sin consumidor DU288 encontrado. Ver esquema. |
| [sg_ebco](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:77) | Bases de concurso | Padre por FK de sg_baco. Ver esquema. |
| [sg_eibc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:119) | Bases de concurso | Padre por FK de sg_inbc. Ver esquema. |
| [sg_inag](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:161) | Incentivos | Agrupación; padre por FK de sg_inac. Ver esquema. |
| [sg_moci](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:175) | Cierre de centro de costo | Motivos de cierre. [sg_mocisSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_mocisSecgen01.sql) |
| [sg_plbc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:218) | Bases de concurso | Plantillas de bases. [sg_plbcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_plbcsSecgen01.sql) |
| [sg_plpc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:234) | Perfil de cargo / concurso | Plantillas de perfil. [sg_plpcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_plpcsSecgen01.sql) |
| [sg_tdre](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:293) | Devolución de recursos | Tipo de devolución. [sg_tdresSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_tdresSecgen01.sql) |
| [sg_telm](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:307) | Perfil de cargo / concurso | Tipos de elementos; padre por FK de sg_itpc. Ver esquema. |
| [sg_tipc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:339) | Incentivos | Tipo de incentivo. [sg_inpcsSecgen02.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_inpcsSecgen02.sql) |
| [sg_tpag](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:385) | Devolución de recursos / catálogo compartido | FK desde sg_dben y consulta payment-type; no es sg_ecuo. [payment-type.model.ts](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/db-assets/sybase-assets/queries/base-crud/payment-type.model.ts) |
| [sg_trec](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:413) | Bases de concurso | Tipos de reclutamiento. [sg_bacosSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_bacosSecgen01.sql) |
| [sg_grpc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:488) | Perfil de cargo / concurso | Grupos de plantilla. [sg_grpcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_grpcsSecgen01.sql) |
| [sg_itpc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:508) | Perfil de cargo / concurso | Ítems de plantilla. [sg_itpcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_itpcsSecgen01.sql) |
| [sg_rear](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:548) | Archivo legacy | Registro de archivo; sin consumidor DU288 encontrado. No confundir con archivo_db.ar_doc1. Ver esquema. |
| [sg_apcc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:641) | Apertura de centro de costo / consulta PDS legacy | Usada por su módulo. También aparece en sg_prsesSecgen07; revisar ese consumidor si se quiere una base aislada. [sg_prsesSecgen07.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/sg_prsesSecgen07.sql) |
| [sg_baco](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:699) | Bases de concurso | Cabecera específica de concurso. [sg_bacosSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_bacosSecgen01.sql) |
| [sg_bccm](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:748) | Bases de concurso | Comentarios de revisión. [sg_bccmsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_bccmsSecgen01.sql) |
| [sg_bcre](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:768) | Bases de concurso | Revisores y decisiones. [sg_bcresSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_bcresSecgen01.sql) |
| [sg_cicc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:788) | Cierre de centro de costo | Solicitud de cierre. [sg_cicciSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_cicciSecgen01.sql) |
| [sg_delm](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:813) | Perfil de cargo / concurso | Detalle de elementos. [sg_delmsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_delmsSecgen01.sql) |
| [sg_drec](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:836) | Devolución de recursos | Detalle de solicitud. [sg_drecsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_drecsSecgen01.sql) |
| [sg_fopc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:854) | Perfil de cargo / concurso | Formulario de perfil. [sg_fopcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_fopcsSecgen01.sql) |
| [sg_ifpc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:900) | Perfil de cargo / concurso | Ítems del formulario. [sg_ifpcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_ifpcsSecgen01.sql) |
| [sg_inbc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:920) | Bases de concurso | Informe de bases. [sg_inbcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_inbcsSecgen01.sql) |
| [sg_inpc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:939) | Incentivos | Cabecera específica de incentivo. [sg_inpcsSecgen02.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_inpcsSecgen02.sql) |
| [sg_appc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1035) | Perfil de cargo / concurso | Aprobación de formulario; FK hacia sg_fopc y sg_eapr. Ejecución no comprobada. Ver esquema. |
| [sg_dben](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1055) | Devolución de recursos | Beneficiarios. [sg_solisSecgen07.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_solisSecgen07.sql) |
| [sg_dfpc](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1084) | Perfil de cargo / concurso | Valores de detalle del formulario. [sg_dfpcsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_dfpcsSecgen01.sql) |
| [sg_inac](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1163) | Incentivos | Académicos beneficiarios. [sg_inacsSecgen01.sql](D:/trabajo_ufro_2026/contexto_prestacion_servicios/sp-20260423T161643Z-3-001/sp/sg_inacsSecgen01.sql) |

La consulta `selectAllByRequestStatusId` todavía apunta a `sg_prsesSecgen07`, cuyo SQL cruza `sg_apcc`. Se encontró su método de repositorio, pero no una llamada adicional a ese método en el código revisado. Por eso `sg_apcc` queda fuera de las altas DU288, sin declararla eliminable ni certificar una base nueva sin ella.

## 8. Tabla nueva diferida y propuestas fuera del inventario

| Tabla / propuesta | Decisión |
|---|---|
| [sg_fum2](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/maestros/diagrama_secgen_actualizado.md:1304) | Es la tabla 67 de este inventario por clasificación, no por orden físico. Aparece en el esquema como historial de cuotas, con FK a sg_fume. No se encontró referencia ni llamada de PA con ese nombre/prefijo en el backend, frontend y PA de solicitud revisados. No incorporarla para certificar DU288; confirmar separadamente si el sistema de pagos la necesita. |
| `sg_wflu`, `sg_wfet`, `sg_wfin`, `sg_wfei`, `sg_apsa`, `sg_apsf`, `sg_hiap` | Propuestas ajenas al motor implementado; no agregar como requisito DU288. El motor usa sg_tfls, sg_eta1, sg_eta2 y sg_apso. |
| `sg_fuev`, `sg_fucu`, `sg_trca` | Nombres de diseños previos; no aparecen como tablas en ninguno de los dos diagramas comparados ni en las referencias ejecutables de solicitud revisadas. No agregarlas a partir del plan histórico. El tope actual usa sg_toca. |

La ausencia de uso encontrada se limita a esta revisión local; no cubre PA instalados sin copia local, procesos externos, reportes institucionales ni el futuro sistema de pagos.

## 9. Dependencias externas que se reutilizan

No forman parte del aumento de 54 a 67 tablas SECGEN y no deben duplicarse dentro de PDS:

| Base / servicio | Dependencias |
|---|---|
| Sistema | `bd_per1`, `bd_prvg`, `bd_pepr`: catálogo y permisos DU288; carga 01 limitada a SG/SISSOLIC. |
| Organización | `ufro_db.es_unid`, `es_orga`: unidad, jerarquía y cargo organizacional. |
| SISPER | Personas, contratos, cargos, haberes, asignaciones y parentesco; `sp_orco`, `sp_orde`, `sp_aufi` para responsables. |
| Finanzas | Centros de costo, jerarquía presupuestaria, movimientos y documentos usados para saldo. |
| Archivo | `ar_doc1`, `ar_doc6` y parámetros utilizados por la generación documental. |
| MySecGen | `sg_rslc_<año>`: almacenamiento de documentos de resolución. Es otra base/motor. |

El detalle por tabla externa está en el catastro operativo, secciones 6 y 8. Que estas tablas queden fuera de los scripts de carga DU288 no significa que sean opcionales para los PA.

`bd_pri2` **no se carga para resolver actores DU288**. Sin embargo, sigue presente en consultas y PA de roles legacy del sistema: [user-permissions.ts](D:/trabajo_ufro_2026/sg-solicitudes-backend/src/db-assets/sybase-assets/queries/auth/user-permissions.ts) y [bd_pri2sSecgen01.sql](D:/trabajo_ufro_2026/nuevo_workflow_fase_2/template-du09/cambios_pa_solicitud_wf/solicitante/PA base/bd_pri2sSecgen01.sql). No es correcto afirmar que todo SG-Solicitudes dejó de utilizarla.

## 10. Alcance concreto de entrega

1. **Estructura:** contrastar certificación con las 9 altas DU288, las 3 altas de consulta/compatibilidad y las 3 modificaciones. Crear o alterar solo lo que falte. Diferir sg_fum2.
2. **Datos maestros:** ejecutar 01–06 en el orden del README. Afectan **15 tablas SECGEN y 3 tablas de Sistema**; no representan todas las dependencias físicas.
3. **Controles existentes:** revisar `sg_parm` y `sg_prm1`; no forman parte de esa carga.
4. **Dependencias externas:** verificar los datos coherentes necesarios para las pruebas y los permisos de los PA.
5. **Prueba funcional pendiente en certificación:** guardar y editar DU288, consultar prestaciones anteriores, recorrer aprobaciones y generar resolución. Comprobar que la solicitud no crea pagos.
6. **Si se pretende una instalación aislada desde cero:** resolver antes las referencias legacy, FK y PA externos. El inventario no certifica que baste crear únicamente las tablas del núcleo.

Reconciliación del inventario: **28 núcleo/control + 5 compatibilidad/soporte + 33 existentes fuera del cambio + 1 diferida = 67**. Las 13 nuevas están todas clasificadas. No se modificaron diagramas, PA, scripts de carga ni datos de base durante esta revisión.

