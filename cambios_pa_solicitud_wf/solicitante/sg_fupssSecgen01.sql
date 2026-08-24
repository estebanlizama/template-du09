USE secgen_db
GO

IF EXISTS (SELECT 1 FROM sysobjects a, sysusers b
           WHERE a.uid = b.uid AND a.type = 'P'
           AND b.name = 'Analisis2' AND a.name = 'sg_fupssSecgen01')
    DROP PROCEDURE Analisis2.sg_fupssSecgen01
GO

/* Procedimiento : Analisis2.sg_fupssSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Opcional)

   Objetivo : Seleccionar un funcionario específico por id_funprse, incluyendo campos legacy y nuevos campos DU288 de sg_fups.

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_fupssSecgen01
    @id_funprse int = NULL
AS
BEGIN
    IF @id_funprse IS NULL
    BEGIN
        SELECT 'Falta campo Id Funcionarios prestación de servicios' AS msg
        RETURN
    END

    SELECT
        id_funprse,
        nro_solici,
        rut,
        cod_cargo,
        cod_sitm,
        itm_global,
        motivo,
        periodos,
        monto_mes,
        mto_total,
        cod_moneda,
        cod_tpps,
        f_inicio,
        f_termino,
        cod_estfun,
        dentro_jor,
        cod_contra,
        mes_haber,
        ano_haber,
        mto_haber,
        mto_tope,
        f_cal_tope,
        tot_cuotas
    FROM
        sg_fups
    WHERE
        id_funprse = @id_funprse
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen01 TO UsuaVrac
GO
