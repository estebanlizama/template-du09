USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen11')
    DROP PROCEDURE Analisis2.sg_fupssSecgen11
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen11
Objetivo      : Obtener la remuneracion efectuada de referencia de un funcionario.
                El calculo se realiza por ficha y mes, no por contrato.
Parametros    :
    @rut     char(9)     : RUT del funcionario.
    @mes_ano varchar(10) : Mes de remuneracion opcional. Si no se informa,
                           se usa el ultimo mes disponible en ss_habe.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen11
    @rut char(9) = NULL,
    @mes_ano varchar(10) = NULL
AS
BEGIN
    DECLARE @cod_ficha varchar(10)

    IF @rut IS NULL OR ltrim(rtrim(@rut)) = ''
    BEGIN
        SELECT 'Falta rut' msg
        RETURN
    END

    SELECT @cod_ficha = pers.cod_ficha
    FROM sisper_db.dbo.sp_pers pers
    WHERE pers.rut_person = @rut

    IF @cod_ficha IS NULL
    BEGIN
        SELECT 'No existe funcionario para el rut informado' msg
        RETURN
    END

    IF @mes_ano IS NULL OR ltrim(rtrim(@mes_ano)) = ''
    BEGIN
        SET ROWCOUNT 1

        SELECT @mes_ano = habe.mes_ano
        FROM sisper_db..ss_habe habe
        WHERE habe.cod_ficha = @cod_ficha
          AND charindex(' ', habe.mes_ano) > 0
        GROUP BY habe.mes_ano
        ORDER BY
            convert(int, substring(habe.mes_ano, charindex(' ', habe.mes_ano) + 1, 4)) DESC,
            convert(int, substring(habe.mes_ano, 1, charindex(' ', habe.mes_ano) - 1)) DESC

        SET ROWCOUNT 0
    END

    IF @mes_ano IS NULL
    BEGIN
        SELECT 'No existen haberes para el funcionario informado' msg
        RETURN
    END

    SELECT
        habe.cod_ficha,
        habe.mes_ano,
        max(habe.num_compl) AS num_compl
    INTO #Planilla
    FROM sisper_db..ss_habe habe
    WHERE habe.cod_ficha = @cod_ficha
      AND habe.mes_ano = @mes_ano
    GROUP BY
        habe.cod_ficha,
        habe.mes_ano

    IF NOT EXISTS (SELECT 1 FROM #Planilla)
    BEGIN
        SELECT 'No existen haberes para el mes informado' msg
        DROP TABLE #Planilla
        RETURN
    END

    SELECT
        pers.rut_person AS rut,
        pers.cod_ficha,
        rtrim(isnull(pers.nom_nombre, '')) + ' ' +
        rtrim(isnull(pers.nom_appate, '')) + ' ' +
        rtrim(isnull(pers.nom_apmate, '')) AS nombre_funcionario,
        planilla.mes_ano AS mes_remuneracion,
        planilla.num_compl AS complemento_remuneracion,
        sum(CASE
                WHEN habe.num_cuenta = '2001' THEN isnull(habe.v_efectuad, 0)
                ELSE 0
            END) AS sueldo_base_efectuado,
        sum(isnull(habe.v_efectuad, 0)) AS remuneracion_efectuada
    FROM #Planilla planilla
    INNER JOIN sisper_db..ss_habe habe
            ON habe.cod_ficha = planilla.cod_ficha
           AND habe.mes_ano = planilla.mes_ano
           AND habe.num_compl = planilla.num_compl
    INNER JOIN sisper_db..sp_pers pers
            ON pers.cod_ficha = habe.cod_ficha
    INNER JOIN fin21_db..es_ccto ccto
            ON ccto.cod_unifin = habe.cod_unifin
           AND ccto.cod_ccto = habe.cod_ccto
    INNER JOIN sisper_db..sp_para para
            ON para.num_cuenta = habe.num_cuenta
    WHERE habe.num_cuenta LIKE '2%'
      AND habe.num_cuenta NOT IN ('2032', '2043', '2044', '2056', '2066', '2067', '2079', '2090', '2402', '2403', '2414', '2417', '2418')
    GROUP BY
        pers.rut_person,
        pers.cod_ficha,
        pers.nom_nombre,
        pers.nom_appate,
        pers.nom_apmate,
        planilla.mes_ano,
        planilla.num_compl

    DROP TABLE #Planilla
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen11 TO UsuaVrac
GO
