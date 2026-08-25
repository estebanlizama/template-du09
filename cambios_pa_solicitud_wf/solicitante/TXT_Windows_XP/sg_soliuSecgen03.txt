use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_soliuSecgen03')
   drop procedure Analisis2.sg_soliuSecgen03
go

/* Procedimiento : sg_soliuSecgen03

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @ano_resolu          -> Parametro de entrada. (Opcional)

   Objetivo : Update datos de resolución

   Creacion: AI 2023/02/03
   Actualizacion: 
*/

create procedure  Analisis2.sg_soliuSecgen03
    @nro_solici int = NULL,
    @nro_resolu int = NULL,
    @ano_resolu smallint = NULL
    as

    if @nro_solici is null
    begin
        select 'Falta campo Numero Solicitud' msg
        return
    end

    if @nro_resolu is null
    begin
        select 'Falta campo numero de resolución' msg
        return
    end

      if @ano_resolu is null
    begin
        select 'Falta campo año de resolución' msg
        return
    end


    begin tran

    UPDATE
        sg_soli
    SET
        ano_resolu = @ano_resolu,
        nro_resolu = @nro_resolu
    WHERE
        nro_solici = @nro_solici

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar datos. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

grant execute on Analisis2.sg_soliuSecgen03 to UsuaVrac
go
