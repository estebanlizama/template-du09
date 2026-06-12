USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen09')
    DROP PROCEDURE Analisis2.sg_fupssSecgen09
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen09
Objetivo      : Obtener la lista de asignaciones/designaciones vigentes del
                funcionario candidato a DU288.
Parametros    :
    @rut char(9) : RUT del funcionario.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen09
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
        desg.cod_design,
        desg.cod_cargo,
        rtrim(carg.nom_cargo) AS nom_cargo,
        carg.vigente AS vigente_cargo,
        desg.cod_unidad,
        rtrim(unid.des_unidad) AS des_unidad,
        desg.cod_des_su,
        desg.vigencia,
        desg.f_inicio,
        desg.f_termino,
        desg.con_asign,
        desg.hora_dedid,
        desg.observ
    FROM sisper_db.dbo.sp_pers pers
    INNER JOIN sisper_db.dbo.sp_desg desg
            ON desg.cod_ficha = pers.cod_ficha
    LEFT JOIN sisper_db.dbo.sp_carg carg
           ON carg.cod_cargo = desg.cod_cargo
    LEFT JOIN ufro_db.dbo.es_unid unid
           ON unid.cod_unidad = desg.cod_unidad
    WHERE pers.rut_person = @rut
      AND desg.vigencia = '0'
      AND desg.f_inicio <= getdate()
      AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
    ORDER BY
        desg.f_inicio DESC,
        desg.cod_design DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen09 TO UsuaVrac
GO
