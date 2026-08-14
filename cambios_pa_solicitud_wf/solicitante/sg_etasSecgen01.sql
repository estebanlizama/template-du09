USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_etasSecgen01'
)
    DROP PROCEDURE Analisis2.sg_etasSecgen01
GO

/*
Procedimiento : Analisis2.sg_etasSecgen01
Objetivo      : Resolver los responsables de cualquier etapa DU288 usando
                solo sg_eta1 y los maestros institucionales existentes, sin
                consultar bd_pri2 ni requerir nuevas tablas.

El PA resuelve una etapa y no crea tareas. La navegacion entre etapas, la
omision por coincidencia con una etapa posterior y el registro de trazabilidad
son responsabilidad del backend.
*/
CREATE PROCEDURE Analisis2.sg_etasSecgen01
    @nro_solici int,
    @cod_etapa tinyint,
    @cod_flusol tinyint = NULL
AS
BEGIN
    DECLARE @cod_flusol1 tinyint
    DECLARE @cod_perfil smallint
    DECLARE @cod_respon tinyint
    DECLARE @cod_organi int
    DECLARE @cod_unidad char(8)
    DECLARE @prefijo char(2)
    DECLARE @estrategia varchar(30)
    DECLARE @perm_omitir char(1)
    DECLARE @rut_responsable char(9)
    DECLARE @fuente_resolucion varchar(20)
    DECLARE @cantidad int
    DECLARE @prioridad tinyint

    SELECT @cod_flusol1 = ISNULL(@cod_flusol, prse.cod_flusol)
    FROM dbo.sg_prse prse
    WHERE prse.nro_solici = @nro_solici

    SELECT
        @cod_perfil = eta.cod_perfil,
        @cod_organi = eta.cod_organi
    FROM dbo.sg_eta1 eta
    WHERE eta.cod_flusol = @cod_flusol1
      AND eta.cod_etapa = @cod_etapa
      AND ISNULL(eta.vigente, 'S') = 'S'

    SELECT @cod_unidad = ufin.cod_unidad
    FROM dbo.sg_prse prse
    INNER JOIN fin21_db..es_ccto ccto
        ON ccto.cod_unifin = prse.cod_unifin
       AND ccto.cod_ccto = prse.cod_ccto
    INNER JOIN fin21_db..es_ufin ufin
        ON ufin.cod_unifin = ccto.cod_unifin
    WHERE prse.nro_solici = @nro_solici
      AND ccto.vigente = '1'

    IF @cod_unidad IS NOT NULL
        SELECT @prefijo = SUBSTRING(@cod_unidad, 1, 2)

    IF @cod_flusol1 IS NULL OR @cod_perfil IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            CONVERT(int, NULL) AS cod_organi,
            CONVERT(tinyint, NULL) AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            CONVERT(varchar(20), NULL) AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La solicitud no posee flujo o la etapa no esta vigente.' AS mensaje,
            CONVERT(varchar(30), NULL) AS estrategia_resolucion,
            CONVERT(char(1), NULL) AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    /*
       El tipo de responsable ya esta expresado por cod_perfil en sg_eta1.
       Las etapas institucionales utilizan primero sg_eta1.cod_organi. Solo
       cuando ese dato no existe se completa con organizaciones que ya estan
       registradas en ufro_db..es_orga.
    */
    SELECT @estrategia = CASE @cod_perfil
        WHEN 6 THEN 'SOLICITANTE'
        WHEN 25 THEN 'JEFE_PROYECTO'
        WHEN 26 THEN 'JEFE_DIRECTO'
        ELSE 'ORGANIZACION_FIJA'
    END

    SELECT @perm_omitir = CASE
        WHEN @cod_perfil IN (6, 25, 12, 13, 14, 16, 17, 18, 23) THEN 'N'
        ELSE 'S'
    END

    IF @estrategia = 'ORGANIZACION_FIJA' AND @cod_organi IS NULL
    BEGIN
        /* Actores que varian segun Facultad o Instituto. */
        IF @cod_flusol1 = 1 AND @cod_etapa = 40
            SELECT @cod_organi = CASE @prefijo
                WHEN '06' THEN 831
                WHEN '07' THEN 835
                WHEN '08' THEN 838
                WHEN '09' THEN 847
                WHEN '17' THEN 602
                WHEN '18' THEN 642
                ELSE NULL
            END

        IF @cod_flusol1 = 1 AND @cod_etapa = 50
            SELECT @cod_organi = CASE @prefijo
                WHEN '06' THEN 82
                WHEN '07' THEN 135
                WHEN '08' THEN 204
                WHEN '09' THEN 248
                WHEN '17' THEN 586
                WHEN '18' THEN 623
                ELSE NULL
            END

        IF @cod_flusol1 = 4 AND @cod_etapa = 40
            SELECT @cod_organi = CASE @prefijo
                WHEN '10' THEN 268
                WHEN '14' THEN 297
                WHEN '15' THEN 457
                ELSE NULL
            END

        /* Actores institucionales fijos ya existentes en es_orga. */
        IF @cod_flusol1 = 2 AND @cod_etapa = 40 SELECT @cod_organi = 301
        IF @cod_flusol1 = 2 AND @cod_etapa = 50 SELECT @cod_organi = 299
        IF @cod_flusol1 = 3 AND @cod_etapa = 40 SELECT @cod_organi = 303
        IF @cod_flusol1 = 3 AND @cod_etapa = 50 SELECT @cod_organi = 299
        IF @cod_flusol1 = 4 AND @cod_etapa = 50 SELECT @cod_organi = 299
        IF @cod_flusol1 = 6 AND @cod_etapa = 40 SELECT @cod_organi = 17
        IF @cod_flusol1 = 7 AND @cod_etapa = 40 SELECT @cod_organi = 704
        IF @cod_flusol1 = 8 AND @cod_etapa = 40 SELECT @cod_organi = 299
    END

    SELECT @cod_respon = CASE @estrategia
        WHEN 'SOLICITANTE' THEN 1
        WHEN 'JEFE_PROYECTO' THEN 2
        WHEN 'JEFE_DIRECTO' THEN 3
        ELSE 4
    END

    IF @estrategia = 'SOLICITANTE'
    BEGIN
        SELECT @rut_responsable = soli.rut_solici
        FROM dbo.sg_soli soli
        WHERE soli.nro_solici = @nro_solici

        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            @rut_responsable AS rut_responsable,
            'SOLICITANTE' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            CASE WHEN @rut_responsable IS NULL THEN 'NO_ENCONTRADO' ELSE 'ENCONTRADO' END AS estado_resolucion,
            CASE WHEN @rut_responsable IS NULL THEN 'La solicitud no posee RUT solicitante.' ELSE NULL END AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    IF @estrategia = 'JEFE_PROYECTO'
    BEGIN
        SELECT @rut_responsable = prse.rut_jefpro
        FROM dbo.sg_prse prse
        WHERE prse.nro_solici = @nro_solici

        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            @rut_responsable AS rut_responsable,
            'JEFE_PROYECTO' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            CASE WHEN @rut_responsable IS NULL THEN 'NO_ENCONTRADO' ELSE 'ENCONTRADO' END AS estado_resolucion,
            CASE WHEN @rut_responsable IS NULL THEN 'La solicitud no posee Jefe de Proyecto.' ELSE NULL END AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    IF @estrategia = 'JEFE_DIRECTO'
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            fups.id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'JEFATURA_DIRECTA' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'RESOLVER_JEFATURA' AS estado_resolucion,
            CONVERT(varchar(255), NULL) AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto,
            fups.rut AS rut_funcionario,
            fups.cod_contra,
            fups.dentro_jor
        FROM dbo.sg_fups fups
        WHERE fups.nro_solici = @nro_solici
        ORDER BY fups.id_funprse
        RETURN
    END

    IF @cod_organi IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'CONFIGURACION' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La etapa requiere una organizacion configurada para la unidad institucional.' AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    /* Titular vigente de la organizacion. */
    SELECT @cantidad = COUNT(DISTINCT orco.rut_person)
    FROM sisper_db.dbo.sp_orco orco
    WHERE orco.cod_organi = @cod_organi
      AND orco.vigente = 'S'

    IF ISNULL(@cantidad, 0) > 1
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol, @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil, @cod_organi AS cod_organi,
            @cod_respon AS cod_respon, CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'ORCO' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'AMBIGUO' AS estado_resolucion,
            'La organizacion posee mas de un titular vigente.' AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    IF @cantidad = 1
    BEGIN
        SELECT @rut_responsable = MIN(orco.rut_person)
        FROM sisper_db.dbo.sp_orco orco
        WHERE orco.cod_organi = @cod_organi
          AND orco.vigente = 'S'
        SELECT @fuente_resolucion = 'ORCO'
    END

    /* Si no hay titular, utilizar delegado o subrogante vigente. */
    IF @rut_responsable IS NULL
    BEGIN
        SELECT @cantidad = COUNT(DISTINCT orde.rut_person)
        FROM sisper_db.dbo.sp_orde orde
        WHERE orde.cod_organi = @cod_organi
          AND orde.vigente = 'S'

        IF ISNULL(@cantidad, 0) > 1
        BEGIN
            SELECT
                @cod_flusol1 AS cod_flusol, @cod_etapa AS cod_etapa,
                @cod_perfil AS cod_perfil, @cod_organi AS cod_organi,
                @cod_respon AS cod_respon, CONVERT(int, NULL) AS id_funprse,
                CONVERT(char(9), NULL) AS rut_responsable,
                'ORDE' AS fuente_resolucion,
                CONVERT(varchar(255), NULL) AS nombre_responsable,
                CONVERT(varchar(100), NULL) AS cargo_responsable,
                'AMBIGUO' AS estado_resolucion,
                'La organizacion posee mas de un delegado o subrogante vigente.' AS mensaje,
                @estrategia AS estrategia_resolucion,
                @perm_omitir AS permite_omision,
                @cod_unidad AS cod_unidad_contexto
            RETURN
        END

        IF @cantidad = 1
        BEGIN
            SELECT @rut_responsable = MIN(orde.rut_person)
            FROM sisper_db.dbo.sp_orde orde
            WHERE orde.cod_organi = @cod_organi
              AND orde.vigente = 'S'
            SELECT @fuente_resolucion = 'ORDE'
        END
    END

    /* Ultima alternativa: organizacion superior AUFI de menor prioridad. */
    IF @rut_responsable IS NULL
    BEGIN
        SELECT @prioridad = MIN(aufi.prioridad)
        FROM sisper_db.dbo.sp_aufi aufi
        WHERE aufi.cod_organi = @cod_organi
          AND (
              EXISTS (
                  SELECT 1 FROM sisper_db.dbo.sp_orco orco
                  WHERE orco.cod_organi = aufi.cod_organ2
                    AND orco.vigente = 'S'
              )
              OR EXISTS (
                  SELECT 1 FROM sisper_db.dbo.sp_orde orde
                  WHERE orde.cod_organi = aufi.cod_organ2
                    AND orde.vigente = 'S'
              )
          )

        IF @prioridad IS NOT NULL
        BEGIN
            SELECT @cantidad = COUNT(DISTINCT orco.rut_person)
            FROM sisper_db.dbo.sp_aufi aufi
            INNER JOIN sisper_db.dbo.sp_orco orco
                ON orco.cod_organi = aufi.cod_organ2
               AND orco.vigente = 'S'
            WHERE aufi.cod_organi = @cod_organi
              AND aufi.prioridad = @prioridad

            IF @cantidad > 1
            BEGIN
                SELECT
                    @cod_flusol1 AS cod_flusol, @cod_etapa AS cod_etapa,
                    @cod_perfil AS cod_perfil, @cod_organi AS cod_organi,
                    @cod_respon AS cod_respon, CONVERT(int, NULL) AS id_funprse,
                    CONVERT(char(9), NULL) AS rut_responsable,
                    'AUFI_ORCO' AS fuente_resolucion,
                    CONVERT(varchar(255), NULL) AS nombre_responsable,
                    CONVERT(varchar(100), NULL) AS cargo_responsable,
                    'AMBIGUO' AS estado_resolucion,
                    'La organizacion superior posee mas de un titular vigente.' AS mensaje,
                    @estrategia AS estrategia_resolucion,
                    @perm_omitir AS permite_omision,
                    @cod_unidad AS cod_unidad_contexto
                RETURN
            END

            IF @cantidad = 1
            BEGIN
                SELECT @rut_responsable = MIN(orco.rut_person)
                FROM sisper_db.dbo.sp_aufi aufi
                INNER JOIN sisper_db.dbo.sp_orco orco
                    ON orco.cod_organi = aufi.cod_organ2
                   AND orco.vigente = 'S'
                WHERE aufi.cod_organi = @cod_organi
                  AND aufi.prioridad = @prioridad
                SELECT @fuente_resolucion = 'AUFI_ORCO'
            END

            IF @rut_responsable IS NULL
            BEGIN
                SELECT @cantidad = COUNT(DISTINCT orde.rut_person)
                FROM sisper_db.dbo.sp_aufi aufi
                INNER JOIN sisper_db.dbo.sp_orde orde
                    ON orde.cod_organi = aufi.cod_organ2
                   AND orde.vigente = 'S'
                WHERE aufi.cod_organi = @cod_organi
                  AND aufi.prioridad = @prioridad

                IF @cantidad > 1
                BEGIN
                    SELECT
                        @cod_flusol1 AS cod_flusol, @cod_etapa AS cod_etapa,
                        @cod_perfil AS cod_perfil, @cod_organi AS cod_organi,
                        @cod_respon AS cod_respon, CONVERT(int, NULL) AS id_funprse,
                        CONVERT(char(9), NULL) AS rut_responsable,
                        'AUFI_ORDE' AS fuente_resolucion,
                        CONVERT(varchar(255), NULL) AS nombre_responsable,
                        CONVERT(varchar(100), NULL) AS cargo_responsable,
                        'AMBIGUO' AS estado_resolucion,
                        'La organizacion superior posee mas de un delegado vigente.' AS mensaje,
                        @estrategia AS estrategia_resolucion,
                        @perm_omitir AS permite_omision,
                        @cod_unidad AS cod_unidad_contexto
                    RETURN
                END

                IF @cantidad = 1
                BEGIN
                    SELECT @rut_responsable = MIN(orde.rut_person)
                    FROM sisper_db.dbo.sp_aufi aufi
                    INNER JOIN sisper_db.dbo.sp_orde orde
                        ON orde.cod_organi = aufi.cod_organ2
                       AND orde.vigente = 'S'
                    WHERE aufi.cod_organi = @cod_organi
                      AND aufi.prioridad = @prioridad
                    SELECT @fuente_resolucion = 'AUFI_ORDE'
                END
            END
        END
    END

    IF @rut_responsable IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'ORGANIZACION' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_ENCONTRADO' AS estado_resolucion,
            'No existe titular ni subrogante vigente para la organizacion.' AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    SELECT
        @cod_flusol1 AS cod_flusol,
        @cod_etapa AS cod_etapa,
        @cod_perfil AS cod_perfil,
        @cod_organi AS cod_organi,
        @cod_respon AS cod_respon,
        CONVERT(int, NULL) AS id_funprse,
        @rut_responsable AS rut_responsable,
        @fuente_resolucion AS fuente_resolucion,
        RTRIM(LTRIM(
            ISNULL(
                CASE
                    WHEN LEN(ISNULL(per.nom_dest, '')) <= 1 THEN per.nom_nombre
                    ELSE per.nom_dest
                END,
                ''
            ) + ' ' + ISNULL(per.nom_appate, '') + ' ' + ISNULL(per.nom_apmate, '')
        )) AS nombre_responsable,
        RTRIM(org.des_organi) AS cargo_responsable,
        'ENCONTRADO' AS estado_resolucion,
        CONVERT(varchar(255), NULL) AS mensaje,
        @estrategia AS estrategia_resolucion,
        @perm_omitir AS permite_omision,
        @cod_unidad AS cod_unidad_contexto
    FROM sisper_db..sp_pers per
    LEFT JOIN ufro_db..es_orga org
        ON org.cod_organi = @cod_organi
    WHERE per.rut_person = @rut_responsable
END
GO

GRANT EXECUTE ON Analisis2.sg_etasSecgen01 TO UsuaVrac
GO
