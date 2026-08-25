USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_soliuSecgen02'
)
    DROP PROCEDURE Analisis2.sg_soliuSecgen02
GO

/* Procedimiento : Analisis2.sg_soliuSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @cod_estsol          -> Codigo de estado de solicitud. (Opcional)

   Objetivo : Update estado de solicitudes

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/03
*/
CREATE PROCEDURE Analisis2.sg_soliuSecgen02
    @nro_solici int = NULL,
    @cod_estsol tinyint = NULL

    as

    if @nro_solici is null
    begin
        select 'Falta campo Numero Solicitud' msg
        return
    end

    if @cod_estsol is null
    begin
        select 'Falta campo Codigo de solicitud' msg
        return
    end

    begin tran

    UPDATE
        sg_soli
    SET
        f_ultmodif = GETDATE(),
        cod_estsol = @cod_estsol
    WHERE
        nro_solici = @nro_solici

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar estado de la solicitud. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        select nro_resolu from sg_soli as nro_resolu where nro_solici = @nro_solici

        commit tran
go

GRANT EXECUTE ON Analisis2.sg_soliuSecgen02 TO UsuaVrac
go
