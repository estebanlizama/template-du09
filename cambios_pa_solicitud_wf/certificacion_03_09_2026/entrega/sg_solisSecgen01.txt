USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_solisSecgen01'
)
    DROP PROCEDURE Analisis2.sg_solisSecgen01
GO

/* Procedimiento : Analisis2.sg_solisSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtener una unica cabecera de solicitud, incluyendo la identidad del solicitante original para el flujo de retorno.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_solisSecgen01
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Numero Solicitud' AS msg
        RETURN
    END

    SELECT
        soli.nro_solici,
        soli.nro_resolu,
        soli.ano_resolu,
        soli.cod_estsol,
        soli.cod_tipsol,
        soli.rut_solici,
        ltrim(rtrim(
            isnull(pers.nom_nombre, '') + ' ' +
            isnull(pers.nom_appate, '') + ' ' +
            isnull(pers.nom_apmate, '')
        )) AS nom_solici,
        'Solicitante' AS des_cargo,
        esol.des_estsol,
        soli.f_solicit,
        soli.f_creacion,
        soli.f_ultmodif,
        soli.ano_proces
    FROM secgen_db.dbo.sg_soli soli
    LEFT JOIN secgen_db.dbo.sg_esol esol
        ON esol.cod_estsol = soli.cod_estsol
    LEFT JOIN sisper_db..sp_pers pers
        ON pers.rut_person = soli.rut_solici
    WHERE soli.nro_solici = @nro_solici
END
GO

GRANT EXECUTE ON Analisis2.sg_solisSecgen01 TO UsuaVrac
GO
