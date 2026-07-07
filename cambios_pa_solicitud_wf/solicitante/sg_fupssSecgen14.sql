USE secgen_db
GO

IF EXISTS (
    SELECT 1
      FROM sysobjects a, sysusers b
     WHERE a.uid = b.uid
       AND a.type = 'P'
       AND b.name = 'Analisis2'
       AND a.name = 'sg_fupssSecgen14'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen14
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen14
Objetivo      : Validar si el contrato evaluado para DU288 queda habilitado o no
                segun calidad juridica, cargo y contexto ANID/externo.
Parametros    :
    @rut_person  char(9)   : RUT del funcionario.
    @id_contrato int       : Contrato evaluado desde sg_fupssSecgen13.
    @cod_cargo   int       : Codigo del cargo evaluado.
    @cod_unidad  varchar(8): Unidad del contrato evaluado.
    @cod_calida  varchar(2): Calidad juridica del contrato evaluado.
    @ind_anid    char(1)   : Indicador ANID/externo ('S'/'N'). Default 'N'.

Retorna       :
    habilitado_du288 : 'S' = habilitado, 'N' = inhabilitado

Creacion      : EL 2026/07/03
Normalizacion : 2026/07/03
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen14
    @rut_person  char(9),
    @id_contrato int = 0,
    @cod_cargo   int = 0,
    @cod_unidad  varchar(8) = '',
    @cod_calida  varchar(2) = '',
    @ind_anid    char(1) = 'N'
AS
BEGIN
    DECLARE @habilitado_du288 char(1)

    SELECT @habilitado_du288 = 'S'

    SELECT @ind_anid = UPPER(LTRIM(RTRIM(ISNULL(@ind_anid, 'N'))))
    IF @ind_anid NOT IN ('S', 'N')
        SELECT @ind_anid = 'N'

    IF LTRIM(RTRIM(ISNULL(@cod_calida, ''))) = '01'
    BEGIN
        SELECT @habilitado_du288 = 'N'
    END
    ELSE IF EXISTS (
        SELECT 1
          FROM sisper_db.dbo.sp_carg c
         WHERE c.cod_cargo = @cod_cargo
           AND c.cod_tipcar = '5'
           AND c.vigente = '1'
    )
    BEGIN
        SELECT @habilitado_du288 = 'N'
    END

    IF @ind_anid = 'S' AND @cod_cargo = 3110
    BEGIN
        SELECT @habilitado_du288 = 'S'
    END

    SELECT @habilitado_du288 AS habilitado_du288
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen14 TO UsuaVrac
GO
