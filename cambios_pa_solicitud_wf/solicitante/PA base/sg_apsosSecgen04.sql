USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsosSecgen04'
)
    DROP PROCEDURE Analisis2.sg_apsosSecgen04
GO

/* Procedimiento : Analisis2.sg_apsosSecgen04

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Trae los aprobadores de una solicitud

   Creacion: AI 2023/06/01
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_apsosSecgen04 
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
    GRANT EXECUTE ON Analisis2.sg_apsosSecgen04 TO UsuaVrac
go
    