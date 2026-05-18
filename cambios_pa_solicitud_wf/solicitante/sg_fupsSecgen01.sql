USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen01')
    DROP PROCEDURE Analisis2.sg_fupssSecgen01
GO

/* 
Procedimiento : Analisis2.sg_fupssSecgen01
Objetivo     : Búsqueda de funcionario para PDS con lógica SEA simplificada y validaciones DU09.
               Incluye marcadores para validaciones futuras (Inhabilidades, Deudas, Topes).
Actualización: 2026/05/14
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen01
    @rut_funcionario char(9) = NULL
AS
BEGIN
    DECLARE @fecha_actual datetime
    SELECT @fecha_actual = getdate()

    SELECT 
        p.rut_person as rut,
        rtrim(p.nom_nombre) + ' ' + rtrim(p.nom_appate) + ' ' + rtrim(p.nom_apmate) as nombre_completo,
        
        -- Datos de la Unidad
        con.cod_unidad,
        uni.des_unidad as unidad_desc,
        
        -- Estamento
        con.cod_estame,
        est.des_estame as estamento_desc,
        
        -- Jerarquía
        con.cod_jerpla,
        jer.des_jerpla as jerarquia_desc,
        
        -- Jornada
        con.cod_jornad,
        jor.des_jornad as jornada_desc,
        con.num_horas,

        -- FLAG OBLIGA COMPENSACIÓN: 'S' si tiene Jornada Completa (44 hrs)
        CASE 
            WHEN con.cod_jornad = '01' THEN 'S' ELSE 'N' 
        END as flag_obliga_compensacion,

        -- LÓGICA SEA: Suma de TODAS las horas académicas del RUT > 11 y Antigüedad > 1 año
        CASE 
            WHEN (SELECT isnull(sum(c2.num_horas), 0) 
                  FROM sisper_db..sp_cont c2 
                  INNER JOIN sisper_db..sp_pers p2 ON p2.cod_ficha = c2.cod_ficha
                  WHERE p2.rut_person = p.rut_person AND c2.cod_estame = '2' AND c2.vigen_cont = '1') > 11
                 AND datediff(yy, p.f_ing_univ, @fecha_actual) >= 1
            THEN 'S' ELSE 'N' 
        END as flag_es_sea,
        
        -- =========================================================================================
        -- VALIDACIONES PENDIENTES (FASE 2 - REQUERIRÁ TABLAS ACTUALIZADAS)
        -- =========================================================================================
        
        /* 1. INHABILIDADES POR CARGO: 
           Aun no se puede validar ya que las tablas de cargos (sp_carg) no están totalmente confiables 
           o mapeadas para autoridades superiores según DU288. */
        'PENDIENTE' as flag_inh_cargo,

        /* 2. DEUDAS PENDIENTES: 
           Se debe integrar la consulta a la base de datos de Cobranzas/Finanzas para detectar 
           morosidades del funcionario con la Universidad. */
        'PENDIENTE' as flag_tiene_deudas,

        /* 3. TOPES POR CARGO Y CONTRATO: 
           Se debe obtener el tope de remuneración (regla 50%) para cada cargo específico en el contrato.
           Cada registro de contrato devuelto aquí debe validar su propio límite de renta. */
        0 as monto_tope_50pct

    FROM sisper_db..sp_pers p
    INNER JOIN sisper_db..sp_cont con ON con.cod_ficha = p.cod_ficha
    INNER JOIN ufro_db..es_unid uni   ON uni.cod_unidad = con.cod_unidad
    LEFT JOIN sisper_db..sp_estm est  ON est.cod_estame = con.cod_estame
    LEFT JOIN sisper_db..sp_jorn jor  ON jor.cod_jornad = con.cod_jornad
    LEFT JOIN sisper_db..sp_jpfu jer  ON jer.cod_jerpla = con.cod_jerpla
    LEFT JOIN sisper_db..sp_cali cal  ON cal.cod_calida = con.cod_calida
    WHERE p.rut_person = @rut_funcionario
      AND p.vigente = '1'
      AND con.vigen_cont = '1'
      AND con.cod_calida IN ('03', '04')
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen01 TO UsuaVrac
GO
