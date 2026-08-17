USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sp_ordesSecgen01'
)
    DROP PROCEDURE Analisis2.sp_ordesSecgen01
GO

/*
Procedimiento : Analisis2.sp_ordesSecgen01
Objetivo      : Resolver los ambitos de gestion personales y por representacion
                para el RUT autenticado, sin cambiar su identidad ni persistir
                una sesion delegada.

La representacion se considera utilizable solo cuando existe un titular ORCO
unico y una persona ORDE unica con una designacion tipo 1 vigente para la
organizacion. Los tipos 2 (Sumario) y 3 (Fondos Fijos) no otorgan subrogancia.
Los conteos se materializan para no exceder el limite de tablas del optimizador
de Sybase ASE.
*/
CREATE PROCEDURE Analisis2.sp_ordesSecgen01
    @rut_actor char(9) = NULL,
    @fecha_eval datetime = NULL
AS
BEGIN
    DECLARE @fecha_val datetime
    SELECT @fecha_val = ISNULL(@fecha_eval, getdate())

    IF @rut_actor IS NULL OR ltrim(rtrim(@rut_actor)) = ''
    BEGIN
        SELECT
            convert(varchar(40), NULL) AS context_key,
            convert(varchar(20), NULL) AS context_type,
            convert(char(9), NULL) AS rut_actor,
            convert(char(9), NULL) AS rut_titular,
            convert(varchar(255), NULL) AS nombre_titular,
            convert(int, NULL) AS cod_organi_representado,
            convert(varchar(100), NULL) AS cargo_representado,
            convert(varchar(10), NULL) AS cod_design,
            convert(varchar(2), NULL) AS cod_des_su,
            convert(varchar(40), NULL) AS tipo_representacion,
            convert(varchar(10), NULL) AS fuente,
            convert(datetime, NULL) AS fecha_desde,
            convert(datetime, NULL) AS fecha_hasta,
            convert(char(1), NULL) AS titular_ausente,
            convert(varchar(10), NULL) AS numero_resolucion,
            convert(varchar(12), 'NO_VIGENTE') AS estado_resolucion,
            convert(char(1), 'N') AS puede_ver,
            convert(char(1), 'N') AS puede_crear,
            convert(char(1), 'N') AS puede_editar,
            convert(char(1), 'N') AS puede_decidir,
            convert(char(1), 'N') AS puede_firmar,
            convert(varchar(255), 'Falta RUT del usuario autenticado') AS mensaje
        RETURN
    END

    CREATE TABLE #titulares_activos (
        cod_organi int not null,
        cantidad int not null
    )

    INSERT INTO #titulares_activos (cod_organi, cantidad)
    SELECT cod_organi, count(DISTINCT rut_person)
    FROM sisper_db.dbo.sp_orco
    WHERE vigente = 'S'
    GROUP BY cod_organi

    CREATE TABLE #designados_vigentes (
        cod_organi int not null,
        cantidad int not null
    )

    INSERT INTO #designados_vigentes (cod_organi, cantidad)
    SELECT orde.cod_organi, count(DISTINCT orde.rut_person)
    FROM sisper_db.dbo.sp_orde orde
    INNER JOIN sisper_db.dbo.sp_desg desg
        ON desg.cod_design = orde.cod_design
       AND desg.cod_des_su = '1'
       AND desg.vigencia IN ('1', 'S')
       AND desg.f_inicio <= @fecha_val
       AND (desg.f_termino IS NULL OR desg.f_termino >= @fecha_val)
    WHERE orde.vigente = 'S'
    GROUP BY orde.cod_organi

    SELECT
        'PERSONAL' AS context_key,
        'PERSONAL' AS context_type,
        @rut_actor AS rut_actor,
        @rut_actor AS rut_titular,
        ltrim(rtrim(isnull(actor.nom_nombre, '') + ' ' +
                    isnull(actor.nom_appate, '') + ' ' +
                    isnull(actor.nom_apmate, ''))) AS nombre_titular,
        convert(int, NULL) AS cod_organi_representado,
        convert(varchar(100), NULL) AS cargo_representado,
        convert(varchar(10), NULL) AS cod_design,
        convert(varchar(2), NULL) AS cod_des_su,
        'PERSONAL' AS tipo_representacion,
        'JWT' AS fuente,
        convert(datetime, NULL) AS fecha_desde,
        convert(datetime, NULL) AS fecha_hasta,
        convert(char(1), NULL) AS titular_ausente,
        convert(varchar(10), NULL) AS numero_resolucion,
        'VIGENTE' AS estado_resolucion,
        'S' AS puede_ver,
        'S' AS puede_crear,
        'S' AS puede_editar,
        'S' AS puede_decidir,
        'S' AS puede_firmar,
        convert(varchar(255), NULL) AS mensaje
    FROM sisper_db.dbo.sp_pers actor
    WHERE actor.rut_person = @rut_actor

    UNION ALL

    SELECT
        'REP:' + convert(varchar(10), orde.cod_organi) + ':' + rtrim(orco.rut_person),
        'REPRESENTACION',
        @rut_actor,
        orco.rut_person,
        ltrim(rtrim(isnull(titular.nom_nombre, '') + ' ' +
                    isnull(titular.nom_appate, '') + ' ' +
                    isnull(titular.nom_apmate, ''))),
        orde.cod_organi,
        rtrim(orga.des_organi),
        desg.cod_design,
        desg.cod_des_su,
        'SUBROGANCIA',
        'ORDE',
        desg.f_inicio,
        desg.f_termino,
        CASE WHEN upper(ltrim(rtrim(isnull(orco.ausente, 'N')))) = 'S'
             THEN 'S' ELSE 'N' END,
        convert(varchar(10), desg.num_resol),
        CASE WHEN titulares.cantidad = 1 AND designados.cantidad = 1
             THEN 'VIGENTE' ELSE 'AMBIGUA' END,
        CASE WHEN titulares.cantidad = 1 AND designados.cantidad = 1
             THEN 'S' ELSE 'N' END,
        CASE WHEN titulares.cantidad = 1 AND designados.cantidad = 1
             THEN 'S' ELSE 'N' END,
        CASE WHEN titulares.cantidad = 1 AND designados.cantidad = 1
             THEN 'S' ELSE 'N' END,
        CASE WHEN titulares.cantidad = 1 AND designados.cantidad = 1
             THEN 'S' ELSE 'N' END,
        CASE WHEN titulares.cantidad = 1 AND designados.cantidad = 1
             THEN 'S' ELSE 'N' END,
        CASE
            WHEN titulares.cantidad <> 1
                THEN 'La organizacion no posee un titular vigente unico.'
            WHEN designados.cantidad <> 1
                THEN 'Existe mas de una persona designada vigente para la organizacion.'
            ELSE NULL
        END
    FROM sisper_db.dbo.sp_orde orde
    INNER JOIN sisper_db.dbo.sp_desg desg
        ON desg.cod_design = orde.cod_design
       AND desg.cod_des_su = '1'
       AND desg.vigencia IN ('1', 'S')
       AND desg.f_inicio <= @fecha_val
       AND (desg.f_termino IS NULL OR desg.f_termino >= @fecha_val)
    INNER JOIN #designados_vigentes designados
        ON designados.cod_organi = orde.cod_organi
    INNER JOIN sisper_db.dbo.sp_orco orco
        ON orco.cod_organi = orde.cod_organi
       AND orco.vigente = 'S'
    INNER JOIN #titulares_activos titulares
        ON titulares.cod_organi = orco.cod_organi
    INNER JOIN sisper_db.dbo.sp_pers titular
        ON titular.rut_person = orco.rut_person
    INNER JOIN ufro_db.dbo.es_orga orga
        ON orga.cod_organi = orde.cod_organi
       AND orga.por_desig = 'S'
    WHERE orde.rut_person = @rut_actor
      AND orde.rut_person <> orco.rut_person
      AND orde.vigente = 'S'
    ORDER BY context_type, cargo_representado, nombre_titular

    DROP TABLE #designados_vigentes
    DROP TABLE #titulares_activos
END
GO

GRANT EXECUTE ON Analisis2.sp_ordesSecgen01 TO UsuaVrac
GO
