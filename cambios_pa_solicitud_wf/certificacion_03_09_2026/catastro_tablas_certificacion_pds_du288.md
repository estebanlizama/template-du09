# Orden de carga de datos para certificación PDS DU288

Este documento contiene únicamente las tablas necesarias para preparar y probar el flujo PDS DU288 en certificación. El orden de las secciones y de las filas debe respetarse.

## 1. `ufro_db`: unidades, organización y calendario

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 1.1 | `ufro_db.dbo.es_unid` | Ninguno. |
| 1.2 | `ufro_db.dbo.es_orga` | `es_unid`. Cargar primero organizaciones padre y después hijas. |
| 1.3 | `ufro_db.dbo.es_cfer` | Ninguno. Cargar las fechas institucionales del período de certificación. |

## 2. `sisper_db`: personas, contratos y responsables

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 2.1 | `sisper_db.dbo.sp_pers` | Ninguno. |
| 2.2 | `sisper_db.dbo.sp_carg` | Ninguno. |
| 2.3 | `sisper_db.dbo.sp_cali` | Ninguno. |
| 2.4 | `sisper_db.dbo.sp_estm` | Ninguno. |
| 2.5 | `sisper_db.dbo.sp_jorn` | Ninguno. |
| 2.6 | `sisper_db.dbo.sp_jpfu` | Ninguno. |
| 2.7 | `sisper_db.dbo.sp_nigr` | Ninguno. |
| 2.8 | `sisper_db.dbo.sp_sede` | Ninguno. |
| 2.9 | `sisper_db.dbo.sp_vigc` | Ninguno. |
| 2.10 | `sisper_db.dbo.sp_para` | Ninguno. |
| 2.11 | `sisper_db.dbo.sp_cont` | `sp_pers`, catálogos laborales 2.2–2.10 y `ufro_db.dbo.es_unid`. |
| 2.12 | `sisper_db.dbo.sp_orco` | `sp_pers` y `ufro_db.dbo.es_orga`. |
| 2.13 | `sisper_db.dbo.sp_orde` | `sp_pers`, `sp_cont` y `ufro_db.dbo.es_orga`. |
| 2.14 | `sisper_db.dbo.sp_aufi` | `sp_pers`, `sp_orco`, `sp_orde` y `ufro_db.dbo.es_orga`. |
| 2.15 | `sisper_db.dbo.sp_desg` | `sp_pers` y `sp_cont`. |
| 2.16 | `sisper_db.dbo.sp_par1` | `sp_pers`. |
| 2.17 | `sisper_db.dbo.sp_par2` | `sp_pers` y `sp_par1`. |
| 2.18 | `sisper_db.dbo.sp_asng` | `sp_cont`. |
| 2.19 | `sisper_db.dbo.ss_habe` | `sp_pers` y `sp_cont`. Cargar el mes inmediatamente anterior al período de prueba. |
| 2.20 | `sisper_db.dbo.ss_hrem` | `sp_pers`, `sp_cont` y `ss_habe` del mismo período. |

## 3. `fin21_db`: centros de costo y presupuesto

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 3.1 | `fin21_db.dbo.es_ufin` | Ninguno. |
| 3.2 | `fin21_db.dbo.es_ecct` | Ninguno. |
| 3.3 | `fin21_db.dbo.es_tfin` | Ninguno. |
| 3.4 | `fin21_db.dbo.sf_ftfn` | Ninguno. |
| 3.5 | `fin21_db.dbo.sf_deaf` | Ninguno. |
| 3.6 | `fin21_db.dbo.es_ccto` | `es_ufin`, `es_ecct`, `es_tfin`, los códigos utilizados de `sf_ftfn` y `sf_deaf`, `sisper_db.dbo.sp_pers` del responsable y `ufro_db.dbo.es_unid`. |
| 3.7 | `fin21_db.dbo.pt_ticp` | Ninguno. |
| 3.8 | `fin21_db.dbo.pt_titl` | `pt_ticp`, relacionado por `cod_cuenta`. |
| 3.9 | `fin21_db.dbo.pt_item` | `pt_titl`, relacionado por `cod_subtitulo`. |
| 3.10 | `fin21_db.dbo.pt_sitm` | `pt_item`, relacionado por `cod_item`. |
| 3.11 | `fin21_db.dbo.pt_depr` | `es_ccto` y `pt_sitm`. |
| 3.12 | `fin21_db.dbo.sf_docf` | Documentos correspondientes a los movimientos de `pt_depr`. |
| 3.13 | `fin21_db.dbo.sf_pfoc` | `sf_docf` y `pt_depr`, relacionados por `numero` y `sf_numero`. |
| 3.14 | `sisper_db.dbo.wf_sol2` | `sp_pers`, `sp_cont` y `fin21_db.dbo.es_ccto`. |
| 3.15 | `sisper_db.dbo.wf_tra1` | `wf_sol2`, relacionado por `ano` y `nro_folio`. |

### 3.1 Orden requerido por `fin21_db.Analisis.valida_saldo_cc_cs`

| Orden | Tabla | Datos que deben estar relacionados |
|---:|---|---|
| 1 | `fin21_db.dbo.es_tfin` | `cod_tfinan`, `cod_tfondo`. |
| 2 | `fin21_db.dbo.es_ccto` | `cod_unifin`, `cod_ccto`, `cod_tfinan`, fechas de cierre, bloqueo y sobregiro. |
| 3 | `fin21_db.dbo.pt_ticp` | `cod_cuenta`. |
| 4 | `fin21_db.dbo.pt_titl` | `cod_subtitulo` y `cod_cuenta` existente en `pt_ticp`. |
| 5 | `fin21_db.dbo.pt_item` | `cod_item`, `cod_subtitulo` existente en `pt_titl` y `cod_agrup`. |
| 6 | `fin21_db.dbo.pt_sitm` | `cod_sitm` recibido por el PA y `cod_item` existente en `pt_item`. |
| 7 | `fin21_db.dbo.pt_depr` | `numero`, centro de costo, subítem, tipo de movimiento, moneda, valores y fecha de ingreso del período evaluado. |
| 8 | `fin21_db.dbo.sf_docf` | Documento directo de `pt_depr` o documento relacionado mediante `sf_pfoc`; tipo, fechas, indicador de saldo y validación. |
| 9 | `fin21_db.dbo.sf_pfoc` | `numero` de `sf_docf` y `sf_numero` de `pt_depr`. |
| 10 | `sisper_db.dbo.wf_sol2` | `ano`, `nro_folio`, centro de costo, `cod_est_cc` y `monto`. |
| 11 | `sisper_db.dbo.wf_tra1` | `ano` y `nro_folio` existentes en `wf_sol2`, `f_inicio` y `f_ini_cont`. |

Orden consolidado de dependencias del PA:

```text
es_tfin -> es_ccto

pt_ticp -> pt_titl -> pt_item -> pt_sitm
es_ccto + pt_sitm -> pt_depr
pt_depr + sf_docf -> sf_pfoc

es_ccto + wf_sol2 -> wf_tra1
```

Para la evaluación se requieren los movimientos y documentos comprendidos entre el 31 de diciembre del año anterior y la fecha de ejecución del PA, además de los compromisos laborales vigentes que correspondan al centro de costo evaluado.

## 4. `sistema_db`: perfiles y privilegios

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 4.1 | `sistema_db.dbo.bd_per1` | Ninguno. |
| 4.2 | `sistema_db.dbo.bd_prvg` | Ninguno. |
| 4.3 | `sistema_db.dbo.bd_pepr` | `bd_per1` y `bd_prvg`. |

## 5. `secgen_db`: catálogos y configuración PDS

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 5.1 | `secgen_db.dbo.sg_tsol` | Ninguno. |
| 5.2 | `secgen_db.dbo.sg_esol` | Ninguno. |
| 5.3 | `secgen_db.dbo.sg_tmod` | Ninguno. |
| 5.4 | `secgen_db.dbo.sg_efun` | Ninguno. |
| 5.5 | `secgen_db.dbo.sg_eapr` | Ninguno. |
| 5.6 | `secgen_db.dbo.sg_tacc` | Ninguno. |
| 5.7 | `secgen_db.dbo.sg_tpps` | Ninguno. |
| 5.8 | `secgen_db.dbo.sg_ecuo` | Ninguno. |
| 5.9 | `secgen_db.dbo.sg_ersl` | Ninguno. |
| 5.10 | `secgen_db.dbo.sg_plse` | Ninguno. |
| 5.11 | `secgen_db.dbo.sg_perf` | Ninguno. |
| 5.12 | `secgen_db.dbo.sg_tfls` | Ninguno. |
| 5.13 | `secgen_db.dbo.sg_eta1` | `sg_tfls`, `sistema_db.dbo.bd_per1` y `ufro_db.dbo.es_orga`. |
| 5.14 | `secgen_db.dbo.sg_eta2` | `sg_eta1`, `sg_tacc` y `sg_esol`. |
| 5.15 | `secgen_db.dbo.sg_toca` | `sisper_db.dbo.sp_carg` y `ufro_db.dbo.es_unid`. |
| 5.16 | `secgen_db.dbo.sg_plre` | `sg_tsol`. |
| 5.17 | `secgen_db.dbo.sg_plde` | `sg_plre` y `sg_plse`. |
| 5.18 | `secgen_db.dbo.sg_parm` | Filas de correlativos para `sg_soli`, `sg_fups`, `sg_apso`, `sg_hist`, `sg_rslc`, `sg_rede` y `sg_apre`. |
| 5.19 | `secgen_db.dbo.sg_prm1` | Año de proceso vigente. |

## 6. `archivo_db` y `MySecGen`: resolución y documentos

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 6.1 | `archivo_db.dbo.ar_adm1` | Usuario autorizado para generar documentos. |
| 6.2 | `archivo_db.dbo.ar_parm` | Correlativo vigente de `id_docum`. |
| 6.3 | `archivo_db.dbo.ar_prm2` | Tipo de documento, año, correlativo y tabla MySQL de destino. |
| 6.4 | `archivo_db.dbo.ar_prm3` | Tipo de documento, emisor, año, correlativo y tabla MySQL de destino cuando la numeración es por emisor. |
| 6.5 | `archivo_db.dbo.ar_edoc` | Estados documentales utilizados por el flujo. |
| 6.6 | `MySecGen.sg_rslc_<año>` | Debe existir para el año indicado en `sg_prm1` y en los parámetros de Archivo. |

## 7. Orden de generación de datos transaccionales

Estas filas se generan mediante la aplicación y sus procedimientos después de completar las cargas 1–6.

| Orden | Tabla | Datos previos requeridos |
|---:|---|---|
| 7.1 | `secgen_db.dbo.sg_soli` | `sg_tsol`, `sg_esol` y correlativo en `sg_parm`. |
| 7.2 | `secgen_db.dbo.sg_prse` | `sg_soli`, `sg_tmod`, `sg_tfls`, `sg_eta1` y `fin21_db.dbo.es_ccto`. |
| 7.3 | `secgen_db.dbo.sg_fups` | `sg_prse`, `sg_efun`, `sg_tpps`, `sisper_db.dbo.sp_pers`, `sp_cont` y `fin21_db.dbo.pt_sitm`. |
| 7.4 | `secgen_db.dbo.sg_fuho` | `sg_fups`. |
| 7.5 | `secgen_db.dbo.sg_fuco` | `sg_fups` y `ufro_db.dbo.es_cfer`. |
| 7.6 | `secgen_db.dbo.sg_fume` | `sg_fups` y `sg_ecuo`; se sincroniza al enviar la solicitud en la implementación vigente. |
| 7.7 | `secgen_db.dbo.sg_apso` | `sg_soli`, `sg_fups`, `sg_eapr` y `sg_eta1`. |
| 7.8 | `secgen_db.dbo.sg_hist` | `sg_soli`, `sg_tsol` y `sg_tacc`. |
| 7.9 | `secgen_db.dbo.sg_his2` | `sg_fups` y `sg_efun`. |
| 7.10 | `archivo_db.dbo.ar_doc1` | `ar_adm1`, `ar_parm`, `ar_prm2` o `ar_prm3`, y `ar_edoc`. |
| 7.11 | `archivo_db.dbo.ar_doc6` | `ar_doc1`. |
| 7.12 | `secgen_db.dbo.sg_rslc` | `sg_plre`, `sg_ersl`, `sg_parm` y numeración de Archivo. |
| 7.13 | `secgen_db.dbo.sg_soli` | Actualizar `ano_resolu` y `nro_resolu` después de crear `sg_rslc`. |
| 7.14 | `secgen_db.dbo.sg_rede` | `sg_rslc`, `sg_plde` y `sg_plse`. |
| 7.15 | `secgen_db.dbo.sg_apre` | `sg_rslc`, `sg_eapr` y `sistema_db.dbo.bd_per1`. |
| 7.16 | `MySecGen.sg_rslc_<año>` | `sg_rslc` y `archivo_db.dbo.ar_doc1`. |
| 7.17 | `secgen_db.dbo.sg_hist` | Registrar el evento de resolución después de completar la generación documental. |
