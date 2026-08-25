USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_redesSecgen02'
)
    DROP PROCEDURE Analisis2.sg_redesSecgen02
GO

/* Procedimiento : Analisis2.sg_redesSecgen02

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @cod_tipsec          -> Parametro de entrada. (Opcional)

   Objetivo : select Detalle de resoluciA³n

   Creacion: AI 2023/05/29
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_redesSecgen02
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

GRANT EXECUTE ON Analisis2.sg_redesSecgen02 TO UsuaVrac
go
