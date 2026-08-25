USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen10'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen10
GO

/* Procedimiento : Analisis2.sg_prsesSecgen10

   Entrada :
   @cod_tipsol          -> Tipo de solicitud. (Opcional)

   Objetivo : Consultar detalle de prestacion de servicios para seguimiento.

   Creacion: CHL 2022/12/27
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen10
    @cod_tipsol tinyint = NULL
    as

    if @cod_tipsol is null
    begin
        select 'Falta campo Rut Solicitud' msg
        return
    end
        SELECT
            plre.id_planti,
            plre.nombre AS plre_nombre,
            plre.vigente,
            plre.cod_tipsol,
            plde.cod_tipsec,
            plde.nombre AS plde_nombre,
            plde.valor,
            plde.editable,
            plde.orden,
            plse.des_tipsec
        FROM
            secgen_db.dbo.sg_plre plre
        INNER JOIN secgen_db.dbo.sg_plde plde ON            (plre.id_planti = plde.id_planti)
        INNER JOIN secgen_db.dbo.sg_plse plse ON            (plse.cod_tipsec = plde.cod_tipsec)
        WHERE
            plre.cod_tipsol = @cod_tipsol

go

GRANT EXECUTE ON Analisis2.sg_prsesSecgen10 TO UsuaVrac
go

--grant execute on Analisis2.sg_prsesSecgen10 to UsuaVrac2
--go
