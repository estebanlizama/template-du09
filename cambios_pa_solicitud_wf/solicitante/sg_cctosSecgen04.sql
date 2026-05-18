/* 
Procedimiento : Analisis2.sg_cctosSecgen04
Objetivo     : Listar Centros de Costo habilitados por RUT.
               Soporta Flujo Legacy (1) y Flujo DU09/Fase 2 (2).
Modificaciones:
- 2024/08/29: Creación original (ELA).
- 2026/05/13: Integración de Flujo DU09 con validación de Fondos 21/44, 
              Saldo Disponible (sf_salp) y descripciones (sf_deaf, es_tfin, es_ufin).
              Se incluye bandera ind_anid para excepción del 50%.
*/

ALTER PROCEDURE Analisis2.sg_cctosSecgen04 
    @rut char(9) = NULL,
    @id_modprse tinyint = 1 -- 1: Legacy, 2: DU09/Fase 2
AS
BEGIN
    -- Validar RUT obligatorio
    IF @rut IS NULL
    BEGIN
        SELECT 'Falta el rut. Se aborta el procedimiento' as msg RETURN
    END

    -- =========================================================================
    -- FLUJO DU09 / FASE 2 (REGLAS DE NO-ESTRUCTURALIDAD Y CONTROL FINANCIERO)
    -- =========================================================================
    IF @id_modprse = 2 
    BEGIN
        SELECT
            ccto.cod_ccto,
            ccto.cod_unifin,
            -- Identificador estandarizado Unidad.CC
            convert(varchar(10), ccto.cod_unifin) + '.' + convert(varchar(10), ccto.cod_ccto) as id_completo,
            ccto.nom_ccto as nombre_proyecto,
            ccto.cod_tfinan,
            tfin.des_tfinan as tipo_financiamiento,
            ufin.des_unifin as unidad_ejecutora,
            ecct.rut as rut_jefe_proyecto,
            (pers.nom_nombre + ' ' + pers.nom_appate + ' ' + pers.nom_apmate) as nombre_jefe_proyecto,
            -- Cálculo de Saldo Disponible real para Personal (Subtítulo 21)
            -- Se filtra por el año de proceso vigente para evitar arrastres de años anteriores
            -- Nota: Para mayor granularidad por ítem (Adm/Aux), se debe consultar el cod_sitm específico
            ISNULL((SELECT SUM(s.mto_presup - s.mto_compro) 
             FROM fin21_db..sf_salp s 
             WHERE s.cod_ccto = ccto.cod_ccto 
               AND s.cod_unifin = ccto.cod_unifin
               AND s.ano_proces = YEAR(GETDATE())  -- Regla: Solo presupuesto del año en curso
               AND s.cod_sitm LIKE '21%'), 0) as saldo_disponible_personal,
            
            deaf.des_decafe as decreto_descripcion
        FROM fin21_db..es_ccto ccto
        INNER JOIN fin21_db..es_ecct ecct ON ecct.cod_ccto = ccto.cod_ccto AND ecct.cod_unifin = ccto.cod_unifin
        INNER JOIN fin21_db..es_tfin tfin ON tfin.cod_tfinan = ccto.cod_tfinan
        INNER JOIN fin21_db..es_ufin ufin ON ufin.cod_unifin = ccto.cod_unifin
        LEFT JOIN fin21_db..sf_deaf deaf ON deaf.decr_afect = ccto.decr_afect
        LEFT JOIN sisper_db..sp_pers pers ON pers.rut_person = ecct.rut
        WHERE ecct.rut = @rut 
          AND ecct.vigente = 'S'           -- El usuario debe estar vigente en la estructura del CCto
          AND ccto.cod_tfinan IN (21, 44) -- REGLA DU09: No permite fondo 11 (Institucional)
          AND ccto.vigente = '1'           -- Proyecto abierto y activo presupuestariamente
    END
    -- =========================================================================
    -- FLUJO LEGACY (DOCENTES ESPECIALES - COMPATIBILIDAD ORIGINARIA)
    -- =========================================================================
    ELSE 
    BEGIN
        DECLARE @unidad_mayor CHAR(8)

        SELECT 
            @unidad_mayor = substring(uni.cod_unidad, 1, 2) + '000000'
        FROM 
            sisper_db..sp_pers pers
        INNER JOIN 
            ufro_db..es_unid uni ON uni.cod_unidad = pers.u_original
        WHERE 
            pers.rut_person = @rut AND uni.vigente = 'S'

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
        FROM
            fin21_db..es_ccto ccto
        LEFT JOIN 
            fin21_db..es_ecct ecct ON ecct.cod_ccto = ccto.cod_ccto AND ecct.cod_unifin = ccto.cod_unifin
        LEFT JOIN 
            sisper_db..sp_pers pers ON ecct.rut = pers.rut_person
        LEFT JOIN 
            ufro_db..es_unid uni ON uni.cod_unidad = pers.u_original
        WHERE
            uni.cod_unidad LIKE LEFT(@unidad_mayor, 2) + '%'
        AND 
            ecct.vigente = 'S'
    END
END
