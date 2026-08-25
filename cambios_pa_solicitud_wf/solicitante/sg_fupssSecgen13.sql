USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen13'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen13
GO

/* Procedimiento : Analisis2.sg_fupssSecgen13

   Entrada :
   @rut_person          -> RUT de la persona. (Opcional)

   Objetivo : Obtener el contrato principal, haberes calculados y tope DU288 asignado para un funcionario.

   Creacion: EL 2026/07/01
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fupssSecgen13
    @rut_person char(9) = NULL
AS
BEGIN
    IF @rut_person IS NULL OR ltrim(rtrim(@rut_person)) = ''
    BEGIN
        SELECT 'Falta RUT del funcionario' AS msg
        RETURN
    END

    CREATE TABLE #Topes
       (rut_person      char(09)     null,
        nom_appate      varchar(20)  null,
        nom_apmate      varchar(20)  null,
        nom_nombre      varchar(20)  null,
        cod_estame      char(01)     null,
        num_horas       tinyint      null,
        tot_horas       tinyint      null,
        hrs_honor       tinyint      null,
        cod_sede        varchar(02)  null,
        asign_sede      decimal(5,2) null,
        cod_jerpln      varchar(05)  null,
        cod_jerpla      varchar(05)  null,
        des_jerpla      varchar(30)  null,
        cod_niv_gr      varchar(05)  null,
        des_niv_gr      varchar(30)  null,
        cod_ficha       varchar(10)  null,
        cal_jerpla      varchar(05)  null,
        cal_niv_gr      varchar(05)  null,
        sueld_base      int          null,
        mto_admsup      int          null,
        mto_respon      int          null,
        mto_profes      int          null,
        mto_noacad      int          null,
        mto_nivela      int          null,
        mto_increm      int          null,
        mto_zona        int          null,
        tot_haber       int          null,
        mto_tope        int          null,
        cod_contra      int          null,
        id_contrato     int          null,
        principal       char(01)     null,
        cod_unidad      varchar(10)  null,
        des_unidad      varchar(60)  null,
        cod_cargo       int          null,
        nom_cargo       varchar(60)  null,
        cod_calida      varchar(02)  null,
        cod_vinculacion varchar(02)  null,
        fecha_inicio    datetime     null,
        fecha_termino   datetime     null)

    INSERT INTO #Topes (
        rut_person, nom_appate, nom_apmate, nom_nombre, cod_estame,
        num_horas, tot_horas, cod_sede, asign_sede, cod_jerpln,
        cod_jerpla, des_jerpla, cod_niv_gr, des_niv_gr, cod_ficha,
        cod_contra, id_contrato, principal, cod_unidad, des_unidad,
        cod_cargo, nom_cargo,
        cod_calida, cod_vinculacion,
        fecha_inicio, fecha_termino
    )
    SELECT
        a.rut_person, a.nom_appate, a.nom_apmate, a.nom_nombre,
        b.cod_estame,
        b.num_horas, b.num_horas, c.cod_sede, c.asign_sede, d.cod_jerpln,
        d.cod_jerpla, d.des_jerpla, e.cod_niv_gr, e.des_niv_gr, a.cod_ficha,
        b.cod_contra, b.cod_contra, isnull(b.principal, '0'), b.cod_unidad, rtrim(unid.des_unidad),
        b.cod_cargo, rtrim(carg.nom_cargo), b.cod_calida, b.cod_calida,
        b.f_inicio_d,
        isnull(b.f_termino, b.f_termin_d)
    FROM sisper_db..sp_pers a
    INNER JOIN sisper_db..sp_cont b ON a.cod_ficha = b.cod_ficha
    INNER JOIN sisper_db..sp_sede c ON b.cod_sede = c.cod_sede
    INNER JOIN sisper_db..sp_jpfu d ON b.cod_jerpla = d.cod_jerpla
    INNER JOIN sisper_db..sp_nigr e ON b.cod_jerpla = e.cod_jerpla AND b.cod_niv_gr = e.cod_niv_gr
    LEFT JOIN sisper_db..sp_carg carg ON carg.cod_cargo = b.cod_cargo
    LEFT JOIN ufro_db.dbo.es_unid unid ON unid.cod_unidad = b.cod_unidad
    WHERE b.cod_calida <> '01'
      AND b.vigen_cont in ('0', '2')
      AND b.principal = '1'
      AND a.rut_person = @rut_person

    IF OBJECT_ID('tempdb..#Horas') IS NOT NULL DROP TABLE #Horas

    SELECT a.rut_person, sum(b.num_horas) tot_horas
    INTO #Horas
    FROM #Topes a, sisper_db..sp_cont b
    WHERE a.cod_ficha = b.cod_ficha
      AND b.vigen_cont in ('0', '2')
      AND b.cod_calida in ('03', '04', '06')
      AND b.principal = '0'
    GROUP BY a.rut_person

    UPDATE #Topes
    SET tot_horas = a.num_horas + b.tot_horas
    FROM #Topes a, #Horas b
    WHERE a.rut_person = b.rut_person

    IF OBJECT_ID('tempdb..#HorasHono') IS NOT NULL DROP TABLE #HorasHono

    SELECT a.rut_person, sum(b.num_horas) tot_horas
    INTO #HorasHono
    FROM #Topes a, sisper_db..sp_cont b
    WHERE a.cod_ficha = b.cod_ficha
      AND b.vigen_cont in ('0', '2')
      AND b.cod_calida in ('01')
    GROUP BY a.rut_person

    UPDATE #Topes
    SET hrs_honor = b.tot_horas
    FROM #Topes a, #HorasHono b
    WHERE a.rut_person = b.rut_person

    UPDATE #Topes
    SET sueld_base = 0, mto_admsup = 0, mto_respon = 0, mto_profes = 0,
        mto_noacad = 0, mto_nivela = 0, mto_increm = 0, mto_zona = 0,
        tot_haber = 0, mto_tope = 0

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND d.cod_jerpln = '3'
      AND e.cod_niv_gr = '53'

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND d.cod_jerpln = '4'
      AND e.cod_niv_gr = '65'

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND d.cod_jerpln = '5'
      AND e.cod_niv_gr = '158'

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND a.cod_jerpla = e.cod_jerpla
      AND a.cod_niv_gr = e.cod_niv_gr
      AND a.cod_jerpln = '2'
      AND isnull(a.tot_horas, a.num_horas) < 44

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND a.cod_niv_gr in ('112', '141')
      AND e.cod_niv_gr = '112'
      AND isnull(a.tot_horas, a.num_horas) < 44

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND a.cod_niv_gr in ('18', '96', '111', '113', '142')
      AND e.cod_niv_gr = '7'
      AND isnull(a.tot_horas, a.num_horas) < 44

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND a.cod_niv_gr in ('92', '110')
      AND e.cod_niv_gr = '4'
      AND isnull(a.tot_horas, a.num_horas) < 44

    UPDATE #Topes
    SET cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
    FROM #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
    WHERE a.cod_jerpln = d.cod_jerpln
      AND d.cod_jerpla = e.cod_jerpla
      AND a.cod_niv_gr in ('14', '109')
      AND e.cod_niv_gr = '1'
      AND isnull(a.tot_horas, a.num_horas) < 44

    UPDATE #Topes
    SET mto_noacad = round((a.sueld_base * b.valor) / 100.0, 0)
    FROM #Topes a, sisper_db..sp_asng b
    WHERE a.cal_niv_gr = b.cod_niv_gr
      AND b.num_cuenta = '2013'

    UPDATE #Topes
    SET mto_profes = round((a.sueld_base * b.valor) / 100.0, 0)
    FROM #Topes a, sisper_db..sp_asng b
    WHERE a.cal_niv_gr = b.cod_niv_gr
      AND b.num_cuenta = '2011'

    UPDATE #Topes
    SET mto_nivela = round((a.sueld_base * b.valor) / 100.0, 0)
    FROM #Topes a, sisper_db..sp_asng b
    WHERE a.cal_niv_gr = b.cod_niv_gr
      AND b.num_cuenta = '2319'

    UPDATE #Topes
    SET mto_increm = round((a.sueld_base * b.valor) / 100.0, 0)
    FROM #Topes a, sisper_db..sp_asng b
    WHERE a.cal_niv_gr = b.cod_niv_gr
      AND b.num_cuenta = '2320'

    UPDATE #Topes
    SET mto_zona = round((sueld_base * asign_sede) / 100.0, 0)

    UPDATE #Topes
    SET tot_haber = sueld_base + mto_admsup + mto_respon + mto_profes + mto_noacad + mto_nivela + mto_increm + mto_zona,
        mto_tope = (sueld_base + mto_admsup + mto_respon + mto_profes + mto_noacad + mto_nivela + mto_increm + mto_zona) / 2

    IF EXISTS(SELECT 1 FROM #Topes WHERE tot_horas = 44 AND cod_jerpln not in ('3', '4', '5'))
    BEGIN
        DECLARE @FechaCons datetime
        SELECT @FechaCons = dateadd(mm, -1, getdate())

        IF OBJECT_ID('tempdb..#Planilla') IS NOT NULL DROP TABLE #Planilla
        IF OBJECT_ID('tempdb..#Cuentas') IS NOT NULL DROP TABLE #Cuentas
        IF OBJECT_ID('tempdb..#Haberes') IS NOT NULL DROP TABLE #Haberes

        SELECT a.cod_ficha, b.mes_ano, max(num_compl) num_compl
        INTO #Planilla
        FROM #Topes a, sisper_db..ss_hrem b
        WHERE a.cod_ficha = b.cod_ficha
          AND convert(smallint, right(rtrim(b.mes_ano), 4)) = datepart(yy, @FechaCons)
          AND convert(smallint, left(rtrim(b.mes_ano), 2)) = datepart(mm, @FechaCons)
          AND a.tot_horas = 44
          AND a.cod_jerpln not in ('3', '4', '5')
        GROUP BY a.cod_ficha, b.mes_ano

        SELECT a.rut_person, a.cod_ficha, d.num_cuenta, d.des_cuenta, b.v_efectuad
        INTO #Cuentas
        FROM #Topes a, sisper_db..ss_habe b, #Planilla c, sisper_db..sp_para d
        WHERE a.cod_ficha = b.cod_ficha
          AND b.cod_ficha = c.cod_ficha
          AND b.mes_ano = c.mes_ano
          AND b.num_compl = c.num_compl
          AND b.num_cuenta = d.num_cuenta
          AND b.num_cuenta like '2%'

        DELETE FROM #Cuentas
        WHERE num_cuenta in (
            '2032',
            '2043',
            '2044',
            '2056',
            '2066',
            '2067',
            '2079',
            '2090',
            '2402',
            '2403',
            '2414',
            '2417',
            '2418'
        )

        SELECT a.rut_person, sum(b.v_efectuad) v_efectuad
        INTO #Haberes
        FROM #Topes a, #Cuentas b
        WHERE a.rut_person = b.rut_person
        GROUP BY a.rut_person

        UPDATE #Topes
        SET tot_haber = b.v_efectuad, mto_tope = b.v_efectuad / 2
        FROM #Topes a, #Haberes b
        WHERE a.rut_person = b.rut_person

        DROP TABLE #Planilla
        DROP TABLE #Cuentas
        DROP TABLE #Haberes
    END

    SELECT
        rut_person, nom_appate, nom_apmate, nom_nombre,
        cod_ficha, cod_contra, id_contrato, principal,
        cod_estame,
        cod_calida, cod_vinculacion,
        cod_jerpla, des_jerpla, cod_niv_gr, des_niv_gr, cod_jerpln,
        cod_unidad, des_unidad,
        cod_cargo, nom_cargo,
        cod_sede, asign_sede,
        num_horas, tot_horas, hrs_honor,
        cal_jerpla, cal_niv_gr,
        sueld_base, mto_admsup, mto_respon, mto_profes,
        mto_noacad, mto_nivela, mto_increm, mto_zona,
        tot_haber, mto_tope,
        fecha_inicio, fecha_termino
    FROM #Topes

    DROP TABLE #Topes
    IF OBJECT_ID('tempdb..#Horas') IS NOT NULL DROP TABLE #Horas
    IF OBJECT_ID('tempdb..#HorasHono') IS NOT NULL DROP TABLE #HorasHono
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen13 TO UsuaVrac
GO
