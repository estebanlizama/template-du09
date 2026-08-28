USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_etasSecgen01'
)
    DROP PROCEDURE Analisis2.sg_etasSecgen01
GO

/* Procedimiento : Analisis2.sg_etasSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Obligatorio)
   @cod_etapa           -> Parametro de entrada. (Obligatorio)
   @cod_flusol          -> Codigo de flujo de solicitud. (Opcional)

   Objetivo : Resolver el responsable de cualquier etapa DU288 usando solo
              sg_eta1 y los maestros institucionales existentes, sin consultar
              bd_pri2 ni requerir nuevas tablas.

   Desde 2026/08/28 este procedimiento ORQUESTA tres procedimientos y ya no
   resuelve todo por si mismo:

     1. sg_prsesSecgen20  Contexto de la solicitud: flujo, centro de costo,
                          unidad institucional y prefijo. Es el unico que
                          necesita la solicitud persistida.
     2. sg_eta1sSecgen03  Politica de la etapa: perfil, organizacion
                          configurada, estrategia y si admite omitirse.
     3. sp_orcosSecgen01  Responsable vigente de una organizacion, recorriendo
                          ORCO -> ORDE -> AUFI.

   Lo que queda aca es lo que solo tiene sentido con la solicitud a la vista:
   el mapeo de organizacion por flujo y etapa, las ramas SOLICITANTE /
   JEFE_PROYECTO / JEFE_DIRECTO, la deteccion de conflicto de interes y el
   escalamiento de decanato a VRAC.

   El motivo de la separacion es que 2 y 3 no dependen de nro_solici: pueden
   invocarse para previsualizar a quien le llegara la solicitud mientras el
   usuario todavia llena el formulario. Antes toda la logica vivia aca y
   exigia la solicitud guardada incluso para la parte que no la necesitaba.

   Los tres se invocan con @solo_parametros = 'S' y devuelven por parametros
   OUTPUT: ASE 12.5 no admite INSERT ... EXEC -- se incorporo recien en ASE 15
   -- de modo que OUTPUT es la unica via para que un procedimiento consuma a
   otro sin que el resultset del llamado se filtre al cliente. Invocados
   directamente, sin esa bandera, los tres siguen entregando su resultset.

   La firma y las columnas de salida no cambiaron: el backend
   -- service-provision-request.ts -- la invoca igual que antes.

   Creacion: ELA 2026/08/24
   Actualizacion: 2026/08/28 Separacion en tres procedimientos.
*/
CREATE PROCEDURE Analisis2.sg_etasSecgen01
    @nro_solici int,
    @cod_etapa tinyint,
    @cod_flusol tinyint = NULL
AS
BEGIN
    DECLARE @cod_flusol1 tinyint
    DECLARE @cod_perfil smallint
    DECLARE @cod_respon tinyint
    DECLARE @cod_organi int
    DECLARE @cod_unidad char(8)
    DECLARE @prefijo char(2)
    DECLARE @estrategia varchar(30)
    DECLARE @perm_omitir char(1)
    DECLARE @rut_responsable char(9)
    DECLARE @fuente_resolucion varchar(20)
    DECLARE @cantidad int
    DECLARE @prioridad int
    DECLARE @cod_organi_actor int
    DECLARE @es_subrogante char(1)
    DECLARE @rut_titular char(9)
    DECLARE @nombre_titular varchar(255)
    DECLARE @cargo_titular varchar(100)
    DECLARE @estado_configuracion varchar(20)
    DECLARE @mensaje_configuracion varchar(255)
    DECLARE @conflicto_funcionario char(1)
    DECLARE @cod_organi_conflicto int
    DECLARE @cod_organi_escalado int
    DECLARE @escalado char(1)

    DECLARE @ruts_excluidos varchar(500)
    DECLARE @ctx_flusol tinyint
    DECLARE @ctx_unifin smallint
    DECLARE @ctx_ccto smallint
    DECLARE @ctx_rut_solici char(9)
    DECLARE @ctx_etapa tinyint
    DECLARE @des_etapa varchar(100)

    /* -----------------------------------------------------------------
       Contexto de la solicitud.

       sg_prsesSecgen20 entrega flujo, centro de costo, unidad y prefijo.
       Se invoca con @solo_parametros = 'S' para que no emita su resultset y
       responda solo por OUTPUT. ASE 12.5 no admite INSERT ... EXEC -- llego
       en ASE 15 -- asi que OUTPUT es la unica via para encadenar.
       ----------------------------------------------------------------- */
    EXEC Analisis2.sg_prsesSecgen20
        @nro_solici,
        @ctx_flusol OUTPUT,
        @ctx_unifin OUTPUT,
        @ctx_ccto OUTPUT,
        @cod_unidad OUTPUT,
        @prefijo OUTPUT,
        @ctx_rut_solici OUTPUT,
        @ctx_etapa OUTPUT,
        @estado_configuracion OUTPUT,
        @mensaje_configuracion OUTPUT,
        'S'

    SELECT @cod_flusol1 = ISNULL(@cod_flusol, @ctx_flusol)

    /* -----------------------------------------------------------------
       Politica de la etapa.

       sg_eta1sSecgen03 solo lee configuracion (sg_eta1): perfil,
       organizacion configurada, estrategia de resolucion y si la etapa
       admite omitirse. Al no depender de nro_solici puede invocarse para
       previsualizar el flujo antes de que la solicitud exista.
       ----------------------------------------------------------------- */
    EXEC Analisis2.sg_eta1sSecgen03
        @cod_flusol1,
        @cod_etapa,
        @cod_perfil OUTPUT,
        @cod_organi OUTPUT,
        @des_etapa OUTPUT,
        @estrategia OUTPUT,
        @perm_omitir OUTPUT,
        @estado_configuracion OUTPUT,
        @mensaje_configuracion OUTPUT,
        'S'

    IF @cod_flusol1 IS NULL OR @cod_perfil IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            CONVERT(int, NULL) AS cod_organi,
            CONVERT(tinyint, NULL) AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            CONVERT(varchar(20), NULL) AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_CONFIGURADO' AS estado_resolucion,
            'La solicitud no posee flujo o la etapa no esta vigente.' AS mensaje,
            CONVERT(varchar(30), NULL) AS estrategia_resolucion,
            CONVERT(char(1), NULL) AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    /*
       El Decano del flujo Facultad depende de la unidad financiera de la
       solicitud. Se resuelve desde es_orga y no desde un codigo institucional
       fijo en sg_eta1 ni desde una tabla CASE mantenida manualmente.
    */
    IF @estrategia = 'ORGANIZACION_FIJA'
       AND @cod_flusol1 = 1 AND @cod_etapa = 50
    BEGIN
        SELECT @cod_organi = NULL
        SELECT @cantidad = COUNT(DISTINCT orga.cod_organi)
        FROM ufro_db.dbo.es_orga orga
        WHERE orga.cod_unidad = @prefijo + '010000'
          AND orga.cod_tiporg = 1
          AND orga.cod_estame = '1'
          AND orga.por_contra = 'S'
          AND UPPER(LTRIM(RTRIM(orga.des_organi))) LIKE 'DECAN%FACULTAD%'

        IF @cantidad = 1
            SELECT @cod_organi = MIN(orga.cod_organi)
            FROM ufro_db.dbo.es_orga orga
            WHERE orga.cod_unidad = @prefijo + '010000'
              AND orga.cod_tiporg = 1
              AND orga.cod_estame = '1'
              AND orga.por_contra = 'S'
              AND UPPER(LTRIM(RTRIM(orga.des_organi))) LIKE 'DECAN%FACULTAD%'

        IF ISNULL(@cantidad, 0) = 0
            SELECT @estado_configuracion = 'NO_CONFIGURADO',
                   @mensaje_configuracion = 'No se encontro un cargo Decano vigente y unico para la Facultad de la solicitud.'

        IF @cantidad > 1
            SELECT @estado_configuracion = 'AMBIGUO',
                   @mensaje_configuracion = 'La Facultad posee mas de un cargo Decano vigente en la estructura organizacional.'
    END

    IF @estrategia = 'ORGANIZACION_FIJA' AND @cod_organi IS NULL
    BEGIN
        /* Actores que varian segun Facultad o Instituto. */
        IF @cod_flusol1 = 1 AND @cod_etapa = 40
            SELECT @cod_organi = CASE @prefijo
                WHEN '06' THEN 831
                WHEN '07' THEN 835
                WHEN '08' THEN 838
                WHEN '09' THEN 847
                WHEN '17' THEN 602
                WHEN '18' THEN 642
                ELSE NULL
            END

        IF @cod_flusol1 = 4 AND @cod_etapa = 40
            SELECT @cod_organi = CASE @cod_unidad
                WHEN '16100000' THEN 268 -- Directora Inst. Agroindustrias
                WHEN '16110000' THEN 35  -- Director Inst. Medio Ambiente (IMA)
                WHEN '16120000' THEN 297 -- Director Inst. Informatica Educativa (IIE)
                WHEN '16130000' THEN 37  -- Director Inst. Estudios Indigenas (IEI)
                WHEN '16200100' THEN 769 -- Directora BIOREN
                WHEN '16200200' THEN 771 -- Director Nucleo Cs Sociales y Humanidades
                ELSE 
                    (SELECT MIN(orga.cod_organi) 
                     FROM ufro_db.dbo.es_orga orga
                     WHERE orga.cod_unidad = @cod_unidad
                       AND orga.cod_tiporg = 1
                       AND (UPPER(orga.des_organi) LIKE 'DIRECTOR%' OR UPPER(orga.des_organi) LIKE 'DIRECTORA%'))
            END

        /* Actores institucionales fijos ya existentes en es_orga. */
        IF @cod_flusol1 = 2 AND @cod_etapa = 40 SELECT @cod_organi = 301
        IF @cod_flusol1 = 2 AND @cod_etapa = 50 SELECT @cod_organi = 299
        IF @cod_flusol1 = 3 AND @cod_etapa = 40 SELECT @cod_organi = 303
        IF @cod_flusol1 = 3 AND @cod_etapa = 50 SELECT @cod_organi = 299
        IF @cod_flusol1 = 4 AND @cod_etapa = 50 SELECT @cod_organi = 299
        IF @cod_flusol1 = 6 AND @cod_etapa = 40 SELECT @cod_organi = 17
        IF @cod_flusol1 = 7 AND @cod_etapa = 40 SELECT @cod_organi = 704
        IF @cod_flusol1 = 8 AND @cod_etapa = 40 SELECT @cod_organi = 299
    END

    SELECT @cod_respon = CASE @estrategia
        WHEN 'SOLICITANTE' THEN 1
        WHEN 'JEFE_PROYECTO' THEN 2
        WHEN 'JEFE_DIRECTO' THEN 3
        ELSE 4
    END

    IF @estrategia = 'SOLICITANTE'
    BEGIN
        /*
           Esta rama NO filtra contra sg_fups, a proposito. El solicitante no
           revisa: presenta, y su etapa es la via de devolucion a correccion.
           Descartarlo por conflicto dejaria la solicitud sin nadie que pueda
           corregirla.

           Que el solicitante no sea funcionario se garantiza aguas arriba, al
           incorporarlo: validateNormativeRequestStaff rechaza esa combinacion
           con DU288_APPLICANT_IS_STAFF.
        */
        SELECT @rut_responsable = @ctx_rut_solici

        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            @rut_responsable AS rut_responsable,
            'SOLICITANTE' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            CASE WHEN @rut_responsable IS NULL THEN 'NO_ENCONTRADO' ELSE 'ENCONTRADO' END AS estado_resolucion,
            CASE WHEN @rut_responsable IS NULL THEN 'La solicitud no posee RUT solicitante.' ELSE NULL END AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    IF @estrategia = 'JEFE_PROYECTO'
    BEGIN
        /*
           El Jefe de Proyecto se excluye si es funcionario de la prestacion,
           igual que en las etapas de organizacion. Antes se devolvia el RUT
           sin filtrar y el bloqueo lo hacia el backend, que no distingue esta
           causa de un dato faltante: la pantalla decia lo mismo si no habia
           jefe de proyecto cargado que si el jefe era el propio prestador.
        */
        SELECT @conflicto_funcionario = 'N'
        SELECT @rut_responsable = prse.rut_jefpro
        FROM dbo.sg_prse prse
        WHERE prse.nro_solici = @nro_solici

        IF @rut_responsable IS NOT NULL
           AND EXISTS (SELECT 1 FROM dbo.sg_fups f
                       WHERE f.nro_solici = @nro_solici
                         AND f.rut = @rut_responsable)
        BEGIN
            SELECT @conflicto_funcionario = 'S'
            SELECT @rut_responsable = NULL
        END

        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            @rut_responsable AS rut_responsable,
            'JEFE_PROYECTO' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            CASE WHEN @rut_responsable IS NULL THEN 'NO_ENCONTRADO' ELSE 'ENCONTRADO' END AS estado_resolucion,
            CASE
                WHEN @conflicto_funcionario = 'S'
                THEN 'El Jefe de Proyecto es el funcionario de la prestacion y no puede revisar su propia solicitud.'
                WHEN @rut_responsable IS NULL
                THEN 'La solicitud no posee Jefe de Proyecto.'
                ELSE NULL END AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    IF @estrategia = 'JEFE_DIRECTO'
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            fups.id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'JEFATURA_DIRECTA' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            CASE
                WHEN fups.dentro_jor = 'N' THEN 'OMITIR_FUERA_JORNADA'
                WHEN fups.dentro_jor IN ('S', 'D') THEN 'RESOLVER_JEFATURA'
                ELSE 'JORNADA_NO_DEFINIDA'
            END AS estado_resolucion,
            CASE
                WHEN fups.dentro_jor = 'N'
                    THEN 'La jefatura directa no participa porque la prestacion se realizara fuera de la jornada laboral.'
                WHEN fups.dentro_jor NOT IN ('S', 'D') OR fups.dentro_jor IS NULL
                    THEN 'No fue posible determinar la condicion de jornada del funcionario.'
                ELSE CONVERT(varchar(255), NULL)
            END AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto,
            fups.rut AS rut_funcionario,
            fups.cod_contra,
            fups.dentro_jor
        FROM dbo.sg_fups fups
        WHERE fups.nro_solici = @nro_solici
        ORDER BY fups.id_funprse
        RETURN
    END

    IF @cod_organi IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'CONFIGURACION' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            ISNULL(@estado_configuracion, 'NO_CONFIGURADO') AS estado_resolucion,
            ISNULL(@mensaje_configuracion,
                'La etapa requiere una organizacion configurada para la unidad institucional.') AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    SELECT @conflicto_funcionario = 'N'
    SELECT @escalado = 'N'
    IF EXISTS (
        SELECT 1
        FROM sisper_db.dbo.sp_orco orco
        INNER JOIN dbo.sg_fups f
          ON f.nro_solici = @nro_solici AND f.rut = orco.rut_person
        WHERE orco.cod_organi = @cod_organi
          AND orco.vigente = 'S'
    )
        SELECT @conflicto_funcionario = 'S'

    /*
       Escalamiento por conflicto de interes.

       El titular de la organizacion es el funcionario de la prestacion. No
       puede visar su propia solicitud, y buscar su reemplazo por AUFI
       devolveria a un subordinado -- para un decanato, el Vicedecano.

       Cuando existe una regla de escalamiento vigente, la etapa se resuelve
       contra la organizacion revisora en lugar de la original. A partir de
       ahi corre la cadena ORCO -> ORDE -> AUFI normal de esa organizacion.

       El escalamiento no se encadena: si la organizacion escalada tampoco
       resuelve, la etapa queda bloqueada. Nunca se autoaprueba ni se omite.

       Sobre las columnas de salida: cod_organi_requerido sigue siendo la
       organizacion contra la que se resolvio, y cod_organi_actor de donde
       proviene la persona. Esa semantica es la que usa la subrogancia AUFI y
       no se toca. La organizacion en conflicto se informa aparte, en
       cod_organi_conflicto, para no perder ningun eslabon de la cadena
       cuando ademas hay subrogancia: decanato -> VRAC -> subrogante del VRAC.
    */
    /*
       Equivalencias de escalamiento.

       Antes vivian en una tabla propia (secgen_db.dbo.sg_escl) que habia que
       crear y cargar aparte. Son cuatro filas que no cambian: los cuatro
       decanatos escalan al VRAC (organizacion 17). Se resuelven aca para no
       agregar una tabla al esquema por un dato fijo.

       Se listan explicitamente y no por patron de codigo: una facultad nueva
       debe agregarse a mano y quedar visible en este CASE, no resolverse por
       coincidencia de prefijo.

       Aplica SOLO a esta etapa (la de Decano). La etapa de Jefe Directo
       Funcionario -- sg_fupssSecgen16 -- no escala: ahi es correcto que la
       visacion la haga un subordinado (el Vicedecano por AUFI). El superior
       estricto del decano es el VRAC y eso se resuelve aca.

       Tras escalar, corre la cadena ORCO -> ORDE -> AUFI normal del VRAC: si
       no hay titular vigente, AUFI entrega su subrogante.

       Si se agrega una facultad, agregarla a este CASE. Es el unico lugar
       donde vive la regla.
    */
    IF @conflicto_funcionario = 'S'
    BEGIN
        SELECT @cod_organi_escalado = CASE @cod_organi
            WHEN 82  THEN 17   /* Decano Facultad de Medicina                        -> VRAC */
            WHEN 135 THEN 17   /* Decano Facultad de Ingenieria, Ciencias y Admin.   -> VRAC */
            WHEN 204 THEN 17   /* Decano Facultad de Educacion y Humanidades         -> VRAC */
            WHEN 248 THEN 17   /* Decano Facultad de Ciencias Agropecuarias          -> VRAC */
            ELSE NULL
        END

        IF @cod_organi_escalado IS NOT NULL AND @cod_organi_escalado <> @cod_organi
        BEGIN
            SELECT @cod_organi_conflicto = @cod_organi
            SELECT @cod_organi = @cod_organi_escalado
            SELECT @escalado = 'S'

            /* Se reevalua el conflicto contra la organizacion escalada: si el
               funcionario tambien fuera su titular, no hay a quien recurrir. */
            SELECT @conflicto_funcionario = 'N'
            IF EXISTS (
                SELECT 1
                FROM sisper_db.dbo.sp_orco orco
                INNER JOIN dbo.sg_fups f
                  ON f.nro_solici = @nro_solici AND f.rut = orco.rut_person
                WHERE orco.cod_organi = @cod_organi
                  AND orco.vigente = 'S'
            )
                SELECT @conflicto_funcionario = 'S'
        END
    END

    /* -----------------------------------------------------------------
       Resolucion del responsable.

       sp_orcosSecgen01 recorre la cadena ORCO -> ORDE -> AUFI contra
       @cod_organi -- ya escalada si hubo conflicto -- y corta como AMBIGUO
       cuando un nivel ofrece mas de un candidato distinto.

       Los funcionarios de la prestacion se pasan como lista de exclusion en
       lugar de que el procedimiento lea sg_fups: asi la resolucion de actor
       no depende de que la solicitud este guardada.
       ----------------------------------------------------------------- */
    SELECT @ruts_excluidos = ''
    SELECT @ruts_excluidos = @ruts_excluidos + RTRIM(f.rut) + ','
    FROM dbo.sg_fups f
    WHERE f.nro_solici = @nro_solici

    EXEC Analisis2.sp_orcosSecgen01
        @cod_organi,
        @ruts_excluidos,
        @rut_responsable OUTPUT,
        @cod_organi_actor OUTPUT,
        @fuente_resolucion OUTPUT,
        @es_subrogante OUTPUT,
        @prioridad OUTPUT,
        @estado_configuracion OUTPUT,
        @mensaje_configuracion OUTPUT,
        'S'

    SELECT @es_subrogante = ISNULL(@es_subrogante, 'N')

    IF @estado_configuracion = 'AMBIGUO'
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol, @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil, @cod_organi AS cod_organi,
            @cod_respon AS cod_respon, CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            @fuente_resolucion AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'AMBIGUO' AS estado_resolucion,
            @mensaje_configuracion AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END

    IF @rut_responsable IS NULL
    BEGIN
        SELECT
            @cod_flusol1 AS cod_flusol,
            @cod_etapa AS cod_etapa,
            @cod_perfil AS cod_perfil,
            @cod_organi AS cod_organi,
            @cod_respon AS cod_respon,
            CONVERT(int, NULL) AS id_funprse,
            CONVERT(char(9), NULL) AS rut_responsable,
            'ORGANIZACION' AS fuente_resolucion,
            CONVERT(varchar(255), NULL) AS nombre_responsable,
            CONVERT(varchar(100), NULL) AS cargo_responsable,
            'NO_ENCONTRADO' AS estado_resolucion,
            CASE
                 WHEN @escalado = 'S'
                 THEN 'El titular del cargo es el funcionario de la prestacion. Se escalo a la jefatura definida, que tampoco tiene responsable vigente para revisar.'
                 WHEN @conflicto_funcionario = 'S'
                 THEN 'El titular del cargo es el funcionario de la prestacion y no existe otro responsable vigente para revisar.'
                 ELSE 'No existe titular ni subrogante vigente para la organizacion.' END AS mensaje,
            @estrategia AS estrategia_resolucion,
            @perm_omitir AS permite_omision,
            @cod_unidad AS cod_unidad_contexto
        RETURN
    END
    IF @es_subrogante = 'S'
    BEGIN
        SELECT @cargo_titular = RTRIM(des_organi)
        FROM ufro_db.dbo.es_orga
        WHERE cod_organi = @cod_organi

        SELECT @cantidad = COUNT(DISTINCT rut_person)
        FROM sisper_db.dbo.sp_orco
        WHERE cod_organi = @cod_organi AND vigente = 'S'

        IF @cantidad = 1
            SELECT @rut_titular = MIN(rut_person)
            FROM sisper_db.dbo.sp_orco
            WHERE cod_organi = @cod_organi AND vigente = 'S'

        IF @rut_titular IS NOT NULL
            SELECT @nombre_titular = LTRIM(RTRIM(
                ISNULL(nom_nombre, '') + ' ' + ISNULL(nom_appate, '') + ' ' +
                ISNULL(nom_apmate, '')
            ))
            FROM sisper_db.dbo.sp_pers
            WHERE rut_person = @rut_titular
    END


    SELECT
        @cod_flusol1 AS cod_flusol,
        @cod_etapa AS cod_etapa,
        @cod_perfil AS cod_perfil,
        @cod_organi AS cod_organi,
        @cod_respon AS cod_respon,
        CONVERT(int, NULL) AS id_funprse,
        @rut_responsable AS rut_responsable,
        @fuente_resolucion AS fuente_resolucion,
        RTRIM(LTRIM(
            ISNULL(
                CASE
                    WHEN LEN(ISNULL(per.nom_dest, '')) <= 1 THEN per.nom_nombre
                    ELSE per.nom_dest
                END,
                ''
            ) + ' ' + ISNULL(per.nom_appate, '') + ' ' + ISNULL(per.nom_apmate, '')
        )) AS nombre_responsable,
        RTRIM(org.des_organi) AS cargo_responsable,
        org.cod_unidad AS cod_unidad_responsable,
        RTRIM(unid.des_unidad) AS departamento_responsable,
        'ENCONTRADO' AS estado_resolucion,
        CASE WHEN @escalado = 'S'
             THEN 'El titular del cargo es el funcionario de la prestacion. Revisa la jefatura definida para ese cargo.'
             ELSE CONVERT(varchar(255), NULL) END AS mensaje,
        @estrategia AS estrategia_resolucion,
        @perm_omitir AS permite_omision,
        @cod_unidad AS cod_unidad_contexto,
        @cod_organi AS cod_organi_requerido,
        @cod_organi_actor AS cod_organi_actor,
        @cod_organi_conflicto AS cod_organi_conflicto,
        @escalado AS es_escalado,
        ISNULL(@es_subrogante, 'N') AS es_subrogante,
        CASE WHEN @es_subrogante = 'S' THEN @prioridad ELSE NULL END AS prioridad_aufi,
        CASE WHEN @es_subrogante = 'S' THEN @rut_titular ELSE NULL END AS rut_titular,
        CASE WHEN @es_subrogante = 'S' THEN @nombre_titular ELSE NULL END AS nombre_titular,
        CASE WHEN @es_subrogante = 'S' THEN @cargo_titular ELSE NULL END AS cargo_titular
    FROM sisper_db..sp_pers per
    LEFT JOIN ufro_db..es_orga org
        ON org.cod_organi = @cod_organi_actor
    LEFT JOIN ufro_db..es_unid unid
        ON unid.cod_unidad = org.cod_unidad
    WHERE per.rut_person = @rut_responsable
END
GO

GRANT EXECUTE ON Analisis2.sg_etasSecgen01 TO UsuaVrac
GO
