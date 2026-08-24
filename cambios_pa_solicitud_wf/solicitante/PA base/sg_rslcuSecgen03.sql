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
            and a.name = 'sg_rslcuSecgen03'
    ) drop procedure Analisis2.sg_rslcuSecgen03
go
    /* Procedimiento : sg_rslcuSecgen03

     Entrada  :

     @nro_resolu         -> Numero Resolucion
     @rut_archiv         -> Rut del archivador
     @cod_estres         -> código de estado de la resolución

     Objetivo : Cambiar el estado de una resolución

     Creacion: AI 2023/02/23
     Actualizacion: AI 2023/04/10

     */
    create procedure Analisis2.sg_rslcuSecgen03
    @nro_resolu int = null,
    @rut_archiv character(9) = null,
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
update
    sg_rslc
set
    rut_archiv = @rut_archiv,
    f_archivad = getDate(),
    cod_estres = @cod_estres
where
    nro_resolu = @nro_resolu

    update sg_soli set cod_estsol = @cod_estres where nro_resolu = @nro_resolu

        commit tran
go
    grant execute on Analisis2.sg_rslcuSecgen03 to UsuaVrac
go
    /*
     execute secgen_db.Analisis2.sg_rslcuSecgen03 @nro_resolu = 28,  @rut_archiv = '175842314', @cod_estres = 7
     */
