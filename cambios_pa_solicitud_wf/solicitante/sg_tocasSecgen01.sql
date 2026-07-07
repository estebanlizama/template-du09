USE secgen_db
GO

IF EXISTS (
    SELECT 1
      FROM sysobjects a, sysusers b
     WHERE a.uid = b.uid
       AND a.type = 'P'
       AND b.name = 'Analisis2'
       AND a.name = 'sg_tocasSecgen01'
)
    DROP PROCEDURE Analisis2.sg_tocasSecgen01
GO

/*
Procedimiento : Analisis2.sg_tocasSecgen01
Objetivo      : Validar si el contrato evaluado de un funcionario posee
                un tope especial configurado en sg_toca.

Fuente        : secgen_db.dbo.sg_toca

Regla         :
    - sg_toca se usa solo para topes especiales por cargo + unidad.
    - En esta fase contiene Directores/as de Institutos Independientes.
    - No valida inhabilidad por cargo.
    - No reemplaza el calculo general de sg_fupssSecgen13.
    - Si existe regla vigente para cod_cargo + cod_unidad, se debe usar
      ese mto_tope como tope mensual aplicable.

Parametros    :
    @rut_person  char(9)  : RUT del funcionario.
    @id_contrato int      : Contrato evaluado. Si viene 0 o NULL, se usa
                            el contrato principal vigente/en tramite.
    @fecha_eval  datetime : Fecha de evaluacion de vigencia de sg_toca.
                            Si viene NULL, usa getdate().

Retorna       :
    tiene_tope_cargo char(1)  : 'S' si existe tope especial, 'N' si no.
    mto_tope         int      : Tope mensual encontrado en sg_toca.
    cod_cargo        int      : Cargo del contrato evaluado.
    nom_cargo        varchar  : Descripción del cargo evaluado.
    cod_unidad       char(8)  : Unidad del contrato evaluado.
    des_unidad       varchar  : Descripción de la unidad evaluada.
    f_inicio         datetime : Inicio de vigencia del tope encontrado.
    f_termino        datetime : Termino de vigencia del tope encontrado.

Creacion      : 2026/07/06
*/

CREATE PROCEDURE Analisis2.sg_tocasSecgen01
    @rut_person  char(9) = NULL,
    @id_contrato int = NULL,
    @fecha_eval  datetime = NULL
AS
BEGIN
    DECLARE @cod_ficha varchar(10)
    DECLARE @cod_cargo int
    DECLARE @cod_unidad char(8)
    DECLARE @nom_cargo varchar(60)
    DECLARE @des_unidad varchar(60)
    DECLARE @f_inicio_tope datetime

    IF @fecha_eval IS NULL
        SELECT @fecha_eval = getdate()

    IF @rut_person IS NULL OR ltrim(rtrim(@rut_person)) = ''
    BEGIN
        SELECT
            'N' AS tiene_tope_cargo,
            NULL AS mto_tope,
            NULL AS cod_cargo,
            NULL AS nom_cargo,
            NULL AS cod_unidad,
            NULL AS des_unidad,
            NULL AS f_inicio,
            NULL AS f_termino
        RETURN
    END

    SELECT @cod_ficha = p.cod_ficha
      FROM sisper_db..sp_pers p
     WHERE p.rut_person = @rut_person

    IF @cod_ficha IS NULL
    BEGIN
        SELECT
            'N' AS tiene_tope_cargo,
            NULL AS mto_tope,
            NULL AS cod_cargo,
            NULL AS nom_cargo,
            NULL AS cod_unidad,
            NULL AS des_unidad,
            NULL AS f_inicio,
            NULL AS f_termino
        RETURN
    END

    IF @id_contrato IS NOT NULL AND @id_contrato > 0
    BEGIN
        SELECT
            @cod_cargo = c.cod_cargo,
            @cod_unidad = c.cod_unidad,
            @nom_cargo = rtrim(carg.nom_cargo),
            @des_unidad = rtrim(unid.des_unidad)
          FROM sisper_db..sp_cont c
          LEFT JOIN sisper_db..sp_carg carg
            ON carg.cod_cargo = c.cod_cargo
          LEFT JOIN ufro_db.dbo.es_unid unid
            ON unid.cod_unidad = c.cod_unidad
         WHERE c.cod_ficha = @cod_ficha
           AND c.cod_contra = @id_contrato
    END
    ELSE
    BEGIN
        SELECT
            @cod_cargo = c.cod_cargo,
            @cod_unidad = c.cod_unidad,
            @nom_cargo = rtrim(carg.nom_cargo),
            @des_unidad = rtrim(unid.des_unidad)
          FROM sisper_db..sp_cont c
          LEFT JOIN sisper_db..sp_carg carg
            ON carg.cod_cargo = c.cod_cargo
          LEFT JOIN ufro_db.dbo.es_unid unid
            ON unid.cod_unidad = c.cod_unidad
         WHERE c.cod_ficha = @cod_ficha
           AND c.vigen_cont IN ('0', '2')
           AND c.cod_calida <> '01'
           AND c.principal = '1'
    END

    IF @cod_cargo IS NULL OR @cod_unidad IS NULL
    BEGIN
        SELECT
            'N' AS tiene_tope_cargo,
            NULL AS mto_tope,
            @cod_cargo AS cod_cargo,
            @nom_cargo AS nom_cargo,
            @cod_unidad AS cod_unidad,
            @des_unidad AS des_unidad,
            NULL AS f_inicio,
            NULL AS f_termino
        RETURN
    END

    SELECT @f_inicio_tope = max(t.f_inicio)
      FROM secgen_db.dbo.sg_toca t
     WHERE t.cod_cargo = @cod_cargo
       AND t.cod_unidad = @cod_unidad
       AND t.vigente = 'S'
       AND @fecha_eval >= t.f_inicio
       AND (t.f_termino IS NULL OR @fecha_eval <= t.f_termino)

    IF @f_inicio_tope IS NULL
    BEGIN
        SELECT
            'N' AS tiene_tope_cargo,
            NULL AS mto_tope,
            @cod_cargo AS cod_cargo,
            @nom_cargo AS nom_cargo,
            @cod_unidad AS cod_unidad,
            @des_unidad AS des_unidad,
            NULL AS f_inicio,
            NULL AS f_termino
        RETURN
    END

    SELECT
        'S' AS tiene_tope_cargo,
        t.mto_tope,
        t.cod_cargo,
        @nom_cargo AS nom_cargo,
        t.cod_unidad,
        @des_unidad AS des_unidad,
        t.f_inicio,
        t.f_termino
      FROM secgen_db.dbo.sg_toca t
     WHERE t.cod_cargo = @cod_cargo
       AND t.cod_unidad = @cod_unidad
       AND t.f_inicio = @f_inicio_tope
       AND t.vigente = 'S'
END
GO

GRANT EXECUTE ON Analisis2.sg_tocasSecgen01 TO UsuaVrac
GO
