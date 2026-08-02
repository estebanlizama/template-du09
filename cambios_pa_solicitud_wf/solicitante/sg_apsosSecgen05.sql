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
   Objetivo      : Contar las tareas pendientes de la etapa actual. */
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
