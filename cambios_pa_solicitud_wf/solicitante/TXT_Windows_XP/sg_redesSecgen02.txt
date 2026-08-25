use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_redesSecgen02')
   drop procedure Analisis2.sg_redesSecgen02
go

/* Procedimiento : sg_redesSecgen02

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @cod_tipsec          -> Parametro de entrada. (Opcional)

   Objetivo : select Detalle de resolución

   Creacion: AI 2023/05/29
   Actualizacion: 
*/

create procedure  Analisis2.sg_redesSecgen02
    @nro_resolu int = null,
    @cod_tipsec int = null
    as

    if @nro_resolu is null
    begin
        select 'Falta campo Numero Resolucion' msg
        return
    end
     if @cod_tipsec is null
    begin
        select 'Falta campo codigo de tipo de seccion' msg
        return
    end

    begin tran

    SELECT rd.id_resdet,
        rd.ano_resolu,
       rd.nro_resolu,
        rd.id_pladet,
        rd.cod_tipsec,
       rd.nombre,
        rd.valor,
        rd.editable,
        rd.orden,
        rd.f_creacion,
        rd.f_ultmodif
  FROM secgen_db.dbo.sg_rede rd
  JOIN secgen_db.dbo.sg_plse ps
  ON rd.cod_tipsec = ps.cod_tipsec AND ps.cod_tipsec = @cod_tipsec
  WHERE rd.nro_resolu = @nro_resolu
        commit tran
go

grant execute on Analisis2.sg_redesSecgen02 to UsuaVrac
go
