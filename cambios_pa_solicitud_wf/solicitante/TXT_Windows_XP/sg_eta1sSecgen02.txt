USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_eta1sSecgen02'
)
    DROP PROCEDURE Analisis2.sg_eta1sSecgen02
GO

/* Procedimiento : Analisis2.sg_eta1sSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Listar las etapas configuradas y vigentes para el flujo asociado a una solicitud, indicando la etapa actual.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_eta1sSecgen02
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta Numero de Solicitud' AS msg
        RETURN
    END

    SELECT
        etapa.cod_flusol,
        etapa.cod_etapa,
        etapa.des_etapa,
        etapa.cod_perfil,
        etapa.cod_organi,
        etapa.est_final,
        prse.cod_etapa AS cod_etapa_act
    FROM secgen_db.dbo.sg_prse prse
    INNER JOIN secgen_db.dbo.sg_eta1 etapa
        ON etapa.cod_flusol = prse.cod_flusol
    WHERE prse.nro_solici = @nro_solici
      AND isnull(etapa.vigente, 'S') = 'S'
    ORDER BY etapa.cod_etapa
END
GO

GRANT EXECUTE ON Analisis2.sg_eta1sSecgen02 TO UsuaVrac
GO
