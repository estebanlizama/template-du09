USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsosSecgen01'
)
    DROP PROCEDURE Analisis2.sg_apsosSecgen01
GO

/* Procedimiento : Analisis2.sg_apsosSecgen01

   Entrada :
   @nro_solici         -> Numero Resolucion

   Objetivo : Seleccionar comentario de solicitud

   Creacion: CHL 2022/12/13
   Actualizacion: AI 2023/02/15
*/
CREATE PROCEDURE Analisis2.sg_apsosSecgen01 @nro_solici int = None
as
    if @nro_solici is null
        begin
            select
                'Falta campo Numero Solicitud' msg return
        end begin tran
select
    apso.comentario,
    apso.f_aprobac,
    pers.nom_appate + ' ' + pers.nom_apmate + ' ' + pers.nom_nombre nombre,
    per1.des_perext
from
    sg_apso as apso
        left join sisper_db..sp_pers pers on (pers.rut_person = apso.rut_usua)
        left join sistema_db..bd_pri2 pri2 on (apso.rut_usua = pri2.rut) and (pri2.cod_sistem = 'SG') and (pri2.cod_modulo = 'SISSOLIC')
        left join sistema_db..bd_per1 per1 on (pri2.cod_perfil = per1.cod_perfil) and (per1.cod_sistem = 'SG') and (per1.cod_modulo = 'SISSOLIC')
where
        apso.nro_solici = @nro_solici and apso.comentario like '%'
    commit tran
go
GRANT EXECUTE ON Analisis2.sg_apsosSecgen01 TO UsuaVrac
go
