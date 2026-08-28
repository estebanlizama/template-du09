USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sp_orcosSecgen01'
)
    DROP PROCEDURE Analisis2.sp_orcosSecgen01
GO

/* Procedimiento : Analisis2.sp_orcosSecgen01

   Entrada :
   @cod_organi          -> Organizacion contra la que se resuelve. (Obligatorio)
   @ruts_excluidos      -> RUT que no pueden ser responsables, separados por
                           coma. (Opcional)
   @solo_parametros     -> 'S' para responder solo por parametros OUTPUT, sin
                           emitir el resultset. (Opcional, por omision 'N')

   Objetivo : Resolver el RESPONSABLE vigente de una organizacion recorriendo la
              cadena ORCO -> ORDE -> AUFI.

   No consulta la solicitud: los RUT a excluir -- normalmente los funcionarios
   de la prestacion, que no pueden visar lo suyo -- llegan como lista. Antes
   esta logica vivia dentro de sg_etasSecgen01 y filtraba leyendo sg_fups por
   nro_solici, lo que obligaba a tener la solicitud persistida para resolver un
   responsable.

   Orden de resolucion:
     1. ORCO: titular vigente y no ausente.
     2. ORDE: delegado vigente, cuando no hay titular.
     3. AUFI: subrogancia por prioridad ascendente. Dentro de cada prioridad se
        buscan titulares (AUFI_ORCO) y delegados (AUFI_ORDE) de la organizacion
        subrogante; se avanza a la prioridad siguiente solo si esa no resuelve.

   En cualquier nivel, mas de un candidato distinto es AMBIGUO y se corta: es
   preferible pedir definicion a elegir uno por criterio arbitrario.

   Salida :
   rut_responsable    -> RUT resuelto, NULL si no hay.
   cod_organi_actor   -> Organizacion de la que proviene la persona. Difiere de
                         @cod_organi cuando resolvio por subrogancia.
   fuente_resolucion  -> ORCO, ORDE, AUFI_ORCO o AUFI_ORDE.
   es_subrogante      -> S cuando la persona no es titular de @cod_organi.
   prioridad_aufi     -> Prioridad AUFI con la que resolvio.
   estado_resolucion  -> ENCONTRADO, AMBIGUO o NO_ENCONTRADO.
   mensaje            -> Detalle cuando no resolvio.

   Devuelve los mismos valores por resultset y por parametros OUTPUT. Con
   @solo_parametros = 'S' omite el resultset, que es como lo invoca
   sg_etasSecgen01: ASE 12.5 no admite INSERT ... EXEC -- se incorporo recien en
   ASE 15 -- de modo que OUTPUT es la unica via para encadenar procedimientos.

   Creacion: 2026/08/27
   Actualizacion: 2026/08/28 Parametros OUTPUT para uso como subrutina.
*/
CREATE PROCEDURE Analisis2.sp_orcosSecgen01
    @cod_organi       int,
    @ruts_excluidos   varchar(500) = NULL,
    @rut_responsable  char(9)      = NULL OUTPUT,
    @cod_organi_actor int          = NULL OUTPUT,
    @fuente           varchar(20)  = NULL OUTPUT,
    @es_subrogante    char(1)      = NULL OUTPUT,
    @prioridad_usada  int          = NULL OUTPUT,
    @estado           varchar(20)  = NULL OUTPUT,
    @mensaje          varchar(255) = NULL OUTPUT,
    @solo_parametros  char(1)      = 'N'
AS
BEGIN
    DECLARE @cantidad int
    DECLARE @prioridad int
    DECLARE @prioridad_anterior int
    DECLARE @filtro varchar(510)

    SELECT @rut_responsable = NULL, @cod_organi_actor = NULL, @fuente = NULL
    SELECT @es_subrogante = 'N', @prioridad_usada = NULL

    IF @cod_organi IS NULL OR @cod_organi <= 0
    BEGIN
        SELECT @estado = 'NO_CONFIGURADO',
               @mensaje = 'Debe informar la organizacion.'

        IF @solo_parametros <> 'S'
            SELECT
                CONVERT(int, NULL) AS cod_organi,
                CONVERT(char(9), NULL) AS rut_responsable,
                CONVERT(int, NULL) AS cod_organi_actor,
                CONVERT(varchar(20), NULL) AS fuente_resolucion,
                'N' AS es_subrogante,
                CONVERT(int, NULL) AS prioridad_aufi,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    /* La exclusion se evalua con CHARINDEX sobre la lista delimitada por comas
       en ambos extremos: asi '0123' no calza dentro de '80123456'. */
    SELECT @filtro = ',' + ISNULL(LTRIM(RTRIM(@ruts_excluidos)), '') + ','

    /* 1. Titular vigente de la organizacion. */
    SELECT @cantidad = COUNT(DISTINCT orco.rut_person)
    FROM sisper_db.dbo.sp_orco orco
    WHERE orco.cod_organi = @cod_organi
      AND orco.vigente = 'S'
      AND UPPER(LTRIM(RTRIM(ISNULL(orco.ausente, 'N')))) <> 'S'
      AND CHARINDEX(',' + RTRIM(orco.rut_person) + ',', @filtro) = 0

    IF ISNULL(@cantidad, 0) > 1
    BEGIN
        SELECT @fuente = 'ORCO',
               @estado = 'AMBIGUO',
               @mensaje = 'La organizacion posee mas de un titular vigente.'

        IF @solo_parametros <> 'S'
            SELECT
                @cod_organi AS cod_organi,
                CONVERT(char(9), NULL) AS rut_responsable,
                CONVERT(int, NULL) AS cod_organi_actor,
                @fuente AS fuente_resolucion,
                'N' AS es_subrogante,
                CONVERT(int, NULL) AS prioridad_aufi,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    IF @cantidad = 1
    BEGIN
        SELECT @rut_responsable = MIN(orco.rut_person)
        FROM sisper_db.dbo.sp_orco orco
        WHERE orco.cod_organi = @cod_organi
          AND orco.vigente = 'S'
          AND UPPER(LTRIM(RTRIM(ISNULL(orco.ausente, 'N')))) <> 'S'
          AND CHARINDEX(',' + RTRIM(orco.rut_person) + ',', @filtro) = 0

        SELECT @fuente = 'ORCO', @cod_organi_actor = @cod_organi
    END

    /* 2. Sin titular: delegado vigente de la misma organizacion. */
    IF @rut_responsable IS NULL
    BEGIN
        SELECT @cantidad = COUNT(DISTINCT orde.rut_person)
        FROM sisper_db.dbo.sp_orde orde
        WHERE orde.cod_organi = @cod_organi
          AND orde.vigente = 'S'
          AND CHARINDEX(',' + RTRIM(orde.rut_person) + ',', @filtro) = 0

        IF ISNULL(@cantidad, 0) > 1
        BEGIN
            SELECT @fuente = 'ORDE',
                   @estado = 'AMBIGUO',
                   @mensaje = 'La organizacion posee mas de un delegado vigente.'

            IF @solo_parametros <> 'S'
                SELECT
                    @cod_organi AS cod_organi,
                    CONVERT(char(9), NULL) AS rut_responsable,
                    CONVERT(int, NULL) AS cod_organi_actor,
                    @fuente AS fuente_resolucion,
                    'N' AS es_subrogante,
                    CONVERT(int, NULL) AS prioridad_aufi,
                    @estado AS estado_resolucion,
                    @mensaje AS mensaje
            RETURN
        END

        IF @cantidad = 1
        BEGIN
            SELECT @rut_responsable = MIN(orde.rut_person)
            FROM sisper_db.dbo.sp_orde orde
            WHERE orde.cod_organi = @cod_organi
              AND orde.vigente = 'S'
              AND CHARINDEX(',' + RTRIM(orde.rut_person) + ',', @filtro) = 0

            SELECT @fuente = 'ORDE', @cod_organi_actor = @cod_organi
        END
    END

    /* 3. Sin titular ni delegado: subrogancia AUFI por prioridad ascendente.
          La temporal se crea siempre, fuera del IF, porque ASE la resuelve al
          compilar el procedimiento completo. */
    CREATE TABLE #candidatos_aufi (
        rut_person       char(9) NOT NULL,
        cod_organi_actor int     NOT NULL,
        fuente           varchar(20) NOT NULL
    )

    IF @rut_responsable IS NULL
    BEGIN
        SELECT @prioridad_anterior = -1, @prioridad = NULL
        SELECT @prioridad = MIN(aufi.prioridad)
        FROM sisper_db.dbo.sp_aufi aufi
        WHERE aufi.cod_organi = @cod_organi

        WHILE @prioridad IS NOT NULL AND @rut_responsable IS NULL
        BEGIN
            DELETE FROM #candidatos_aufi
            INSERT INTO #candidatos_aufi
            SELECT orco.rut_person, aufi.cod_organ2, 'AUFI_ORCO'
            FROM sisper_db.dbo.sp_aufi aufi
            INNER JOIN sisper_db.dbo.sp_orco orco
              ON orco.cod_organi = aufi.cod_organ2
             AND orco.vigente = 'S'
             AND UPPER(LTRIM(RTRIM(ISNULL(orco.ausente, 'N')))) <> 'S'
            WHERE aufi.cod_organi = @cod_organi
              AND aufi.prioridad = @prioridad
              AND CHARINDEX(',' + RTRIM(orco.rut_person) + ',', @filtro) = 0
            UNION
            SELECT orde.rut_person, aufi.cod_organ2, 'AUFI_ORDE'
            FROM sisper_db.dbo.sp_aufi aufi
            INNER JOIN sisper_db.dbo.sp_orde orde
              ON orde.cod_organi = aufi.cod_organ2
             AND orde.vigente = 'S'
            WHERE aufi.cod_organi = @cod_organi
              AND aufi.prioridad = @prioridad
              AND CHARINDEX(',' + RTRIM(orde.rut_person) + ',', @filtro) = 0

            SELECT @cantidad = COUNT(DISTINCT rut_person)
            FROM #candidatos_aufi

            IF @cantidad > 1
            BEGIN
                SELECT @fuente = 'AUFI',
                       @es_subrogante = 'S',
                       @prioridad_usada = @prioridad,
                       @estado = 'AMBIGUO',
                       @mensaje = 'AUFI posee mas de un responsable disponible en la misma prioridad.'

                DROP TABLE #candidatos_aufi

                IF @solo_parametros <> 'S'
                    SELECT
                        @cod_organi AS cod_organi,
                        CONVERT(char(9), NULL) AS rut_responsable,
                        CONVERT(int, NULL) AS cod_organi_actor,
                        @fuente AS fuente_resolucion,
                        @es_subrogante AS es_subrogante,
                        @prioridad_usada AS prioridad_aufi,
                        @estado AS estado_resolucion,
                        @mensaje AS mensaje
                RETURN
            END

            IF @cantidad = 1
            BEGIN
                SELECT @rut_responsable = MIN(rut_person)
                FROM #candidatos_aufi

                SELECT @cod_organi_actor = MIN(cod_organi_actor)
                FROM #candidatos_aufi
                WHERE rut_person = @rut_responsable

                SELECT @fuente = CASE WHEN EXISTS (
                    SELECT 1 FROM #candidatos_aufi
                    WHERE rut_person = @rut_responsable AND fuente = 'AUFI_ORCO'
                ) THEN 'AUFI_ORCO' ELSE 'AUFI_ORDE' END

                SELECT @es_subrogante = 'S', @prioridad_usada = @prioridad
                BREAK
            END

            SELECT @prioridad_anterior = @prioridad, @prioridad = NULL
            SELECT @prioridad = MIN(aufi.prioridad)
            FROM sisper_db.dbo.sp_aufi aufi
            WHERE aufi.cod_organi = @cod_organi
              AND aufi.prioridad > @prioridad_anterior
        END
    END

    DROP TABLE #candidatos_aufi

    IF @rut_responsable IS NULL
    BEGIN
        SELECT @fuente = 'ORGANIZACION',
               @es_subrogante = 'N',
               @estado = 'NO_ENCONTRADO',
               @mensaje = 'No existe titular ni subrogante vigente para la organizacion.'

        IF @solo_parametros <> 'S'
            SELECT
                @cod_organi AS cod_organi,
                CONVERT(char(9), NULL) AS rut_responsable,
                CONVERT(int, NULL) AS cod_organi_actor,
                @fuente AS fuente_resolucion,
                @es_subrogante AS es_subrogante,
                CONVERT(int, NULL) AS prioridad_aufi,
                @estado AS estado_resolucion,
                @mensaje AS mensaje
        RETURN
    END

    SELECT @estado = 'ENCONTRADO', @mensaje = NULL

    IF @solo_parametros <> 'S'
        SELECT
            @cod_organi AS cod_organi,
            @rut_responsable AS rut_responsable,
            @cod_organi_actor AS cod_organi_actor,
            @fuente AS fuente_resolucion,
            @es_subrogante AS es_subrogante,
            @prioridad_usada AS prioridad_aufi,
            @estado AS estado_resolucion,
            @mensaje AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sp_orcosSecgen01 TO UsuaVrac
GO
