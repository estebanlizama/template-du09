USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsosSecgen05'
)
    DROP PROCEDURE Analisis2.sg_apsosSecgen05
GO

/* Procedimiento : Analisis2.sg_apsosSecgen05

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtener la cantidad de tareas pendientes (cod_estapr = 4) para una solicitud especifica.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_apsosSecgen05
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 0 AS tareas_pendientes
        RETURN
    END

    SELECT count(*) AS tareas_pendientes
    FROM secgen_db.dbo.sg_apso apso
    INNER JOIN secgen_db.dbo.sg_prse prse
        ON prse.nro_solici = apso.nro_solici
       AND prse.cod_flusol = apso.cod_flusol
       AND prse.cod_etapa = apso.cod_etapa
    WHERE apso.nro_solici = @nro_solici
      AND apso.cod_estapr = 4
END
GO

GRANT EXECUTE ON Analisis2.sg_apsosSecgen05 TO UsuaVrac
GO
