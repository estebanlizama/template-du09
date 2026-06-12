USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen08')
    DROP PROCEDURE Analisis2.sg_fupssSecgen08
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen08
Objetivo      : Obtener la lista de contratos vigentes del funcionario candidato a DU288.
Parametros    :
    @rut char(9) : RUT del funcionario.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen08
    @rut char(9) = NULL
AS
BEGIN
    IF @rut IS NULL OR ltrim(rtrim(@rut)) = ''
    BEGIN
        SELECT 'Falta rut' msg
        RETURN
    END

    SELECT
        pers.rut_person AS rut,
        pers.cod_ficha,
        rtrim(isnull(pers.nom_nombre, '')) + ' ' +
        rtrim(isnull(pers.nom_appate, '')) + ' ' +
        rtrim(isnull(pers.nom_apmate, '')) AS nombre_funcionario,
        ltrim(rtrim(rutp.cta_email)) AS cta_email,
        cont.cod_contra AS id_contrato,
        cont.cod_contra,
        isnull(cont.principal, '0') AS principal,
        cont.cod_unidad,
        rtrim(unid.des_unidad) AS des_unidad,
        cont.cod_cargo,
        rtrim(carg.nom_cargo) AS nom_cargo,
        cont.cod_estame,
        rtrim(estm.des_estame) AS des_estame,
        cont.cod_calida,
        rtrim(cali.des_calida) AS des_calida,
        rtrim(cali.des_calida) AS tipo_vinculacion,
        isnull(cont.prof_acad, 'N') AS prof_acad,
        cont.cod_jerpla,
        rtrim(jpfu.des_jerpla) AS des_jerpla,
        cont.cod_niv_gr,
        rtrim(nigr.des_niv_gr) AS des_niv_gr,
        cont.cod_jornad,
        rtrim(jorn.des_jornad) AS des_jornad,
        isnull(cont.num_horas, 0) AS num_horas,
        cont.f_ing_jera,
        pers.f_ing_univ,
        cont.f_inicio_d,
        cont.f_termin_d,
        cont.f_termino,
        cont.vigen_cont,
        vigc.des_vigen
    FROM sisper_db.dbo.sp_pers pers
    INNER JOIN sisper_db.dbo.sp_cont cont
            ON cont.cod_ficha = pers.cod_ficha
    LEFT JOIN sisper_db.dbo.sp_rutp rutp
           ON rutp.rut = pers.rut_person
    LEFT JOIN sisper_db.dbo.sp_carg carg
           ON carg.cod_cargo = cont.cod_cargo
    LEFT JOIN sisper_db.dbo.sp_cali cali
           ON cali.cod_calida = cont.cod_calida
    LEFT JOIN ufro_db.dbo.es_unid unid
           ON unid.cod_unidad = cont.cod_unidad
    LEFT JOIN sisper_db.dbo.sp_jpfu jpfu
           ON jpfu.cod_jerpla = cont.cod_jerpla
    LEFT JOIN sisper_db.dbo.sp_nigr nigr
           ON nigr.cod_jerpla = cont.cod_jerpla
          AND nigr.cod_niv_gr = cont.cod_niv_gr
    LEFT JOIN sisper_db.dbo.sp_jorn jorn
           ON jorn.cod_jornad = cont.cod_jornad
    LEFT JOIN sisper_db.dbo.sp_estm estm
           ON estm.cod_estame = cont.cod_estame
    LEFT JOIN sisper_db.dbo.sp_vigc vigc
           ON vigc.vigen_cont = cont.vigen_cont
    WHERE pers.rut_person = @rut
      AND cont.vigen_cont IN ('0', '2')
      AND cont.cod_calida <> '01'
    ORDER BY
        cont.principal DESC,
        cont.cod_contra DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen08 TO UsuaVrac
GO
