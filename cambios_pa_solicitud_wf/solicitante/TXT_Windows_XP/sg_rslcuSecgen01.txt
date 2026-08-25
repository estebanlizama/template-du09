USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_rslcuSecgen01'
)
    DROP PROCEDURE Analisis2.sg_rslcuSecgen01
GO

/* Procedimiento : Analisis2.sg_rslcuSecgen01

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @num_resolu          -> Parametro de entrada. (Opcional)
   @codigo_sdg          -> Parametro de entrada. (Opcional)
   @f_resolucio         -> Parametro de entrada. (Obligatorio)

   Objetivo : update Resoluciones

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/21
*/
CREATE PROCEDURE Analisis2.sg_rslcuSecgen01
    @nro_resolu int = NULL,
    @num_resolu int = NULL,
    @codigo_sdg varchar(50) = NULL,
    @f_resolucio datetime
        as
        if @nro_resolu is null begin
select
    'Falta campo Numero Resolucion' msg return
end if @num_resolu is null begin
select
    'Falta campo número de resolución' msg return
end if @codigo_sdg is null begin
select
    'Falta campo código de secretaria general de decretación' msg return
end if @f_resolucio is null begin
select
    'Falta campo fecha de resolución' msg return
end begin tran
update
    sg_rslc
set
    num_resolu = @num_resolu,
    codigo_sdg = @codigo_sdg,
    f_resolucio = @f_resolucio
where
    nro_resolu = @nro_resolu commit tran
go
    GRANT EXECUTE ON Analisis2.sg_rslcuSecgen01 TO UsuaVrac
go
    