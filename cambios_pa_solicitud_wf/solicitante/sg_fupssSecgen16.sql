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

    DECLARE @cod_organi_actual int
    DECLARE @cod_organi_siguiente int
    DECLARE @rut_jefe char(9)
    DECLARE @fuente_jefatura varchar(10)
    DECLARE @cod_organi_jefe int
    DECLARE @cargo_jefe varchar(100)
    DECLARE @cod_unidad_jefe char(8)
    DECLARE @departamento_jefe varchar(100)
    DECLARE @nivel_jefatura tinyint

    SELECT @nivel_jefatura = 0
    SELECT @rut_jefe = NULL

    /* Punto inicial: primer cargo organizacional de jefatura en la unidad contractual */
    SELECT @cod_organi_actual = min(orga.cod_organi)
    FROM ufro_db.dbo.es_orga orga
    WHERE orga.cod_unidad = @cod_unidad
      AND orga.cod_tiporg = 1
      AND (orga.por_contra = 'S' OR orga.por_desig = 'S')

    IF @cod_organi_actual IS NULL
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

    WHILE @nivel_jefatura <= 10 AND @rut_jefe IS NULL AND @cod_organi_actual IS NOT NULL
    BEGIN
        /* 1. Probar Titular (ORCO) */
        SELECT @rut_jefe = min(orco.rut_person)
        FROM sisper_db.dbo.sp_orco orco
        INNER JOIN ufro_db.dbo.es_orga orga
            ON orga.cod_organi = @cod_organi_actual
        WHERE orco.cod_organi = @cod_organi_actual
          AND orga.por_contra = 'S'
          AND orco.vigente = 'S'
          AND orco.rut_person <> @rut_person

        IF @rut_jefe IS NOT NULL
        BEGIN
            SELECT @fuente_jefatura = 'ORCO'
            SELECT @cod_organi_jefe = @cod_organi_actual
            BREAK
        END

        /* 2. Probar Subrogante (ORDE) */
        SELECT @rut_jefe = min(orde.rut_person)
        FROM sisper_db.dbo.sp_orde orde
        INNER JOIN ufro_db.dbo.es_orga orga
            ON orga.cod_organi = @cod_organi_actual
        WHERE orde.cod_organi = @cod_organi_actual
          AND orga.por_desig = 'S'
          AND orde.vigente = 'S'
          AND orde.rut_person <> @rut_person

        IF @rut_jefe IS NOT NULL
        BEGIN
            SELECT @fuente_jefatura = 'ORDE'
            SELECT @cod_organi_jefe = @cod_organi_actual
            BREAK
        END

        /* 3. Avanzar al siguiente cargo superior por es_orga.cod_orgjef */
        SELECT @cod_organi_siguiente = min(superior.cod_organi)
        FROM ufro_db.dbo.es_orga orga
        INNER JOIN ufro_db.dbo.es_orga superior
            ON superior.cod_organi = orga.cod_orgjef
        WHERE orga.cod_organi = @cod_organi_actual
          AND orga.cod_orgjef IS NOT NULL
          AND orga.cod_orgjef <> orga.cod_organi
          AND SUBSTRING(superior.cod_unidad, 1, 2) = @prefijo_unidad

        IF @cod_organi_siguiente IS NULL OR @cod_organi_siguiente = @cod_organi_actual
            BREAK

        SELECT @cod_organi_actual = @cod_organi_siguiente
        SELECT @nivel_jefatura = @nivel_jefatura + 1
    END

    IF @rut_jefe IS NULL
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

    /* Obtener metadata de la jefatura resuelta */
    SELECT
        @cargo_jefe = RTRIM(orga.des_organi),
        @cod_unidad_jefe = orga.cod_unidad,
        @departamento_jefe = RTRIM(unid.des_unidad)
    FROM ufro_db.dbo.es_orga orga
    LEFT JOIN ufro_db.dbo.es_unid unid
        ON unid.cod_unidad = orga.cod_unidad
    WHERE orga.cod_organi = @cod_organi_jefe

    SELECT
        @rut_person AS rut_funcionario,
        @cod_contra AS cod_contra,
        @cod_unidad AS cod_unidad_funcionario,
        RTRIM(@des_unidad) AS des_unidad_funcionario,
        @rut_jefe AS rut_jefe,
        LTRIM(RTRIM(
            ISNULL(pers.nom_nombre, '') + ' ' +
            ISNULL(pers.nom_appate, '') + ' ' +
            ISNULL(pers.nom_apmate, '')
        )) AS nombre_jefe,
        @cod_organi_jefe AS cod_organi_jefe,
        @cargo_jefe AS cargo_jefe,
        @cod_unidad_jefe AS cod_unidad_jefe,
        @departamento_jefe AS departamento_jefe,
        @fuente_jefatura AS fuente_jefatura,
        @nivel_jefatura AS nivel_jefatura,
        'ENCONTRADO' AS estado_resolucion,
        CONVERT(varchar(255), NULL) AS mensaje
    FROM sisper_db.dbo.sp_pers pers
    WHERE pers.rut_person = @rut_jefe
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen16 TO UsuaVrac
GO
