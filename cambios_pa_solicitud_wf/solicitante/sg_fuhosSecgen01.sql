USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fuhosSecgen01')
    DROP PROCEDURE Analisis2.sg_fuhosSecgen01
GO

/* Procedimiento : Analisis2.sg_fuhosSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @id_funprse          -> Identificador de la funcion/prestacion. (Opcional)

   Objetivo : Retorna la distribución de horarios de ejecución de prestación (sg_fuho) para los funcionarios de una solicitud o por funcionario especifico. Entrada       : @nro_solici int (opcional) @id_funprse int (opcional) Salida        : id_funprse  int cod_diasem  tinyint correlativ  tinyint hora_ini    varchar(8) hora_ter    varchar(8)

   Creacion: Sin registro
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fuhosSecgen01
    @nro_solici int = NULL,
    @id_funprse int = NULL
AS
BEGIN
    IF @nro_solici IS NULL AND @id_funprse IS NULL
    BEGIN
        SELECT 'Debe especificar nro_solici o id_funprse' AS msg
        RETURN
    END

    SELECT 
        fh.id_funprse,
        fh.cod_diasem,
        fh.correlativ,
        convert(varchar(8), fh.hora_ini, 108) AS hora_ini,
        convert(varchar(8), fh.hora_ter, 108) AS hora_ter
    FROM secgen_db.dbo.sg_fuho fh
    INNER JOIN secgen_db.dbo.sg_fups fu ON fh.id_funprse = fu.id_funprse
    WHERE (@nro_solici IS NULL OR fu.nro_solici = @nro_solici)
      AND (@id_funprse IS NULL OR fh.id_funprse = @id_funprse)
    ORDER BY fh.id_funprse, fh.cod_diasem, fh.correlativ
END
GO

GRANT EXECUTE ON Analisis2.sg_fuhosSecgen01 TO UsuaVrac
GO
