USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prseuSecgen02'
)
    DROP PROCEDURE Analisis2.sg_prseuSecgen02
GO

/* Procedimiento : Analisis2.sg_prseuSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @cod_flusol          -> Codigo de flujo de solicitud. (Opcional)
   @reemplazar          -> Parametro de entrada. (Opcional)

   Objetivo : Inicializar el flujo y la etapa vigente de una solicitud PDS.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prseuSecgen02
    @nro_solici int = NULL,
    @cod_flusol tinyint = NULL,
    @reemplazar tinyint = 0
AS
BEGIN
    DECLARE @cod_etapa tinyint
    DECLARE @cantidad_etapas int
    DECLARE @cantidad_trans int
    DECLARE @filas_actualizadas int

    IF @nro_solici IS NULL
    BEGIN
        SELECT 0 AS status, 'Falta Numero de Solicitud' AS mensaje
        RETURN
    END

    IF @cod_flusol IS NULL
    BEGIN
        SELECT 0 AS status, 'Falta Codigo de Flujo' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_prse
        WHERE nro_solici = @nro_solici
    )
    BEGIN
        SELECT 0 AS status, 'La solicitud PDS no existe' AS mensaje
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

    SELECT
        @cod_etapa = min(cod_etapa),
        @cantidad_etapas = count(*)
    FROM secgen_db.dbo.sg_eta1
    WHERE cod_flusol = @cod_flusol
      AND isnull(vigente, 'S') = 'S'

    IF isnull(@cantidad_etapas, 0) = 0 OR @cod_etapa IS NULL
    BEGIN
        SELECT 0 AS status, 'El flujo no posee etapas vigentes configuradas' AS mensaje
        RETURN
    END

    SELECT @cantidad_trans = count(*)
    FROM secgen_db.dbo.sg_eta2
    WHERE cod_flusol = @cod_flusol
      AND cod_etapa1 = @cod_etapa
      AND id_tipacc = 1

    IF isnull(@cantidad_trans, 0) <> 1
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol AS cod_flusol,
            @cod_etapa AS cod_etapa,
            CASE
                WHEN isnull(@cantidad_trans, 0) = 0
                    THEN 'La etapa inicial no posee una transicion de envio'
                ELSE 'La etapa inicial posee mas de una transicion de envio'
            END AS mensaje
        RETURN
    END

    UPDATE secgen_db.dbo.sg_prse
    SET cod_flusol = @cod_flusol,
        cod_etapa = @cod_etapa
    WHERE nro_solici = @nro_solici
      AND (
          cod_flusol IS NULL
          OR @reemplazar = 1
      )

    SELECT @filas_actualizadas = @@rowcount

    IF @filas_actualizadas <> 1
    BEGIN
        SELECT
            0 AS status,
            @cod_flusol AS cod_flusol,
            @cod_etapa AS cod_etapa,
            'La solicitud ya posee un flujo que no puede reemplazarse' AS mensaje
        RETURN
    END

    SELECT
        1 AS status,
        @cod_flusol AS cod_flusol,
        @cod_etapa AS cod_etapa,
        CONVERT(varchar(255), NULL) AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_prseuSecgen02 TO UsuaVrac
GO
