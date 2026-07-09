# Flujo de Roles PDS DU09 - Revision Inicial

Este documento resume el cruce entre el flujo PDS actual del sistema y el flujo propuesto por las vistas DU09, con foco en identificar que roles ya existen y que actores deben agregarse o definirse antes de implementar las pantallas.

## 1. Criterio general

El rol solicitante de Prestacion de Servicios ya existe en el sistema:

| Rol tecnico | Nombre funcional | Estado |
| :--- | :--- | :--- |
| `prse_applicant` | Solicitante PDS | Existente |

Por lo tanto, no se recomienda crear un nuevo rol solicitante para DU09. La diferencia del flujo DU09 debe controlarse por modalidad de prestacion y reglas de negocio, no por duplicacion del rol solicitante.

Para DU09, el `prse_applicant` debe entenderse como el usuario que crea la solicitud PDS. En la operacion real puede corresponder a dos casos:

| Caso | Descripcion | Implicancia de flujo |
| :--- | :--- | :--- |
| Jefe de Proyecto crea directamente | El solicitante autenticado tambien es el Jefe de Proyecto responsable del centro de costo/proyecto. | La etapa de Jefe de Proyecto puede quedar auto-validada o registrarse como aprobacion equivalente, segun definicion de negocio. |
| Delegado crea por encargo | El solicitante autenticado es una persona autorizada/delegada por el Jefe de Proyecto. | La solicitud debe pasar al Jefe de Proyecto para visacion formal antes de avanzar a la jefatura del proyecto. |

Regla base: `prse_applicant` no reemplaza necesariamente al Jefe de Proyecto; representa al creador de la solicitud. El Jefe de Proyecto debe conservarse como responsable funcional de la PDS mediante `sg_prse.rut_jefpro`.

Referencia BDD:

| Tabla | Campo | Uso |
| :--- | :--- | :--- |
| `sg_prse` | `id_modprse` | Distingue modalidad legacy versus DU288-D09/2026. |

## 2. Flujo PDS actual en backend

El flujo actual declarado en `sg-solicitudes-backend/src/utils/roles-const.ts` para Prestacion de Servicios es:

```text
prse_applicant
-> finance_manager
-> applicant_head
-> finance_director
-> head_decreeing
-> general_secretary
-> academic_vice_rector
-> legality_director
-> university_comptroller
-> university_archive_head
```

Equivalencia funcional:

| Orden | Rol tecnico actual | Nombre funcional |
| :--- | :--- | :--- |
| 1 | `prse_applicant` | Solicitante |
| 2 | `finance_manager` | Director/Encargado de finanzas unidad |
| 3 | `applicant_head` | Jefe de Solicitante |
| 4 | `finance_director` | Director de finanzas |
| 5 | `head_decreeing` | Jefe de decretacion |
| 6 | `general_secretary` | Secretario General |
| 7 | `academic_vice_rector` | Vicerrector academico |
| 8 | `legality_director` | Director de legalidad |
| 9 | `university_comptroller` | Contralor Universitario |
| 10 | `university_archive_head` | Jefe archivo universitario |

## 3. Flujo DU09 propuesto por las pantallas

Las vistas del template DU09 sugieren un flujo mas amplio:

```text
Solicitante / delegado operativo
-> Jefe de Proyecto
-> Jefatura del Jefe de Proyecto / Jefe de Departamento
-> DGDP
-> Encargado de Finanzas Unidad / Facultad
-> Decanatura / Vicerrectoria
-> Direccion de Finanzas
-> Jefe de Decretacion
-> Secretario General
-> Rector
-> Contraloria Universitaria / Profesional
-> Contralor Universitario
-> Jefe Archivo Universitario
```

Vistas asociadas:

| Vista | Actor / etapa |
| :--- | :--- |
| `01_vista_formulario_solicitud.html` | Solicitante / delegado operativo / jefe proyecto |
| `02_vista_visacion_aprobador.html` | Jefe de Proyecto |
| `03_vista_visacion_jefatura.html` | Jefatura del Jefe de Proyecto / Jefe de Departamento |
| `04_vista_visacion_dgdp.html` | DGDP |
| `05_vista_visacion_finanzas_facultad.html` | Encargado de Finanzas Unidad / Facultad |
| `06_vista_visacion_decano.html` | Decanatura / Vicerrectoria |
| `07_vista_visacion_finanzas_central.html` | Direccion de Finanzas |
| `08_vista_decretacion.html` | Jefe de Decretacion |
| `11_vista_visacion_secretario_general.html` | Secretario General |
| `12_vista_visacion_rector.html` | Rector |
| `13_vista_visacion_contraloria_profesional.html` | Contraloria Universitaria / Profesional |
| `14_vista_visacion_contralor_final.html` | Contralor Universitario |
| `15_vista_archivo_universitario.html` | Jefe Archivo Universitario |

## 4. Cruce de actores

| Actor DU09 | Estado actual | Rol tecnico actual / sugerido | Observacion |
| :--- | :--- | :--- | :--- |
| Solicitante / delegado operativo | Existe | `prse_applicant` | Mantener. Cumple para P01 como creador de la solicitud. |
| Jefe de Proyecto | No existe como rol de workflow PDS | `project_head` sugerido | Existe como dato en `sg_prse.rut_jefpro`. Debe visar si la solicitud fue creada por delegado. |
| Jefatura del Jefe de Proyecto / Jefe de Departamento | No existe como rol especifico DU09 | `project_department_head` sugerido | Se crea para no confundir esta etapa con `applicant_head`, que hoy representa una jefatura generica del solicitante. |
| DGDP | Existe como perfil equivalente | `human_resources_director` | La Direccion de Recursos Humanos ahora corresponde a la Direccion de Gestion y Desarrollo de Personas (DGDP). |
| Encargado Finanzas Unidad / Facultad | Existe | `finance_manager` | Ya esta en PDS actual. |
| Decanatura / Vicerrectoria | Parcial | `dean` sugerido o reutilizar `academic_vice_rector` segun unidad | Debe resolverse segun la dependencia del Jefe de Proyecto o del centro de costo. |
| Direccion de Finanzas | Existe | `finance_director` | Ya esta en PDS actual. |
| Jefe Decretacion | Existe | `head_decreeing` | Ya esta en PDS actual. |
| Secretario General | Existe | `general_secretary` | Ya esta en PDS actual. |
| Rector | Existe como constante, no en flujo PDS | `rector` | Debe insertarse en `nextRoleServiceProvision` si DU09 lo requiere. |
| Contraloria Universitaria | No existe como rol PDS separado | `comptroller_officer` sugerido | Diferente del Contralor Universitario. |
| Contralor Universitario | Existe | `university_comptroller` | Ya esta en PDS actual. |
| Jefe Archivo Universitario | Existe | `university_archive_head` | Ya esta en PDS actual. |

## 5. Roles candidatos a agregar

Estos roles solo deberian agregarse si negocio confirma que son etapas reales y no solo etiquetas visuales de la maqueta.

| Rol tecnico sugerido | Nombre funcional | Motivo |
| :--- | :--- | :--- |
| `project_head` | Jefe de Proyecto | Visacion posterior al envio de la solicitud. |
| `project_department_head` | Jefe de Departamento del Jefe de Proyecto | Aprobacion de la jefatura superior del Jefe de Proyecto. |
| `dean` | Decano / Decanatura | Visacion de autoridad de facultad, si aplica. |
| `comptroller_officer` | Profesional Contraloria Universitaria | Revision previa a Contralor Universitario. |

Roles existentes que podrian reutilizarse:

| Rol existente | Nombre funcional actual | Posible uso DU09 |
| :--- | :--- | :--- |
| `chief_person` | Jefe de division de personal y remuneraciones | No usar como DGDP en este flujo. |
| `human_resources_director` | Director recursos humanos | Usar como Director DGDP / Direccion de Gestion y Desarrollo de Personas. |
| `rector` | Rector | Firma/visacion Rector. |
| `academic_vice_rector` | Vicerrector academico | Posible autoridad superior para unidades que no dependen de decanatura o cuando corresponda por regla DU09. |

## 6. Flujo DU09 tentativo si se agregan todos los actores

```text
prse_applicant
-> project_head
-> project_department_head
-> human_resources_director
-> finance_manager
-> dean / academic_vice_rector
-> finance_director
-> head_decreeing
-> general_secretary
-> rector
-> comptroller_officer
-> university_comptroller
-> university_archive_head
```

Interpretacion de las primeras etapas:

| Etapa | Actor | Regla |
| :--- | :--- | :--- |
| `prse_applicant` | Creador de la solicitud | Puede ser el Jefe de Proyecto o un delegado autorizado. |
| `project_head` | Jefe de Proyecto responsable | Debe visar la solicitud cuando el creador actua por delegacion. |
| `project_department_head` | Jefatura del Jefe de Proyecto / Jefe de Departamento | Debe aprobar despues de la visacion del Jefe de Proyecto. |

Si el creador y el Jefe de Proyecto son la misma persona, se debe definir si el sistema:

1. Registra automaticamente la visacion del Jefe de Proyecto y avanza a `project_department_head`.
2. Mantiene una etapa explicita de confirmacion por el mismo usuario.
3. Omite `project_head` solo en ese caso y deja trazabilidad de auto-visacion.

## 7. Decisiones pendientes

| Decision | Pregunta |
| :--- | :--- |
| Jefe de Proyecto | Debe aprobar siempre como etapa formal o solo cuando el creador es delegado? |
| Auto-visacion | Si `prse_applicant` y `rut_jefpro` son la misma persona, se auto-valida la etapa de Jefe de Proyecto? |
| Jefatura posterior | Como se resuelve la persona usuaria de `project_department_head`, es decir, el Jefe de Departamento del Jefe de Proyecto? |
| Decanatura / Vicerrectoria | La etapa se resuelve por facultad/decanatura o por vicerrectoria segun la unidad del Jefe de Proyecto/centro de costo? |
| Rector | Debe incorporarse en PDS DU09 aunque no este en PDS actual? |
| Contraloria profesional | Es una etapa separada del Contralor Universitario o solo una revision interna sin rol de workflow? |
| Flujo por modalidad | El flujo DU09 debe convivir con PDS legacy usando `id_modprse`? |

## 8. Recomendacion inicial

Mantener `prse_applicant` como Solicitante PDS y crear una variante de flujo para DU09 controlada por `sg_prse.id_modprse`.

No modificar el flujo PDS legacy hasta confirmar si DU09 debe convivir con el flujo actual. Si conviven, se recomienda definir un mapa separado:

```ts
nextRoleServiceProvisionD9
```

Esto evita romper solicitudes PDS tradicionales que ya usen `nextRoleServiceProvision`.

## 9. Roles y etapas que se deben agregar

Esta seccion lista solo los elementos que no estan cubiertos por el flujo PDS actual y que se deben evaluar/agregar para DU09. No incluye roles ya existentes como `prse_applicant`, `finance_manager`, `finance_director`, `head_decreeing`, `general_secretary`, `academic_vice_rector`, `university_comptroller` o `university_archive_head`.

### 9.1 Nuevos roles candidatos

| Orden DU09 | Rol tecnico sugerido | Nombre funcional | Tipo de alta | Motivo |
| :--- | :--- | :--- | :--- | :--- |
| 2 | `project_head` | Jefe de Proyecto | Nuevo rol o asignacion directa por RUT | Debe visar la solicitud cuando fue creada por un delegado. Si el aprobador se asigna directamente desde `sg_prse.rut_jefpro`, el rol podria no requerirse como perfil global. |
| 3 | `project_department_head` | Jefe de Departamento del Jefe de Proyecto | Nuevo rol | Evita reutilizar `applicant_head` para una etapa que debe depender del Jefe de Proyecto y no del creador de la solicitud. |
| 4 | `human_resources_director` | Director DGDP | Perfil existente | No crear perfil nuevo. La Direccion de Recursos Humanos corresponde actualmente a DGDP. |
| 6 | `dean` | Decano / Decanatura | Nuevo rol condicional | Se requiere cuando la unidad depende de una facultad. Para unidades centrales podria resolverse con una autoridad de vicerrectoria existente. |
| 11 | `comptroller_officer` | Profesional Contraloria Universitaria | Nuevo rol | Representa revision profesional previa al Contralor Universitario. No debe confundirse con `university_comptroller`. |

### 9.2 Roles existentes que no se crean, pero deben agregarse al flujo DU09

| Rol tecnico existente | Nombre funcional | Accion requerida |
| :--- | :--- | :--- |
| `rector` | Rector | No crear rol. Ya existe como constante, pero no esta en `nextRoleServiceProvision`; debe incorporarse al flujo DU09 si la etapa Rector aplica. |
| `academic_vice_rector` | Vicerrector academico | No crear rol. Puede reutilizarse como alternativa a `dean` cuando la unidad no dependa de decanatura o cuando la regla DU09 derive a vicerrectoria. |
| `applicant_head` | Jefe de Solicitante | No usar como Jefe de Departamento DU09. Se mantiene para el flujo PDS actual/legacy o para reglas existentes. |

### 9.3 Alta sugerida estilo base de datos

> Nota: los perfiles reales se administran en el sistema externo de permisos. Este bloque sigue el estilo de `contexto_prestacion_servicios/sql_base_perfilamiento_solicitudes.sql`.
>
> En la base actual, el ultimo `cod_perfil` usado es `24` (`applicant_head`) y los privilegios PDS ya existen:
>
> | `cod_privil` | Privilegio |
> | :--- | :--- |
> | `65` | `provision-request-approve` |
> | `67` | `provision-request-document-read` |
> | `68` | `provision-request-history-read` |
> | `69` | `provision-request-read` |
> | `81` | `provision-request-read-waiting` |
>
> Por eso, para las nuevas etapas DU09 no se crean privilegios nuevos inicialmente; se reutilizan los privilegios PDS existentes.

```sql
-- =====================================================
-- Nuevos perfiles DU09 sugeridos para Prestacion de Servicios
-- =====================================================

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 25, 'project_head', 'Jefe de Proyecto');

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 26, 'project_department_head', 'Jefe de Departamento del Jefe de Proyecto');

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 27, 'dean', 'Decano / Decanatura');

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 28, 'comptroller_officer', 'Profesional Contraloria Universitaria');

-- =====================================================
-- Privilegios por perfil DU09 PDS
-- Se reutilizan privilegios existentes de Prestacion de Servicios:
-- 65 approve, 67 document-read, 68 history-read, 69 read, 81 read-waiting.
-- =====================================================

-- project_head - Jefe de Proyecto
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 81);

-- project_department_head - Jefe de Departamento del Jefe de Proyecto
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 81);

-- dean - Decano / Decanatura
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 81);

-- comptroller_officer - Profesional Contraloria Universitaria
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 71);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 81);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 91);
```

Perfiles existentes que no requieren `INSERT INTO bd_per1`:

| Perfil | `cod_perfil` | Observacion |
| :--- | :--- | :--- |
| `prse_applicant` | `6` | Ya existe como Solicitante PDS. |
| `finance_manager` | `8` | Ya existe como encargado de finanzas unidad. |
| `finance_director` | `10` | Ya existe como Director de Finanzas. |
| `head_decreeing` | `12` | Ya existe como Jefe de Decretacion. |
| `human_resources_director` | `13` | Ya existe como Director Recursos Humanos; usar como DGDP. |
| `general_secretary` | `14` | Ya existe como Secretario General. |
| `rector` | `15` | Ya existe; solo debe agregarse al flujo DU09 si aplica. |
| `legality_director` | `16` | Ya existe como Director de Legalidad. |
| `university_comptroller` | `17` | Ya existe como Contralor Universitario. |
| `university_archive_head` | `18` | Ya existe como Jefe Archivo Universitario. |
| `chief_person` | `21` | Ya existe; no usar como DGDP salvo que negocio lo redefina. |
| `academic_vice_rector` | `22` | Ya existe; posible alternativa a decanatura/vicerrectoria. |
| `vraf` | `23` | Ya existe; posible alternativa para vicerrectoria administrativa/financiera. |
| `applicant_head` | `24` | Ya existe; no usar como Jefe de Departamento DU09. |

### 9.4 Flujo DU09 con solo agregados necesarios

```text
prse_applicant
-> project_head                  NUEVO / o asignacion directa por rut_jefpro
-> project_department_head       NUEVO, Jefe de Departamento del Jefe de Proyecto
-> human_resources_director      EXISTENTE, usar como DGDP
-> finance_manager               EXISTENTE
-> dean / academic_vice_rector   NUEVO solo si se usa dean; vicerrectoria ya existe
-> finance_director              EXISTENTE
-> head_decreeing                EXISTENTE
-> general_secretary             EXISTENTE
-> rector                        EXISTENTE, agregar al flujo PDS DU09
-> comptroller_officer           NUEVO
-> university_comptroller        EXISTENTE
-> university_archive_head       EXISTENTE
```

## 10. Privilegios PDS a agregar segun perfilamiento actual

Revision cruzada con:

- `contexto_prestacion_servicios/diagrama_pre_wf/datos_sistema_db_bd_prvg.md`
- `contexto_prestacion_servicios/diagrama_pre_wf/datos_sistema_db_bd_per1.md`
- `contexto_prestacion_servicios/diagrama_pre_wf/datos_sistema_db_bd_pepr.md`

### 10.1 Conclusion sobre `bd_prvg`

No se recomienda crear privilegios nuevos en `bd_prvg` para implementar el flujo DU09 inicial. El catalogo actual ya contiene los permisos base de Prestacion de Servicios que requiere el flujo:

| `cod_privil` | Privilegio actual | Uso DU09 |
| :--- | :--- | :--- |
| `65` | `provision-request-approve` | Visar/aprobar una solicitud PDS en etapa de workflow. |
| `67` | `provision-request-document-read` | Leer documentos asociados a la solicitud/resolucion. |
| `68` | `provision-request-history-read` | Leer historial/trazabilidad de la solicitud. |
| `69` | `provision-request-read` | Leer detalle de solicitud PDS. |
| `81` | `provision-request-read-waiting` | Ver solicitudes pendientes del rol. |
| `83` | `provision-request-resolution-create` | Crear resolucion, usado por decretacion. |
| `84` | `provision-request-resolution-read` | Leer resolucion. |
| `85` | `provision-request-resolution-send-to-sign` | Enviar resolucion a firma. |
| `86` | `provision-request-resolution-update` | Actualizar resolucion. |
| `70` | `provision-request-resolution-document-archive` | Archivar documento de resolucion. |
| `71` | `provision-request-resolution-document-sign` | Firmar documento de resolucion. |
| `91` | `provision-request-resolution-document-sign-with-scope` | Firma con alcance, usado en perfiles de legalidad/contraloria. |

Por ahora, los cambios necesarios estan en `bd_pepr`: asignar privilegios existentes a los perfiles que entran al nuevo flujo.

### 10.2 Asociaciones nuevas recomendadas en `bd_pepr`

Estos son solo los privilegios faltantes segun el cruce actual. No se listan asociaciones que ya existen.

| Perfil | `cod_perfil` | Privilegios faltantes a agregar | Motivo |
| :--- | :--- | :--- | :--- |
| `project_head` | `25` | `65`, `67`, `68`, `69`, `81` | Nuevo rol de visacion del Jefe de Proyecto. |
| `project_department_head` | `26` | `65`, `67`, `68`, `69`, `81` | Nuevo rol de aprobacion del Jefe de Departamento del Jefe de Proyecto. |
| `dean` | `27` | `65`, `67`, `68`, `69`, `81` | Nuevo rol de visacion Decanatura. |
| `comptroller_officer` | `28` | `65`, `67`, `68`, `69`, `71`, `81`, `91` | Nuevo rol de revision profesional de Contraloria con lectura y firma documental. |
| `human_resources_director` | `13` | `65`, `67`, `68`, `69`, `81` | Perfil existente que se usara como DGDP; hoy solo tiene permisos BACO. |
| `finance_manager` | `8` | `67` | Ya puede aprobar/leer/listar PDS, pero le falta lectura documental. |
| `finance_director` | `10` | `67` | Ya puede aprobar/leer/listar PDS, pero le falta lectura documental. |
| `academic_vice_rector` | `22` | `65`, `69` | Si se usa como etapa de Decanatura/Vicerrectoria DU09, debe poder aprobar y leer solicitud. |
| `vraf` | `23` | `69` | Ya puede aprobar/ver pendientes/documentos, pero le falta lectura directa de solicitud. |
| `head_decreeing` | `12` | `67`, `69` | Ya tiene resolucion PDS y pendientes; falta lectura documental/detalle para DU09. |
| `general_secretary` | `14` | `69` | Ya tiene firma/documentos/historial/pendientes; falta lectura directa de solicitud. |
| `rector` | `15` | `65`, `68`, `69`, `81` | Existe como perfil, pero no tiene permisos PDS de workflow/lista pendiente. Ya tiene lectura documental y firma. |
| `university_comptroller` | `17` | `65`, `69` | Ya tiene documentos/historial/firma/pendientes; falta aprobar y leer detalle si sera etapa formal de visacion. |
| `university_archive_head` | `18` | `69` | Ya tiene archivo/documentos/historial/pendientes; agregar lectura directa para consistencia DU09. |

### 10.3 Inserts `bd_pepr` sugeridos para privilegios faltantes

```sql
-- =====================================================
-- Privilegios PDS faltantes para perfiles existentes DU09
-- =====================================================

-- finance_manager - Encargado de Finanzas Unidad / Facultad
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 8, 67);

-- finance_director - Direccion de Finanzas
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 10, 67);

-- human_resources_director - DGDP
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 81);

-- academic_vice_rector - alternativa Vicerrectoria Academica
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 22, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 22, 69);

-- vraf - alternativa Vicerrectoria de Administracion y Finanzas
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 23, 69);

-- head_decreeing - Jefe de Decretacion
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 12, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 12, 69);

-- general_secretary - Secretario General
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 14, 69);

-- rector - Rector
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 81);

-- university_comptroller - Contralor Universitario
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 17, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 17, 69);

-- university_archive_head - Jefe Archivo Universitario
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 18, 69);
```

### 10.4 Inserts `bd_pepr` para perfiles nuevos DU09

Estos inserts complementan las altas de `bd_per1` propuestas en la seccion 9.3.

```sql
-- project_head - Jefe de Proyecto
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 81);

-- project_department_head - Jefe de Departamento del Jefe de Proyecto
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 81);

-- dean - Decano / Decanatura
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 81);

-- comptroller_officer - Profesional Contraloria Universitaria
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 71);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 81);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 91);
```

### 10.5 Punto de cuidado

Antes de ejecutar inserts reales, se debe validar si `cod_perfil` 25, 26, 27 y 28 siguen libres en el ambiente destino. En la base documentada, el ultimo perfil `SG/SISSOLIC` es `24`, pero el ambiente productivo podria tener altas posteriores.

## 11. Script consolidado final para copiar y pegar

Este bloque contiene los `INSERT` completos que se deben agregar para el perfilamiento DU09 segun la revision actual.

No se incluyen inserts en `bd_prvg`, porque los privilegios PDS necesarios ya existen en el catalogo actual.

```sql
-- =====================================================
-- PDS DU09 - Perfiles nuevos
-- Sistema: SG
-- Modulo: SISSOLIC
-- =====================================================

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 25, 'project_head', 'Jefe de Proyecto');

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 26, 'project_department_head', 'Jefe de Departamento del Jefe de Proyecto');

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 27, 'dean', 'Decano / Decanatura');

INSERT INTO bd_per1 (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
VALUES ('SG', 'SISSOLIC', 28, 'comptroller_officer', 'Profesional Contraloria Universitaria');


-- =====================================================
-- PDS DU09 - Privilegios para perfiles nuevos
-- Privilegios existentes:
-- 65 provision-request-approve
-- 67 provision-request-document-read
-- 68 provision-request-history-read
-- 69 provision-request-read
-- 81 provision-request-read-waiting
-- =====================================================

-- project_head - Jefe de Proyecto
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 25, 81);

-- project_department_head - Jefe de Departamento del Jefe de Proyecto
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 26, 81);

-- dean - Decano / Decanatura
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 27, 81);

-- comptroller_officer - Profesional Contraloria Universitaria
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 71);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 81);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 28, 91);


-- =====================================================
-- PDS DU09 - Privilegios faltantes para perfiles existentes
-- Solo se listan asociaciones que no aparecen en bd_pepr actual.
-- =====================================================

-- finance_manager - Director/Encargado de Finanzas Unidad
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 8, 67);

-- finance_director - Director de Finanzas
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 10, 67);

-- human_resources_director - DGDP
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 13, 81);

-- academic_vice_rector - Vicerrector Academico
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 22, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 22, 69);

-- vraf - Vicerrector de Administracion y Finanzas
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 23, 69);

-- head_decreeing - Jefe de Decretacion
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 12, 67);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 12, 69);

-- general_secretary - Secretario General
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 14, 69);

-- rector - Rector
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 68);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 69);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 15, 81);

-- university_comptroller - Contralor Universitario
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 17, 65);
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 17, 69);

-- university_archive_head - Jefe Archivo Universitario
INSERT INTO sistema_db..bd_pepr (cod_sistem, cod_modulo, cod_perfil, cod_privil) VALUES ('SG', 'SISSOLIC', 18, 69);
```
