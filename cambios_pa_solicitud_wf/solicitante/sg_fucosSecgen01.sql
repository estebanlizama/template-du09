USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fucosSecgen01')
    DROP PROCEDURE Analisis2.sg_fucosSecgen01
GO

/* Procedimiento : Analisis2.sg_fucosSecgen01
   Objetivo      : Retorna las compensaciones (fecha y rango horario) registradas en sg_fuco para los funcionarios de una solicitud.
   Entrada       :
       @nro_solici int
   Salida        :
       id_funprse  int
       fec_compro  datetime
       hora_ini    time(3)
       hora_ter    time(3)
*/
CREATE PROCEDURE Analisis2.sg_fucosSecgen01
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta numero de solicitud' AS msg
        RETURN
    END

    SELECT 
        fc.id_funprse,
        fc.fec_compro,
        fc.hora_ini,
        fc.hora_ter
    FROM secgen_db.dbo.sg_fuco fc
    INNER JOIN secgen_db.dbo.sg_fups fu ON fc.id_funprse = fu.id_funprse
    INNER JOIN secgen_db.dbo.sg_prse prse ON prse.nro_solici = fu.nro_solici
    WHERE fu.nro_solici = @nro_solici
      AND isnull(prse.cod_modprs, 1) = 2
    ORDER BY fc.id_funprse, fc.fec_compro
END
GO

GRANT EXECUTE ON Analisis2.sg_fucosSecgen01 TO UsuaVrac
GO
