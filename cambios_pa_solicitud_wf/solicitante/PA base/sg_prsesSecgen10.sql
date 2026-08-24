use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_prsesSecgen10')
   drop procedure Analisis2.sg_prsesSecgen10
go

/* Procedimiento : sg_prsesSecgen10

   Entrada :
   @cod_tipsol          -> Tipo de solicitud. (Opcional)

   Objetivo : select Prestación de servicios

   Creacion: CHL 2022/12/27
   Actualizacion: 
*/

create procedure  Analisis2.sg_prsesSecgen10
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

grant execute on Analisis2.sg_prsesSecgen10 to UsuaVrac
go

--grant execute on Analisis2.sg_prsesSecgen10 to UsuaVrac2
--go
