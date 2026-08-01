USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_flusSecgen01'
)
    DROP PROCEDURE Analisis2.sg_flusSecgen01
GO

/*
Procedimiento : Analisis2.sg_flusSecgen01
Objetivo      : Resolver el flujo organizacional DU288 correspondiente a un
                Centro de Costo, sin recibir cod_flusol desde el cliente.

Reglas vigentes:
    02xxxxxx                         -> VRAC
    03xxxxxx                         -> VRAF
    16xxxxxx                         -> VRIP
    05/07/08/09/17/18xxxxxx          -> FACULTAD

Pendiente de definicion institucional:
    ANID, DITT, INVESTIGACION e INSTITUTO.
    Estas rutas no deben inferirse ni usar un flujo alternativo.

La columna abr_flusol de sg_tfls debe contener una de las abreviaturas
FACULTAD, VRIP, VRAC o VRAF y debe existir exactamente un flujo vigente.
*/
CREATE PROCEDURE Analisis2.sg_flusSecgen01
    @cod_unifin smallint = NULL,
    @cod_ccto smallint = NULL
AS
BEGIN
    DECLARE @cod_unidad char(8)
    DECLARE @unidad_mayor char(8)
    DECLARE @des_unidad varchar(100)
    DECLARE @abr_flujo varchar(10)
    DECLARE @cod_flusol tinyint
    DECLARE @des_flusol varchar(60)
    DECLARE @cantidad_flujos int
    DECLARE @cantidad_etapas int

    IF @cod_unifin IS NULL OR @cod_ccto IS NULL
    BEGIN
        SELECT
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            CONVERT(char(8), NULL) AS cod_unidad,
            CONVERT(char(8), NULL) AS unidad_mayor,
            CONVERT(varchar(100), NULL) AS des_unidad,
            CONVERT(varchar(10), NULL) AS tipo_flujo,
            CONVERT(tinyint, NULL) AS cod_flusol,
            CONVERT(varchar(60), NULL) AS des_flusol,
            CONVERT(varchar(10), NULL) AS abr_flusol,
            0 AS status,
            'ERROR' AS estado_resolucion,
            'Faltan los parametros de Unidad Financiera o Centro de Costo.' AS mensaje
        RETURN
    END

    SELECT
        @cod_unidad = ufin.cod_unidad,
        @des_unidad = ufin.des_unifin
    FROM fin21_db..es_ccto ccto
    INNER JOIN fin21_db..es_ufin ufin
        ON ufin.cod_unifin = ccto.cod_unifin
    WHERE ccto.cod_unifin = @cod_unifin
      AND ccto.cod_ccto = @cod_ccto
      AND ccto.vigente = '1'

    IF @cod_unidad IS NULL
    BEGIN
        SELECT
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            CONVERT(char(8), NULL) AS cod_unidad,
            CONVERT(char(8), NULL) AS unidad_mayor,
            CONVERT(varchar(100), NULL) AS des_unidad,
            CONVERT(varchar(10), NULL) AS tipo_flujo,
            CONVERT(tinyint, NULL) AS cod_flusol,
            CONVERT(varchar(60), NULL) AS des_flusol,
            CONVERT(varchar(10), NULL) AS abr_flusol,
            0 AS status,
            'NO_ENCONTRADO' AS estado_resolucion,
            'El Centro de Costo no existe, no esta vigente o no posee unidad institucional.' AS mensaje
        RETURN
    END

    SELECT @unidad_mayor = SUBSTRING(@cod_unidad, 1, 2) + '000000'

    SELECT @abr_flujo = CASE SUBSTRING(@cod_unidad, 1, 2)
        WHEN '02' THEN 'VRAC'
        WHEN '03' THEN 'VRAF'
        WHEN '16' THEN 'VRIP'
        WHEN '05' THEN 'FACULTAD'
        WHEN '07' THEN 'FACULTAD'
        WHEN '08' THEN 'FACULTAD'
        WHEN '09' THEN 'FACULTAD'
        WHEN '17' THEN 'FACULTAD'
        WHEN '18' THEN 'FACULTAD'
        ELSE NULL
    END

    IF @abr_flujo IS NULL
    BEGIN
        SELECT
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            @cod_unidad AS cod_unidad,
            @unidad_mayor AS unidad_mayor,
            @des_unidad AS des_unidad,
            CONVERT(varchar(10), NULL) AS tipo_flujo,
            CONVERT(tinyint, NULL) AS cod_flusol,
            CONVERT(varchar(60), NULL) AS des_flusol,
            CONVERT(varchar(10), NULL) AS abr_flusol,
            0 AS status,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La unidad institucional del Centro de Costo no tiene un flujo DU288 configurado.' AS mensaje
        RETURN
    END

    SELECT @cantidad_flujos = COUNT(*)
    FROM dbo.sg_tfls
    WHERE UPPER(RTRIM(abr_flusol)) = @abr_flujo
      AND ISNULL(vigente, 'S') = 'S'

    IF ISNULL(@cantidad_flujos, 0) <> 1
    BEGIN
        SELECT
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            @cod_unidad AS cod_unidad,
            @unidad_mayor AS unidad_mayor,
            @des_unidad AS des_unidad,
            @abr_flujo AS tipo_flujo,
            CONVERT(tinyint, NULL) AS cod_flusol,
            CONVERT(varchar(60), NULL) AS des_flusol,
            @abr_flujo AS abr_flusol,
            0 AS status,
            CASE WHEN ISNULL(@cantidad_flujos, 0) = 0
                THEN 'NO_CONFIGURADO'
                ELSE 'AMBIGUO'
            END AS estado_resolucion,
            CASE WHEN ISNULL(@cantidad_flujos, 0) = 0
                THEN 'No existe un flujo vigente en sg_tfls para la unidad institucional.'
                ELSE 'Existe mas de un flujo vigente en sg_tfls para la unidad institucional.'
            END AS mensaje
        RETURN
    END

    SELECT
        @cod_flusol = cod_flusol,
        @des_flusol = des_flusol
    FROM dbo.sg_tfls
    WHERE UPPER(RTRIM(abr_flusol)) = @abr_flujo
      AND ISNULL(vigente, 'S') = 'S'

    SELECT @cantidad_etapas = COUNT(*)
    FROM dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND ISNULL(vigente, 'S') = 'S'

    IF ISNULL(@cantidad_etapas, 0) = 0
    BEGIN
        SELECT
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            @cod_unidad AS cod_unidad,
            @unidad_mayor AS unidad_mayor,
            @des_unidad AS des_unidad,
            @abr_flujo AS tipo_flujo,
            @cod_flusol AS cod_flusol,
            @des_flusol AS des_flusol,
            @abr_flujo AS abr_flusol,
            0 AS status,
            'NO_CONFIGURADO' AS estado_resolucion,
            'El flujo correspondiente no posee etapas vigentes configuradas.' AS mensaje
        RETURN
    END

    SELECT
        @cod_unifin AS cod_unifin,
        @cod_ccto AS cod_ccto,
        @cod_unidad AS cod_unidad,
        @unidad_mayor AS unidad_mayor,
        @des_unidad AS des_unidad,
        @abr_flujo AS tipo_flujo,
        @cod_flusol AS cod_flusol,
        @des_flusol AS des_flusol,
        @abr_flujo AS abr_flusol,
        1 AS status,
        'ENCONTRADO' AS estado_resolucion,
        CONVERT(varchar(255), NULL) AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_flusSecgen01 TO UsuaVrac
GO
