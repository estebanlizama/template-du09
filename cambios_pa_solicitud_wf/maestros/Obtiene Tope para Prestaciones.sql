SQL_ADVANTAGE11.1ÿ….drop table #Topes
go
create table #Topes
       (rut_person     char(09)     null,
        nom_appate     varchar(20)  null, 
        nom_apmate     varchar(20)  null, 
        nom_nombre     varchar(20)  null,
        cod_estame     char(01)     null,
        num_horas      tinyint      null,
        tot_horas      tinyint      null,
        hrs_honor      tinyint      null,
        cod_sede       varchar(02)  null,
        asign_sede     decimal(5,2) null,
        cod_jerpln     varchar(05)  null,
        cod_jerpla     varchar(05)  null,
        des_jerpla     varchar(30)  null,
        cod_niv_gr     varchar(05)  null,
        des_niv_gr     varchar(30)  null,
        cod_ficha      varchar(10)  null,
        cal_jerpla     varchar(05)  null,
        cal_niv_gr     varchar(05)  null,
        sueld_base     int          null,
        mto_admsup     int          null,
        mto_respon     int          null,
        mto_profes     int          null,
        mto_noacad     int          null,
        mto_nivela     int          null,
        mto_increm     int          null,
        mto_zona       int          null,
        tot_haber      int          null,
        mto_tope       int          null)

/************************/
/* Calculo de Tope DU 9 */
/************************/

declare @rut_person   char(09)

-- select @rut_person  = "21323319K"   -- Tecnico
-- select @rut_person  = "176587970"   -- Profesional menor a 44 horas
-- select @rut_person  = "129286873"   -- Academico menor  44 horas
select @rut_person  = "119088380"   -- Profesional 44 horas
-- select @rut_person  = "100494698"   -- Auxiliar


insert #Topes(rut_person, nom_appate, nom_apmate, nom_nombre, b.cod_estame, num_horas, tot_horas, cod_sede, asign_sede, cod_jerpln, cod_jerpla, des_jerpla, cod_niv_gr, des_niv_gr, a.cod_ficha)        
select a.rut_person, a.nom_appate, a.nom_apmate, a.nom_nombre, b.cod_estame, b.num_horas, b.num_horas, c.cod_sede, c.asign_sede, d.cod_jerpln, d.cod_jerpla, d.des_jerpla, e.cod_niv_gr, e.des_niv_gr, a.cod_ficha
       from sisper_db..sp_pers a, sisper_db..sp_cont b, sisper_db..sp_sede c, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_ficha = b.cod_ficha
       and   b.cod_sede = c.cod_sede
       and   b.cod_jerpla = d.cod_jerpla
       and   b.cod_jerpla = e.cod_jerpla
       and   b.cod_niv_gr = e.cod_niv_gr
       and   b.cod_calida <> "01"
       and   b.vigen_cont in ("0", "2")
       and   b.principal = "1"
       and   a.rut_person = @rut_person

drop table #Horas
go
select a.rut_person, sum(b.num_horas) tot_horas into #Horas
       from #Topes a, sisper_db..sp_cont b
       where a.cod_ficha = b.cod_ficha
       and   b.vigen_cont in ("0", "2")
       and   b.cod_Calida in ("03", "04", "06")
       and   b.principal = "0"
group by a.rut_person

update #Topes set tot_horas = a.num_horas +  b.tot_horas  from #Topes a, #Horas b where a.rut_person = b.rut_person

-- Horas a Honorarios
drop table #HorasHono
go
select a.rut_person, sum(b.num_horas) tot_horas into #HorasHono
       from #Topes a, sisper_db..sp_cont b
       where a.cod_ficha = b.cod_ficha
       and   b.vigen_cont in ("0", "2")
       and   b.cod_Calida in ("01")
group by a.rut_person

update #Topes set hrs_honor = b.tot_horas  from #Topes a, #HorasHono b where a.rut_person = b.rut_person

update #Topes set sueld_base = 0, mto_admsup = 0, mto_respon = 0, mto_profes = 0, mto_noacad = 0, mto_nivela = 0, mto_increm = 0, mto_zona = 0, tot_haber = 0, mto_tope = 0 

/******************************************************************************/
/* Funcionarios tecnico, Auxiliares y Administrativos se toma desde la Escala */
/******************************************************************************/
-- Tecnico
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   d.cod_jerpln = "3"
       and   e.cod_niv_gr  = "53"

-- Administrativo
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   d.cod_jerpln = "4"
       and   e.cod_niv_gr  = "65"

-- Auxiliar
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   d.cod_jerpln = "5"
       and   e.cod_niv_gr  = "158"

/*****************************************************************************/
/* Funcionarios Academicos y Profesionales por horas se toma desde la Escala */
/*****************************************************************************/
--Profesionales
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   a.cod_jerpla = e.cod_jerpla
       and   a.cod_niv_gr = e.cod_niv_gr
       and   a.cod_jerpln = "2"
       and   isnull(a.tot_horas, a.num_horas) < 44

--Academicos Instructor
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   a.cod_niv_gr in ("112", "141")
       and   e.cod_niv_gr  = "112"
       and   isnull(a.tot_horas, a.num_horas) < 44

--Academicos Asistente
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   a.cod_niv_gr in ("18", "96", "111", "113", "142")
       and   e.cod_niv_gr  = "7"
       and   isnull(a.tot_horas, a.num_horas) < 44

--Academicos Asociado
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   a.cod_niv_gr in ("92", "110")
       and   e.cod_niv_gr  = "4"
       and   isnull(a.tot_horas, a.num_horas) < 44

--Academicos Titular
update #Topes set cal_jerpla = d.cod_jerpla, cal_niv_gr = e.cod_niv_gr, sueld_base = e.sueld_base
       from #Topes a, sisper_db..sp_jpfu d, sisper_db..sp_nigr e
       where a.cod_jerpln = d.cod_jerpln
       and   d.cod_jerpla = e.cod_jerpla
       and   a.cod_niv_gr in ("14", "109")
       and   e.cod_niv_gr  = "1"
       and   isnull(a.tot_horas, a.num_horas) < 44

/***********************************/
/* Actualizamos monto de la Escala */
/***********************************/

update #Topes set mto_noacad = round((a.sueld_base * b.valor ) / 100.0,0) from #Topes a, sisper_db..sp_asng b where a.cal_niv_gr = b.cod_niv_gr and num_cuenta = "2013"
update #Topes set mto_profes = round((a.sueld_base * b.valor ) / 100.0,0) from #Topes a, sisper_db..sp_asng b where a.cal_niv_gr = b.cod_niv_gr and num_cuenta = "2011"
update #Topes set mto_nivela = round((a.sueld_base * b.valor ) / 100.0,0) from #Topes a, sisper_db..sp_asng b where a.cal_niv_gr = b.cod_niv_gr and num_cuenta = "2319"
update #Topes set mto_increm = round((a.sueld_base * b.valor ) / 100.0,0) from #Topes a, sisper_db..sp_asng b where a.cal_niv_gr = b.cod_niv_gr and num_cuenta = "2320"
update #Topes set mto_zona = round((sueld_base * asign_sede) / 100.0,0)

update #Topes set tot_haber = sueld_base + mto_admsup + mto_respon + mto_profes + mto_noacad + mto_nivela + mto_increm + mto_zona, 
                  mto_tope = (sueld_base + mto_admsup + mto_respon + mto_profes + mto_noacad + mto_nivela + mto_increm + mto_zona) / 2


select * from #Topes

/***********************************************************/
/* Funcionarios con 44 Horas (profesionales y academicos)  */
/***********************************************************/
-- select num_cuenta + ",  -- " + des_cuenta from sp_para where num_cuenta in ("2032", "2043", "2044", "2056", "2066", "2067", "2079", "2090", "2402", "2403", "2414", "2417", "2418")

drop table #Planilla
drop table #Cuentas
drop table #Haberes
go

declare @FechaCons  datetime

select @FechaCons = dateadd(mm, -1, getdate())

select a.cod_ficha, b.mes_ano, max(num_compl) num_compl into #Planilla
       from #Topes a, sisper_db..ss_hrem b
       where a.cod_ficha = b.cod_ficha
       and   convert(smallint, right(rtrim(b.mes_ano),4)) = datepart(yy,@FechaCons)
       and   convert(smallint, left(rtrim(b.mes_ano),2))  = datepart(mm,@FechaCons)
       and   a.tot_horas = 44
       and   a.cod_jerpln not in ("3", "4", "5")
group by a.cod_ficha, b.mes_ano

select a.rut_person, a.cod_ficha, d.num_cuenta, d.des_cuenta, b.v_efectuad into #Cuentas
       from #Topes a, sisper_db..ss_habe b, #Planilla c, sisper_db..sp_para d
       where a.cod_ficha = b.cod_ficha
       and   b.cod_ficha = c.cod_ficha
       and   b.mes_ano   = c.mes_ano
       and   b.num_compl = c.num_compl
       and   b.num_cuenta = d.num_cuenta
       and   b.num_cuenta like '2%'  

delete #Cuentas 
       where num_cuenta in ("2032",  -- Asig. Familiar                                                                                             
                            "2043",  -- Horas Extras Diurnas                                                                                       
                            "2044",  -- Horas Extra Fest/Noct.                                                                                     
                            "2056",  -- Asig. Familiar Retroactiva                                                                                 
                            "2066",  -- Haber Retroactivo 
                            "2067",  -- Bonif. por Absorción                                                                                                                                                                                
                            "2079",  -- BONO DE ESCOLARIDAD                                                                                        
                            "2090",  -- Asig. Docencia Administrativos                                                                             
                            "2402",  -- Bono Sala Cuna                                                                                             
                            "2403",  -- Bono Sala Cuna Retroactivo                                                                                 
                            "2414",  -- Bono de Cargo Fiscal                                                                                       
                            "2417",  -- D.U. 288, Asig. de Prest. de Servicios                                                                     
                            "2418")  -- Prest. de Serv. Docentes Especiales     


select a.rut_person, sum(b.v_efectuad) v_efectuad into #Haberes
       from #Topes a, #Cuentas b
       where a.rut_person = b.rut_person
group by a.rut_person

update #Topes set tot_haber = b.v_efectuad, mto_tope  = b.v_efectuad / 2
       from #Topes a, #Haberes b
       where a.rut_person = b.rut_person


select * from #Topes

  


(1 row affected)
                            <   <           ÿ    €                È                         óÿÿÿ                                       1    GOCHE_SQLjmanqueJMANQUE,Courier   ÿÿ