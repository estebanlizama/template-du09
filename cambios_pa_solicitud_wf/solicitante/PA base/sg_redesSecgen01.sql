use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_redesSecgen01')
   drop procedure Analisis2.sg_redesSecgen01
go

/* Procedimiento : sg_redesSecgen01

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Obligatorio)

   Objetivo : select Detalle de resolución

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/13
*/

create procedure  Analisis2.sg_redesSecgen01
    @nro_resolu int = None
    as

    if @nro_resolu is null
    begin
        select 'Falta campo Numero Resolucion' msg
        return
    end

    begin tran

    SELECT  rede.id_resdet,
        rede.ano_resolu,
        rede.nro_resolu,
        rede.id_pladet,
        rede.cod_tipsec,
        rede.nombre,
        rede.valor,
        rede.editable,
        rede.orden,
        rede.f_creacion,
        rede.f_ultmodif
        FROM sg_rede as rede
        WHERE rede.nro_resolu = @nro_resolu
        commit tran
go

grant execute on Analisis2.sg_redesSecgen01 to UsuaVrac
go
