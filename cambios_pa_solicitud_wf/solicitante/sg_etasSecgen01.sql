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
    @cod_etapa tinyint
AS
BEGIN
    DECLARE @cod_flusol tinyint
    DECLARE @cod_respon tinyint
    DECLARE @cod_perfil smallint
    DECLARE @cod_organi int
    DECLARE @rut_respons char(9)
    DECLARE @cantidad int
    DECLARE @prioridad tinyint

    SELECT
        @cod_flusol = prse.cod_flusol,
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
        ON eta.cod_flusol = prse.cod_flusol
       AND eta.cod_etapa = @cod_etapa
    WHERE prse.nro_solici = @nro_solici
      AND isnull(eta.vigente, 'S') = 'S'

    IF @cod_flusol IS NULL OR @cod_perfil IS NULL
    BEGIN
        SELECT
            @cod_flusol AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            CONVERT(varchar(20), NULL) AS fuente_resolucion,
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
            @cod_flusol AS cod_flusol,
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
            @cod_flusol AS cod_flusol,
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
            @cod_flusol AS cod_flusol,
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
            @cod_flusol AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'ORGANIZACION' AS fuente_resolucion,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La etapa institucional no posee cod_organi configurado.' AS mensaje
        RETURN
    END

    CREATE TABLE #responsables (
        rut_responsable char(9) NOT NULL,
        fuente_resolucion varchar(20) NOT NULL
    )

    INSERT INTO #responsables
    SELECT DISTINCT orco.rut_person, 'ORCO'
    FROM sisper_db.dbo.sp_orco orco
    WHERE orco.cod_organi = @cod_organi
      AND orco.vigente = 'S'

    IF @@rowcount = 0
    BEGIN
        INSERT INTO #responsables
        SELECT DISTINCT orde.rut_person, 'ORDE'
        FROM sisper_db.dbo.sp_orde orde
        WHERE orde.cod_organi = @cod_organi
          AND orde.vigente = 'S'
    END

    IF NOT EXISTS (SELECT 1 FROM #responsables)
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

        INSERT INTO #responsables
        SELECT DISTINCT orco.rut_person, 'AUFI_ORCO'
        FROM sisper_db.dbo.sp_aufi aufi
        INNER JOIN sisper_db.dbo.sp_orco orco
            ON orco.cod_organi = aufi.cod_organ2
           AND orco.vigente = 'S'
        WHERE aufi.cod_organi = @cod_organi
          AND aufi.prioridad = @prioridad

        INSERT INTO #responsables
        SELECT DISTINCT orde.rut_person, 'AUFI_ORDE'
        FROM sisper_db.dbo.sp_aufi aufi
        INNER JOIN sisper_db.dbo.sp_orde orde
            ON orde.cod_organi = aufi.cod_organ2
           AND orde.vigente = 'S'
        WHERE aufi.cod_organi = @cod_organi
          AND aufi.prioridad = @prioridad
          AND NOT EXISTS (
              SELECT 1
              FROM sisper_db.dbo.sp_orco orco
              WHERE orco.cod_organi = aufi.cod_organ2
                AND orco.vigente = 'S'
          )
    END

    SELECT @cantidad = count(DISTINCT rut_responsable)
    FROM #responsables

    IF @cantidad = 0
    BEGIN
        SELECT
            @cod_flusol AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'ORGANIZACION' AS fuente_resolucion,
            'NO_ENCONTRADO' AS estado_resolucion,
            'No existe titular ni subrogante vigente para la organizacion.' AS mensaje
        RETURN
    END

    SELECT DISTINCT
        @cod_flusol AS cod_flusol,
        @cod_etapa AS cod_etapa,
        @cod_perfil AS cod_perfil,
        @cod_organi AS cod_organi,
        @cod_respon AS cod_respon,
        CONVERT(int, NULL) AS id_funprse,
        resp.rut_responsable,
        resp.fuente_resolucion,
        CASE WHEN @cantidad = 1 THEN 'ENCONTRADO' ELSE 'AMBIGUO' END AS estado_resolucion,
        CASE
            WHEN @cantidad = 1 THEN NULL
            ELSE 'Existe mas de un titular o subrogante vigente para la organizacion.'
        END AS mensaje
    FROM #responsables resp
    ORDER BY resp.rut_responsable
END
GO

GRANT EXECUTE ON Analisis2.sg_etasSecgen01 TO UsuaVrac
GO
