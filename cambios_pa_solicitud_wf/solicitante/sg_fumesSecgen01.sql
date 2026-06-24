USE secgen_db
GO

/* PENDIENTE FASE 2 - NO DESPLEGAR TODAVIA.
   El backend no invoca este PA mientras sg_fume no exista.
*/

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fumesSecgen01')
    DROP PROCEDURE Analisis2.sg_fumesSecgen01
GO

/* Procedimiento : Analisis2.sg_fumesSecgen01
   Objetivo      : Obtiene la lista de meses de ejecución vigentes para los funcionarios de una solicitud.
   Entrada       :
       @nro_solici   int
*/
CREATE PROCEDURE Analisis2.sg_fumesSecgen01
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Error: Falta número de solicitud' AS msg
        RETURN
    END

    SELECT 
        fm.id_funmes,
        fm.id_funprse,
        fm.anio,
        fm.nro_mes,
        fm.vigente
    FROM secgen_db.dbo.sg_fume fm
    INNER JOIN secgen_db.dbo.sg_fups fu ON fm.id_funprse = fu.id_funprse
    INNER JOIN secgen_db.dbo.sg_prse prse ON prse.nro_solici = fu.nro_solici
    WHERE fu.nro_solici = @nro_solici
      AND isnull(prse.cod_modprs, 1) = 2
      AND fm.vigente = 'S'
    ORDER BY fm.id_funprse, fm.anio, fm.nro_mes
END
GO

GRANT EXECUTE ON Analisis2.sg_fumesSecgen01 TO UsuaVrac
GO
