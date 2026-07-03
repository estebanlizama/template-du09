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
Objetivo      : Resolver el estado normativo DU288 del funcionario para la solicitud PDS.
                Esta capa complementa a sg_fupssSecgen13, que entrega el contrato
                y los datos laborales base evaluados.
Parametros    :
    @rut_person char(9)   : RUT del funcionario.
    @cod_cargo  int       : Código del cargo evaluado.
    @cod_calida varchar(2): Código de calidad jurídica evaluada.
    @ind_anid   char(1)   : Indicador ANID del centro de costo ('S'/'N'). Default 'N'.

Retorna       :
    habilitado_du288          : 1 = habilitado, 0 = inhabilitado
    motivo_inhab              : motivo normativo del resultado
    ignora_tope_du288         : 1 = ignora topes institucionales, 0 = respeta topes
    permite_mas_de_dos_meses  : 1 = permite más de 2 meses, 0 = no permite
    tipo_excepcion            : código de excepción aplicada

Creacion      : EL 2026/07/03
Normalizacion : 2026/07/03
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen14
    @rut_person char(9),
    @cod_cargo  int,
    @cod_calida varchar(2),
    @ind_anid   char(1) = 'N'
AS
BEGIN
    DECLARE @habilitado_du288 char(1)
    DECLARE @motivo_inhab varchar(255)
    DECLARE @ignora_tope_du288 char(1)
    DECLARE @permite_mas_de_dos_meses char(1)
    DECLARE @tipo_excepcion varchar(50)

    SELECT @habilitado_du288 = '1',
           @motivo_inhab = NULL,
           @ignora_tope_du288 = '0',
           @permite_mas_de_dos_meses = '0',
           @tipo_excepcion = 'NINGUNA'

    SELECT @ind_anid = UPPER(LTRIM(RTRIM(ISNULL(@ind_anid, 'N'))))
    IF @ind_anid NOT IN ('S', 'N')
        SELECT @ind_anid = 'N'

    IF @cod_calida IN ('07', '0')
    BEGIN
        SELECT @habilitado_du288 = '0',
               @motivo_inhab = 'Contrato de honorarios no habilitado para DU288'
    END
    ELSE IF EXISTS (
        SELECT 1
          FROM sisper_db.dbo.sp_carg c
         WHERE c.cod_cargo = @cod_cargo
           AND c.cod_tipcar = '5'
           AND c.vigente = '1'
    )
    BEGIN
        SELECT @habilitado_du288 = '0',
               @motivo_inhab = 'Cargo directivo inhabilitado para DU288 segun normativa'
    END

    IF @ind_anid = 'S'
    BEGIN
        SELECT @ignora_tope_du288 = '1',
               @permite_mas_de_dos_meses = '1'

        IF @cod_cargo = 3110
        BEGIN
            SELECT @habilitado_du288 = '1',
                   @motivo_inhab = 'Habilitado excepcionalmente por proyecto externo ANID',
                   @tipo_excepcion = 'ANID_DECANO'
        END
    END

    IF @habilitado_du288 = '1' AND @motivo_inhab IS NULL
    BEGIN
        SELECT @motivo_inhab = 'Funcionario habilitado'
    END

    SELECT @habilitado_du288 AS habilitado_du288,
           @motivo_inhab AS motivo_inhab,
           @ignora_tope_du288 AS ignora_tope_du288,
           @permite_mas_de_dos_meses AS permite_mas_de_dos_meses,
           @tipo_excepcion AS tipo_excepcion
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen14 TO UsuaVrac
GO
