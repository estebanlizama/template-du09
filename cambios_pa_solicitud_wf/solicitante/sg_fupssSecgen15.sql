USE secgen_db
GO

IF EXISTS (
    SELECT 1
      FROM sysobjects a, sysusers b
     WHERE a.uid = b.uid
       AND a.type = 'P'
       AND b.name = 'Analisis2'
       AND a.name = 'sg_fupssSecgen15'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen15
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen15
Objetivo      : Obtener asignaciones/designaciones vigentes del funcionario
                y evaluar si alguna inhabilita DU288.
Parametros    :
    @rut_person  char(9)  : RUT del funcionario.
    @id_contrato int      : Contrato seleccionado en DU288. Solo contexto.
    @fecha_eval datetime  : Fecha de evaluacion. Default getdate().
    @ind_anid   char(1)   : Indicador ANID/externo ('S'/'N'). Default 'N'.

Retorna       :
    Lista de asignaciones vigentes y habilitado_du288 ('S'/'N').

Creacion      : 2026/07/10
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen15
    @rut_person  char(9),
    @id_contrato int = 0,
    @fecha_eval  datetime = NULL,
    @ind_anid    char(1) = 'N'
AS
BEGIN
    IF @fecha_eval IS NULL
        SELECT @fecha_eval = getdate()

    SELECT @ind_anid = UPPER(LTRIM(RTRIM(ISNULL(@ind_anid, 'N'))))
    IF @ind_anid NOT IN ('S', 'N')
        SELECT @ind_anid = 'N'

    SELECT
        orde.rut_person,
        @id_contrato AS id_contrato,
        desg.cod_ficha,
        desg.cod_design,
        desg.cod_cargo,
        RTRIM(carg.nom_cargo) AS nom_cargo,
        carg.cod_tipcar,
        desg.cod_unidad,
        RTRIM(unid.des_unidad) AS des_unidad,
        desg.vigencia,
        desg.f_inicio AS fecha_inicio,
        desg.f_termino AS fecha_termino,
        desg.con_asign,
        desg.hora_dedid,
        RTRIM(desg.observ) AS observ,
        CASE
            WHEN @ind_anid = 'S' AND desg.cod_cargo = 3110 THEN 'S'
            WHEN carg.cod_tipcar = '5' THEN 'N'
            ELSE 'S'
        END AS habilitado_du288,
        CASE
            WHEN @ind_anid = 'S' AND desg.cod_cargo = 3110 THEN NULL
            WHEN carg.cod_tipcar = '5' THEN 'Asignacion/designacion directiva vigente'
            ELSE NULL
        END AS motivo_inhabilidad
    FROM sisper_db.dbo.sp_orde orde
    INNER JOIN sisper_db.dbo.sp_desg desg
        ON desg.cod_design = orde.cod_design
    LEFT JOIN sisper_db.dbo.sp_carg carg
        ON carg.cod_cargo = desg.cod_cargo
    LEFT JOIN ufro_db.dbo.es_unid unid
        ON unid.cod_unidad = desg.cod_unidad
    WHERE orde.rut_person = @rut_person
      AND orde.vigente = 'S'
      AND desg.vigencia IN ('1', 'S')
      AND desg.f_inicio <= @fecha_eval
      AND (desg.f_termino IS NULL OR desg.f_termino >= @fecha_eval)
    ORDER BY desg.f_inicio DESC, desg.cod_design
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen15 TO UsuaVrac
GO
