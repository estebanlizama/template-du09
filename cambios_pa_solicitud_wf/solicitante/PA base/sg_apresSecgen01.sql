USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apresSecgen01'
)
    DROP PROCEDURE Analisis2.sg_apresSecgen01
GO

/* Procedimiento : Analisis2.sg_apresSecgen01

   Entrada :
   @nro_resolu          -> Parametro de entrada. (Opcional)

   Objetivo : seleccionar todos los aprobadores de resoluciones

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/22
*/
CREATE PROCEDURE Analisis2.sg_apresSecgen01 @nro_resolu int = null as\r\n    if @nro_resolu is null begin
select
    'Falta campo numero de resolucion, se abortara el procedimiento.' msg return
end
select
    apre.id_aprbres,
    apre.ano_resolu,
    apre.rut_aprob,
    apre.id_perfil,
    apre.cod_estapr,
    apre.observacio,
    pers.nom_nombre,
    pers.nom_appate,
    pers.nom_apmate,
    per1.des_perfil,
    apre.nro_resolu,
    apre.observacio,
    rslc.cod_estres
from
    sg_apre as apre
    left join sisper_db..sp_pers as pers on (apre.rut_aprob = pers.rut_person)
    inner join secgen_db..sg_rslc as rslc on (
        apre.nro_resolu = rslc.nro_resolu
        and apre.ano_resolu = rslc.ano_resolu
    )
    inner join sistema_db..bd_pri2 as pri2 on (apre.rut_aprob = pri2.rut)
    inner join sistema_db..bd_per1 as per1 on (
        pri2.cod_perfil = per1.cod_perfil
        and pri2.cod_sistem = 'SG'
        and pri2.cod_modulo = 'SISSOLIC'
    )
where
    apre.nro_resolu = @nro_resolu
go
    GRANT EXECUTE ON Analisis2.sg_apresSecgen01 TO UsuaVrac
go
    