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
            and a.name = 'sg_rslcuSecgen04'
    ) drop procedure Analisis2.sg_rslcuSecgen04
go
    /* Procedimiento : sg_rslcuSecgen04

     Entrada  :

     @nro_resolu         -> Numero Resolucion
     @cod_estres         -> Código de estado de resolución

     Objetivo : Marcar una resolución como ingresada

     Creacion: AI 2023/03/14
     Actualizacion:

     */
    create procedure Analisis2.sg_rslcuSecgen04
        @nro_resolu int = null,
    @cod_estres int = null
     as
        if @nro_resolu is null begin
select
    'Falta campo Numero Resolucion' msg return
end
        if @cod_estres is null begin
select
    'Falta campo código de estado de la resolución' msg return
end
        begin tran

        declare @status_code int

             select @status_code = rslc.cod_estres from sg_rslc as rslc where nro_resolu = @nro_resolu

        if(@status_code = 7)
begin
    UPDATE sg_rslc SET cod_estres = 8
    where nro_resolu = @nro_resolu


      update sg_soli set cod_estsol = @cod_estres where nro_resolu = @nro_resolu
end
    if(@status_code != 7)
        begin
    UPDATE sg_rslc SET cod_estres = @cod_estres
        where nro_resolu = @nro_resolu

end
    commit tran
go
    grant execute on Analisis2.sg_rslcuSecgen04 to UsuaVrac
go
    /*
     execute secgen_db.Analisis2.sg_rslcuSecgen04 @nro_resolu = 56, @cod_estres = 7
     */
