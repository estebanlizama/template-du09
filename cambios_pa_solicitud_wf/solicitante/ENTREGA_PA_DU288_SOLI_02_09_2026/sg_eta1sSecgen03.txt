USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_eta1sSecgen03'
)
    DROP PROCEDURE Analisis2.sg_eta1sSecgen03
GO

/* Procedimiento : Analisis2.sg_eta1sSecgen03

   Entrada :
   @cod_flusol          -> Codigo de flujo de solicitud. (Obligatorio)
   @cod_etapa           -> Codigo de etapa. (Obligatorio)
   @cod_perfil          -> Perfil configurado para la etapa. (Opcional)
   @cod_organi          -> Organizacion configurada para la etapa. (Opcional)
   @des_etapa           -> Descripcion de la etapa. (Opcional)
   @estrategia          -> Estrategia de resolucion. (Opcional)
   @perm_omitir         -> Indicador de omision permitida. (Opcional)
   @estado              -> Estado de la resolucion. (Opcional)
   @mensaje             -> Mensaje de la resolucion. (Opcional)
   @solo_parametros     -> Indicador de respuesta solo por parametros. (Opcional)

   Objetivo : Obtener la politica de resolucion y omision configurada para una
              etapa del flujo de solicitud.

   Creacion: ELA 2026/08/27
   Actualizacion: ELA 2026/08/28
*/
CREATE PROCEDURE Analisis2.sg_eta1sSecgen03
    @cod_flusol       tinyint,
    @cod_etapa        tinyint,
    @cod_perfil       smallint     = NULL OUTPUT,
    @cod_organi       int          = NULL OUTPUT,
    @des_etapa        varchar(100) = NULL OUTPUT,
    @estrategia       varchar(30)  = NULL OUTPUT,
    @perm_omitir      char(1)      = NULL OUTPUT,
    @estado           varchar(20)  = NULL OUTPUT,
    @mensaje          varchar(255) = NULL OUTPUT,
    @solo_parametros  char(1)      = 'N'
AS
BEGIN
    SELECT @cod_perfil = NULL, @cod_organi = NULL, @des_etapa = NULL
    SELECT @estrategia = NULL, @perm_omitir = NULL

    IF @cod_flusol IS NULL OR @cod_etapa IS NULL
    BEGIN
        SELECT @estado = 'NO_CONFIGURADO',
               @mensaje = 'Debe informar el flujo y la etapa.'

        IF @solo_parametros <> 'S'
            SELECT
                CONVERT(tinyint, @cod_flusol) AS cod_flusol,
                CONVERT(tinyint, @cod_etapa) AS cod_etapa,
                CONVERT(smallint, NULL) AS cod_perfil,
                CONVERT(int, NULL) AS cod_organi,
                CONVERT(varchar(100), NULL) AS des_etapa,
                CONVERT(varchar(30), NULL) AS estrategia_resolucion,
                CONVERT(char(1), NULL) AS permite_omision,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    SELECT
        @cod_perfil = eta.cod_perfil,
        @cod_organi = eta.cod_organi,
        @des_etapa  = eta.des_etapa
    FROM dbo.sg_eta1 eta
    WHERE eta.cod_flusol = @cod_flusol
      AND eta.cod_etapa = @cod_etapa
      AND ISNULL(eta.vigente, 'S') = 'S'

    IF @cod_perfil IS NULL
    BEGIN
        SELECT @estado = 'NO_CONFIGURADO',
               @mensaje = 'La etapa no esta vigente para el flujo indicado.'

        IF @solo_parametros <> 'S'
            SELECT
                @cod_flusol AS cod_flusol,
                @cod_etapa AS cod_etapa,
                CONVERT(smallint, NULL) AS cod_perfil,
                CONVERT(int, NULL) AS cod_organi,
                CONVERT(varchar(100), NULL) AS des_etapa,
                CONVERT(varchar(30), NULL) AS estrategia_resolucion,
                CONVERT(char(1), NULL) AS permite_omision,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    /* Determina la estrategia desde el perfil configurado para la etapa. */
    SELECT @estrategia = CASE @cod_perfil
        WHEN 6 THEN 'SOLICITANTE'
        WHEN 25 THEN 'JEFE_PROYECTO'
        WHEN 26 THEN 'JEFE_DIRECTO'
        ELSE 'ORGANIZACION_FIJA'
    END

    /* Los perfiles formales ejecutan controles propios y no admiten omision.
       Para los demas perfiles, la bandera solo habilita evaluar si una misma
       persona reaparece como responsable en una etapa posterior. */
    SELECT @perm_omitir = CASE
        WHEN @cod_perfil IN (6, 10, 12, 13, 14, 16, 17, 18, 23) THEN 'N'
        ELSE 'S'
    END

    SELECT @estado = 'ENCONTRADO', @mensaje = NULL

    IF @solo_parametros <> 'S'
        SELECT
            @cod_flusol AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            RTRIM(@des_etapa) AS des_etapa,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @estado AS estado_resolucion,
            @mensaje AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_eta1sSecgen03 TO UsuaVrac
GO
