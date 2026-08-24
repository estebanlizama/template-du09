USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsosSecgen03'
)
    DROP PROCEDURE Analisis2.sg_apsosSecgen03
GO

/*
    Entrada  :
    
    Salida   :

    Objetivo : Seleccionar el historial o datos de aprobacion de una solicitud
    Creacion : ELA 2026/08/24
    Modificacion :
*/
CREATE PROCEDURE Analisis2.sg_apsosSecgen03
    @nro_solici int = NULL,
    @cod_estapr int = NULL,
    @rut_usua varchar(9) = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo numero de solicitud' AS msg
        RETURN
    END
    IF @cod_estapr IS NULL
    BEGIN
        SELECT 'Falta campo codigo de estado de aprobacion' AS msg
        RETURN
    END
    IF @rut_usua IS NULL
    BEGIN
        SELECT 'Falta campo rut de usuario' AS msg
        RETURN
    END

    SELECT apso.nro_aproba, apso.nro_solici, apso.rut_usua,
        apso.cod_estapr, convert(varchar(255), apso.comentario) comentario,
        apso.f_aprobac, apso.f_creacion, apso.f_ultmodif,
        apso.cod_flusol, apso.cod_etapa, apso.rut_autori, apso.id_funprse,
        eta.cod_perfil, eta.des_etapa,
        @rut_usua rut_actor, 'ASIGNACION_DIRECTA' tipo_acceso,
        convert(char(9), NULL) rut_titular,
        convert(varchar(255), NULL) nombre_titular,
        convert(int, NULL) cod_organi_representado,
        convert(varchar(100), NULL) cargo_representado
    FROM secgen_db.dbo.sg_apso apso
    INNER JOIN secgen_db.dbo.sg_prse prse
      ON prse.nro_solici = apso.nro_solici
     AND prse.cod_flusol = apso.cod_flusol
     AND prse.cod_etapa = apso.cod_etapa
    INNER JOIN secgen_db.dbo.sg_eta1 eta
      ON eta.cod_flusol = apso.cod_flusol
     AND eta.cod_etapa = apso.cod_etapa
    WHERE apso.cod_estapr = @cod_estapr
      AND apso.nro_solici = @nro_solici
      AND apso.rut_usua = @rut_usua
      AND isnull(eta.vigente, 'S') = 'S'
    ORDER BY apso.nro_aproba DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_apsosSecgen03 TO UsuaVrac
GO
