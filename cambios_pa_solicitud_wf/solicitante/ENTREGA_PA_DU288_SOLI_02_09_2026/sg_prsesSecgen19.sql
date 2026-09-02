USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen19'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen19
GO

/* Procedimiento : Analisis2.sg_prsesSecgen19

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtener la etapa actual, flujo, modulo y estado general de una solicitud especifica.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen19
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta Numero de Solicitud' AS msg
        RETURN
    END

    /* rut_solici viaja en el contexto porque el motor de omision necesita
       saber quien presento la solicitud: una etapa omitible cuyo responsable
       es el propio solicitante no requiere revision, ya autorizo al presentar. */
    SELECT
        prse.cod_modprs,
        prse.cod_flusol,
        prse.cod_etapa,
        soli.cod_estsol,
        soli.rut_solici,
        estado.des_estsol
    FROM secgen_db.dbo.sg_prse prse
    INNER JOIN secgen_db.dbo.sg_soli soli
        ON soli.nro_solici = prse.nro_solici
    INNER JOIN secgen_db.dbo.sg_esol estado
        ON estado.cod_estsol = soli.cod_estsol
    WHERE prse.nro_solici = @nro_solici
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen19 TO UsuaVrac
GO
