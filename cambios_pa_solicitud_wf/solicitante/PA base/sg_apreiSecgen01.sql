use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_apreiSecgen01')
   drop procedure Analisis2.sg_apreiSecgen01
go

/* Procedimiento : sg_apreiSecgen01

   Entrada :
   @ano_resolu          -> Parametro de entrada. (Opcional)
   @nro_resolu          -> Parametro de entrada. (Opcional)
   @rut_aprob           -> Parametro de entrada. (Opcional)
   @cod_estapr          -> Codigo de estado de aprobacion. (Opcional)
   @id_perfil           -> Parametro de entrada. (Opcional)

   Objetivo : insertar Aprobación de resoluciones

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/22
*/

create procedure  Analisis2.sg_apreiSecgen01
    @ano_resolu smallint = Null,
    @nro_resolu int = Null,
    @rut_aprob char(9) = Null,
    @cod_estapr tinyint = Null,
    @id_perfil tinyint = Null
    as


    if @ano_resolu is null
    begin
        select 'Falta campo Año Resolucion' msg
        return
    end

    if @nro_resolu is null
    begin
        select 'Falta campo Numero Resolucion' msg
        return
    end

    if @rut_aprob is null
    begin
        select 'Falta campo RUT Aprobacion' msg
        return
    end

    if @cod_estapr is null
    begin
        select 'Falta campo Codigo Estado Aprobacion' msg
        return
    end

    if @id_perfil is null
    begin
        select 'Falta campo Id Perfil' msg
        return
    end

    begin tran

    declare @id_aprbres int
    select @id_aprbres = max(ultimo_id)from secgen_db..sg_parm WHERE nom_tabla LIKE 'sg_apre'
        select @id_aprbres = isnull(@id_aprbres,0) + 1

         update secgen_db..sg_parm
             set ultimo_id = @id_aprbres
             WHERE nom_tabla LIKE 'sg_apre'

    if @@transtate = 2 or @@transtate = 3
        begin
             select 'Error al insertar datos. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
            return
        end

    insert into sg_apre (
        id_aprbres,
        ano_resolu,
        nro_resolu,
        rut_aprob,
        cod_estapr,
        id_perfil
    )values(
        @id_aprbres,
        @ano_resolu,
        @nro_resolu,
        @rut_aprob,
        @cod_estapr,
        @id_perfil
    )

    if @@transtate = 2 or @@transtate = 3
        begin
            select 'Error al insertar información. Se aborta el procedimiento' msg
            if @@transtate = 2
                rollback  tran
                return
        end

        commit tran

go

grant execute on Analisis2.sg_apreiSecgen01 to UsuaVrac
go
