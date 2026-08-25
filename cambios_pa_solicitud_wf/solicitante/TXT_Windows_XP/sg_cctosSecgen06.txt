USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_cctosSecgen06')
    DROP PROCEDURE Analisis2.sg_cctosSecgen06
GO

/* Procedimiento : Analisis2.sg_cctosSecgen06

   Entrada :
   @cod_unifin          -> Unidad financiera. (Opcional)
   @cod_ccto            -> Centro de costo. (Opcional)
   @fecha_eval          -> Fecha de evaluacion. (Opcional)

   Objetivo : Obtener el saldo disponible consolidado por item presupuestario y general de un Centro de Costo.

   Creacion: EL 2026/07/10
   Actualizacion: Sin registro
*/

CREATE PROCEDURE Analisis2.sg_cctosSecgen06
    @cod_unifin int = NULL,
    @cod_ccto   int = NULL,
    @fecha_eval datetime = NULL
AS
BEGIN
    IF @cod_unifin IS NULL OR @cod_ccto IS NULL
    BEGIN
        SELECT
            'ERROR' AS tipo_registro,
            convert(int, isnull(@cod_unifin, 0)) AS cod_unifin,
            convert(int, isnull(@cod_ccto, 0)) AS cod_ccto,
            convert(int, NULL) AS tipo_cc,
            convert(varchar(5), NULL) AS item_presupuestario,
            convert(varchar(255), NULL) AS nombre_item,
            convert(decimal(20,4), 0) AS saldo_presupuesto,
            convert(decimal(20,4), 0) AS saldo_percibido,
            convert(decimal(20,4), 0) AS saldo_compromiso,
            convert(decimal(20,4), 0) AS saldo_disponible,
            0 AS status,
            'Faltan parametros de Unidad o Centro de Costo' AS mensaje
        RETURN
    END

    DECLARE @cod_unifin1   smallint
    DECLARE @cod_ccto1     smallint
    DECLARE @tipo_cc       smallint
    DECLARE @fecha_val     datetime
    DECLARE @f_creacion    datetime
    DECLARE @f_cierre      datetime
    DECLARE @f_ven_sob     datetime
    DECLARE @mto_sobreg    int
    DECLARE @f_ven_sob2    datetime
    DECLARE @mto_sobreg2   int
    DECLARE @bloqueo       char(1)
    DECLARE @f_inicio      char(10)
    DECLARE @ano           smallint

    SELECT @cod_unifin1 = convert(smallint, @cod_unifin)
    SELECT @cod_ccto1  = convert(smallint, @cod_ccto)

    SELECT @fecha_val = isnull(@fecha_eval, getdate())
    SELECT @ano = datepart(yy, convert(datetime, @fecha_val, 103))
    SELECT @f_inicio = '31/12/' + convert(char(4), @ano - 1)

    /* 1. Obtener tipo de centro de costo y vigencia */
    SELECT 
        @tipo_cc = t.cod_tfondo,
        @f_cierre = es.f_cierre,
        @f_ven_sob = es.f_ven_sob,
        @mto_sobreg = es.mto_sobreg,
        @f_creacion = es.f_creacion,
        @mto_sobreg2 = es.mto_sobre2,
        @f_ven_sob2 = es.f_ven_so2,
        @bloqueo = es.bloqueo
    FROM fin21_db..es_ccto es
    INNER JOIN fin21_db..es_tfin t ON t.cod_tfinan = es.cod_tfinan
    WHERE es.cod_unifin = @cod_unifin1
      AND es.cod_ccto = @cod_ccto1

    IF @tipo_cc IS NULL
    BEGIN
        SELECT
            'ERROR' AS tipo_registro,
            convert(int, @cod_unifin1) AS cod_unifin,
            convert(int, @cod_ccto1) AS cod_ccto,
            convert(int, NULL) AS tipo_cc,
            convert(varchar(5), NULL) AS item_presupuestario,
            convert(varchar(255), NULL) AS nombre_item,
            convert(decimal(20,4), 0) AS saldo_presupuesto,
            convert(decimal(20,4), 0) AS saldo_percibido,
            convert(decimal(20,4), 0) AS saldo_compromiso,
            convert(decimal(20,4), 0) AS saldo_disponible,
            0 AS status,
            'Centro de costo no encontrado' AS mensaje
        RETURN
    END

    IF isnull(@bloqueo, '0') = '1'
    BEGIN
        SELECT
            'ERROR' AS tipo_registro,
            convert(int, @cod_unifin1) AS cod_unifin,
            convert(int, @cod_ccto1) AS cod_ccto,
            convert(int, @tipo_cc) AS tipo_cc,
            convert(varchar(5), NULL) AS item_presupuestario,
            convert(varchar(255), NULL) AS nombre_item,
            convert(decimal(20,4), 0) AS saldo_presupuesto,
            convert(decimal(20,4), 0) AS saldo_percibido,
            convert(decimal(20,4), 0) AS saldo_compromiso,
            convert(decimal(20,4), 0) AS saldo_disponible,
            0 AS status,
            'El centro de costo esta bloqueado' AS mensaje
        RETURN
    END

    IF isnull(@f_cierre, @fecha_val) < @fecha_val
    BEGIN
        SELECT
            'ERROR' AS tipo_registro,
            convert(int, @cod_unifin1) AS cod_unifin,
            convert(int, @cod_ccto1) AS cod_ccto,
            convert(int, @tipo_cc) AS tipo_cc,
            convert(varchar(5), NULL) AS item_presupuestario,
            convert(varchar(255), NULL) AS nombre_item,
            convert(decimal(20,4), 0) AS saldo_presupuesto,
            convert(decimal(20,4), 0) AS saldo_percibido,
            convert(decimal(20,4), 0) AS saldo_compromiso,
            convert(decimal(20,4), 0) AS saldo_disponible,
            0 AS status,
            'El centro de costo esta cerrado' AS mensaje
        RETURN
    END

    /* 2. Crear tablas temporales de movimientos */
    CREATE TABLE #depr (
        numero int null, 
        cod_unifin smallint null, 
        cod_ccto smallint null, 
        cod_sitm varchar(5) null, 
        cod_tipmov tinyint null, 
        cod_moneda smallint null,  
        valor decimal(15,2) null, 
        valor_his decimal(15,2) null
    )

    CREATE TABLE #depr2 (
        numero int null, 
        cod_unifin smallint null, 
        cod_ccto smallint null, 
        cod_sitm varchar(5) null, 
        cod_tipmov tinyint null, 
        cod_moneda smallint null,  
        valor decimal(15,2) null, 
        valor_his decimal(15,2) null
    )

    CREATE TABLE #depr3 (
        numero int null, 
        cod_unifin smallint null, 
        cod_ccto smallint null, 
        cod_sitm varchar(5) null, 
        cod_tipmov tinyint null, 
        cod_moneda smallint null,  
        valor decimal(15,2) null, 
        valor_his decimal(15,2) null
    )

    CREATE TABLE #docs (
        numero int null, 
        f_ingreso datetime null,  
        afect_sald char(1) null,  
        valida char(1) null, 
        cod_tipodoc smallint null, 
        f_cierre datetime null, 
        ano smallint null, 
        mes smallint null, 
        ano_docume smallint null, 
        mes_docume smallint null
    )

    CREATE TABLE #docs2 (
        numero int null, 
        f_ingreso datetime null,  
        afect_sald char(1) null,  
        valida char(1) null, 
        cod_tipodoc smallint null, 
        f_cierre datetime null, 
        ano smallint null, 
        mes smallint null, 
        ano_docume smallint null, 
        mes_docume smallint null
    )

    CREATE TABLE #docs3 (
        numero int null, 
        f_ingreso datetime null,  
        afect_sald char(1) null,  
        valida char(1) null, 
        cod_tipodoc smallint null, 
        f_cierre datetime null, 
        ano smallint null, 
        mes smallint null, 
        ano_docume smallint null, 
        mes_docume smallint null
    )

    CREATE TABLE #pfoc (
        numero int null, 
        sf_numero int null, 
        abono decimal(15,2) null, 
        afect_sald char(1) null
    )

    CREATE TABLE #pfoc3 (
        numero int null, 
        sf_numero int null, 
        abono decimal(15,2) null, 
        afect_sald char(1) null
    )

    CREATE TABLE #resumen_saldos (
        cod_sitm varchar(5) null, 
        cod_unifin smallint null, 
        cod_ccto smallint null,         
        mes smallint null, 
        ano smallint null, 
        cod_moneda smallint null, 
        f_cierre datetime null,        
        saldo_mone decimal(20,4) null, 
        saldo_prsp decimal(20,4) null, 
        saldo_devg decimal(20,4) null,         
        saldo_perc decimal(20,4) null, 
        saldo_comp decimal(20,4) null, 
        saldo_pago decimal(20,4) null,        
        saldo decimal(20,4) null
    )

    /* 3. Cargar movimientos de detalle de presupuesto */
    INSERT INTO #depr (numero, cod_unifin, cod_ccto, cod_sitm, cod_tipmov, cod_moneda, valor, valor_his)
    SELECT numero, cod_unifin, cod_ccto, cod_sitm, cod_tipmov, cod_moneda, sum(valor), sum(valor_his)
    FROM fin21_db..pt_depr
    WHERE f_ingreso > convert(datetime, @f_inicio, 103)
      AND f_ingreso <= convert(datetime, @fecha_val, 103)
      AND cod_unifin = @cod_unifin1
      AND cod_ccto = @cod_ccto1
    GROUP BY numero, cod_unifin, cod_ccto, cod_sitm, cod_tipmov, cod_moneda

    /* 4. Cargar documentos financieros de la sesion */
    INSERT INTO #docs (numero, f_ingreso, afect_sald, valida, cod_tipodoc, f_cierre, ano, mes, ano_docume, mes_docume)
    SELECT DISTINCT d.numero, d.f_ingreso, d.afect_sald, d.valida, d.cod_tipodoc, d.f_cierre, datepart(yy, d.f_ingreso), datepart(mm, d.f_ingreso), ano_docume, mes_docume
    FROM #depr p
    INNER JOIN fin21_db..sf_docf d ON p.numero = d.numero
    WHERE d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1

    INSERT INTO #docs2 (numero, f_ingreso, afect_sald, valida, cod_tipodoc, f_cierre, ano, mes, ano_docume, mes_docume)
    SELECT d.numero, d.f_ingreso, d.afect_sald, d.valida, d.cod_tipodoc, d.f_cierre, datepart(yy, d.f_ingreso), datepart(mm, d.f_ingreso), ano_docume, mes_docume
    FROM fin21_db..sf_docf d
    WHERE d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND d.cod_tipodoc in (1, 41)
      AND isnull(d.afect_sald, '1') = '1'
      AND isnull(d.valida, '1') <> '0'

    INSERT INTO #docs3 (numero, f_ingreso, afect_sald, valida, cod_tipodoc, f_cierre, ano, mes, ano_docume, mes_docume)
    SELECT d.numero, d.f_ingreso, d.afect_sald, d.valida, d.cod_tipodoc, d.f_cierre, datepart(yy, d.f_ingreso), datepart(mm, d.f_ingreso), ano_docume, mes_docume
    FROM fin21_db..sf_docf d
    WHERE d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND d.cod_tipodoc in (55, 2, 4, 8, 9, 15, 133, 134, 156, 240, 143, 61, 62, 63, 5, 16, 33, 34, 43, 44, 45, 46, 47, 25)
      AND isnull(d.afect_sald, '1') = '1'
      AND isnull(d.valida, '1') <> '0'

    INSERT INTO #pfoc (numero, sf_numero, abono, afect_sald)
    SELECT DISTINCT p.numero, p.sf_numero, p.abono, p.afect_sald
    FROM fin21_db..sf_pfoc p
    INNER JOIN #docs2 d ON p.numero = d.numero
    INNER JOIN fin21_db..pt_depr dp ON dp.numero = p.sf_numero
    WHERE dp.cod_unifin = @cod_unifin1
      AND dp.cod_ccto = @cod_ccto1

    INSERT INTO #pfoc3 (numero, sf_numero, abono, afect_sald)
    SELECT DISTINCT p.numero, p.sf_numero, p.abono, p.afect_sald
    FROM fin21_db..sf_pfoc p
    INNER JOIN #docs3 d ON p.numero = d.numero
    INNER JOIN fin21_db..pt_depr dp ON dp.numero = p.sf_numero
    WHERE dp.cod_unifin = @cod_unifin1
      AND dp.cod_ccto = @cod_ccto1

    INSERT INTO #depr2 (numero, cod_unifin, cod_ccto, cod_sitm, cod_tipmov, cod_moneda, valor, valor_his)
    SELECT p.numero, p.cod_unifin, p.cod_ccto, p.cod_sitm, p.cod_tipmov, p.cod_moneda, sum(p.valor), sum(p.valor_his)
    FROM fin21_db..pt_depr p
    INNER JOIN #pfoc pf ON pf.sf_numero = p.numero
    WHERE p.cod_tipmov in (1, 2, 3, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
    GROUP BY p.numero, p.cod_unifin, p.cod_ccto, p.cod_sitm, p.cod_tipmov, p.cod_moneda

    INSERT INTO #depr3 (numero, cod_unifin, cod_ccto, cod_sitm, cod_tipmov, cod_moneda, valor, valor_his)
    SELECT p.numero, p.cod_unifin, p.cod_ccto, p.cod_sitm, p.cod_tipmov, p.cod_moneda, sum(p.valor), sum(p.valor_his)
    FROM fin21_db..pt_depr p
    INNER JOIN #pfoc3 pf ON pf.sf_numero = p.numero
    WHERE p.cod_tipmov in (1, 2, 3, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
    GROUP BY p.numero, p.cod_unifin, p.cod_ccto, p.cod_sitm, p.cod_tipmov, p.cod_moneda

    /* 5. Insercion de movimientos en resumen_saldos */
    
    /* Compromisos (mov 21) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, 0, 0, 0, p.valor, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (5,6,7,12,13,14,16,17,18,19,20,21,22,24,25,26,27,28,29,31,33,34,35,55,100,101,104,105,201,62,63,64,47,43,44,45,46,65,66,146,161,261,242,106,601)
      AND isnull(d.afect_sald, '1') = '1'
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 21
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Rebaja compromisos (mov 24) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), -p.valor, 0, 0, 0, -p.valor, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,24,25,26,27,28,29,32,33,34,35,102,103,146,133,134,139,141,156,240,262,263,143,601)
      AND isnull(d.afect_sald, '1') = '1'
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 24
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Rebaja compromiso NC (mov 24) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), -p.valor, 0, 0, 0, -p.valor, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (161)
      AND isnull(d.afect_sald, '1') = '1'
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 24
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Egresos con pago (mov 14) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes_docume, d.ano_docume, p.cod_moneda, getdate(), p.valor, 0, 0, -p.valor, 0, 0, 0
    FROM #depr2 p
    INNER JOIN #docs2 d ON d.numero = p.numero
    INNER JOIN fin21_db..sf_pfoc ref ON ref.numero = d.numero AND ref.sf_numero = p.numero
    WHERE d.cod_tipodoc in (1)
      AND isnull(d.afect_sald, '1') = '1'
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 14
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Compromiso y pago (mov 20) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, 0, 0, 0, p.valor, p.valor, 0
    FROM #docs d
    INNER JOIN #depr p ON p.numero = d.numero
    WHERE d.cod_tipodoc in (1)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 20
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Ingreso deveng y percibido (mov 10) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, 0, p.valor, p.valor, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (1, 2)
      AND p.cod_tipmov = 10
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Ingreso percibido (mov 12) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, 0, 0, p.valor, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (1, 2, 41, 301, 302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 12
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Rebaja ingreso deveng y percib (mov 13) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, 0, -p.valor, -p.valor, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (1)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 13
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Ajustes Compromiso (mov 21) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, 0, 0, 0, p.valor, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,3,30,50,301,302,501,503,504)
      AND isnull(d.afect_sald, '1') = '1'
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 21
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Ajustes Rebaja Compromiso (mov 24) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), -p.valor, 0, 0, 0, -p.valor, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,3,30,50,301,302,501,503,504)
      AND isnull(d.afect_sald, '1') = '1'
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 24
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Asignacion Presupuesto (mov 1, 2) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), p.valor, p.valor, 0, 0, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,3,30,50,301,302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (1, 2)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Disminucion Presupuesto (mov 3) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), -p.valor, -p.valor, 0, 0, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,3,30,50,301,302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (3)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Ingreso Devengado y Percibido 2 (mov 10) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, p.valor, p.valor, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,3,30,50,301,302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (10)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Rebaja Ingreso Devengado 2 (mov 13) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, -p.valor, -p.valor, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,3,30,50,301,302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (13)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Rebaja Ingreso Percibido 2 (mov 15) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, -p.valor, 0, 0, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (1,41,42,2,30,50,301,302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (15)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Compromiso y Pago 2 (mov 20) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, 0, p.valor, p.valor, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,30,6,7,12,13,14,19,20,21,26,27,28,29,35,50,100,101,104,105,201,301,302,146,242,106,601)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (20)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Rebaja Compromiso y Pago (mov 23) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, 0, -p.valor, -p.valor, 0
    FROM #depr p
    INNER JOIN #docs d ON d.numero = p.numero
    WHERE d.cod_tipodoc in (41,42,30,2,18,32,50,102,103,301,302)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov in (23)
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND isnull(d.afect_sald, '1') = '1'

    /* Reversa RVEE factura (mov 11) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, -p.valor, 0, 0, 0, 0
    FROM #depr2 p
    INNER JOIN #docs d ON d.numero = p.numero
    INNER JOIN fin21_db..sf_pfoc ref ON ref.numero = d.numero
    INNER JOIN fin21_db..sf_docf dd ON ref.sf_numero = dd.numero AND dd.numero = p.numero
    WHERE isnull(d.afect_sald, '1') = '1'
      AND d.cod_tipodoc in (8,9,15,133,134,156,240,143)
      AND dd.cod_tipodoc in (61)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 11
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Reversa RVEE CI (mov 11) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, -convert(decimal(15,2), round(p.valor * isnull(ref.abono, dd.mto_neto) / dd.mto_neto, 0)), 0, 0, 0, 0
    FROM #depr2 p
    INNER JOIN #docs d ON d.numero = p.numero
    INNER JOIN fin21_db..sf_pfoc ref ON ref.numero = d.numero
    INNER JOIN fin21_db..sf_docf dd ON ref.sf_numero = dd.numero AND dd.numero = p.numero
    WHERE isnull(d.afect_sald, '1') = '1'
      AND isnull(ref.afect_sald, '1') = '0'
      AND d.cod_tipodoc in (2)
      AND dd.cod_tipodoc in (61)
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 11
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'

    /* Reversa SEC (mov 21) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, 0, -pp.valor, 0, 0
    FROM #depr3 p, #docs3 d, fin21_db..sf_pfoc ref, fin21_db..sf_docf dd, #depr pp
    WHERE ref.numero = d.numero
      AND ref.sf_numero = dd.numero
      AND isnull(d.afect_sald, '1') = '1'
      AND d.cod_tipodoc in (5, 16, 33, 34, 43, 44, 45, 46, 47)
      AND dd.cod_tipodoc in (62, 63)
      AND isnull(dd.afect_sald, '1') = '1'
      AND dd.numero = p.numero
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 21
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND d.numero = pp.numero
      AND pp.cod_unifin = @cod_unifin1
      AND pp.cod_ccto = @cod_ccto1

    /* Reversa SEC por Aj. OC 1 (mov 21) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, 0, -pp.valor, 0, 0
    FROM #depr2 p, #docs d, fin21_db..sf_pfoc ref, fin21_db..sf_docf dd, #depr2 pp
    WHERE ref.numero = d.numero
      AND ref.sf_numero = dd.numero
      AND isnull(d.afect_sald, '1') = '1'
      AND d.cod_tipodoc in (25)
      AND dd.cod_tipodoc in (62, 63)
      AND isnull(dd.afect_sald, '1') = '1'
      AND dd.numero = p.numero
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 21
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND d.numero = pp.numero 
      AND pp.cod_tipmov = 21
      AND pp.cod_unifin = @cod_unifin1
      AND pp.cod_ccto = @cod_ccto1

    /* Reversa SEC por Aj. OC 2 (mov 21) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, 0, pp.valor, 0, 0
    FROM #depr3 p, #docs3 d, fin21_db..sf_pfoc ref, fin21_db..sf_docf dd, #depr3 pp
    WHERE ref.numero = d.numero
      AND ref.sf_numero = dd.numero
      AND isnull(d.afect_sald, '1') = '1'
      AND d.cod_tipodoc in (25)
      AND dd.cod_tipodoc in (62, 63)
      AND isnull(dd.afect_sald, '1') = '1'
      AND dd.numero = p.numero
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 21
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND d.numero = pp.numero 
      AND pp.cod_tipmov = 24
      AND pp.cod_unifin = @cod_unifin1
      AND pp.cod_ccto = @cod_ccto1

    /* Ajuste por cierre SEC (mov 21) */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, datepart(mm, d.f_cierre), datepart(yy, d.f_cierre), p.cod_moneda, getdate(), 0, 0, 0, 0, -(p.valor - p.valor_his), 0, 0
    FROM #depr p
    INNER JOIN fin21_db..sf_docf d ON d.numero = p.numero
    WHERE isnull(d.afect_sald, '1') = '1'
      AND d.cod_tipodoc in (62, 63)
      AND d.f_cierre <= convert(datetime, @fecha_val, 103)
      AND d.f_cierre > convert(datetime, @f_inicio, 103)
      AND p.cod_tipmov = 21
      AND p.cod_unifin = @cod_unifin1
      AND p.cod_ccto = @cod_ccto1
      AND isnull(d.valida, '1') <> '0'
      AND d.f_cierre is not null

    /* Incluye compromisos de contratos del workflow */
    IF @tipo_cc = 1
    BEGIN
        INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
        SELECT '30700', p.cod_unifin, p.cod_ccto, datepart(mm, t.f_inicio), datepart(yy, t.f_inicio), 4, getdate(), 0, 0, 0, 0, p.monto, 0, 0
        FROM sisper_db..wf_sol2 p
        INNER JOIN sisper_db..wf_tra1 t ON p.ano = t.ano AND p.nro_folio = t.nro_folio
        WHERE p.ano = @ano
          AND t.f_inicio <= convert(datetime, @fecha_val, 103)
          AND p.cod_unifin = @cod_unifin1
          AND p.cod_ccto = @cod_ccto1
          AND p.cod_est_cc in (0, 1, 3)
          AND p.ano >= datepart(yy, t.f_ini_cont)

        INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
        SELECT '30700', p.cod_unifin, p.cod_ccto, datepart(mm, t.f_ini_cont), datepart(yy, t.f_ini_cont), 4, getdate(), 0, 0, 0, 0, p.monto, 0, 0
        FROM sisper_db..wf_sol2 p
        INNER JOIN sisper_db..wf_tra1 t ON p.ano = t.ano AND p.nro_folio = t.nro_folio
        WHERE datepart(yy, t.f_ini_cont) = @ano
          AND t.f_ini_cont <= convert(datetime, @fecha_val, 103)
          AND p.cod_unifin = @cod_unifin1
          AND p.cod_ccto = @cod_ccto1
          AND p.cod_est_cc in (0, 1, 3)
          AND p.ano < datepart(yy, t.f_ini_cont)
    END

    /* Reversa SBL y SAE */
    INSERT INTO #resumen_saldos (cod_sitm, cod_unifin, cod_ccto, mes, ano, cod_moneda, f_cierre, saldo_mone, saldo_prsp, saldo_devg, saldo_perc, saldo_comp, saldo_pago, saldo)
    SELECT p.cod_sitm, p.cod_unifin, p.cod_ccto, d.mes, d.ano, p.cod_moneda, getdate(), 0, 0, 0, 0, -pp.valor, 0, 0
    FROM #depr3 p, #docs3 d, fin21_db..sf_pfoc ref, fin21_db..sf_docf dd, #depr pp
    WHERE ref.numero = d.numero                
      AND ref.sf_numero = dd.numero                
      AND isnull(d.afect_sald, '1') = '1'              
      AND d.cod_tipodoc in (55)                
      AND dd.cod_tipodoc in (65,66)              
      AND isnull(dd.afect_sald, '1') = '1'              
      AND dd.numero = p.numero               
      AND d.f_ingreso <= convert(datetime, @fecha_val, 103)       
      AND d.f_ingreso > convert(datetime, @f_inicio, 103)       
      AND p.cod_unifin = @cod_unifin1  
      AND p.cod_tipmov = 21                
      AND p.cod_ccto = @cod_ccto1 
      AND isnull(d.valida, '1') <> '0'               
      AND d.numero = pp.numero               
      AND pp.cod_unifin = @cod_unifin1 
      AND pp.cod_ccto = @cod_ccto1

    /* 6. Consulta Consolidada Final: saldo general y detalle por item */
    CREATE TABLE #saldos_general (
        saldo_presupuesto decimal(20,4) null,
        saldo_percibido decimal(20,4) null,
        saldo_compromiso decimal(20,4) null,
        saldo_disponible decimal(20,4) null
    )

    IF @tipo_cc = 1
    BEGIN
        INSERT INTO #saldos_general (saldo_presupuesto, saldo_percibido, saldo_compromiso, saldo_disponible)
        SELECT
            sum(isnull(st.saldo_prsp, 0)),
            sum(isnull(st.saldo_perc, 0)),
            sum(isnull(st.saldo_comp, 0)),
            sum(isnull(st.saldo_prsp, 0)) - sum(isnull(st.saldo_comp, 0))
        FROM fin21_db..pt_item pt, #resumen_saldos st, fin21_db..pt_sitm si
        WHERE si.cod_item = pt.cod_item
          AND pt.cod_agrup <> 30
          AND si.cod_sitm = st.cod_sitm
    END
    ELSE
    BEGIN
        INSERT INTO #saldos_general (saldo_presupuesto, saldo_percibido, saldo_compromiso, saldo_disponible)
        SELECT
            sum(isnull(saldo_prsp, 0)),
            sum(isnull(saldo_perc, 0)),
            sum(isnull(saldo_comp, 0)),
            sum(isnull(saldo_prsp, 0)) + sum(isnull(saldo_perc, 0)) - sum(isnull(saldo_comp, 0))
        FROM #resumen_saldos
    END

    SELECT
        'GENERAL' AS tipo_registro,
        convert(int, @cod_unifin1) AS cod_unifin,
        convert(int, @cod_ccto1) AS cod_ccto,
        convert(int, @tipo_cc) AS tipo_cc,
        convert(varchar(5), NULL) AS item_presupuestario,
        convert(varchar(255), 'SALDO GENERAL DISPONIBLE') AS nombre_item,
        isnull(saldo_presupuesto, 0) AS saldo_presupuesto,
        isnull(saldo_percibido, 0) AS saldo_percibido,
        isnull(saldo_compromiso, 0) AS saldo_compromiso,
        isnull(saldo_disponible, 0) AS saldo_disponible,
        1 AS status,
        convert(varchar(255), NULL) AS mensaje
    FROM #saldos_general

    UNION ALL

    SELECT 
        'ITEM' AS tipo_registro,
        convert(int, st.cod_unifin) AS cod_unifin,
        convert(int, st.cod_ccto) AS cod_ccto,
        convert(int, @tipo_cc) AS tipo_cc,
        st.cod_sitm AS item_presupuestario,
        convert(varchar(255), isnull(si.des_item, 'SIN DESCRIPCION')) AS nombre_item,
        sum(isnull(st.saldo_prsp, 0)) AS saldo_presupuesto,
        sum(isnull(st.saldo_perc, 0)) AS saldo_percibido,
        sum(isnull(st.saldo_comp, 0)) AS saldo_compromiso,
        CASE 
            WHEN @tipo_cc = 1 THEN sum(isnull(st.saldo_prsp, 0)) - sum(isnull(st.saldo_comp, 0))
            ELSE sum(isnull(st.saldo_prsp, 0)) + sum(isnull(st.saldo_perc, 0)) - sum(isnull(st.saldo_comp, 0))
        END AS saldo_disponible,
        1 AS status,
        convert(varchar(255), NULL) AS mensaje
    FROM #resumen_saldos st
    LEFT JOIN fin21_db..pt_sitm si ON si.cod_sitm = st.cod_sitm
    GROUP BY st.cod_unifin, st.cod_ccto, st.cod_sitm, si.des_item
    ORDER BY 1 ASC, 5 ASC

    /* 7. Limpieza de tablas temporales */
    DROP TABLE #saldos_general
    DROP TABLE #depr
    DROP TABLE #depr2
    DROP TABLE #depr3
    DROP TABLE #docs
    DROP TABLE #docs2
    DROP TABLE #docs3
    DROP TABLE #pfoc
    DROP TABLE #pfoc3
    DROP TABLE #resumen_saldos
END
GO

GRANT EXECUTE ON Analisis2.sg_cctosSecgen06 TO UsuaVrac
GO
