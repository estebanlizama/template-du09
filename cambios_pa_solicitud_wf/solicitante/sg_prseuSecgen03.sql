USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_prseuSecgen03'
)
    DROP PROCEDURE Analisis2.sg_prseuSecgen03
GO

/* Procedimiento : Analisis2.sg_prseuSecgen03

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @id_tipacc           -> Identificador tipo de accion. (Opcional)

   Objetivo : Aplicar una transicion configurada en sg_eta2 y actualizar la etapa actual de una solicitud PDS.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prseuSecgen03
    @nro_solici int = NULL,
    @id_tipacc tinyint = NULL
AS
BEGIN
    DECLARE @cod_flusol tinyint
    DECLARE @cod_etapa1 tinyint
    DECLARE @cod_etapa2 tinyint
    DECLARE @cod_estsol tinyint
    DECLARE @cod_etapa_resol tinyint
    DECLARE @cod_etapa_devol tinyint
    DECLARE @cod_etapa_reingreso tinyint
    DECLARE @cod_perfil smallint
    DECLARE @cod_organi int
    DECLARE @cod_respon tinyint
    DECLARE @est_final char(1)
    DECLARE @abr_accion varchar(24)
    DECLARE @des_accion varchar(50)
    DECLARE @cantidad_trans int
    DECLARE @filas_actualizadas int

    IF @nro_solici IS NULL
    BEGIN
        SELECT 0 AS status, 'Falta Numero de Solicitud' AS mensaje
        RETURN
    END

    IF @id_tipacc IS NULL
    BEGIN
        SELECT 0 AS status, 'Falta Codigo de Accion' AS mensaje
        RETURN
    END

    SELECT
        @cod_flusol = cod_flusol,
        @cod_etapa1 = cod_etapa
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF @cod_flusol IS NULL OR @cod_etapa1 IS NULL
    BEGIN
        SELECT 0 AS status, 'La solicitud no posee flujo y etapa configurados' AS mensaje
        RETURN
    END

    SELECT @cantidad_trans = count(*)
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = @cod_flusol
      AND cod_etapa1 = @cod_etapa1
      AND id_tipacc = @id_tipacc

    IF isnull(@cantidad_trans, 0) <> 1
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol AS cod_flusol,
            @cod_etapa1 AS cod_etapa_origen,
            @id_tipacc AS id_tipacc,
            CASE
                WHEN isnull(@cantidad_trans, 0) = 0
                    THEN 'La accion no tiene una transicion configurada para la etapa actual'
                ELSE 'La accion posee mas de una transicion para la etapa actual'
            END AS mensaje
        RETURN
    END

    SELECT
        @cod_etapa2 = cod_etapa2,
        @cod_estsol = cod_estsol
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = @cod_flusol
      AND cod_etapa1 = @cod_etapa1
      AND id_tipacc = @id_tipacc

    IF @cod_estsol IS NULL
    BEGIN
        SELECT 0 AS status, 'La transicion no posee un estado de solicitud' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_esol
        WHERE cod_estsol = @cod_estsol
    )
    BEGIN
        SELECT 0 AS status, 'El estado resultante de la transicion no existe' AS mensaje
        RETURN
    END

    /* Una solicitud corregida despues de decretacion reingresa a esa etapa. */
    IF @id_tipacc = 1
    BEGIN
        SELECT @cod_etapa_resol = min(cod_etapa)
        FROM secgen_db.dbo.sg_eta1
        WHERE cod_flusol = @cod_flusol
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
        @cod_perfil = eta.cod_perfil,
        @cod_organi = eta.cod_organi,
        @cod_respon = CASE
            WHEN eta.cod_perfil = 6 THEN 1
            WHEN eta.cod_perfil = 25 THEN 2
            WHEN eta.cod_perfil = 26 THEN 3
            ELSE 4
        END,
        @est_final = eta.est_final
    FROM secgen_db.dbo.sg_eta1 eta
    WHERE eta.cod_flusol = @cod_flusol
      AND eta.cod_etapa = @cod_etapa2
      AND isnull(eta.vigente, 'S') = 'S'

    IF @cod_perfil IS NULL
    BEGIN
        SELECT 0 AS status, 'La etapa destino no existe o no se encuentra vigente' AS mensaje
        RETURN
    END

    SELECT
        @abr_accion = CASE acc.id_tipacc
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
            ELSE convert(varchar(24), acc.id_tipacc)
        END,
        @des_accion = acc.des_accion
    FROM secgen_db.dbo.sg_tacc acc
    WHERE acc.id_tipacc = @id_tipacc

    IF @abr_accion IS NULL
    BEGIN
        SELECT 0 AS status, 'La accion no existe en el catalogo sg_tacc' AS mensaje
        RETURN
    END

    UPDATE secgen_db.dbo.sg_prse
    SET cod_etapa = @cod_etapa2
    WHERE nro_solici = @nro_solici
      AND cod_flusol = @cod_flusol
      AND cod_etapa = @cod_etapa1

    SELECT @filas_actualizadas = @@rowcount

    IF @filas_actualizadas <> 1
    BEGIN
        SELECT 0 AS status, 'La etapa cambio durante la operacion; recargue e intente nuevamente' AS mensaje
        RETURN
    END

    SELECT
        1 AS status,
        @cod_flusol AS cod_flusol,
        @cod_etapa1 AS cod_etapa_origen,
        @cod_etapa2 AS cod_etapa_destino,
        @cod_estsol AS cod_estsol,
        @cod_etapa_reingreso AS cod_etapa_reingreso,
        CONVERT(tinyint, NULL) AS cod_estado_reingreso,
        @cod_perfil AS cod_perfil_destino,
        @cod_organi AS cod_organi_destino,
        @cod_respon AS cod_respon_destino,
        @est_final AS etapa_final,
        @id_tipacc AS id_tipacc,
        @abr_accion AS abr_accion,
        @des_accion AS des_accion,
        CONVERT(varchar(255), NULL) AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_prseuSecgen03 TO UsuaVrac
GO
