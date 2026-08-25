USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_soliuSecgen05'
)
    DROP PROCEDURE Analisis2.sg_soliuSecgen05
GO

/* Procedimiento : Analisis2.sg_soliuSecgen05

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @ano_resolu          -> Parametro de entrada. (Opcional)
   @cod_estsol          -> Codigo de estado de solicitud. (Opcional)

   Objetivo : Actualizar solicitudes agrupadas por numero y aA±o de resolucion

   Creacion: GE 2023/03/08
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_soliuSecgen05
    @nro_resolu int = NULL,
    @ano_resolu int = NULL,
    @cod_estsol tinyint = NULL
    as

    if @nro_resolu is null
    begin
        select 'Falta campo Numero de resolucion' msg
        return
    end

    if @ano_resolu is null
    begin
        select 'Falta campo Id Tipo de Devolucion' msg
        return
    end

    begin tran

    update sg_soli
             set cod_estsol = @cod_estsol
             WHERE nro_resolu = @nro_resolu and ano_resolu = @ano_resolu

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar informaci√≥n de solicitud. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

GRANT EXECUTE ON Analisis2.sg_soliuSecgen05 TO UsuaVrac
go
