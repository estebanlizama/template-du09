USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apreuSecgen01'
)
    DROP PROCEDURE Analisis2.sg_apreuSecgen01
GO

/* Procedimiento : Analisis2.sg_apreuSecgen01

   Entrada :
   @id_aprbres          -> Parametro de entrada. (Opcional)
   @cod_estapr          -> Codigo de estado de aprobacion. (Opcional)

   Objetivo : update AprobaciA≥n de resoluciones

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/22
*/
CREATE PROCEDURE Analisis2.sg_apreuSecgen01
    @id_aprbres int = null,
    @cod_estapr tinyint = null
    as

    if @id_aprbres is null
    begin
        select 'Falta campo Id Aprobacion' msg
        return
    end

    if @cod_estapr is null
    begin
        select 'Falta campo Codigo Estado Aprobacion' msg
        return
    end

    begin tran

    update sg_apre
    set cod_estapr = @cod_estapr
    where id_aprbres = @id_aprbres

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al actualizar informaci√≥n. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran
go

GRANT EXECUTE ON Analisis2.sg_apreuSecgen01 TO UsuaVrac
go
