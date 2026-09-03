USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen20'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen20
GO

/* Procedimiento : Analisis2.sg_prsesSecgen20

   Entrada :
   @nro_solici          -> Numero de solicitud. (Obligatorio)
   @cod_flusol          -> Flujo de la solicitud. (Opcional)
   @cod_unifin          -> Unidad financiera. (Opcional)
   @cod_ccto            -> Centro de costo. (Opcional)
   @cod_unidad          -> Unidad institucional. (Opcional)
   @prefijo             -> Prefijo de la unidad institucional. (Opcional)
   @rut_solicitante     -> RUT del solicitante. (Opcional)
   @cod_etapa           -> Etapa actual de la solicitud. (Opcional)
   @estado              -> Estado de la resolucion. (Opcional)
   @mensaje             -> Mensaje de la resolucion. (Opcional)
   @solo_parametros     -> Indicador de respuesta solo por parametros. (Opcional)

   Objetivo : Obtener el contexto institucional de una solicitud requerido
              para resolver responsables y etapas del flujo.

   Creacion: ELA 2026/08/27
   Actualizacion: ELA 2026/08/28
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen20
    @nro_solici       int,
    @cod_flusol       tinyint      = NULL OUTPUT,
    @cod_unifin       smallint     = NULL OUTPUT,
    @cod_ccto         smallint     = NULL OUTPUT,
    @cod_unidad       char(8)      = NULL OUTPUT,
    @prefijo          char(2)      = NULL OUTPUT,
    @rut_solicitante  char(9)      = NULL OUTPUT,
    @cod_etapa        tinyint      = NULL OUTPUT,
    @estado           varchar(20)  = NULL OUTPUT,
    @mensaje          varchar(255) = NULL OUTPUT,
    @solo_parametros  char(1)      = 'N'
AS
BEGIN
    SELECT @cod_flusol = NULL, @cod_unifin = NULL, @cod_ccto = NULL
    SELECT @cod_unidad = NULL, @prefijo = NULL, @rut_solicitante = NULL
    SELECT @cod_etapa = NULL

    IF @nro_solici IS NULL OR @nro_solici <= 0
    BEGIN
        SELECT @estado = 'NO_CONFIGURADO',
               @mensaje = 'Debe informar el numero de solicitud.'

        IF @solo_parametros <> 'S'
            SELECT
                CONVERT(tinyint, NULL) AS cod_flusol,
                CONVERT(smallint, NULL) AS cod_unifin,
                CONVERT(smallint, NULL) AS cod_ccto,
                CONVERT(char(8), NULL) AS cod_unidad,
                CONVERT(char(2), NULL) AS prefijo_unidad,
                CONVERT(char(9), NULL) AS rut_solicitante,
                CONVERT(tinyint, NULL) AS cod_etapa,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    SELECT
        @cod_flusol = prse.cod_flusol,
        @cod_unifin = prse.cod_unifin,
        @cod_ccto   = prse.cod_ccto,
        @cod_etapa  = prse.cod_etapa
    FROM dbo.sg_prse prse
    WHERE prse.nro_solici = @nro_solici

    IF @cod_flusol IS NULL AND @cod_unifin IS NULL
    BEGIN
        SELECT @estado = 'NO_ENCONTRADO',
               @mensaje = 'La solicitud no existe o no tiene prestacion asociada.'

        IF @solo_parametros <> 'S'
            SELECT
                CONVERT(tinyint, NULL) AS cod_flusol,
                CONVERT(smallint, NULL) AS cod_unifin,
                CONVERT(smallint, NULL) AS cod_ccto,
                CONVERT(char(8), NULL) AS cod_unidad,
                CONVERT(char(2), NULL) AS prefijo_unidad,
                CONVERT(char(9), NULL) AS rut_solicitante,
                CONVERT(tinyint, NULL) AS cod_etapa,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    /* La unidad institucional viene del centro de costo, no de la solicitud:
       es la que define el prefijo con que se acota el ascenso jerarquico. */
    SELECT @cod_unidad = ufin.cod_unidad
    FROM fin21_db..es_ccto ccto
    INNER JOIN fin21_db..es_ufin ufin
        ON ufin.cod_unifin = ccto.cod_unifin
    WHERE ccto.cod_unifin = @cod_unifin
      AND ccto.cod_ccto = @cod_ccto
      AND ccto.vigente = '1'

    IF @cod_unidad IS NOT NULL
        SELECT @prefijo = SUBSTRING(@cod_unidad, 1, 2)

    SELECT @rut_solicitante = soli.rut_solici
    FROM dbo.sg_soli soli
    WHERE soli.nro_solici = @nro_solici

    SELECT @estado = 'ENCONTRADO', @mensaje = NULL

    IF @solo_parametros <> 'S'
        SELECT
            @cod_flusol AS cod_flusol,
            @cod_unifin AS cod_unifin,
            @cod_ccto AS cod_ccto,
            @cod_unidad AS cod_unidad,
            @prefijo AS prefijo_unidad,
            @rut_solicitante AS rut_solicitante,
            @cod_etapa AS cod_etapa,
            @estado AS estado_resolucion,
            @mensaje AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen20 TO UsuaVrac
GO
