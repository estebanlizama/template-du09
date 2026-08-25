USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen15'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen15
GO

/* Procedimiento : Analisis2.sg_fupssSecgen15

   Entrada :
   @rut_person          -> RUT de la persona. (Obligatorio)
   @id_contrato         -> Identificador del contrato. (Obligatorio)
   @fecha_eval          -> Fecha de evaluacion. (Opcional)
   @ind_anid            -> Parametro de entrada. (Obligatorio)

   Objetivo : Obtener asignaciones/designaciones vigentes del funcionario y evaluar si alguna inhabilita DU288.

   Creacion: 2026/07/10
   Actualizacion: Sin registro
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
            WHEN carg.cod_tipcar = '3'
             AND (
                    UPPER(RTRIM(carg.nom_cargo)) LIKE '%DIRECTOR%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%DIRECTORA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%RECTOR%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%RECTORA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%DECANO%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%DECANA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%VICERRECTOR%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%VICERRECTORA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%SECRETARIO GENERAL%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%SECRETARIA GENERAL%'
                ) THEN 'N'
            ELSE 'S'
        END AS habilitado_du288,
        CASE
            WHEN @ind_anid = 'S' AND desg.cod_cargo = 3110 THEN NULL
            WHEN carg.cod_tipcar = '5' THEN 'Cargo directivo vigente'
            WHEN carg.cod_tipcar = '3'
             AND (
                    UPPER(RTRIM(carg.nom_cargo)) LIKE '%DIRECTOR%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%DIRECTORA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%RECTOR%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%RECTORA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%DECANO%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%DECANA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%VICERRECTOR%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%VICERRECTORA%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%SECRETARIO GENERAL%'
                 OR UPPER(RTRIM(carg.nom_cargo)) LIKE '%SECRETARIA GENERAL%'
                ) THEN 'Funcion directiva vigente'
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
