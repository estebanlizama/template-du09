USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fucosSecgen01'
)
    DROP PROCEDURE Analisis2.sg_fucosSecgen01
GO

/* Procedimiento : Analisis2.sg_fucosSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Listar las compensaciones horarias registradas para los
              funcionarios de una solicitud.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
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
        /* El componente horario identifica el tramo; la interfaz recibe el dia. */
        dateadd(
            day,
            datediff(day, convert(datetime, '19000101'), fc.fec_compro),
            convert(datetime, '19000101')
        ) AS fec_compro,
        fc.hora_ini,
        fc.hora_ter
    FROM secgen_db.dbo.sg_fuco fc
    INNER JOIN secgen_db.dbo.sg_fups fu ON fc.id_funprse = fu.id_funprse
    INNER JOIN secgen_db.dbo.sg_prse prse ON prse.nro_solici = fu.nro_solici
    WHERE fu.nro_solici = @nro_solici
      AND isnull(prse.cod_modprs, 1) = 2
    ORDER BY fc.id_funprse, fc.fec_compro, fc.hora_ini, fc.hora_ter
END
GO

GRANT EXECUTE ON Analisis2.sg_fucosSecgen01 TO UsuaVrac
GO
