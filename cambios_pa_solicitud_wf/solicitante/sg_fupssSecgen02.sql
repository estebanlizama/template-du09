USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen02')
    DROP PROCEDURE Analisis2.sg_fupssSecgen02
GO

/* Procedimiento : Analisis2.sg_fupssSecgen02
   Objetivo      : Listar los funcionarios asociados a una solicitud de PDS,
                   incluyendo campos legacy y nuevos campos DU288 de sg_fups.
   Entrada       :
       @nro_solici int
*/
CREATE PROCEDURE Analisis2.sg_fupssSecgen02
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Id Funcionarios prestación de servicios' AS msg
        RETURN
    END

    SELECT
        fu.id_funprse,
        fu.nro_solici,
        fu.rut,
        fu.cod_cargo,
        fu.cod_sitm,
        fu.itm_global,
        fu.motivo,
        fu.periodos,
        fu.monto_mes,
        fu.mto_total,
        fu.cod_moneda,
        fu.cod_tpps,
        fu.f_inicio,
        fu.f_termino,
        fu.cod_estfun,
        fu.dentro_jor,
        fu.cod_contra,
        fu.mes_haber,
        fu.ano_haber,
        fu.mto_haber,
        fu.mto_tope,
        fu.f_cal_tope,
        fu.tot_cuotas,
        (pers.nom_nombre + ' ' + pers.nom_appate + ' ' + pers.nom_apmate) AS nombre,
        pers.uni_ctadi,
        carg.nom_cargo
    FROM
        sg_fups fu
        LEFT JOIN sisper_db..sp_pers pers
            ON (pers.rut_person = fu.rut)
        LEFT JOIN sisper_db..sp_carg carg
            ON (carg.cod_cargo = fu.cod_cargo)
    WHERE
        fu.nro_solici = @nro_solici
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen02 TO UsuaVrac
GO
