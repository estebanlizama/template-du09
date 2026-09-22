USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_fuhosiSecgen01'
)
    DROP PROCEDURE Analisis2.sg_fuhosiSecgen01
GO

/* Procedimiento : Analisis2.sg_fuhosiSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Obligatorio)
   @cod_diasem          -> Parametro de entrada. (Obligatorio)
   @correlativ          -> Parametro de entrada. (Obligatorio)
   @hora_ini            -> Parametro de entrada. (Obligatorio)
   @hora_ter            -> Parametro de entrada. (Obligatorio)

   Objetivo : Registrar un tramo horario de ejecucion para una prestacion de
              servicios.

   Creacion: ELA 2026/08/24
   Actualizacion: 2026/09/07 - Soporte de tramos que terminan al dia siguiente.
                  2026/09/21 - ADR-024: se habilitan sabado (6) y domingo (7)
                  como dias de ejecucion y se permite cualquier cruce de
                  medianoche, incluido domingo a lunes.
*/
CREATE PROCEDURE Analisis2.sg_fuhosiSecgen01
    @id_funprse int,
    @cod_diasem tinyint,
    @correlativ tinyint,
    @hora_ini   varchar(8),
    @hora_ter   varchar(8)
AS
BEGIN
    IF @id_funprse IS NULL OR @cod_diasem IS NULL OR @correlativ IS NULL OR @hora_ini IS NULL OR @hora_ter IS NULL
    BEGIN
        SELECT 'Parametros requeridos incompletos' AS msg
        RETURN
    END

    IF @cod_diasem < 1 OR @cod_diasem > 7
    BEGIN
        SELECT 'Error: el dia de ejecucion debe estar entre lunes y domingo' AS msg
        RETURN
    END

    IF convert(time, @hora_ini) = convert(time, @hora_ter)
    BEGIN
        SELECT 'Error: la hora de inicio y termino deben ser distintas' AS msg
        RETURN
    END

    /* Si hora_ter es menor, el tramo termina al dia siguiente. ADR-024 admite
       cualquier cruce de medianoche; el tramo iniciado el domingo continua el
       lunes. sg_fuho guarda solo el dia de inicio, asi que el segundo segmento
       lo derivan backend y frontend al proyectar por fecha. */

    INSERT INTO secgen_db.dbo.sg_fuho (
        id_funprse,
        cod_diasem,
        correlativ,
        hora_ini,
        hora_ter
    ) VALUES (
        @id_funprse,
        @cod_diasem,
        @correlativ,
        convert(time, @hora_ini),
        convert(time, @hora_ter)
    )

    SELECT 'OK' AS status
END
GO

GRANT EXECUTE ON Analisis2.sg_fuhosiSecgen01 TO UsuaVrac
GO
