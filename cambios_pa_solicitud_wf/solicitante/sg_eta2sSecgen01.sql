USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_eta2sSecgen01'
)
    DROP PROCEDURE Analisis2.sg_eta2sSecgen01
GO

/*
Procedimiento : Analisis2.sg_eta2sSecgen01
Objetivo      : Resolver una transicion configurada en sg_eta2 o listar las
                acciones disponibles para la etapa actual de una solicitud.

Uso inicial  : informar @cod_flusol y dejar @nro_solici NULL.
Uso solicitud: informar @nro_solici; el flujo y etapa se leen desde sg_prse.
Uso acciones : informar @nro_solici y dejar @id_tipacc NULL.

El PA solo consulta y valida. No modifica sg_prse, sg_soli ni sg_apso.
*/
CREATE PROCEDURE Analisis2.sg_eta2sSecgen01
    @nro_solici int = NULL,
    @cod_flusol tinyint = NULL,
    @id_tipacc tinyint = NULL,
    @cod_etaori tinyint = NULL
AS
BEGIN
    DECLARE @cod_flusol1 tinyint
    DECLARE @cod_etapa1 tinyint
    DECLARE @cod_etapa2 tinyint
    DECLARE @cod_estsol tinyint
    DECLARE @cod_etapa_resol tinyint
    DECLARE @cod_etapa_devol tinyint
    DECLARE @cod_etapa_reingreso tinyint
    DECLARE @cantidad_transiciones int

    IF @nro_solici IS NULL AND @cod_flusol IS NULL
    BEGIN
        SELECT 0 AS status, 'Debe informar Numero de Solicitud o Codigo de Flujo' AS mensaje
        RETURN
    END

    IF @nro_solici IS NOT NULL
    BEGIN
        SELECT
            @cod_flusol1 = cod_flusol,
            @cod_etapa1 = isnull(@cod_etaori, cod_etapa)
        FROM secgen_db.dbo.sg_prse
        WHERE nro_solici = @nro_solici
    END
    ELSE
    BEGIN
        SELECT @cod_flusol1 = @cod_flusol

        IF @cod_etaori IS NOT NULL
        BEGIN
            SELECT @cod_etapa1 = @cod_etaori
        END
        ELSE
        BEGIN
            SELECT @cod_etapa1 = min(cod_etapa)
            FROM secgen_db.dbo.sg_eta1
            WHERE cod_flusol = @cod_flusol1
              AND isnull(vigente, 'S') = 'S'
        END
    END

    IF @cod_flusol1 IS NULL OR @cod_etapa1 IS NULL
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol1 AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            'No fue posible determinar el flujo y etapa de origen' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_tfls
        WHERE cod_flusol = @cod_flusol1
          AND isnull(vigente, 'S') = 'S'
    )
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol1 AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            'El flujo de la solicitud no existe o no se encuentra vigente' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_eta1
        WHERE cod_flusol = @cod_flusol1
          AND cod_etapa = @cod_etapa1
          AND isnull(vigente, 'S') = 'S'
    )
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol1 AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            'La etapa de origen no existe o no se encuentra vigente' AS mensaje
        RETURN
    END

    IF @id_tipacc IS NULL
    BEGIN
        IF @nro_solici IS NULL
        BEGIN
            SELECT 0 AS status, 'Falta Codigo de Accion' AS mensaje
            RETURN
        END


        IF EXISTS (
            SELECT 1
            FROM secgen_db.dbo.sg_eta2 transicion1,
                 secgen_db.dbo.sg_eta2 transicion2
            WHERE transicion1.cod_flusol = @cod_flusol1
              AND transicion1.cod_etapa1 = @cod_etapa1
              AND transicion2.cod_flusol = transicion1.cod_flusol
              AND transicion2.cod_etapa1 = transicion1.cod_etapa1
              AND transicion2.id_tipacc = transicion1.id_tipacc
              AND transicion2.cod_etapa2 <> transicion1.cod_etapa2
        )
        BEGIN
            SELECT
                0 AS status,
                @cod_flusol1 AS cod_flusol,
                @cod_etapa1 AS cod_etapa_origen,
                CONVERT(tinyint, NULL) AS id_tipacc,
                'La etapa posee acciones duplicadas con mas de un destino' AS mensaje
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM secgen_db.dbo.sg_eta2 transicion
            INNER JOIN secgen_db.dbo.sg_eta1 destino
                ON destino.cod_flusol = transicion.cod_flusol
               AND destino.cod_etapa = transicion.cod_etapa2
               AND isnull(destino.vigente, 'S') = 'S'
            WHERE transicion.cod_flusol = @cod_flusol1
              AND transicion.cod_etapa1 = @cod_etapa1
              AND transicion.cod_estsol IS NOT NULL
        )
        BEGIN
            SELECT
                0 AS status,
                @cod_flusol1 AS cod_flusol,
                @cod_etapa1 AS cod_etapa_origen,
                CONVERT(tinyint, NULL) AS id_tipacc,
                'La etapa no posee acciones vigentes configuradas' AS mensaje
            RETURN
        END

        SELECT
            1 AS status,
            transicion.id_tipacc,
            CASE accion.id_tipacc
                WHEN 1 THEN 'SUBMIT'
                WHEN 2 THEN 'APPROVE'
                WHEN 3 THEN 'REJECT'
                WHEN 4 THEN 'RETURN'
                WHEN 5 THEN 'CREATE_RESOLUTION'
                WHEN 6 THEN 'EDIT_RESOLUTION'
                WHEN 7 THEN 'SEND_TO_SIGNATURE'
                WHEN 13 THEN 'ARCHIVE'
                WHEN 15 THEN 'EDIT_REQUEST'
                WHEN 28 THEN 'CORRECT_REQUEST'
                WHEN 29 THEN 'SAVE_DRAFT'
                ELSE convert(varchar(24), accion.id_tipacc)
            END AS abr_accion,
            accion.des_accion,
            transicion.cod_etapa1 AS cod_etapa_origen,
            transicion.cod_etapa2 AS cod_etapa_destino,
            transicion.cod_estsol,
            CONVERT(varchar(255), NULL) AS mensaje
        FROM secgen_db.dbo.sg_eta2 transicion
        INNER JOIN secgen_db.dbo.sg_tacc accion
            ON accion.id_tipacc = transicion.id_tipacc
        INNER JOIN secgen_db.dbo.sg_eta1 destino
            ON destino.cod_flusol = transicion.cod_flusol
           AND destino.cod_etapa = transicion.cod_etapa2
           AND isnull(destino.vigente, 'S') = 'S'
        WHERE transicion.cod_flusol = @cod_flusol1
          AND transicion.cod_etapa1 = @cod_etapa1
          AND transicion.cod_estsol IS NOT NULL
        ORDER BY transicion.id_tipacc
        RETURN
    END

    SELECT @cantidad_transiciones = count(*)
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = @cod_flusol1
      AND cod_etapa1 = @cod_etapa1
      AND id_tipacc = @id_tipacc

    IF isnull(@cantidad_transiciones, 0) <> 1
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol1 AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            CASE
                WHEN isnull(@cantidad_transiciones, 0) = 0
                    THEN 'No existe transicion para el flujo, etapa y accion indicados'
                ELSE 'Existe mas de una transicion para el flujo, etapa y accion indicados'
            END AS mensaje
        RETURN
    END

    SELECT
        @cod_etapa2 = cod_etapa2,
        @cod_estsol = cod_estsol
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = @cod_flusol1
      AND cod_etapa1 = @cod_etapa1
      AND id_tipacc = @id_tipacc

    IF @cod_estsol IS NULL
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol1 AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            'La transicion no posee un estado de solicitud configurado' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_esol
        WHERE cod_estsol = @cod_estsol
    )
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol1 AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            'El estado resultante de la transicion no existe' AS mensaje
        RETURN
    END

    /* Una correccion devuelta desde decretacion reingresa a esa fase. */
    IF @nro_solici IS NOT NULL AND @id_tipacc = 1
    BEGIN
        SELECT @cod_etapa_resol = min(cod_etapa)
        FROM secgen_db.dbo.sg_eta1
        WHERE cod_flusol = @cod_flusol1
          AND cod_perfil = 12
          AND isnull(vigente, 'S') = 'S'

        SELECT @cod_etapa_devol = cod_etapa
        FROM secgen_db.dbo.sg_apso
        WHERE nro_solici = @nro_solici
          AND cod_estapr = 3
          AND nro_aproba = (
              SELECT max(nro_aproba)
              FROM secgen_db.dbo.sg_apso
              WHERE nro_solici = @nro_solici
                AND cod_estapr = 3
          )

        IF @cod_etapa_resol IS NOT NULL
           AND @cod_etapa_devol >= @cod_etapa_resol
        BEGIN
            SELECT @cod_etapa2 = @cod_etapa_resol
            SELECT @cod_etapa_reingreso = @cod_etapa_resol
        END
    END

    SELECT
        1 AS status,
        transicion.cod_flusol,
        transicion.cod_etapa1 AS cod_etapa_origen,
        @cod_etapa2 AS cod_etapa_destino,
        @cod_estsol AS cod_estsol,
        @cod_etapa_reingreso AS cod_etapa_reingreso,
        CONVERT(tinyint, NULL) AS cod_estado_reingreso,
        transicion.id_tipacc,
        CASE accion.id_tipacc
            WHEN 1 THEN 'SUBMIT'
            WHEN 2 THEN 'APPROVE'
            WHEN 3 THEN 'REJECT'
            WHEN 4 THEN 'RETURN'
            WHEN 5 THEN 'CREATE_RESOLUTION'
            WHEN 6 THEN 'EDIT_RESOLUTION'
            WHEN 7 THEN 'SEND_TO_SIGNATURE'
            WHEN 13 THEN 'ARCHIVE'
            WHEN 15 THEN 'EDIT_REQUEST'
            WHEN 28 THEN 'CORRECT_REQUEST'
            WHEN 29 THEN 'SAVE_DRAFT'
            ELSE convert(varchar(24), accion.id_tipacc)
        END AS abr_accion,
        accion.des_accion,
        destino.cod_perfil AS cod_perfil_destino,
        destino.cod_organi AS cod_organi_destino,
        CASE
            WHEN destino.cod_perfil = 6 THEN 1
            WHEN destino.cod_perfil = 25 THEN 2
            WHEN destino.cod_perfil = 26 THEN 3
            ELSE 4
        END AS cod_respon_destino,
        destino.est_final AS etapa_final,
        CONVERT(varchar(255), NULL) AS mensaje
    FROM secgen_db.dbo.sg_eta2 transicion
    INNER JOIN secgen_db.dbo.sg_eta1 destino
        ON destino.cod_flusol = transicion.cod_flusol
       AND destino.cod_etapa = @cod_etapa2
       AND isnull(destino.vigente, 'S') = 'S'
    INNER JOIN secgen_db.dbo.sg_tacc accion
        ON accion.id_tipacc = transicion.id_tipacc
    WHERE transicion.cod_flusol = @cod_flusol1
      AND transicion.cod_etapa1 = @cod_etapa1
      AND transicion.id_tipacc = @id_tipacc
END
GO

GRANT EXECUTE ON Analisis2.sg_eta2sSecgen01 TO UsuaVrac
GO
