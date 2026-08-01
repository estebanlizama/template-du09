USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_fupssSecgen16'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen16
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen16
Objetivo      : Resolver la jefatura directa de un funcionario segun el
                contrato seleccionado para una solicitud PDS DU288.

Prioridad     :
    1. Jefatura de la unidad ocupada por contrato (sp_orco).
    2. Jefatura de la unidad ocupada por designacion (sp_orde).
    3. Autoridad subrogante configurada en sp_aufi.
    4. Si no existe jefatura o existe autojefatura, subir por cod_orgjef.
    5. Si cod_orgjef no resuelve, subir por es_ujer.cod_unisup.

Importante    : El PA no inserta en sg_apso. Si retorna estado_resolucion
                AMBIGUO, la aplicacion no debe asignar un jefe arbitrario.

Parametros    :
    @rut_person char(9) : RUT del funcionario, sin puntos y con digito verificador.
    @cod_contra int     : Contrato seleccionado en la solicitud DU288.

Retorna       :
    Datos del funcionario, unidad contractual, RUT y nombre de la jefatura,
    cargo organizacional, departamento, fuente y nivel jerarquico.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen16
    @rut_person char(9),
    @cod_contra int
AS
BEGIN
    DECLARE @cod_unidad char(8)
    DECLARE @des_unidad varchar(100)
    DECLARE @unidad_actual char(8)
    DECLARE @unidad_superior char(8)
    DECLARE @nivel tinyint
    DECLARE @cantidad int
    DECLARE @cantidad_rut int
    DECLARE @prioridad_aufi tinyint

    SELECT
        @cod_unidad = cont.cod_unidad,
        @des_unidad = unid.des_unidad
    FROM sisper_db.dbo.sp_cont cont
    INNER JOIN sisper_db.dbo.sp_pers pers
        ON cont.cod_ficha = pers.cod_ficha
    LEFT JOIN ufro_db.dbo.es_unid unid
        ON cont.cod_unidad = unid.cod_unidad
    WHERE cont.cod_contra = @cod_contra
      AND pers.rut_person = @rut_person

    IF @cod_unidad IS NULL
    BEGIN
        SELECT
            @rut_person AS rut_funcionario,
            @cod_contra AS cod_contra,
            CONVERT(char(8), NULL) AS cod_unidad_funcionario,
            CONVERT(varchar(100), NULL) AS des_unidad_funcionario,
            CONVERT(char(9), NULL) AS rut_jefe,
            CONVERT(varchar(200), NULL) AS nombre_jefe,
            CONVERT(int, NULL) AS cod_organi_jefe,
            CONVERT(varchar(100), NULL) AS cargo_jefe,
            CONVERT(char(8), NULL) AS cod_unidad_jefe,
            CONVERT(varchar(100), NULL) AS departamento_jefe,
            CONVERT(varchar(10), NULL) AS fuente_jefatura,
            CONVERT(tinyint, NULL) AS nivel_jefatura,
            'NO_ENCONTRADO' AS estado_resolucion,
            'El contrato no existe o no pertenece al funcionario informado.' AS mensaje
        RETURN
    END

    CREATE TABLE #Jefaturas (
        rut_jefe char(9) NOT NULL,
        nombre_jefe varchar(200) NULL,
        cod_organi_jefe int NOT NULL,
        cargo_jefe varchar(100) NULL,
        cod_unidad_jefe char(8) NOT NULL,
        departamento_jefe varchar(100) NULL,
        fuente_jefatura varchar(10) NOT NULL,
        nivel_jefatura tinyint NOT NULL
    )

    SELECT @unidad_actual = @cod_unidad
    SELECT @nivel = 0
    SELECT @cantidad = 0

    WHILE @nivel <= 10 AND @cantidad = 0
    BEGIN
        /* La organizacion esta ocupada mediante contrato. */
        INSERT INTO #Jefaturas (
            rut_jefe,
            nombre_jefe,
            cod_organi_jefe,
            cargo_jefe,
            cod_unidad_jefe,
            departamento_jefe,
            fuente_jefatura,
            nivel_jefatura
        )
        SELECT DISTINCT
            orco.rut_person,
            LTRIM(RTRIM(
                ISNULL(pers.nom_nombre, '') + ' ' +
                ISNULL(pers.nom_appate, '') + ' ' +
                ISNULL(pers.nom_apmate, '')
            )),
            orga.cod_organi,
            RTRIM(orga.des_organi),
            orga.cod_unidad,
            RTRIM(unid.des_unidad),
            'ORCO',
            @nivel
        FROM ufro_db.dbo.es_orga orga
        INNER JOIN sisper_db.dbo.sp_orco orco
            ON orga.cod_organi = orco.cod_organi
        LEFT JOIN sisper_db.dbo.sp_pers pers
            ON orco.rut_person = pers.rut_person
        LEFT JOIN ufro_db.dbo.es_unid unid
            ON orga.cod_unidad = unid.cod_unidad
        WHERE orga.cod_unidad = @unidad_actual
          AND orga.cod_tiporg = 1
          AND orga.por_contra = 'S'
          AND orco.vigente = 'S'
          AND orco.rut_person <> @rut_person

        SELECT @cantidad = @@rowcount

        /* Si no existe ocupante por contrato, buscar por designacion. */
        IF @cantidad = 0
        BEGIN
            INSERT INTO #Jefaturas (
                rut_jefe,
                nombre_jefe,
                cod_organi_jefe,
                cargo_jefe,
                cod_unidad_jefe,
                departamento_jefe,
                fuente_jefatura,
                nivel_jefatura
            )
            SELECT DISTINCT
                orde.rut_person,
                LTRIM(RTRIM(
                    ISNULL(pers.nom_nombre, '') + ' ' +
                    ISNULL(pers.nom_appate, '') + ' ' +
                    ISNULL(pers.nom_apmate, '')
                )),
                orga.cod_organi,
                RTRIM(orga.des_organi),
                orga.cod_unidad,
                RTRIM(unid.des_unidad),
                'ORDE',
                @nivel
            FROM ufro_db.dbo.es_orga orga
            INNER JOIN sisper_db.dbo.sp_orde orde
                ON orga.cod_organi = orde.cod_organi
            LEFT JOIN sisper_db.dbo.sp_pers pers
                ON orde.rut_person = pers.rut_person
            LEFT JOIN ufro_db.dbo.es_unid unid
                ON orga.cod_unidad = unid.cod_unidad
            WHERE orga.cod_unidad = @unidad_actual
              AND orga.cod_tiporg = 1
              AND orga.por_desig = 'S'
              AND orde.vigente = 'S'
              AND orde.rut_person <> @rut_person

            SELECT @cantidad = @@rowcount
        END

        IF @cantidad = 0
        BEGIN
            /*
             * Buscar una autoridad subrogante. sp_aufi.cod_organi identifica
             * el cargo requerido y cod_organ2 el cargo que lo subroga.
             */
            SELECT @prioridad_aufi = NULL

            SELECT @prioridad_aufi = MIN(aufi.prioridad)
            FROM ufro_db.dbo.es_orga orga_obj
            INNER JOIN sisper_db.dbo.sp_aufi aufi
                ON aufi.cod_organi = orga_obj.cod_organi
            WHERE orga_obj.cod_unidad = @unidad_actual
              AND orga_obj.cod_tiporg = 1
              AND (
                  EXISTS (
                      SELECT 1
                      FROM sisper_db.dbo.sp_orco orco_vig
                      WHERE orco_vig.cod_organi = aufi.cod_organ2
                        AND orco_vig.vigente = 'S'
                        AND orco_vig.rut_person <> @rut_person
                  )
                  OR EXISTS (
                      SELECT 1
                      FROM sisper_db.dbo.sp_orde orde_vig
                      WHERE orde_vig.cod_organi = aufi.cod_organ2
                        AND orde_vig.vigente = 'S'
                        AND orde_vig.rut_person <> @rut_person
                  )
              )

            INSERT INTO #Jefaturas (
                rut_jefe,
                nombre_jefe,
                cod_organi_jefe,
                cargo_jefe,
                cod_unidad_jefe,
                departamento_jefe,
                fuente_jefatura,
                nivel_jefatura
            )
            SELECT DISTINCT
                orco.rut_person,
                LTRIM(RTRIM(
                    ISNULL(pers.nom_nombre, '') + ' ' +
                    ISNULL(pers.nom_appate, '') + ' ' +
                    ISNULL(pers.nom_apmate, '')
                )),
                orga_obj.cod_organi,
                RTRIM(orga_obj.des_organi),
                orga_obj.cod_unidad,
                RTRIM(unid.des_unidad),
                'AUFI_ORCO',
                @nivel
            FROM ufro_db.dbo.es_orga orga_obj
            INNER JOIN sisper_db.dbo.sp_aufi aufi
                ON aufi.cod_organi = orga_obj.cod_organi
            INNER JOIN sisper_db.dbo.sp_orco orco
                ON orco.cod_organi = aufi.cod_organ2
            LEFT JOIN sisper_db.dbo.sp_pers pers
                ON pers.rut_person = orco.rut_person
            LEFT JOIN ufro_db.dbo.es_unid unid
                ON unid.cod_unidad = orga_obj.cod_unidad
            WHERE orga_obj.cod_unidad = @unidad_actual
              AND orga_obj.cod_tiporg = 1
              AND orco.vigente = 'S'
              AND orco.rut_person <> @rut_person
              AND aufi.prioridad = @prioridad_aufi

            SELECT @cantidad = @@rowcount
        END

        IF @cantidad = 0
        BEGIN
            INSERT INTO #Jefaturas (
                rut_jefe,
                nombre_jefe,
                cod_organi_jefe,
                cargo_jefe,
                cod_unidad_jefe,
                departamento_jefe,
                fuente_jefatura,
                nivel_jefatura
            )
            SELECT DISTINCT
                orde.rut_person,
                LTRIM(RTRIM(
                    ISNULL(pers.nom_nombre, '') + ' ' +
                    ISNULL(pers.nom_appate, '') + ' ' +
                    ISNULL(pers.nom_apmate, '')
                )),
                orga_obj.cod_organi,
                RTRIM(orga_obj.des_organi),
                orga_obj.cod_unidad,
                RTRIM(unid.des_unidad),
                'AUFI_ORDE',
                @nivel
            FROM ufro_db.dbo.es_orga orga_obj
            INNER JOIN sisper_db.dbo.sp_aufi aufi
                ON aufi.cod_organi = orga_obj.cod_organi
            INNER JOIN sisper_db.dbo.sp_orde orde
                ON orde.cod_organi = aufi.cod_organ2
            LEFT JOIN sisper_db.dbo.sp_pers pers
                ON pers.rut_person = orde.rut_person
            LEFT JOIN ufro_db.dbo.es_unid unid
                ON unid.cod_unidad = orga_obj.cod_unidad
            WHERE orga_obj.cod_unidad = @unidad_actual
              AND orga_obj.cod_tiporg = 1
              AND orde.vigente = 'S'
              AND orde.rut_person <> @rut_person
              AND aufi.prioridad = @prioridad_aufi

            SELECT @cantidad = @@rowcount
        END

        IF @cantidad = 0
        BEGIN
            SELECT @unidad_superior = NULL

            /*
             * Si el funcionario ocupa la jefatura de su propia unidad,
             * continuar desde la organizacion superior.
             */
            SELECT @unidad_superior = orga_sup.cod_unidad
            FROM ufro_db.dbo.es_orga orga,
                 ufro_db.dbo.es_orga orga_sup,
                 sisper_db.dbo.sp_orco orco
            WHERE orga.cod_organi = orco.cod_organi
              AND orga.cod_orgjef = orga_sup.cod_organi
              AND orga.cod_unidad = @unidad_actual
              AND orga.cod_tiporg = 1
              AND orga.por_contra = 'S'
              AND orco.vigente = 'S'
              AND orco.rut_person = @rut_person

            IF @unidad_superior IS NULL
            BEGIN
                SELECT @unidad_superior = orga_sup.cod_unidad
                FROM ufro_db.dbo.es_orga orga,
                     ufro_db.dbo.es_orga orga_sup,
                     sisper_db.dbo.sp_orde orde
                WHERE orga.cod_organi = orde.cod_organi
                  AND orga.cod_orgjef = orga_sup.cod_organi
                  AND orga.cod_unidad = @unidad_actual
                  AND orga.cod_tiporg = 1
                  AND orga.por_desig = 'S'
                  AND orde.vigente = 'S'
                  AND orde.rut_person = @rut_person
            END

            /*
             * Si el cargo de jefatura existe pero esta vacante, continuar
             * por su organizacion superior.
             */
            IF @unidad_superior IS NULL
            BEGIN
                SELECT @unidad_superior = orga_sup.cod_unidad
                FROM ufro_db.dbo.es_orga orga,
                     ufro_db.dbo.es_orga orga_sup
                WHERE orga.cod_orgjef = orga_sup.cod_organi
                  AND orga.cod_unidad = @unidad_actual
                  AND orga.cod_tiporg = 1
                  AND (orga.por_contra = 'S' OR orga.por_desig = 'S')
            END

            /* Fallback formal de jerarquia de unidades. */
            IF @unidad_superior IS NULL
            BEGIN
                SELECT @unidad_superior = ujer.cod_unisup
                FROM ufro_db.dbo.es_ujer ujer
                WHERE ujer.cod_unidep = @unidad_actual
            END

            /*
             * Compatibilidad con unidades antiguas que no tienen relacion
             * registrada en es_ujer. La jerarquia se obtiene eliminando el
             * ultimo segmento significativo del codigo de unidad.
             */
            IF @unidad_superior IS NULL
            BEGIN
                IF CONVERT(int, RIGHT(@unidad_actual, 2)) > 0
                    SELECT @unidad_superior = LEFT(@unidad_actual, 6) + '00'
                ELSE IF CONVERT(int, RIGHT(@unidad_actual, 4)) > 0
                    SELECT @unidad_superior = LEFT(@unidad_actual, 4) + '0000'
                ELSE IF CONVERT(int, RIGHT(@unidad_actual, 6)) > 0
                    SELECT @unidad_superior = LEFT(@unidad_actual, 2) + '000000'
            END

            IF @unidad_superior IS NULL OR @unidad_superior = @unidad_actual
                BREAK

            SELECT @unidad_actual = @unidad_superior
            SELECT @nivel = @nivel + 1
        END
    END

    IF @cantidad = 0
    BEGIN
        SELECT
            @rut_person AS rut_funcionario,
            @cod_contra AS cod_contra,
            @cod_unidad AS cod_unidad_funcionario,
            RTRIM(@des_unidad) AS des_unidad_funcionario,
            CONVERT(char(9), NULL) AS rut_jefe,
            CONVERT(varchar(200), NULL) AS nombre_jefe,
            CONVERT(int, NULL) AS cod_organi_jefe,
            CONVERT(varchar(100), NULL) AS cargo_jefe,
            CONVERT(char(8), NULL) AS cod_unidad_jefe,
            CONVERT(varchar(100), NULL) AS departamento_jefe,
            CONVERT(varchar(10), NULL) AS fuente_jefatura,
            CONVERT(tinyint, NULL) AS nivel_jefatura,
            'NO_ENCONTRADO' AS estado_resolucion,
            'No se encontro una jefatura vigente para el contrato informado.' AS mensaje
        RETURN
    END

    SELECT @cantidad_rut = COUNT(DISTINCT rut_jefe)
    FROM #Jefaturas

    SELECT DISTINCT
        @rut_person AS rut_funcionario,
        @cod_contra AS cod_contra,
        @cod_unidad AS cod_unidad_funcionario,
        RTRIM(@des_unidad) AS des_unidad_funcionario,
        jefe.rut_jefe,
        jefe.nombre_jefe,
        jefe.cod_organi_jefe,
        jefe.cargo_jefe,
        jefe.cod_unidad_jefe,
        jefe.departamento_jefe,
        jefe.fuente_jefatura,
        jefe.nivel_jefatura,
        CASE
            WHEN @cantidad_rut = 1 THEN 'ENCONTRADO'
            ELSE 'AMBIGUO'
        END AS estado_resolucion,
        CASE
            WHEN @cantidad_rut = 1 THEN NULL
            ELSE 'Existe mas de una jefatura vigente. Se requiere desambiguar antes de asignar sg_apso.'
        END AS mensaje
    FROM #Jefaturas jefe
    ORDER BY jefe.rut_jefe, jefe.cod_organi_jefe
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen16 TO UsuaVrac
GO
