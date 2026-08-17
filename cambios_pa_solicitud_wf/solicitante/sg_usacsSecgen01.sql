USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_usacsSecgen01'
)
    DROP PROCEDURE Analisis2.sg_usacsSecgen01
GO

/*
Procedimiento : Analisis2.sg_usacsSecgen01
Objetivo      : Obtener perfiles y privilegios dinamicos de acceso a PDS.

El perfil solicitante se obtiene por contrato vigente. Los perfiles
aprobadores se obtienen desde tareas pendientes directas o desde una
representacion institucional vigente y no ambigua.
*/
CREATE PROCEDURE Analisis2.sg_usacsSecgen01
    @rut         char(9) = NULL,
    @cod_sistem  char(2) = 'SG',
    @cod_modulo  varchar(8) = 'SISSOLIC',
    @fecha_eval  datetime = NULL
AS
BEGIN
    DECLARE @fecha_val datetime
    SELECT @fecha_val = isnull(@fecha_eval, getdate())

    IF @rut IS NULL OR ltrim(rtrim(@rut)) = ''
    BEGIN
        SELECT
            convert(char(9), NULL) AS rut,
            convert(char(2), NULL) AS cod_sistem,
            convert(varchar(8), NULL) AS cod_modulo,
            convert(smallint, NULL) AS cod_perfil,
            convert(varchar(100), NULL) AS des_perfil,
            convert(smallint, NULL) AS cod_privil,
            convert(varchar(100), NULL) AS des_privil,
            convert(varchar(100), NULL) AS nom_privil,
            convert(char(1), 'N') AS elegible_solicitante,
            convert(char(1), 'N') AS tiene_tarea_pendiente,
            convert(varchar(100), 'Falta RUT del usuario') AS mensaje
        RETURN
    END

    CREATE TABLE #perfiles (
        cod_perfil smallint not null,
        origen varchar(10) not null
    )

    IF EXISTS (
        SELECT 1
        FROM sisper_db..sp_pers pers
        INNER JOIN sisper_db..sp_cont cont
            ON cont.cod_ficha = pers.cod_ficha
        WHERE pers.rut_person = @rut
          AND cont.vigen_cont in ('0', '2')
          AND cont.cod_calida <> '01'
          AND isnull(cont.f_inicio_d, @fecha_val) <= @fecha_val
          AND isnull(cont.f_termino, isnull(cont.f_termin_d, @fecha_val)) >= @fecha_val
    )
    BEGIN
        INSERT INTO #perfiles (cod_perfil, origen)
        VALUES (6, 'CONTRATO')
    END

    IF NOT EXISTS (SELECT 1 FROM #perfiles WHERE cod_perfil = 6)
       AND EXISTS (
           SELECT 1
           FROM sisper_db.dbo.sp_orde orde
           INNER JOIN sisper_db.dbo.sp_desg desg
             ON desg.cod_design = orde.cod_design
            AND desg.cod_des_su = '1'
            AND desg.vigencia IN ('1', 'S')
            AND desg.f_inicio <= @fecha_val
            AND (desg.f_termino IS NULL OR desg.f_termino >= @fecha_val)
           INNER JOIN ufro_db.dbo.es_orga orga
             ON orga.cod_organi = orde.cod_organi
            AND orga.por_desig = 'S'
           WHERE orde.rut_person = @rut
             AND orde.vigente = 'S'
       )
    BEGIN
        INSERT INTO #perfiles (cod_perfil, origen)
        VALUES (6, 'REPRESENTA')
    END

    INSERT INTO #perfiles (cod_perfil, origen)
    SELECT DISTINCT eta.cod_perfil, 'TAREA'
    FROM secgen_db..sg_apso apso
    INNER JOIN secgen_db..sg_prse prse
        ON prse.nro_solici = apso.nro_solici
       AND prse.cod_flusol = apso.cod_flusol
       AND prse.cod_etapa = apso.cod_etapa
    INNER JOIN secgen_db..sg_eta1 eta
        ON eta.cod_flusol = apso.cod_flusol
       AND eta.cod_etapa = apso.cod_etapa
    WHERE apso.cod_estapr = 4
      AND (
          apso.rut_usua = @rut
          OR EXISTS (
              SELECT 1
              FROM sisper_db.dbo.sp_orco orco
              INNER JOIN sisper_db.dbo.sp_orde orde
                ON orde.cod_organi = orco.cod_organi
               AND orde.rut_person = @rut
               AND orde.vigente = 'S'
              INNER JOIN sisper_db.dbo.sp_desg desg
                ON desg.cod_design = orde.cod_design
               AND desg.cod_des_su = '1'
               AND desg.vigencia IN ('1', 'S')
               AND desg.f_inicio <= @fecha_val
               AND (desg.f_termino IS NULL OR desg.f_termino >= @fecha_val)
              INNER JOIN ufro_db.dbo.es_orga orga
                ON orga.cod_organi = orde.cod_organi
               AND orga.por_desig = 'S'
              WHERE orco.rut_person = apso.rut_usua
                AND prse.cod_modprs = 2
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
                       AND g2.f_inicio <= @fecha_val
                       AND (g2.f_termino IS NULL OR g2.f_termino >= @fecha_val)) = 1
          )
      )
      AND isnull(eta.vigente, 'S') = 'S'
      AND NOT EXISTS (
          SELECT 1
          FROM #perfiles p
          WHERE p.cod_perfil = eta.cod_perfil
      )

    SELECT
        @rut AS rut,
        per.cod_sistem,
        per.cod_modulo,
        per.cod_perfil,
        per.des_perfil,
        pri.cod_privil,
        pri.des_privil,
        pri.nom_privil,
        CASE
            WHEN EXISTS (
                SELECT 1 FROM #perfiles p
                WHERE p.cod_perfil = 6 AND p.origen = 'CONTRATO'
            ) THEN 'S'
            ELSE 'N'
        END AS elegible_solicitante,
        CASE
            WHEN EXISTS (
                SELECT 1 FROM #perfiles p
                WHERE p.origen = 'TAREA'
            ) THEN 'S'
            ELSE 'N'
        END AS tiene_tarea_pendiente,
        convert(varchar(100), NULL) AS mensaje
    FROM #perfiles ctx
    INNER JOIN sistema_db..bd_per1 per
        ON per.cod_sistem = @cod_sistem
       AND per.cod_modulo = @cod_modulo
       AND per.cod_perfil = ctx.cod_perfil
    LEFT JOIN sistema_db..bd_pepr pep
        ON pep.cod_sistem = per.cod_sistem
       AND pep.cod_modulo = per.cod_modulo
       AND pep.cod_perfil = per.cod_perfil
    LEFT JOIN sistema_db..bd_prvg pri
        ON pri.cod_sistem = pep.cod_sistem
       AND pri.cod_modulo = pep.cod_modulo
       AND pri.cod_privil = pep.cod_privil
    ORDER BY per.cod_perfil, pri.cod_privil

    DROP TABLE #perfiles
END
GO

GRANT EXECUTE ON Analisis2.sg_usacsSecgen01 TO UsuaVrac
GO
