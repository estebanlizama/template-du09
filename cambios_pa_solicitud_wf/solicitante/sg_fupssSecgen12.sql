USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen12')
    DROP PROCEDURE Analisis2.sg_fupssSecgen12
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen12
Objetivo      : Verificar si el funcionario tiene parentesco activo con el jefe de proyecto.
Parametros    :
    @rut_funcionario char(9) : RUT del funcionario.
    @rut_jefpro      char(9) : RUT del jefe de proyecto.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen12
    @rut_funcionario char(9) = NULL,
    @rut_jefpro      char(9) = NULL
AS
BEGIN
    IF @rut_funcionario IS NULL OR @rut_jefpro IS NULL
    BEGIN
        SELECT 
            @rut_funcionario AS rut_funcionario,
            @rut_jefpro AS rut_jefpro,
            'N' AS tiene_parentesco,
            NULL AS cod_parent,
            NULL AS rut_parent,
            NULL AS nombre_parent,
            'N' AS requiere_constancia,
            'RUTs de entrada inválidos' AS mensaje
        RETURN
    END

    -- Intentar obtener la relación activa de parentesco
    IF EXISTS (
        SELECT 1 
        FROM sisper_db.dbo.sp_par2
        WHERE vigente = 'S'
          AND (
                (rut_person = @rut_jefpro AND rut_parent = @rut_funcionario)
             OR (rut_person = @rut_funcionario AND rut_parent = @rut_jefpro)
          )
    )
    BEGIN
        SELECT
            @rut_funcionario AS rut_funcionario,
            @rut_jefpro AS rut_jefpro,
            'S' AS tiene_parentesco,
            p2.cod_parent,
            p2.rut_parent,
            rtrim(p1.nombres) + ' ' + rtrim(p1.ap_paterno) + ' ' + rtrim(p1.ap_materno) AS nombre_parent,
            'S' AS requiere_constancia,
            'Funcionario registra parentesco con jefe de proyecto. Requiere constancia/autorización en etapa de aprobación.' AS mensaje
        FROM sisper_db.dbo.sp_par2 p2
        LEFT JOIN sisper_db.dbo.sp_par1 p1 ON p1.rut_parent = p2.rut_parent
        WHERE p2.vigente = 'S'
          AND (
                (p2.rut_person = @rut_jefpro AND p2.rut_parent = @rut_funcionario)
             OR (p2.rut_person = @rut_funcionario AND p2.rut_parent = @rut_jefpro)
          )
    END
    ELSE
    BEGIN
        SELECT 
            @rut_funcionario AS rut_funcionario,
            @rut_jefpro AS rut_jefpro,
            'N' AS tiene_parentesco,
            NULL AS cod_parent,
            NULL AS rut_parent,
            NULL AS nombre_parent,
            'N' AS requiere_constancia,
            NULL AS mensaje
    END
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen12 TO UsuaVrac
GO
