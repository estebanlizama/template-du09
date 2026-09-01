use secgen_db
go

if exists (select 1
             from sysobjects a, sysusers b
            where a.uid = b.uid
              and a.type = 'P'
              and b.name = 'Analisis2'
              and a.name = 'sg_apsosSecgen04')
begin
    drop procedure Analisis2.sg_apsosSecgen04
end
go

/* Procedimiento : sg_apsosSecgen04

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Trae los aprobadores de una solicitud

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/

create procedure Analisis2.sg_apsosSecgen04
    @nro_solici int = null
 as
 if @nro_solici is null begin
select
    'Falta campo numero de solicitud' msg return
end

 SELECT apso.rut_usua as rut_aprob,
      perf.nom_perfil,
      perf.des_perfil
    FROM secgen_db.dbo.sg_apso apso
    RIGHT JOIN secgen_db.dbo.sg_soli soli
            ON (apso.nro_solici = soli.nro_solici)
    RIGHT JOIN secgen_db.dbo.sg_uspe uspe
            ON (uspe.rut = apso.rut_usua)
    RIGHT JOIN secgen_db.dbo.sg_perf perf
            ON (uspe.id_perfil = perf.id_perfil)
    WHERE soli.nro_solici = @nro_solici AND apso.cod_estapr = 1
    commit tran
go

grant execute on Analisis2.sg_apsosSecgen04 to UsuaVrac
go
