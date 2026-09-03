USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fumesSecgen01'
)
    DROP PROCEDURE Analisis2.sg_fumesSecgen01
GO

/* Procedimiento : Analisis2.sg_fumesSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtiene la lista de meses de ejecucion vigentes para los funcionarios de una solicitud.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
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
        fm.id_funprse,
        fm.nro_cuota,
        fm.ano_prop,
        fm.mes_prop,
        fm.cod_estcuo,
        e.des_estcuo
    FROM secgen_db.dbo.sg_fume fm
    INNER JOIN secgen_db.dbo.sg_fups fu ON fm.id_funprse = fu.id_funprse
    INNER JOIN secgen_db.dbo.sg_prse prse ON prse.nro_solici = fu.nro_solici
    LEFT JOIN secgen_db.dbo.sg_ecuo e ON fm.cod_estcuo = e.cod_estcuo
    WHERE fu.nro_solici = @nro_solici
      AND isnull(prse.cod_modprs, 1) = 2
    ORDER BY fm.id_funprse, fm.ano_prop, fm.mes_prop
END
GO

GRANT EXECUTE ON Analisis2.sg_fumesSecgen01 TO UsuaVrac
GO
