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
Objetivo      : Resolver los candidatos responsables de una etapa configurada
                de PDS DU288 sin consultar bd_pri2.

El PA no crea tareas. El backend debe aceptar solamente estado_resolucion =
ENCONTRADO y debe rechazar configuraciones ambiguas o incompletas.
*/
CREATE PROCEDURE Analisis2.sg_etasSecgen01
    @nro_solici int,
    @cod_etapa tinyint,
    @cod_flusol tinyint = NULL
AS
BEGIN
    DECLARE @cod_flusol1 tinyint
    DECLARE @cod_respon tinyint
    DECLARE @cod_perfil smallint
    DECLARE @cod_organi int
    DECLARE @rut_respons char(9)
    DECLARE @cantidad int
    DECLARE @prioridad tinyint

    SELECT
        @cod_flusol1 = isnull(@cod_flusol, prse.cod_flusol),
        @cod_perfil = eta.cod_perfil,
        @cod_organi = eta.cod_organi,
        @cod_respon = CASE
            WHEN eta.cod_perfil = 6 THEN 1
            WHEN eta.cod_perfil = 25 THEN 2
            WHEN eta.cod_perfil = 26 THEN 3
            ELSE 4
        END
    FROM dbo.sg_prse prse
    INNER JOIN dbo.sg_eta1 eta
        ON eta.cod_flusol = isnull(@cod_flusol, prse.cod_flusol)
       AND eta.cod_etapa = @cod_etapa
    WHERE prse.nro_solici = @nro_solici
      AND isnull(eta.vigente, 'S') = 'S'

    IF @cod_flusol1 IS NULL OR @cod_perfil IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            CONVERT(varchar(20), NULL) AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La etapa no posee una estrategia de responsable vigente.' AS mensaje
        RETURN
    END

    IF @cod_respon = 1
    BEGIN
        SELECT @rut_respons = soli.rut_solici
        FROM dbo.sg_soli soli
        WHERE soli.nro_solici = @nro_solici

        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            @rut_respons AS rut_responsable,
            'SOLICITANTE' AS fuente_resolucion,
            CASE WHEN @rut_respons IS NULL THEN 'NO_ENCONTRADO' ELSE 'ENCONTRADO' END AS estado_resolucion,
            CASE WHEN @rut_respons IS NULL THEN 'La solicitud no posee RUT solicitante.' ELSE NULL END AS mensaje
        RETURN
    END

    IF @cod_respon = 2
    BEGIN
        SELECT @rut_respons = prse.rut_jefpro
        FROM dbo.sg_prse prse
        WHERE prse.nro_solici = @nro_solici

        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            @rut_respons AS rut_responsable,
            'JEFE_PROYECTO' AS fuente_resolucion,
            CASE WHEN @rut_respons IS NULL THEN 'NO_ENCONTRADO' ELSE 'ENCONTRADO' END AS estado_resolucion,
            CASE WHEN @rut_respons IS NULL THEN 'La solicitud no posee Jefe de Proyecto.' ELSE NULL END AS mensaje
        RETURN
    END

    IF @cod_respon = 3
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
            'RESOLVER_JEFATURA' AS estado_resolucion,
            CONVERT(varchar(255), NULL) AS mensaje,
            fups.rut AS rut_funcionario,
            fups.cod_contra
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
            'ORGANIZACION' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La etapa institucional no posee cod_organi configurado.' AS mensaje
        RETURN
    END

    DECLARE @rut_responsable char(9)
    DECLARE @fuente_resolucion varchar(20)

    /* 1. Evaluar Titular (ORCO) */
    SELECT @rut_responsable = min(orco.rut_person)
    FROM sisper_db.dbo.sp_orco orco
    WHERE orco.cod_organi = @cod_organi
      AND orco.vigente = 'S'

    IF @rut_responsable IS NOT NULL
        SELECT @fuente_resolucion = 'ORCO'

    /* 2. Si no existe Titular, evaluar Subrogante/Delegado (ORDE) */
    IF @rut_responsable IS NULL
    BEGIN
        SELECT @rut_responsable = min(orde.rut_person)
        FROM sisper_db.dbo.sp_orde orde
        WHERE orde.cod_organi = @cod_organi
          AND orde.vigente = 'S'

        IF @rut_responsable IS NOT NULL
            SELECT @fuente_resolucion = 'ORDE'
    END

    /* 3. Si no existe en la organizacion directa, evaluar Jefatura AUFI */
    IF @rut_responsable IS NULL
    BEGIN
        SELECT @prioridad = min(aufi.prioridad)
        FROM sisper_db.dbo.sp_aufi aufi
        WHERE aufi.cod_organi = @cod_organi
          AND (
              EXISTS (
                  SELECT 1
                  FROM sisper_db.dbo.sp_orco orco
                  WHERE orco.cod_organi = aufi.cod_organ2
                    AND orco.vigente = 'S'
              )
              OR EXISTS (
                  SELECT 1
                  FROM sisper_db.dbo.sp_orde orde
                  WHERE orde.cod_organi = aufi.cod_organ2
                    AND orde.vigente = 'S'
              )
          )

        IF @prioridad IS NOT NULL
        BEGIN
            SELECT @rut_responsable = min(orco.rut_person)
            FROM sisper_db.dbo.sp_aufi aufi
            INNER JOIN sisper_db.dbo.sp_orco orco
                ON orco.cod_organi = aufi.cod_organ2
               AND orco.vigente = 'S'
            WHERE aufi.cod_organi = @cod_organi
              AND aufi.prioridad = @prioridad

            IF @rut_responsable IS NOT NULL
                SELECT @fuente_resolucion = 'AUFI_ORCO'

            IF @rut_responsable IS NULL
            BEGIN
                SELECT @rut_responsable = min(orde.rut_person)
                FROM sisper_db.dbo.sp_aufi aufi
                INNER JOIN sisper_db.dbo.sp_orde orde
                    ON orde.cod_organi = aufi.cod_organ2
                   AND orde.vigente = 'S'
                WHERE aufi.cod_organi = @cod_organi
                  AND aufi.prioridad = @prioridad

                IF @rut_responsable IS NOT NULL
                    SELECT @fuente_resolucion = 'AUFI_ORDE'
            END
        END
    END

    /* 4. Si no fue posible resolver un responsable */
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
            'No existe titular ni subrogante vigente para la organizacion.' AS mensaje
        RETURN
    END

    /* 5. Retornar el responsable resuelto */
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
                    WHEN LEN(ISNULL(per.nom_dest, '')) <= 1
                        THEN per.nom_nombre
                    ELSE per.nom_dest
                END,
                ''
            ) + ' ' + ISNULL(per.nom_appate, '') + ' ' + ISNULL(per.nom_apmate, '')
        )) AS nombre_responsable,
        RTRIM(org.des_organi) AS cargo_responsable,
        'ENCONTRADO' AS estado_resolucion,
        CONVERT(varchar(255), NULL) AS mensaje
    FROM sisper_db..sp_pers per
    LEFT JOIN ufro_db..es_orga org
        ON org.cod_organi = @cod_organi
    WHERE per.rut_person = @rut_responsable
END
GO

GRANT EXECUTE ON Analisis2.sg_etasSecgen01 TO UsuaVrac
GO
