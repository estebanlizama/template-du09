USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_apsosSecgen02'
)
    DROP PROCEDURE Analisis2.sg_apsosSecgen02
GO

/* Procedimiento : Analisis2.sg_apsosSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Trae los aprobadores para revisar estado

   Creacion: GE 2023/04/23
   Actualizacion: AI 2023/04/25
*/
CREATE PROCEDURE Analisis2.sg_apsosSecgen02
    @nro_solici int = NULL

    as

    if @nro_solici is null
    begin
        select 'Falta campo numero de solicitud' msg
        return
    end
 SELECT apso.rut_usua, per1.des_perfil, apso.cod_estapr
        FROM sg_soli as soli
        INNER JOIN sg_apso as apso ON (soli.nro_solici = apso.nro_solici)
        INNER JOIN sistema_db..bd_pri2 as pri2 ON (pri2.rut = apso.rut_usua)
        INNER JOIN sistema_db..bd_per1 as per1 ON (per1.cod_perfil = pri2.cod_perfil AND per1.cod_sistem = 'SG' AND per1.cod_modulo = 'SISSOLIC')
        WHERE soli.nro_solici = @nro_solici



        commit tran
go

GRANT EXECUTE ON Analisis2.sg_apsosSecgen02 TO UsuaVrac
go
