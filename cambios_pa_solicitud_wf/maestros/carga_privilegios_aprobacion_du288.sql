/*
Objetivo:
    Asociar el privilegio provision-request-approve a los perfiles que
    participan como revisores en los flujos configurados de PDS DU288.

Reglas:
    - La configuracion de etapas y acciones se obtiene desde sg_eta1/sg_eta2.
    - No se asigna el privilegio al solicitante solo por pertenecer a un flujo.
    - El script es idempotente y puede ejecutarse mas de una vez.
    - La autorizacion sigue requiriendo una tarea pendiente en sg_apso para
      el RUT y la etapa actual.
*/

DECLARE @cod_privil smallint
DECLARE @filas int

SELECT @cod_privil = cod_privil
FROM sistema_db.dbo.bd_prvg
WHERE cod_sistem = 'SG'
  AND cod_modulo = 'SISSOLIC'
  AND nom_privil = 'provision-request-approve'

IF @cod_privil IS NULL
BEGIN
    SELECT
        0 AS status,
        'No existe el privilegio provision-request-approve en bd_prvg' AS mensaje
    RETURN
END
ELSE
BEGIN
    INSERT INTO sistema_db.dbo.bd_pepr
        (cod_sistem, cod_modulo, cod_perfil, cod_privil)
    SELECT DISTINCT
        eta.cod_sistem,
        eta.cod_modulo,
        eta.cod_perfil,
        @cod_privil
    FROM secgen_db.dbo.sg_eta1 eta
    WHERE isnull(eta.vigente, 'S') = 'S'
      AND EXISTS (
          SELECT 1
          FROM secgen_db.dbo.sg_eta2 tra
          WHERE tra.cod_flusol = eta.cod_flusol
            AND tra.cod_etapa1 = eta.cod_etapa
            AND tra.id_tipacc in (2, 3, 4)
      )
      AND NOT EXISTS (
          SELECT 1
          FROM sistema_db.dbo.bd_pepr pep
          WHERE pep.cod_sistem = eta.cod_sistem
            AND pep.cod_modulo = eta.cod_modulo
            AND pep.cod_perfil = eta.cod_perfil
            AND pep.cod_privil = @cod_privil
      )

    SELECT @filas = @@rowcount

    SELECT
        1 AS status,
        @filas AS perfiles_actualizados,
        @cod_privil AS cod_privil,
        'Privilegios de aprobacion DU288 sincronizados correctamente' AS mensaje
END

SELECT DISTINCT
    eta.cod_flusol,
    eta.cod_etapa,
    eta.cod_perfil,
    per.des_perfil,
    pep.cod_privil,
    pri.nom_privil
FROM secgen_db.dbo.sg_eta1 eta
INNER JOIN sistema_db.dbo.bd_per1 per
    ON per.cod_sistem = eta.cod_sistem
   AND per.cod_modulo = eta.cod_modulo
   AND per.cod_perfil = eta.cod_perfil
LEFT JOIN sistema_db.dbo.bd_pepr pep
    ON pep.cod_sistem = eta.cod_sistem
   AND pep.cod_modulo = eta.cod_modulo
   AND pep.cod_perfil = eta.cod_perfil
   AND pep.cod_privil = @cod_privil
LEFT JOIN sistema_db.dbo.bd_prvg pri
    ON pri.cod_sistem = pep.cod_sistem
   AND pri.cod_modulo = pep.cod_modulo
   AND pri.cod_privil = pep.cod_privil
WHERE isnull(eta.vigente, 'S') = 'S'
  AND EXISTS (
      SELECT 1
      FROM secgen_db.dbo.sg_eta2 tra
      WHERE tra.cod_flusol = eta.cod_flusol
        AND tra.cod_etapa1 = eta.cod_etapa
        AND tra.id_tipacc in (2, 3, 4)
  )
ORDER BY eta.cod_flusol, eta.cod_etapa
