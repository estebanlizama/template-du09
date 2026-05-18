USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P' 
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen03')
    DROP PROCEDURE Analisis2.sg_fupssSecgen03
GO

/* 
Procedimiento : Analisis2.sg_fupssSecgen03
Objetivo     : Buscar datos de un funcionario y realizar validaciones preliminares para PDS.
               Retorna perfil, jornada y el indicador SEA simplificado.
Entrada      : @rut_funcionario -> RUT del profesional a consultar.
Actualización: 2026/05/14 - Simplificado: se quitan topes de sueldo e inhabilidades de cargo por falta de tablas.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen03
    @rut_funcionario char(9) = NULL
AS
BEGIN
    -- 1. Variables de control
    DECLARE @fecha_actual datetime
    SELECT @fecha_actual = getdate()

    -- 2. Tabla temporal para consolidar datos del funcionario (Lógica SISPER)
    CREATE TABLE #PerfilFuncionario (
        rut_person      char(9),
        nombres         varchar(100),
        cod_unidad      smallint,
        des_unidad      varchar(100),
        cod_estame      char(1),
        des_estame      varchar(50),
        des_jornad      varchar(50),
        num_horas       tinyint,
        f_ing_univ      datetime,
        cod_jerpla      char(2),
        prof_acad       char(1),
        cod_ficha       int
    )

    INSERT INTO #PerfilFuncionario
    SELECT 
        p.rut_person,
        rtrim(p.nom_nombre) + ' ' + rtrim(p.nom_appate) + ' ' + rtrim(p.nom_apmate),
        con.cod_unidad,
        u.des_unidad,
        con.cod_estame,
        est.des_estame,
        jor.des_jornad,
        con.num_horas,
        con.f_ing_univ,
        con.cod_jerpla,
        con.prof_acad,
        p.cod_ficha
    FROM sisper_db..sp_pers p
    INNER JOIN sisper_db..sp_cont con ON p.cod_ficha = con.cod_ficha
    INNER JOIN ufro_db..es_unid u    ON con.cod_unidad = u.cod_unidad
    INNER JOIN sisper_db..sp_estm est ON con.cod_estame = est.cod_estame
    INNER JOIN sisper_db..sp_jorn jor ON con.cod_jornad = jor.cod_jornad
    WHERE p.rut_person = @rut_funcionario
      AND con.vigen_cont = '1' -- Solo contratos vigentes

    -- 3. Retorno de Datos con Validaciones Simplificadas
    SELECT 
        rut_person as rut,
        nombres as nombre_completo,
        cod_unidad,
        des_unidad as unidad,
        cod_estame,
        des_estame as estamento,
        des_jornad as jornada,
        
        -- Cálculo de Total de Horas Académicas (para regla SEA)
        (SELECT isnull(sum(num_horas), 0) FROM #PerfilFuncionario WHERE cod_estame = '2') as total_horas_aca,
        
        -- LÓGICA SEA: > 11 hrs académicas Y > 1 año de antigüedad
        CASE 
            WHEN (SELECT isnull(sum(num_horas), 0) FROM #PerfilFuncionario WHERE cod_estame = '2') > 11
                 AND datediff(yy, f_ing_univ, @fecha_actual) >= 1
            THEN 'S' ELSE 'N' 
        END as flag_es_sea,

        -- PENDIENTE: Inhabilidades por Cargo (Requiere tabla sp_carg actualizada)
        'N' as flag_inh_cargo,
        
        -- PENDIENTE: Tope de sueldo 50% (Requiere tabla de haberes/sueldos)
        0 as monto_tope_50pct,

        -- PENDIENTE: Deudas pendientes (Requiere integración con Cobranzas)
        'N' as flag_tiene_deudas

    FROM #PerfilFuncionario
    GROUP BY rut_person, nombres, cod_unidad, des_unidad, cod_estame, des_estame, des_jornad, f_ing_univ

    DROP TABLE #PerfilFuncionario
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen03 TO UsuaVrac
GO
