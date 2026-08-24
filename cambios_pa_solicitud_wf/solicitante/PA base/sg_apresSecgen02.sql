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
            and a.name = 'sg_apresSecgen02'
    ) drop procedure Analisis2.sg_apresSecgen02
go
    /* Procedimiento : sg_apresSecgen02

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)

   Objetivo : seleccionar la cantidad de aprocaciones de una resolución

   Creacion: AI 2023/02/24
   Actualizacion: 
*/
    create procedure Analisis2.sg_apresSecgen02 @nro_resolu int = null as declare @cant_aprobaciones tinyint
select
    @cant_aprobaciones = count(nro_resolu)
from
    sg_apre
where
    cod_estapr = 1
    and nro_resolu = @nro_resolu
select
    @cant_aprobaciones as cant_aprobaciones
go
    grant execute on Analisis2.sg_apresSecgen02 to UsuaVrac
go
    