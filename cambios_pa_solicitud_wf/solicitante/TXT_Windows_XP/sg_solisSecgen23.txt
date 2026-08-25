USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_solisSecgen23'
)
    DROP PROCEDURE Analisis2.sg_solisSecgen23
GO

/* Procedimiento : Analisis2.sg_solisSecgen23

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtener el detalle de aprobaciones (sg_apso) de una solicitud, para armar el flujo organizacional completo en el frontend (historial por etapa).

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_solisSecgen23
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo numero de solicitud' AS msg
        RETURN
    END

    SELECT
        apso.nro_aproba,
        apso.nro_solici,
        apso.rut_usua,
        apso.cod_estapr,
        apso.comentario,
        apso.f_aprobac,
        apso.f_creacion,
        apso.f_ultmodif,
        apso.cod_flusol,
        apso.cod_etapa,
        soli.nro_resolu
    FROM secgen_db.dbo.sg_soli soli
    INNER JOIN secgen_db.dbo.sg_apso apso
        ON soli.nro_solici = apso.nro_solici
    WHERE soli.nro_solici = @nro_solici
      AND apso.cod_estapr != 4
    ORDER BY apso.f_ultmodif DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_solisSecgen23 TO UsuaVrac
GO
