USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_cargsSecgen01')
    DROP PROCEDURE Analisis2.sg_cargsSecgen01
GO

/* Procedimiento : Analisis2.sg_cargsSecgen01
   Objetivo      : Retorna los cargos directivos (cod_tipcar = 5) inhabilitados para DU288.
                   Cuando ind_anid = 'S', el cargo 3110 (DECANO DE FACULTAD) queda habilitado
                   como excepción ANID. Los demás cargos tipo 5 permanecen inhabilitados.
   Entrada       :
       @ind_anid    char(1)  = 'N'  -- Indicador ANID del centro de costo (S/N)
       @cod_modprs  tinyint  = 2    -- Modalidad de prestación (solo aplica para DU288)
   Salida        :
       cod_cargo    int            -- Código del cargo
       nom_cargo    varchar(...)   -- Nombre del cargo
       cod_tipcar   char(1)        -- Tipo de cargo (5 = directivo)
       cod_jerpla   char(2)        -- Jerarquía de planta
       cod_modprs   tinyint        -- Modalidad (siempre 2 en resultado)
       inhabilitado bit            -- 1 = inhabilitado para DU288
       motivo       varchar(255)   -- Razón de inhabilitación
   Creación      : 2026-06-24
   Modificación  : 2026-06-24
*/
CREATE PROCEDURE Analisis2.sg_cargsSecgen01
    @ind_anid   char(1)  = 'N',
    @cod_modprs tinyint  = 2
AS
BEGIN
    -- Normalizar @ind_anid a valores válidos
    SELECT @ind_anid = UPPER(LTRIM(RTRIM(ISNULL(@ind_anid, 'N'))))

    IF @ind_anid NOT IN ('S', 'N')
    BEGIN
        SELECT 'Indicador ANID no valido' AS msg
        RETURN
    END

    -- Validar que la modalidad exista en sg_tmod (solo DU288 aplica esta regla)
    IF NOT EXISTS (SELECT 1 FROM secgen_db.dbo.sg_tmod WHERE CONVERT(int, cod_modprs) = @cod_modprs)
    BEGIN
        SELECT 'Modalidad no válida' AS msg
        RETURN
    END

    -- Consultar cargos directivos inhabilitados para DU288:
    --   - cod_tipcar = 5 (directivos)
    --   - vigente = 1
    --   - Excluir cod_cargo = 3110 únicamente si @ind_anid = 'S' (excepción ANID)
    SELECT
        c.cod_cargo,
        c.nom_cargo,
        c.cod_tipcar,
        c.cod_jerpla,
        @cod_modprs AS cod_modprs,
        1           AS inhabilitado,
        CASE
            WHEN CONVERT(int, c.cod_cargo) = 3110 AND @ind_anid = 'N'
                THEN 'Cargo DECANO DE FACULTAD no habilitado para DU288 (sin excepción ANID)'
            ELSE
                'Cargo directivo inhabilitado para DU288 según normativa'
        END AS motivo
    FROM sisper_db.dbo.sp_carg c
    WHERE c.cod_tipcar = '5'
      AND c.vigente    = '1'
      AND NOT (
          @ind_anid = 'S'
          AND CONVERT(int, c.cod_cargo) = 3110
      )
    ORDER BY c.cod_cargo
END
GO

GRANT EXECUTE ON Analisis2.sg_cargsSecgen01 TO UsuaVrac
GO
