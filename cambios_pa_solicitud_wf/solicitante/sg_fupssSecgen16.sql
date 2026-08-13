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
Objetivo      : Resolver la jefatura de un funcionario a partir de la unidad
                del contrato seleccionado y de la jerarquia formal definida
                en ufro_db.dbo.es_orga.

Recorrido     :
    1. Validar que @cod_contra pertenezca a @rut_person y obtener su unidad.
    2. Obtener los cargos de jefatura de la unidad en es_orga.
    3. Buscar ocupante vigente en sp_orco para el cod_organi actual.
    4. Si ORCO no resuelve, buscar en sp_orde con el mismo cod_organi.
    5. Si tampoco resuelve, avanzar al cod_orgjef de es_orga mientras la
       organizacion superior pertenezca a la misma unidad institucional raiz.
    6. Repetir ORCO -> ORDE -> cod_orgjef hasta resolver o alcanzar el limite
       de la unidad superior (por ejemplo, Decanato).

Reglas        :
    - ORCO tiene prioridad sobre ORDE en cada nivel.
    - ORCO aplica solamente cuando es_orga.por_contra = 'S'.
    - ORDE aplica solamente cuando es_orga.por_desig = 'S'.
    - El funcionario no puede quedar asignado como su propia jefatura.
    - Un RUT distinto encontrado retorna ENCONTRADO.
    - Mas de un RUT distinto en el mismo nivel retorna AMBIGUO.
    - El recorrido no cruza a Rectoría ni a otra raiz institucional. Para ello,
      el prefijo de dos digitos de cod_unidad debe mantenerse en cada salto.
      Ejemplo: 07051100 -> 07010000 es valido; 07010000 -> 01010000 no.
    - Sin ocupante dentro de la unidad superior retorna NO_ENCONTRADO.
    - El recorrido se limita a 10 niveles y no permite ciclos.

Importante    : El PA no inserta tareas en sg_apso. La aplicacion debe crear
                la tarea solamente cuando estado_resolucion = ENCONTRADO.

Parametros    :
    @rut_person char(9) : RUT sin puntos ni guion.
    @cod_contra int     : Contrato seleccionado para el funcionario.

nivel_jefatura:
    0 : cargo de jefatura asociado directamente a la unidad contractual.
    1 o superior : cantidad de saltos realizados mediante es_orga.cod_orgjef.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen16
    @rut_person char(9),
    @cod_contra int
AS
BEGIN
    DECLARE @cod_unidad char(8)
    DECLARE @prefijo_unidad char(2)
    DECLARE @des_unidad varchar(100)
    DECLARE @nivel tinyint
    DECLARE @cantidad int
    DECLARE @cantidad_rut int
    DECLARE @cantidad_siguiente int

    SELECT
        @cod_unidad = cont.cod_unidad,
        @des_unidad = unid.des_unidad
    FROM sisper_db.dbo.sp_cont cont
    INNER JOIN sisper_db.dbo.sp_pers pers
        ON pers.cod_ficha = cont.cod_ficha
    LEFT JOIN ufro_db.dbo.es_unid unid
        ON unid.cod_unidad = cont.cod_unidad
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

    SELECT @prefijo_unidad = SUBSTRING(@cod_unidad, 1, 2)

    /*
     * Organizaciones que deben evaluarse en cada nivel. El mismo cargo no
     * puede insertarse nuevamente; esto evita ciclos en cod_orgjef.
     */
    CREATE TABLE #Organizaciones (
        cod_organi int NOT NULL,
        nivel tinyint NOT NULL
    )

    CREATE UNIQUE INDEX idx_organizaciones
        ON #Organizaciones (cod_organi)

    CREATE TABLE #Jefaturas (
        rut_jefe char(9) NOT NULL,
        nombre_jefe varchar(200) NULL,
        cod_organi_jefe int NOT NULL,
        cargo_jefe varchar(100) NULL,
        cod_unidad_jefe char(8) NULL,
        departamento_jefe varchar(100) NULL,
        fuente_jefatura varchar(10) NOT NULL,
        nivel_jefatura tinyint NOT NULL
    )

    /*
     * Punto inicial: cargos organizacionales de jefatura pertenecientes a la
     * unidad contractual. cod_tiporg = 1 corresponde al tipo de jefatura que
     * utiliza la estructura institucional actual.
     */
    INSERT INTO #Organizaciones (cod_organi, nivel)
    SELECT DISTINCT orga.cod_organi, 0
    FROM ufro_db.dbo.es_orga orga
    WHERE orga.cod_unidad = @cod_unidad
      AND orga.cod_tiporg = 1
      AND (orga.por_contra = 'S' OR orga.por_desig = 'S')

    SELECT @cantidad = @@rowcount

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
            'La unidad contractual no posee un cargo de jefatura configurado en es_orga.' AS mensaje
        RETURN
    END

    SELECT @nivel = 0
    SELECT @cantidad = 0

    WHILE @nivel <= 10 AND @cantidad = 0
    BEGIN
        /* Primera prioridad del nivel: ocupante vigente por contrato. */
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
        FROM #Organizaciones actual
        INNER JOIN ufro_db.dbo.es_orga orga
            ON orga.cod_organi = actual.cod_organi
        INNER JOIN sisper_db.dbo.sp_orco orco
            ON orco.cod_organi = actual.cod_organi
        LEFT JOIN sisper_db.dbo.sp_pers pers
            ON pers.rut_person = orco.rut_person
        LEFT JOIN ufro_db.dbo.es_unid unid
            ON unid.cod_unidad = orga.cod_unidad
        WHERE actual.nivel = @nivel
          AND orga.por_contra = 'S'
          AND orco.vigente = 'S'
          AND orco.rut_person <> @rut_person

        SELECT @cantidad = @@rowcount

        /* Segunda prioridad: designacion sobre el mismo cod_organi. */
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
            FROM #Organizaciones actual
            INNER JOIN ufro_db.dbo.es_orga orga
                ON orga.cod_organi = actual.cod_organi
            INNER JOIN sisper_db.dbo.sp_orde orde
                ON orde.cod_organi = actual.cod_organi
            LEFT JOIN sisper_db.dbo.sp_pers pers
                ON pers.rut_person = orde.rut_person
            LEFT JOIN ufro_db.dbo.es_unid unid
                ON unid.cod_unidad = orga.cod_unidad
            WHERE actual.nivel = @nivel
              AND orga.por_desig = 'S'
              AND orde.vigente = 'S'
              AND orde.rut_person <> @rut_person

            SELECT @cantidad = @@rowcount
        END

        /*
         * Sin ocupante en ORCO ni ORDE: cada cod_orgjef pasa a ser el
         * cod_organi que se evaluara en el nivel siguiente, siempre que su
         * unidad conserve el prefijo institucional de la unidad contractual.
         * Esto permite llegar al Decanato, pero impide continuar a Rectoria.
         */
        IF @cantidad = 0
        BEGIN
            SELECT @cantidad_siguiente = 0

            IF @nivel < 10
            BEGIN
                INSERT INTO #Organizaciones (cod_organi, nivel)
                SELECT DISTINCT superior.cod_organi, @nivel + 1
                FROM #Organizaciones actual
                INNER JOIN ufro_db.dbo.es_orga orga
                    ON orga.cod_organi = actual.cod_organi
                INNER JOIN ufro_db.dbo.es_orga superior
                    ON superior.cod_organi = orga.cod_orgjef
                WHERE actual.nivel = @nivel
                  AND orga.cod_orgjef IS NOT NULL
                  AND orga.cod_orgjef <> orga.cod_organi
                  AND SUBSTRING(superior.cod_unidad, 1, 2) = @prefijo_unidad
                  AND NOT EXISTS (
                      SELECT 1
                      FROM #Organizaciones visitada
                      WHERE visitada.cod_organi = superior.cod_organi
                  )

                SELECT @cantidad_siguiente = @@rowcount
            END

            IF @cantidad_siguiente = 0
                BREAK

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
            'No se encontro un ocupante vigente en ORCO u ORDE dentro de la unidad superior. El recorrido no escala a Rectoria ni cambia la raiz institucional.' AS mensaje
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
            ELSE 'Existe mas de un ocupante vigente en el mismo nivel de la jerarquia organizacional.'
        END AS mensaje
    FROM #Jefaturas jefe
    ORDER BY jefe.rut_jefe, jefe.cod_organi_jefe
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen16 TO UsuaVrac
GO
