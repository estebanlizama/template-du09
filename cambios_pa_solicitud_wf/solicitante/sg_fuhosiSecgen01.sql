USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fuhosiSecgen01')
    DROP PROCEDURE Analisis2.sg_fuhosiSecgen01
GO

/* Procedimiento : Analisis2.sg_fuhosiSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Obligatorio)
   @cod_diasem          -> Parametro de entrada. (Obligatorio)
   @correlativ          -> Parametro de entrada. (Obligatorio)
   @hora_ini            -> Parametro de entrada. (Obligatorio)
   @hora_ter            -> Parametro de entrada. (Obligatorio)

   Objetivo : Inserta un tramo de horario de ejecucion de prestacion en sg_fuho.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
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
