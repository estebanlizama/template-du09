use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_soliuSecgen01')
   drop procedure Analisis2.sg_soliuSecgen01
go

/* Procedimiento : sg_soliuSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @cod_estsol          -> Codigo de estado de solicitud. (Opcional)
   @rut_solici          -> RUT del solicitante. (Opcional)

   Objetivo : Update solicitud

   Creacion: GE 2023/03/08
   Actualizacion: 
*/

create procedure  Analisis2.sg_soliuSecgen01
    @nro_solici int = NULL,
    @cod_estsol tinyint = NULL,
    @rut_solici char(9) = NULL
    as

    if @nro_solici is null
    begin
        select 'Falta campo Numero Solicitud' msg
        return
    end

    if @cod_estsol is null
    begin
        select 'Falta campo Id Tipo de Devolucion' msg
        return
    end

    if @rut_solici is null
    begin
        select 'Falta campo Rut de solcitante' msg
        return
    end

    begin tran

    update sg_soli
             set cod_estsol = @cod_estsol
             WHERE nro_solici = @nro_solici and rut_solici = @rut_solici

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar información de solicitud. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

grant execute on Analisis2.sg_soliuSecgen01 to UsuaVrac
go
