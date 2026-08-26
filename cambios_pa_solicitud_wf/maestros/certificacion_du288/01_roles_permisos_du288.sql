/*
===============================================================================
DU288 - ROLES Y PERMISOS PARA AMBIENTACION DE CERTIFICACION
Motor  : Sybase ASE 12.5
Modulo : SG / SISSOLIC

Alcance exclusivo:
  - perfiles que participan en DU288;
  - privilegios PDS utilizados por esos perfiles;
  - matriz completa perfil/privilegio requerida por DU288.

No carga perfiles ni privilegios de otros modulos. No crea usuarios en sg_uspe:
los actores dinamicos se resuelven por etapa y RUT asignado en sg_apso.
Los IDs definidos se conservan sin recalcularlos.
===============================================================================
*/

USE sistema_db
GO

SET NOCOUNT ON
GO

/* -------------------------------------------------------------------------
   1. PERFILES DU288
   ------------------------------------------------------------------------- */

CREATE TABLE #roles_du288 (
    cod_perfil smallint NOT NULL,
    des_perfil varchar(60) NOT NULL,
    des_perext varchar(100) NOT NULL
)

INSERT INTO #roles_du288 VALUES (6,  'prse_applicant',              'Solicitante prestacion de servicio')
INSERT INTO #roles_du288 VALUES (8,  'finance_manager',             'Director/Encargado de finanzas unidad')
INSERT INTO #roles_du288 VALUES (10, 'finance_director',            'Director de Finanzas')
INSERT INTO #roles_du288 VALUES (12, 'head_decreeing',              'Jefe de decretación')
INSERT INTO #roles_du288 VALUES (13, 'human_resources_director',    'Director DGDP')
INSERT INTO #roles_du288 VALUES (14, 'general_secretary',           'Secretario General')
INSERT INTO #roles_du288 VALUES (15, 'rector',                      'Rector')
INSERT INTO #roles_du288 VALUES (16, 'legality_director',           'Director de Legalidad')
INSERT INTO #roles_du288 VALUES (17, 'university_comptroller',      'Contralor Universitario')
INSERT INTO #roles_du288 VALUES (18, 'university_archive_head',     'Jefe de archivo Universitario')
INSERT INTO #roles_du288 VALUES (22, 'academic_vice_rector',        'Vicerrector Académico')
INSERT INTO #roles_du288 VALUES (23, 'vraf',                        'Vicerrector de Administración y Finanzas')
INSERT INTO #roles_du288 VALUES (25, 'project_head',                'Jefe de Proyecto')
INSERT INTO #roles_du288 VALUES (26, 'project_department_head',     'Jefe de Departamento del Jefe de Proyecto')
INSERT INTO #roles_du288 VALUES (27, 'dean',                        'Decano / Decanatura')
INSERT INTO #roles_du288 VALUES (28, 'comptroller_officer',         'Profesional Contraloria Universitaria')
GO

UPDATE sistema_db.dbo.bd_per1
SET des_perfil = r.des_perfil,
    des_perext = r.des_perext
FROM sistema_db.dbo.bd_per1 p, #roles_du288 r
WHERE p.cod_sistem = 'SG'
  AND p.cod_modulo = 'SISSOLIC'
  AND p.cod_perfil = r.cod_perfil
GO

INSERT INTO sistema_db.dbo.bd_per1
    (cod_sistem, cod_modulo, cod_perfil, des_perfil, des_perext)
SELECT 'SG', 'SISSOLIC', r.cod_perfil, r.des_perfil, r.des_perext
FROM #roles_du288 r
WHERE NOT EXISTS (
    SELECT 1
    FROM sistema_db.dbo.bd_per1 p
    WHERE p.cod_sistem = 'SG'
      AND p.cod_modulo = 'SISSOLIC'
      AND p.cod_perfil = r.cod_perfil
)
GO

/* -------------------------------------------------------------------------
   2. PRIVILEGIOS PDS UTILIZADOS POR DU288
   ------------------------------------------------------------------------- */

CREATE TABLE #privilegios_du288 (
    cod_privil smallint NOT NULL,
    nom_privil varchar(100) NOT NULL
)

INSERT INTO #privilegios_du288 VALUES (65, 'provision-request-approve')
INSERT INTO #privilegios_du288 VALUES (66, 'provision-request-create')
INSERT INTO #privilegios_du288 VALUES (67, 'provision-request-document-read')
INSERT INTO #privilegios_du288 VALUES (68, 'provision-request-history-read')
INSERT INTO #privilegios_du288 VALUES (69, 'provision-request-read')
INSERT INTO #privilegios_du288 VALUES (70, 'provision-request-resolution-document-archive')
INSERT INTO #privilegios_du288 VALUES (71, 'provision-request-resolution-document-sign')
INSERT INTO #privilegios_du288 VALUES (81, 'provision-request-read-waiting')
INSERT INTO #privilegios_du288 VALUES (83, 'provision-request-resolution-create')
INSERT INTO #privilegios_du288 VALUES (84, 'provision-request-resolution-read')
INSERT INTO #privilegios_du288 VALUES (85, 'provision-request-resolution-send-to-sign')
INSERT INTO #privilegios_du288 VALUES (86, 'provision-request-resolution-update')
INSERT INTO #privilegios_du288 VALUES (91, 'provision-request-resolution-document-sign-with-scope')
GO

UPDATE sistema_db.dbo.bd_prvg
SET des_privil = v.nom_privil,
    nom_privil = v.nom_privil
FROM sistema_db.dbo.bd_prvg p, #privilegios_du288 v
WHERE p.cod_sistem = 'SG'
  AND p.cod_modulo = 'SISSOLIC'
  AND p.cod_privil = v.cod_privil
GO

INSERT INTO sistema_db.dbo.bd_prvg
    (cod_sistem, cod_modulo, cod_privil, des_privil, nom_privil)
SELECT 'SG', 'SISSOLIC', v.cod_privil, v.nom_privil, v.nom_privil
FROM #privilegios_du288 v
WHERE NOT EXISTS (
    SELECT 1
    FROM sistema_db.dbo.bd_prvg p
    WHERE p.cod_sistem = 'SG'
      AND p.cod_modulo = 'SISSOLIC'
      AND p.cod_privil = v.cod_privil
)
GO

/* -------------------------------------------------------------------------
   3. MATRIZ COMPLETA PERFIL / PRIVILEGIO DU288

   Incluye la base existente y los complementos definidos para DU288. Solo
   agrega asociaciones faltantes; no elimina permisos institucionales.
   ------------------------------------------------------------------------- */

CREATE TABLE #perfil_privilegio_du288 (
    cod_perfil smallint NOT NULL,
    cod_privil smallint NOT NULL
)

/* Solicitante PDS. */
INSERT INTO #perfil_privilegio_du288 VALUES (6, 66)
INSERT INTO #perfil_privilegio_du288 VALUES (6, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (6, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (6, 81)

/* Finanzas de unidad y Direccion de Finanzas. */
INSERT INTO #perfil_privilegio_du288 VALUES (8, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (8, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (8, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (8, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (8, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (10, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (10, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (10, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (10, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (10, 81)

/* Decretacion y DGDP. */
INSERT INTO #perfil_privilegio_du288 VALUES (12, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 83)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 84)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 85)
INSERT INTO #perfil_privilegio_du288 VALUES (12, 86)
INSERT INTO #perfil_privilegio_du288 VALUES (13, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (13, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (13, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (13, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (13, 81)

/* Firmas y control institucional. */
INSERT INTO #perfil_privilegio_du288 VALUES (14, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (14, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (14, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (14, 71)
INSERT INTO #perfil_privilegio_du288 VALUES (14, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (14, 91)
INSERT INTO #perfil_privilegio_du288 VALUES (15, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (15, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (15, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (15, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (15, 71)
INSERT INTO #perfil_privilegio_du288 VALUES (15, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (16, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (16, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (16, 71)
INSERT INTO #perfil_privilegio_du288 VALUES (16, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (16, 91)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 71)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (17, 91)
INSERT INTO #perfil_privilegio_du288 VALUES (18, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (18, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (18, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (18, 70)
INSERT INTO #perfil_privilegio_du288 VALUES (18, 81)

/* Autoridades de facultad/vicerrectoria. */
INSERT INTO #perfil_privilegio_du288 VALUES (22, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (22, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (22, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (22, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (22, 71)
INSERT INTO #perfil_privilegio_du288 VALUES (22, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 70)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (23, 91)

/* Perfiles nuevos definidos para DU288. */
INSERT INTO #perfil_privilegio_du288 VALUES (25, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (25, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (25, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (25, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (25, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (26, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (26, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (26, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (26, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (26, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (27, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (27, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (27, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (27, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (27, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 65)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 67)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 68)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 69)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 71)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 81)
INSERT INTO #perfil_privilegio_du288 VALUES (28, 91)
GO

INSERT INTO sistema_db.dbo.bd_pepr
    (cod_sistem, cod_modulo, cod_perfil, cod_privil)
SELECT 'SG', 'SISSOLIC', x.cod_perfil, x.cod_privil
FROM #perfil_privilegio_du288 x
WHERE NOT EXISTS (
    SELECT 1
    FROM sistema_db.dbo.bd_pepr p
    WHERE p.cod_sistem = 'SG'
      AND p.cod_modulo = 'SISSOLIC'
      AND p.cod_perfil = x.cod_perfil
      AND p.cod_privil = x.cod_privil
)
GO

DROP TABLE #perfil_privilegio_du288
DROP TABLE #privilegios_du288
DROP TABLE #roles_du288
GO
