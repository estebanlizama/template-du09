USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_soliuSecgen03'
)
    DROP PROCEDURE Analisis2.sg_soliuSecgen03
GO

/* Procedimiento : Analisis2.sg_soliuSecgen03

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @ano_resolu          -> Parametro de entrada. (Opcional)

   Objetivo : Update datos de resoluciA�n

   Creacion: AI 2023/02/03
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_soliuSecgen03
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

GRANT EXECUTE ON Analisis2.sg_soliuSecgen03 TO UsuaVrac
go
