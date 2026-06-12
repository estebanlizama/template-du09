USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_cctosSecgen05')
    DROP PROCEDURE Analisis2.sg_cctosSecgen05
GO

/*
================================================================================
Procedimiento : Analisis2.sg_cctosSecgen05
Base de Datos : secgen_db
Objetivo      : Listar los centros de costo habilitados y vigentes asociados a 
                un RUT según la modalidad de prestación.
                - Modprse = 1 (Legacy): Centros asociados a la unidad del usuario.
                - Modprse = 2 (DU288): Centros donde el RUT es jefe/responsable vigente.

Parámetros    :
    @rut         char(9)    : RUT del usuario/funcionario a consultar (obligatorio).
    @id_modprse  tinyint    : Modalidad de prestación (1: Legacy, 2: DU288/DU09).

Historial de Modificaciones:
    Fecha        Autor             Descripción
    ----------   ---------------   ---------------------------------------------
    2026-06-10   Ecosistema UFRO   - Adición de modalidad DU288 (id_modprse = 2).
                                   - Incorporación de flags de validación (vigente_ccto,
                                     vigente_responsable, ind_financiamiento_du288,
                                     ind_decreto_afecto).
                                   - Determinación estricta de Formación Continua
                                     (ind_formacion_continua) usando decreto afecto (DU 305).
================================================================================
*/

CREATE PROCEDURE Analisis2.sg_cctosSecgen05
    @rut char(9) = NULL,
    @id_modprse tinyint = 1 -- 1 Legacy, 2 DU288/Fase 2
AS
BEGIN
    -- Validación de parámetro obligatorio
    IF @rut IS NULL
    BEGIN
        SELECT 'Falta el rut. Se aborta el procedimiento' AS msg
        RETURN
    END

    -- FLUJO DU288 (Fase 2)
    IF @id_modprse = 2
    BEGIN
        SELECT
            ccto.cod_ccto,
            ccto.cod_unifin,
            ccto.cod_tfinan,
            ccto.cod_tcsald,
            ccto.f_creacion,
            ccto.nom_ccto,
            ccto.nom_ab_cct,
            ccto.cc_global,
            ccto.pry_global,
            ecct.rut AS rut_person,
            ecct.rut AS rut_jefe_proyecto,
            pers.nom_nombre,
            pers.nom_appate,
            pers.nom_apmate,
            (pers.nom_nombre + ' ' + pers.nom_appate + ' ' + pers.nom_apmate) AS nombre_jefe_proyecto,
            tfin.des_tfinan AS tipo_financiamiento,
            ufin.des_unifin AS unidad_ejecutora,
            deaf.des_decafe AS decreto_descripcion,
            ccto.decr_afect,
            ccto.vigente AS vigente_ccto,
            ecct.vigente AS vigente_responsable,
            CASE WHEN ccto.cod_tfinan IN (21, 44) THEN 'S' ELSE 'N' END AS ind_financiamiento_du288,
            CASE WHEN ccto.decr_afect IS NULL THEN 'N' ELSE 'S' END AS ind_decreto_afecto,
            CASE WHEN ccto.decr_afect = '1' THEN 'S' ELSE 'N' END AS ind_formacion_continua
        FROM fin21_db..es_ccto ccto
        INNER JOIN fin21_db..es_ecct ecct
                ON ecct.cod_ccto = ccto.cod_ccto
               AND ecct.cod_unifin = ccto.cod_unifin
        INNER JOIN fin21_db..es_tfin tfin
                ON tfin.cod_tfinan = ccto.cod_tfinan
        INNER JOIN fin21_db..es_ufin ufin
                ON ufin.cod_unifin = ccto.cod_unifin
        LEFT JOIN fin21_db..sf_deaf deaf
               ON deaf.decr_afect = ccto.decr_afect
        LEFT JOIN sisper_db..sp_pers pers
               ON pers.rut_person = ecct.rut
        WHERE ecct.rut = @rut
          AND ecct.vigente = 'S'
          AND ccto.vigente = '1'
          AND ccto.cod_tfinan IN (21, 44)
    END
    -- FLUJO LEGACY (Fase 1)
    ELSE
    BEGIN
        DECLARE @unidad_mayor char(8)

        SELECT
            @unidad_mayor = SUBSTRING(uni.cod_unidad, 1, 2) + '000000'
        FROM sisper_db..sp_pers pers
        INNER JOIN ufro_db..es_unid uni
                ON uni.cod_unidad = pers.u_original
        WHERE pers.rut_person = @rut
          AND uni.vigente = 'S'

        SELECT
            pers.rut_person,
            ccto.cod_ccto,
            ccto.cod_unifin,
            ccto.cod_tfinan,
            ccto.cod_tcsald,
            ccto.f_creacion,
            ecct.rut,
            ccto.nom_ccto,
            ccto.nom_ab_cct,
            pers.nom_nombre,
            pers.nom_appate,
            pers.nom_apmate
        FROM fin21_db..es_ccto ccto
        LEFT JOIN fin21_db..es_ecct ecct
               ON ecct.cod_ccto = ccto.cod_ccto
              AND ecct.cod_unifin = ccto.cod_unifin
        LEFT JOIN sisper_db..sp_pers pers
               ON ecct.rut = pers.rut_person
        LEFT JOIN ufro_db..es_unid uni
               ON uni.cod_unidad = pers.u_original
        WHERE uni.cod_unidad LIKE LEFT(@unidad_mayor, 2) + '%'
          AND ecct.vigente = 'S'
    END
END
GO

GRANT EXECUTE ON Analisis2.sg_cctosSecgen05 TO UsuaVrac
GO
