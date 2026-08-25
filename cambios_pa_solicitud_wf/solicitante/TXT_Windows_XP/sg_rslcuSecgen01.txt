use secgen_db
go
    if exists (
        select
            1
        from
            sysobjects a,
            sysusers b
        where
            a.uid = b.uid
            and a.type = 'P'
            and b.name = 'Analisis2'
            and a.name = 'sg_rslcuSecgen01'
    ) drop procedure Analisis2.sg_rslcuSecgen01
go
    /* Procedimiento : sg_rslcuSecgen01

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @num_resolu          -> Parametro de entrada. (Opcional)
   @codigo_sdg          -> Parametro de entrada. (Opcional)
   @f_resolucio         -> Parametro de entrada. (Obligatorio)

   Objetivo : update Resoluciones

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/21
*/
    create procedure Analisis2.sg_rslcuSecgen01
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
    grant execute on Analisis2.sg_rslcuSecgen01 to UsuaVrac
go
    