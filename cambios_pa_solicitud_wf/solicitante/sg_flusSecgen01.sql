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

/* Procedimiento : Analisis2.sg_flusSecgen01

   Entrada :
   @cod_unifin          -> Unidad financiera. (Opcional)
   @cod_ccto            -> Centro de costo. (Opcional)

   Objetivo : Resolver el flujo DU288 con los datos existentes del Centro de Costo y los maestros sg_tfls/sg_eta1. Restricciones del modelo actual: - No crea ni consulta tablas adicionales de configuracion. - La unidad institucional se obtiene desde fin21_db..es_ccto/es_ufin. - El prefijo institucional determina los flujos identificables con los datos actualmente disponibles. - Investigacion y DITT deben contar con un dato diferenciador existente antes de incorporarse; no se infieren por nombre ni por RUT.

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_flusSecgen01
    @cod_unifin smallint = NULL,
    @cod_ccto smallint = NULL
AS
BEGIN
    DECLARE @cod_unidad char(8)
    DECLARE @unidad_mayor char(8)
    DECLARE @des_unidad varchar(100)
    DECLARE @prefijo char(2)
    DECLARE @cod_flusol tinyint
    DECLARE @des_flusol varchar(60)
    DECLARE @abr_flujo varchar(10)
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

    SELECT @prefijo = SUBSTRING(@cod_unidad, 1, 2)
    SELECT @unidad_mayor = @prefijo + '000000'

    /* Correspondencia soportada por la estructura institucional UFRO */
    SELECT @cod_flusol = CASE
        WHEN @prefijo IN ('06', '07', '08', '09', '17', '18') THEN 1
        WHEN SUBSTRING(@cod_unidad, 1, 3) IN ('161', '162') THEN 4
        WHEN @prefijo = '03' THEN 5
        WHEN @prefijo = '02' THEN 6
        WHEN @prefijo = '19' THEN 7
        WHEN @prefijo = '16' THEN 8
        ELSE NULL
    END

    IF @cod_flusol IS NULL
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
            'La unidad institucional no permite determinar un flujo DU288 con los datos existentes.' AS mensaje
        RETURN
    END

    SELECT @cantidad_flujos = COUNT(*)
    FROM dbo.sg_tfls
    WHERE cod_flusol = @cod_flusol
      AND ISNULL(vigente, 'S') = 'S'

    IF ISNULL(@cantidad_flujos, 0) <> 1
    BEGIN
        SELECT
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            @cod_unidad AS cod_unidad,
            @unidad_mayor AS unidad_mayor,
            @des_unidad AS des_unidad,
            CONVERT(varchar(10), NULL) AS tipo_flujo,
            @cod_flusol AS cod_flusol,
            CONVERT(varchar(60), NULL) AS des_flusol,
            CONVERT(varchar(10), NULL) AS abr_flusol,
            0 AS status,
            CASE WHEN ISNULL(@cantidad_flujos, 0) = 0
                THEN 'NO_CONFIGURADO'
                ELSE 'AMBIGUO'
            END AS estado_resolucion,
            CASE WHEN ISNULL(@cantidad_flujos, 0) = 0
                THEN 'El flujo determinado no existe o no esta vigente.'
                ELSE 'Existe mas de un flujo vigente para el codigo determinado.'
            END AS mensaje
        RETURN
    END

    SELECT
        @des_flusol = des_flusol,
        @abr_flujo = abr_flusol
    FROM dbo.sg_tfls
    WHERE cod_flusol = @cod_flusol
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
            'El flujo correspondiente no posee etapas vigentes.' AS mensaje
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
