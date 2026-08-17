USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_apsouSecgen03'
)
    DROP PROCEDURE Analisis2.sg_apsouSecgen03
GO

/*
Procedimiento : Analisis2.sg_apsouSecgen03
Objetivo      : Registrar de forma atomica la decision de una tarea DU288.

Reglas:
    - La tarea debe estar pendiente y pertenecer al RUT autenticado o a un
      titular que este represente de forma unica y vigente.
    - La tarea debe corresponder a la etapa actual de sg_prse.
    - rut_autori identifica a quien ejecuto realmente la accion.
*/
CREATE PROCEDURE Analisis2.sg_apsouSecgen03
    @nro_aproba int = NULL,
    @nro_solici int = NULL,
    @rut_usua char(9) = NULL,
    @cod_estapr tinyint = NULL,
    @comentario varchar(255) = NULL
AS
BEGIN
    DECLARE @filas int
    DECLARE @error int
    DECLARE @cod_flusol tinyint
    DECLARE @cod_etapa tinyint
    DECLARE @cod_modprs tinyint
    DECLARE @rut_titular char(9)
    DECLARE @autorizado char(1)

    IF @nro_aproba IS NULL OR @nro_solici IS NULL
       OR @rut_usua IS NULL OR @cod_estapr IS NULL
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'Faltan parametros para registrar la decision' AS mensaje
        RETURN
    END

    IF @cod_estapr NOT IN (1, 2, 3)
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'La decision de la tarea no es valida' AS mensaje
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_eapr
        WHERE cod_estapr = @cod_estapr
    )
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'El estado de aprobacion no existe' AS mensaje
        RETURN
    END

    IF ltrim(rtrim(isnull(@comentario, ''))) = ''
        SELECT @comentario = NULL

    SELECT
        @cod_flusol = cod_flusol,
        @cod_etapa = cod_etapa,
        @cod_modprs = cod_modprs
    FROM secgen_db.dbo.sg_prse
    WHERE nro_solici = @nro_solici

    IF @cod_flusol IS NULL OR @cod_etapa IS NULL
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'La solicitud no posee una etapa de flujo vigente' AS mensaje
        RETURN
    END

    SELECT @rut_titular = apso.rut_usua
    FROM secgen_db.dbo.sg_apso apso
    WHERE apso.nro_aproba = @nro_aproba
      AND apso.nro_solici = @nro_solici
      AND apso.cod_estapr = 4
      AND apso.cod_flusol = @cod_flusol
      AND apso.cod_etapa = @cod_etapa

    IF @rut_titular IS NULL
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'La tarea ya no esta pendiente o no corresponde a la etapa actual' AS mensaje
        RETURN
    END

    SELECT @autorizado = CASE WHEN @rut_titular = @rut_usua THEN 'S' ELSE 'N' END

    IF @autorizado = 'N' AND @cod_modprs = 2 AND EXISTS (
        SELECT 1
        FROM sisper_db.dbo.sp_orco orco
        INNER JOIN sisper_db.dbo.sp_orde orde
          ON orde.cod_organi = orco.cod_organi
         AND orde.rut_person = @rut_usua
         AND orde.vigente = 'S'
        INNER JOIN sisper_db.dbo.sp_desg desg
          ON desg.cod_design = orde.cod_design
         AND desg.cod_des_su = '1'
         AND desg.vigencia IN ('1', 'S')
         AND desg.f_inicio <= getdate()
         AND (desg.f_termino IS NULL OR desg.f_termino >= getdate())
        INNER JOIN ufro_db.dbo.es_orga orga
          ON orga.cod_organi = orde.cod_organi
         AND orga.por_desig = 'S'
        WHERE orco.rut_person = @rut_titular
          AND orco.vigente = 'S'
          AND (SELECT count(DISTINCT o2.rut_person)
               FROM sisper_db.dbo.sp_orco o2
               WHERE o2.cod_organi = orde.cod_organi AND o2.vigente = 'S') = 1
          AND (SELECT count(DISTINCT d2.rut_person)
               FROM sisper_db.dbo.sp_orde d2
               INNER JOIN sisper_db.dbo.sp_desg g2 ON g2.cod_design = d2.cod_design
               WHERE d2.cod_organi = orde.cod_organi
                 AND d2.vigente = 'S'
                 AND g2.cod_des_su = '1'
                 AND g2.vigencia IN ('1', 'S')
                 AND g2.f_inicio <= getdate()
                 AND (g2.f_termino IS NULL OR g2.f_termino >= getdate())) = 1
    )
        SELECT @autorizado = 'S'

    IF @autorizado <> 'S'
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'La tarea no pertenece al usuario ni a una representacion vigente y unica' AS mensaje
        RETURN
    END

    /* Separacion de funciones para creacion o edicion por representacion. */
    IF @rut_titular <> @rut_usua
       AND EXISTS (
           SELECT 1
           FROM secgen_db.dbo.sg_soli soli
           INNER JOIN secgen_db.dbo.sg_hist hist
             ON hist.nro_solici = soli.nro_solici
           WHERE soli.nro_solici = @nro_solici
             AND soli.rut_solici <> @rut_usua
             AND hist.rut_accion = @rut_usua
             AND hist.id_tipacc IN (1, 15, 28, 29)
       )
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'No puede aprobar una solicitud que creo o edito actuando por representacion' AS mensaje
        RETURN
    END

    UPDATE secgen_db.dbo.sg_apso
    SET cod_estapr = @cod_estapr,
        comentario = @comentario,
        rut_autori = @rut_usua,
        f_aprobac = getdate(),
        f_ultmodif = getdate()
    WHERE nro_aproba = @nro_aproba
      AND nro_solici = @nro_solici
      AND cod_estapr = 4
      AND cod_flusol = @cod_flusol
      AND cod_etapa = @cod_etapa

    SELECT @error = @@error, @filas = @@rowcount

    IF @error <> 0
    BEGIN
        SELECT 0 AS status, 0 AS filas_actualizadas,
               'Error al registrar la decision de la tarea' AS mensaje
        RETURN
    END

    IF @filas <> 1
    BEGIN
        SELECT 0 AS status, @filas AS filas_actualizadas,
               'La tarea no esta pendiente, cambio de etapa o no pertenece al usuario' AS mensaje
        RETURN
    END

    SELECT 1 AS status, @filas AS filas_actualizadas,
           CONVERT(varchar(255), NULL) AS mensaje
END
GO

GRANT EXECUTE ON Analisis2.sg_apsouSecgen03 TO UsuaVrac
GO
