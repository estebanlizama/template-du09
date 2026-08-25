USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_redesSecgen01'
)
    DROP PROCEDURE Analisis2.sg_redesSecgen01
GO

/* Procedimiento : Analisis2.sg_redesSecgen01

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Obligatorio)

   Objetivo : select Detalle de resoluciA³n

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/13
*/
CREATE PROCEDURE Analisis2.sg_redesSecgen01
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

GRANT EXECUTE ON Analisis2.sg_redesSecgen01 TO UsuaVrac
go
