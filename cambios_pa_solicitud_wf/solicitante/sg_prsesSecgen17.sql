USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_prsesSecgen17'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen17
GO

/* Procedimiento : Analisis2.sg_prsesSecgen17

   Entrada :
   @rut_solici          -> RUT del solicitante. (Opcional)

   Objetivo : Listar solicitudes PDS finalizadas creadas por el RUT.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen17
    @rut_solici varchar(9) = NULL
AS
BEGIN
    IF @rut_solici IS NULL
    BEGIN
        SELECT 'Falta Rut de Usuario' AS msg
        RETURN
    END

    SELECT
        soli.nro_solici,
        soli.rut_solici,
        soli.cod_estsol,
        soli.cod_tipsol,
        soli.nro_resolu,
        soli.f_solicit,
        soli.f_creacion,
        soli.f_ultmodif,
        prse.cc_global,
        prse.pry_global,
        prse.cod_modprs,
        prse.cod_flusol,
        prse.cod_etapa,
        eta.des_etapa,
        tiposol.des_tipsol,
        estsol.des_estsol,
        isnull(funps_total.total, 0) AS total,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' +
                    isnull(pers.nom_appate, '') + ' ' +
                    isnull(pers.nom_apmate, ''))) AS nombre,
        CASE WHEN soli.rut_solici = @rut_solici
             THEN 'PROPIA' ELSE 'PARTICIPACION' END AS tipo_acceso,
        CASE WHEN soli.rut_solici = @rut_solici
             THEN 'PERSONAL' ELSE 'HISTORIAL:' + rtrim(soli.rut_solici) END AS context_key,
        CASE WHEN soli.rut_solici = @rut_solici
             THEN convert(char(9), NULL) ELSE soli.rut_solici END AS rut_titular,
        convert(int, NULL) AS cod_organi_representado,
        convert(varchar(100), NULL) AS cargo_representado,
        convert(varchar(40), NULL) AS tipo_representacion
    FROM secgen_db.dbo.sg_prse prse
    INNER JOIN secgen_db.dbo.sg_soli soli
        ON soli.nro_solici = prse.nro_solici
    INNER JOIN secgen_db.dbo.sg_tsol tiposol
        ON tiposol.cod_tipsol = soli.cod_tipsol
    INNER JOIN secgen_db.dbo.sg_esol estsol
        ON estsol.cod_estsol = soli.cod_estsol
    LEFT JOIN secgen_db.dbo.sg_eta1 eta
        ON eta.cod_flusol = prse.cod_flusol
       AND eta.cod_etapa = prse.cod_etapa
    LEFT JOIN sisper_db..sp_pers pers
        ON pers.rut_person = soli.rut_solici
    LEFT JOIN (
        SELECT nro_solici, sum(mto_total) AS total
        FROM secgen_db.dbo.sg_fups
        GROUP BY nro_solici
    ) funps_total
        ON funps_total.nro_solici = soli.nro_solici
    WHERE (
          soli.rut_solici = @rut_solici
          OR (prse.cod_modprs = 2 AND EXISTS (
              SELECT 1
              FROM secgen_db.dbo.sg_hist hist
              WHERE hist.nro_solici = soli.nro_solici
                AND hist.rut_accion = @rut_solici
          ))
          OR (prse.cod_modprs = 2 AND EXISTS (
              SELECT 1
              FROM secgen_db.dbo.sg_apso apso
              WHERE apso.nro_solici = soli.nro_solici
                AND (apso.rut_usua = @rut_solici OR apso.rut_autori = @rut_solici)
          ))
      )
      AND soli.cod_tipsol = 1
      AND soli.cod_estsol IN (4, 8, 9, 11)
    ORDER BY soli.f_creacion DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen17 TO UsuaVrac
GO
