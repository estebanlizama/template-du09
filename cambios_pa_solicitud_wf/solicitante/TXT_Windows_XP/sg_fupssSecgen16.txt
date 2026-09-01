USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen16'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen16
GO

/* Procedimiento : Analisis2.sg_fupssSecgen16

   Entrada :
   @rut_person          -> RUT del funcionario. (Obligatorio)
   @cod_contra          -> Codigo del contrato. (Obligatorio)

   Objetivo : Obtener informacion de un funcionario y su contrato activo

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fupssSecgen16
    @rut_person char(9),
    @cod_contra int
AS
BEGIN
    DECLARE @cod_unidad char(8), @des_unidad varchar(100), @prefijo char(2)
    DECLARE @cod_actual int, @cod_siguiente int, @cod_actor int
    DECLARE @rut_jefe char(9), @fuente varchar(20), @nivel tinyint
    DECLARE @cantidad int, @prioridad int, @prioridad_anterior int
    DECLARE @es_subrogante char(1), @rut_titular char(9)
    DECLARE @nombre_titular varchar(255), @cargo_titular varchar(100)
    DECLARE @cargo_actor varchar(100), @unidad_actor char(8), @departamento_actor varchar(100)

    SELECT @cod_unidad = cont.cod_unidad, @des_unidad = unid.des_unidad
    FROM sisper_db.dbo.sp_cont cont
    INNER JOIN sisper_db.dbo.sp_pers pers ON pers.cod_ficha = cont.cod_ficha
    LEFT JOIN ufro_db.dbo.es_unid unid ON unid.cod_unidad = cont.cod_unidad
    WHERE cont.cod_contra = @cod_contra AND pers.rut_person = @rut_person

    IF @cod_unidad IS NULL
    BEGIN
        SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
            convert(char(8), NULL) cod_unidad_funcionario,
            convert(varchar(100), NULL) des_unidad_funcionario,
            convert(char(9), NULL) rut_jefe, convert(varchar(255), NULL) nombre_jefe,
            convert(int, NULL) cod_organi_jefe, convert(varchar(100), NULL) cargo_jefe,
            convert(char(8), NULL) cod_unidad_jefe, convert(varchar(100), NULL) departamento_jefe,
            convert(varchar(20), NULL) fuente_jefatura, convert(tinyint, NULL) nivel_jefatura,
            'NO_ENCONTRADO' estado_resolucion,
            'El contrato no existe o no pertenece al funcionario informado.' mensaje,
            convert(int, NULL) cod_organi_requerido, convert(int, NULL) cod_organi_actor,
            'N' es_subrogante, convert(int, NULL) prioridad_aufi,
            convert(char(9), NULL) rut_titular, convert(varchar(255), NULL) nombre_titular,
            convert(varchar(100), NULL) cargo_titular
        RETURN
    END

    SELECT @prefijo = substring(@cod_unidad, 1, 2), @nivel = 0
    SELECT @cantidad = count(DISTINCT orga.cod_organi)
    FROM ufro_db.dbo.es_orga orga
    WHERE orga.cod_unidad = @cod_unidad AND orga.cod_tiporg = 1
      AND (orga.por_contra = 'S' OR orga.por_desig = 'S')

    IF isnull(@cantidad, 0) <> 1
    BEGIN
        SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
            @cod_unidad cod_unidad_funcionario, rtrim(@des_unidad) des_unidad_funcionario,
            convert(char(9), NULL) rut_jefe, convert(varchar(255), NULL) nombre_jefe,
            convert(int, NULL) cod_organi_jefe, convert(varchar(100), NULL) cargo_jefe,
            convert(char(8), NULL) cod_unidad_jefe, convert(varchar(100), NULL) departamento_jefe,
            'CONFIGURACION' fuente_jefatura, convert(tinyint, NULL) nivel_jefatura,
            CASE WHEN isnull(@cantidad, 0) = 0 THEN 'NO_ENCONTRADO' ELSE 'AMBIGUO' END estado_resolucion,
            CASE WHEN isnull(@cantidad, 0) = 0
                 THEN 'La unidad contractual no posee un cargo de jefatura configurado.'
                 ELSE 'La unidad contractual posee mas de un cargo de jefatura posible.' END mensaje,
            convert(int, NULL) cod_organi_requerido, convert(int, NULL) cod_organi_actor,
            'N' es_subrogante, convert(int, NULL) prioridad_aufi,
            convert(char(9), NULL) rut_titular, convert(varchar(255), NULL) nombre_titular,
            convert(varchar(100), NULL) cargo_titular
        RETURN
    END

    SELECT @cod_actual = min(orga.cod_organi)
    FROM ufro_db.dbo.es_orga orga
    WHERE orga.cod_unidad = @cod_unidad AND orga.cod_tiporg = 1
      AND (orga.por_contra = 'S' OR orga.por_desig = 'S')

    /* La jefatura directa mantiene la cadena organizacional de la unidad y
       puede ser resuelta por un subrogante cuando no hay titular vigente. */

    CREATE TABLE #visitados (cod_organi int NOT NULL)
    CREATE TABLE #candidatos (
        rut_person char(9) NOT NULL,
        cod_organi_actor int NOT NULL,
        fuente varchar(20) NOT NULL
    )

    WHILE @cod_actual IS NOT NULL AND @nivel < 32 AND @rut_jefe IS NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM #visitados WHERE cod_organi = @cod_actual)
            BREAK
        INSERT INTO #visitados VALUES (@cod_actual)

        SELECT @cantidad = count(DISTINCT orco.rut_person)
        FROM sisper_db.dbo.sp_orco orco
        WHERE orco.cod_organi = @cod_actual AND orco.vigente = 'S'
          AND upper(ltrim(rtrim(isnull(orco.ausente, 'N')))) <> 'S'
          AND orco.rut_person <> @rut_person
          AND EXISTS (SELECT 1 FROM ufro_db.dbo.es_orga orga
                      WHERE orga.cod_organi = @cod_actual AND orga.por_contra = 'S')

        IF @cantidad > 1
        BEGIN
            DROP TABLE #candidatos
            DROP TABLE #visitados
            SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
                @cod_unidad cod_unidad_funcionario, rtrim(@des_unidad) des_unidad_funcionario,
                convert(char(9), NULL) rut_jefe, convert(varchar(255), NULL) nombre_jefe,
                @cod_actual cod_organi_jefe, rtrim(orga.des_organi) cargo_jefe,
                orga.cod_unidad cod_unidad_jefe, rtrim(unid.des_unidad) departamento_jefe,
                'ORCO' fuente_jefatura, @nivel nivel_jefatura, 'AMBIGUO' estado_resolucion,
                'El cargo de jefatura posee mas de un titular vigente y presente.' mensaje,
                @cod_actual cod_organi_requerido, convert(int, NULL) cod_organi_actor,
                'N' es_subrogante, convert(int, NULL) prioridad_aufi,
                convert(char(9), NULL) rut_titular, convert(varchar(255), NULL) nombre_titular,
                rtrim(orga.des_organi) cargo_titular
            FROM ufro_db.dbo.es_orga orga
            LEFT JOIN ufro_db.dbo.es_unid unid ON unid.cod_unidad = orga.cod_unidad
            WHERE orga.cod_organi = @cod_actual
            RETURN
        END

        IF @cantidad = 1
        BEGIN
            SELECT @rut_jefe = min(orco.rut_person)
            FROM sisper_db.dbo.sp_orco orco
            WHERE orco.cod_organi = @cod_actual AND orco.vigente = 'S'
              AND upper(ltrim(rtrim(isnull(orco.ausente, 'N')))) <> 'S'
              AND orco.rut_person <> @rut_person
              AND EXISTS (SELECT 1 FROM ufro_db.dbo.es_orga orga
                          WHERE orga.cod_organi = @cod_actual AND orga.por_contra = 'S')
            SELECT @fuente = 'ORCO', @cod_actor = @cod_actual, @es_subrogante = 'N'
        END

        IF @rut_jefe IS NULL
        BEGIN
            SELECT @cantidad = count(DISTINCT orde.rut_person)
            FROM sisper_db.dbo.sp_orde orde
            WHERE orde.cod_organi = @cod_actual AND orde.vigente = 'S'
              AND orde.rut_person <> @rut_person

            IF @cantidad > 1
            BEGIN
                DROP TABLE #candidatos
                DROP TABLE #visitados
                SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
                    @cod_unidad cod_unidad_funcionario, rtrim(@des_unidad) des_unidad_funcionario,
                    convert(char(9), NULL) rut_jefe, convert(varchar(255), NULL) nombre_jefe,
                    @cod_actual cod_organi_jefe, rtrim(orga.des_organi) cargo_jefe,
                    orga.cod_unidad cod_unidad_jefe, rtrim(unid.des_unidad) departamento_jefe,
                    'ORDE' fuente_jefatura, @nivel nivel_jefatura, 'AMBIGUO' estado_resolucion,
                    'El cargo de jefatura posee mas de una designacion vigente.' mensaje,
                    @cod_actual cod_organi_requerido, convert(int, NULL) cod_organi_actor,
                    'N' es_subrogante, convert(int, NULL) prioridad_aufi,
                    convert(char(9), NULL) rut_titular, convert(varchar(255), NULL) nombre_titular,
                    rtrim(orga.des_organi) cargo_titular
                FROM ufro_db.dbo.es_orga orga
                LEFT JOIN ufro_db.dbo.es_unid unid ON unid.cod_unidad = orga.cod_unidad
                WHERE orga.cod_organi = @cod_actual
                RETURN
            END

            IF @cantidad = 1
            BEGIN
                SELECT @rut_jefe = min(orde.rut_person)
                FROM sisper_db.dbo.sp_orde orde
                WHERE orde.cod_organi = @cod_actual AND orde.vigente = 'S'
                  AND orde.rut_person <> @rut_person
                SELECT @fuente = 'ORDE', @cod_actor = @cod_actual, @es_subrogante = 'N'
            END
        END

        IF @rut_jefe IS NULL
        BEGIN
            SELECT @prioridad_anterior = -1, @prioridad = NULL
            SELECT @prioridad = min(aufi.prioridad)
            FROM sisper_db.dbo.sp_aufi aufi
            WHERE aufi.cod_organi = @cod_actual

            WHILE @prioridad IS NOT NULL AND @rut_jefe IS NULL
            BEGIN
                DELETE FROM #candidatos
                INSERT INTO #candidatos
                SELECT orco.rut_person, aufi.cod_organ2, 'AUFI_ORCO'
                FROM sisper_db.dbo.sp_aufi aufi
                INNER JOIN sisper_db.dbo.sp_orco orco
                  ON orco.cod_organi = aufi.cod_organ2 AND orco.vigente = 'S'
                 AND upper(ltrim(rtrim(isnull(orco.ausente, 'N')))) <> 'S'
                WHERE aufi.cod_organi = @cod_actual AND aufi.prioridad = @prioridad
                  AND orco.rut_person <> @rut_person
                UNION
                SELECT orde.rut_person, aufi.cod_organ2, 'AUFI_ORDE'
                FROM sisper_db.dbo.sp_aufi aufi
                INNER JOIN sisper_db.dbo.sp_orde orde
                  ON orde.cod_organi = aufi.cod_organ2 AND orde.vigente = 'S'
                WHERE aufi.cod_organi = @cod_actual AND aufi.prioridad = @prioridad
                  AND orde.rut_person <> @rut_person

                SELECT @cantidad = count(DISTINCT rut_person) FROM #candidatos
                IF @cantidad > 1
                BEGIN
                    DROP TABLE #candidatos
                    DROP TABLE #visitados
                    SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
                        @cod_unidad cod_unidad_funcionario, rtrim(@des_unidad) des_unidad_funcionario,
                        convert(char(9), NULL) rut_jefe, convert(varchar(255), NULL) nombre_jefe,
                        @cod_actual cod_organi_jefe, rtrim(orga.des_organi) cargo_jefe,
                        orga.cod_unidad cod_unidad_jefe, rtrim(unid.des_unidad) departamento_jefe,
                        'AUFI' fuente_jefatura, @nivel nivel_jefatura, 'AMBIGUO' estado_resolucion,
                        'AUFI posee mas de un responsable disponible en la misma prioridad.' mensaje,
                        @cod_actual cod_organi_requerido, convert(int, NULL) cod_organi_actor,
                        'S' es_subrogante, @prioridad prioridad_aufi,
                        convert(char(9), NULL) rut_titular, convert(varchar(255), NULL) nombre_titular,
                        rtrim(orga.des_organi) cargo_titular
                    FROM ufro_db.dbo.es_orga orga
                    LEFT JOIN ufro_db.dbo.es_unid unid ON unid.cod_unidad = orga.cod_unidad
                    WHERE orga.cod_organi = @cod_actual
                    RETURN
                END

                IF @cantidad = 1
                BEGIN
                    SELECT @rut_jefe = min(rut_person) FROM #candidatos
                    SELECT @cod_actor = min(cod_organi_actor) FROM #candidatos
                    WHERE rut_person = @rut_jefe
                    SELECT @fuente = CASE WHEN EXISTS (
                        SELECT 1 FROM #candidatos
                        WHERE rut_person = @rut_jefe AND fuente = 'AUFI_ORCO'
                    ) THEN 'AUFI_ORCO' ELSE 'AUFI_ORDE' END
                    SELECT @es_subrogante = 'S'
                    BREAK
                END

                SELECT @prioridad_anterior = @prioridad, @prioridad = NULL
                SELECT @prioridad = min(aufi.prioridad)
                FROM sisper_db.dbo.sp_aufi aufi
                WHERE aufi.cod_organi = @cod_actual
                  AND aufi.prioridad > @prioridad_anterior
            END
        END

        IF @rut_jefe IS NULL
        BEGIN
            SELECT @cod_siguiente = NULL
            SELECT @cod_siguiente = superior.cod_organi
            FROM ufro_db.dbo.es_orga actual
            INNER JOIN ufro_db.dbo.es_orga superior
              ON superior.cod_organi = actual.cod_orgjef
            WHERE actual.cod_organi = @cod_actual
              AND actual.cod_orgjef IS NOT NULL
              AND actual.cod_orgjef <> actual.cod_organi
              AND substring(superior.cod_unidad, 1, 2) = @prefijo
              AND NOT EXISTS (
                  SELECT 1 FROM #visitados v WHERE v.cod_organi = superior.cod_organi
              )
            SELECT @cod_actual = @cod_siguiente, @nivel = @nivel + 1
        END
    END

    IF @rut_jefe IS NULL
    BEGIN
        DROP TABLE #candidatos
        DROP TABLE #visitados
        SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
            @cod_unidad cod_unidad_funcionario, rtrim(@des_unidad) des_unidad_funcionario,
            convert(char(9), NULL) rut_jefe, convert(varchar(255), NULL) nombre_jefe,
            convert(int, NULL) cod_organi_jefe, convert(varchar(100), NULL) cargo_jefe,
            convert(char(8), NULL) cod_unidad_jefe, convert(varchar(100), NULL) departamento_jefe,
            'JERARQUIA' fuente_jefatura, @nivel nivel_jefatura, 'NO_ENCONTRADO' estado_resolucion,
            'No existe un ocupante vigente y unico dentro de la raiz institucional.' mensaje,
            convert(int, NULL) cod_organi_requerido, convert(int, NULL) cod_organi_actor,
            'N' es_subrogante, convert(int, NULL) prioridad_aufi,
            convert(char(9), NULL) rut_titular, convert(varchar(255), NULL) nombre_titular,
            convert(varchar(100), NULL) cargo_titular
        RETURN
    END

    SELECT @cargo_titular = rtrim(des_organi) FROM ufro_db.dbo.es_orga
    WHERE cod_organi = @cod_actual
    SELECT @cantidad = count(DISTINCT rut_person) FROM sisper_db.dbo.sp_orco
    WHERE cod_organi = @cod_actual AND vigente = 'S'
    IF @cantidad = 1
        SELECT @rut_titular = min(rut_person) FROM sisper_db.dbo.sp_orco
        WHERE cod_organi = @cod_actual AND vigente = 'S'
    IF @rut_titular IS NOT NULL
        SELECT @nombre_titular = ltrim(rtrim(isnull(nom_nombre, '') + ' ' +
            isnull(nom_appate, '') + ' ' + isnull(nom_apmate, '')))
        FROM sisper_db.dbo.sp_pers WHERE rut_person = @rut_titular

    SELECT @cargo_actor = rtrim(orga.des_organi), @unidad_actor = orga.cod_unidad,
           @departamento_actor = rtrim(unid.des_unidad)
    FROM ufro_db.dbo.es_orga orga
    LEFT JOIN ufro_db.dbo.es_unid unid ON unid.cod_unidad = orga.cod_unidad
    WHERE orga.cod_organi = @cod_actor

    DROP TABLE #candidatos
    DROP TABLE #visitados

    SELECT @rut_person rut_funcionario, @cod_contra cod_contra,
        @cod_unidad cod_unidad_funcionario, rtrim(@des_unidad) des_unidad_funcionario,
        @rut_jefe rut_jefe,
        ltrim(rtrim(isnull(pers.nom_nombre, '') + ' ' + isnull(pers.nom_appate, '') + ' ' +
                    isnull(pers.nom_apmate, ''))) nombre_jefe,
        @cod_actual cod_organi_jefe, @cargo_actor cargo_jefe,
        @unidad_actor cod_unidad_jefe, @departamento_actor departamento_jefe,
        @fuente fuente_jefatura, @nivel nivel_jefatura,
        'ENCONTRADO' estado_resolucion, convert(varchar(255), NULL) mensaje,
        @cod_actual cod_organi_requerido, @cod_actor cod_organi_actor,
        @es_subrogante es_subrogante,
        CASE WHEN @es_subrogante = 'S' THEN @prioridad ELSE NULL END prioridad_aufi,
        CASE WHEN @es_subrogante = 'S' THEN @rut_titular ELSE NULL END rut_titular,
        CASE WHEN @es_subrogante = 'S' THEN @nombre_titular ELSE NULL END nombre_titular,
        CASE WHEN @es_subrogante = 'S' THEN @cargo_titular ELSE NULL END cargo_titular
    FROM sisper_db.dbo.sp_pers pers
    WHERE pers.rut_person = @rut_jefe
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen16 TO UsuaVrac
GO
