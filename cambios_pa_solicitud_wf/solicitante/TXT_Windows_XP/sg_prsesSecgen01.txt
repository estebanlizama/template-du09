USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen01'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen01
GO

/* Procedimiento : Analisis2.sg_prsesSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Consultar una solicitud de Prestacion de Servicios con su modalidad, flujo y etapa actuales.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen01
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo Numero Solicitud' AS msg
        RETURN
    END

    SELECT
        p.nro_solici,
        p.actividad,
        p.per_desde,
        p.per_hasta,
        p.rut_jefpro,
        p.cod_unifin,
        p.cod_ccto,
        rtrim(c.nom_ccto) AS nom_ccto,
        p.cc_global,
        p.pry_global,
        p.cod_modprs,
        m.des_modprs,
        p.cod_flusol,
        p.cod_etapa,
        e.des_etapa,
        e.cod_perfil
    FROM secgen_db.dbo.sg_prse p
    LEFT JOIN fin21_db..es_ccto c
        ON c.cod_unifin = p.cod_unifin
       AND c.cod_ccto = p.cod_ccto
    LEFT JOIN secgen_db.dbo.sg_tmod m
        ON m.cod_modprs = p.cod_modprs
    LEFT JOIN secgen_db.dbo.sg_eta1 e
        ON e.cod_flusol = p.cod_flusol
       AND e.cod_etapa = p.cod_etapa
    WHERE p.nro_solici = @nro_solici
END
GO

GRANT EXECUTE ON Analisis2.sg_prsesSecgen01 TO UsuaVrac
GO
