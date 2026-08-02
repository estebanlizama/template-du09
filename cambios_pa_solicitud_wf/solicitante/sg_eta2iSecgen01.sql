USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_eta2iSecgen01'
)
    DROP PROCEDURE Analisis2.sg_eta2iSecgen01
GO

/*
Procedimiento : Analisis2.sg_eta2iSecgen01
Objetivo      : Completar las transiciones lineales maestras de un flujo PDS
                configurado en sg_eta1.

Reglas:
    Accion 1 : etapa inicial a primera etapa revisora.
    Accion 2 : etapa revisora a siguiente etapa vigente.
    Accion 3 : rechazo conserva la etapa y cambia a estado rechazado.
    Accion 4 : devolucion retorna al solicitante hasta decretacion y a
               decretacion cuando la resolucion ya se encuentra en tramite.

El PA es idempotente. No reemplaza transiciones existentes y debe ejecutarse
al desplegar o modificar la configuracion maestra de un flujo, nunca durante
la operacion normal de una solicitud.
*/
CREATE PROCEDURE Analisis2.sg_eta2iSecgen01
    @cod_flusol tinyint = NULL
AS
BEGIN
    DECLARE @cantidad_etapas int
    DECLARE @cantidad_finales int
    DECLARE @cantidad_acciones int
    DECLARE @cantidad_estados int
    DECLARE @cantidad_transiciones int
    DECLARE @cantidad_existentes int
    DECLARE @filas_insertadas int
    DECLARE @cod_etapa_inicial tinyint
    DECLARE @cod_etapa_final tinyint
    DECLARE @cod_etapa_ultima tinyint
    DECLARE @cod_etapa_resol tinyint
    DECLARE @cod_etapa_actual tinyint
    DECLARE @cod_etapa_siguiente tinyint
    DECLARE @cod_etapa_destino tinyint
    DECLARE @cod_estado_destino tinyint
    DECLARE @id_tipacc_actual tinyint

    IF @cod_flusol IS NULL
    BEGIN
        SELECT 0 AS status, 'Falta Codigo de Flujo' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_tfls
        WHERE cod_flusol = @cod_flusol
          AND isnull(vigente, 'S') = 'S'
    )
    BEGIN
        SELECT 0 AS status, 'El flujo no existe o no se encuentra vigente' AS mensaje
        RETURN
    END

    SELECT @cantidad_etapas = count(*)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'

    IF isnull(@cantidad_etapas, 0) < 2
    BEGIN
        SELECT 0 AS status, 'El flujo debe poseer al menos dos etapas vigentes' AS mensaje
        RETURN
    END

    SELECT @cod_etapa_inicial = min(cod_etapa)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'

    SELECT @cod_etapa_ultima = max(cod_etapa)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'

    SELECT @cantidad_finales = count(*)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'
      AND isnull(est_final, 'N') = 'S'

    SELECT @cod_etapa_final = max(cod_etapa)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'
      AND isnull(est_final, 'N') = 'S'

    SELECT @cod_etapa_resol = min(cod_etapa)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND cod_perfil = 12
      AND isnull(vigente, 'S') = 'S'

    IF isnull(@cantidad_finales, 0) <> 1
    BEGIN
        SELECT 0 AS status, 'El flujo debe poseer exactamente una etapa final vigente' AS mensaje
        RETURN
    END

    IF @cod_etapa_final <> @cod_etapa_ultima
    BEGIN
        SELECT 0 AS status, 'La etapa final debe ser la ultima etapa vigente del flujo' AS mensaje
        RETURN
    END

    IF @cod_etapa_resol IS NULL
    BEGIN
        SELECT 0 AS status, 'El flujo no posee una etapa vigente de Jefe de Decretacion' AS mensaje
        RETURN
    END

    SELECT @cantidad_acciones = count(*)
    FROM secgen_db.dbo.sg_tacc
    WHERE id_tipacc IN (1, 2, 3, 4)

    IF isnull(@cantidad_acciones, 0) <> 4
    BEGIN
        SELECT 0 AS status, 'Faltan acciones maestras requeridas: enviar, aprobar, rechazar o devolver' AS mensaje
        RETURN
    END

    SELECT @cantidad_estados = count(*)
    FROM secgen_db.dbo.sg_esol
    WHERE cod_estsol IN (2, 3, 4, 6, 11)

    IF isnull(@cantidad_estados, 0) <> 5
    BEGIN
        SELECT 0 AS status, 'Faltan estados maestros requeridos por el flujo PDS' AS mensaje
        RETURN
    END

    SELECT @filas_insertadas = 0

    BEGIN TRAN

    SELECT @cod_etapa_actual = @cod_etapa_inicial

    WHILE @cod_etapa_actual IS NOT NULL
    BEGIN
        SELECT @cod_etapa_siguiente = NULL

        SELECT @cod_etapa_siguiente = min(cod_etapa)
        FROM secgen_db.dbo.sg_eta1
        WHERE cod_flusol = @cod_flusol
          AND cod_etapa > @cod_etapa_actual
          AND isnull(vigente, 'S') = 'S'

        IF @cod_etapa_actual = @cod_etapa_inicial
            SELECT @id_tipacc_actual = 1
        ELSE
            SELECT @id_tipacc_actual = 2

        WHILE @id_tipacc_actual IS NOT NULL
        BEGIN
            IF @id_tipacc_actual = 1
            BEGIN
                SELECT @cod_etapa_destino = @cod_etapa_siguiente
                SELECT @cod_estado_destino = 2
            END
            ELSE IF @id_tipacc_actual = 2
            BEGIN
                IF @cod_etapa_actual = @cod_etapa_final
                BEGIN
                    SELECT @cod_etapa_destino = @cod_etapa_actual
                    SELECT @cod_estado_destino = 11
                END
                ELSE
                BEGIN
                    SELECT @cod_etapa_destino = @cod_etapa_siguiente

                    IF @cod_etapa_siguiente >= @cod_etapa_resol
                        SELECT @cod_estado_destino = 3
                    ELSE
                        SELECT @cod_estado_destino = 2
                END
            END
            ELSE IF @id_tipacc_actual = 3
            BEGIN
                SELECT @cod_etapa_destino = @cod_etapa_actual
                SELECT @cod_estado_destino = 4
            END
            ELSE
            BEGIN
                IF @cod_etapa_actual <= @cod_etapa_resol
                    SELECT @cod_etapa_destino = @cod_etapa_inicial
                ELSE
                    SELECT @cod_etapa_destino = @cod_etapa_resol

                SELECT @cod_estado_destino = 6
            END

            SELECT @cantidad_existentes = count(*)
            FROM secgen_db.dbo.sg_eta2
            WHERE cod_flusol = @cod_flusol
              AND cod_etapa1 = @cod_etapa_actual
              AND id_tipacc = @id_tipacc_actual

            IF @cantidad_existentes = 0
            BEGIN
                IF EXISTS (
                    SELECT 1
                    FROM secgen_db.dbo.sg_eta2
                    WHERE cod_flusol = @cod_flusol
                      AND cod_etapa1 = @cod_etapa_actual
                      AND cod_etapa2 = @cod_etapa_destino
                )
                    GOTO CONFIGURACION_INVALIDA

                INSERT INTO secgen_db.dbo.sg_eta2
                (
                    cod_flusol,
                    cod_etapa1,
                    cod_etapa2,
                    id_tipacc,
                    cod_estsol
                )
                VALUES
                (
                    @cod_flusol,
                    @cod_etapa_actual,
                    @cod_etapa_destino,
                    @id_tipacc_actual,
                    @cod_estado_destino
                )

                IF @@error <> 0
                    GOTO ERROR_INSERCION

                SELECT @filas_insertadas = @filas_insertadas + 1
            END
            ELSE
            BEGIN
                IF @cantidad_existentes <> 1
                    GOTO CONFIGURACION_INVALIDA

                IF NOT EXISTS (
                    SELECT 1
                    FROM secgen_db.dbo.sg_eta2
                    WHERE cod_flusol = @cod_flusol
                      AND cod_etapa1 = @cod_etapa_actual
                      AND cod_etapa2 = @cod_etapa_destino
                      AND id_tipacc = @id_tipacc_actual
                      AND cod_estsol = @cod_estado_destino
                )
                    GOTO CONFIGURACION_INVALIDA
            END

            IF @cod_etapa_actual = @cod_etapa_inicial
               OR @cod_etapa_actual = @cod_etapa_final
                SELECT @id_tipacc_actual = NULL
            ELSE IF @id_tipacc_actual = 2
                SELECT @id_tipacc_actual = 3
            ELSE IF @id_tipacc_actual = 3
                SELECT @id_tipacc_actual = 4
            ELSE
                SELECT @id_tipacc_actual = NULL
        END

        SELECT @cod_etapa_actual = @cod_etapa_siguiente
    END

    COMMIT TRAN

    SELECT @cantidad_transiciones = count(*)
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = @cod_flusol

    SELECT
        1 AS status,
        @cod_flusol AS cod_flusol,
        @cantidad_etapas AS etapas_vigentes,
        @filas_insertadas AS filas_insertadas,
        @cantidad_transiciones AS transiciones_configuradas,
        (3 * @cantidad_etapas) - 4 AS trans_lineales_esperadas,
        'Transiciones sincronizadas correctamente' AS mensaje

    SELECT
        transicion.cod_flusol,
        transicion.cod_etapa1,
        origen.des_etapa AS des_etapa1,
        transicion.id_tipacc,
        accion.des_accion,
        transicion.cod_etapa2,
        destino.des_etapa AS des_etapa2,
        transicion.cod_estsol,
        estado.des_estsol
    FROM secgen_db.dbo.sg_eta2 transicion
    INNER JOIN secgen_db.dbo.sg_eta1 origen
        ON origen.cod_flusol = transicion.cod_flusol
       AND origen.cod_etapa = transicion.cod_etapa1
    INNER JOIN secgen_db.dbo.sg_eta1 destino
        ON destino.cod_flusol = transicion.cod_flusol
       AND destino.cod_etapa = transicion.cod_etapa2
    INNER JOIN secgen_db.dbo.sg_tacc accion
        ON accion.id_tipacc = transicion.id_tipacc
    LEFT JOIN secgen_db.dbo.sg_esol estado
        ON estado.cod_estsol = transicion.cod_estsol
    WHERE transicion.cod_flusol = @cod_flusol
    ORDER BY transicion.cod_etapa1, transicion.id_tipacc

    RETURN

CONFIGURACION_INVALIDA:
    ROLLBACK TRAN

    SELECT
        0 AS status,
        @cod_flusol AS cod_flusol,
        @cod_etapa_actual AS cod_etapa,
        @id_tipacc_actual AS id_tipacc,
        'Existe una transicion incompatible con la configuracion lineal esperada' AS mensaje
    RETURN

ERROR_INSERCION:
    IF @@transtate = 2
        ROLLBACK TRAN

    SELECT
        0 AS status,
        @cod_flusol AS cod_flusol,
        @cod_etapa_actual AS cod_etapa,
        @id_tipacc_actual AS id_tipacc,
        'Error al insertar la transicion del flujo' AS mensaje
    RETURN
END
GO

eGO
