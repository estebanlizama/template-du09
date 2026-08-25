USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen05'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen05
GO

/* Procedimiento : Analisis2.sg_prsesSecgen05

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Consultar la informacion principal de una prestacion de servicios por numero de solicitud.

   Creacion: CHL 2022/12/27
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen05
    @nro_solici int = Null
    as

    if @nro_solici is null
    begin
        select 'Falta campo Numero Solicitud' msg
        return
    end

        SELECT
            soli.nro_solici,
            prse.actividad,
            prse.per_desde,
            prse.per_hasta,
            prse.rut_jefpro,
            prse.cod_unifin,
            prse.cod_ccto,
            prse.cc_global,
            prse.pry_global,
            soli.rut_solici,
            soli.nro_resolu,
            soli.cod_estsol,
            soli.cod_tipsol,
            soli.f_solicit,
             soli.f_creacion,
             soli.f_ultmodif,
            tiposol.des_tipsol,
            estsol.des_estsol,
            soli.ano_proces,
            pers.nom_nombre + '' + pers.nom_appate + '' + pers.nom_apmate as nombre,
            pers.uni_ctadi,
            cc.nom_ab_cct
        FROM
            secgen_db.dbo.sg_prse prse
        INNER JOIN secgen_db.dbo.sg_soli soli ON (prse.nro_solici = soli.nro_solici)
        INNER JOIN secgen_db.dbo.sg_tsol tiposol ON	(soli.cod_tipsol = tiposol.cod_tipsol)
        INNER JOIN secgen_db.dbo.sg_esol estsol ON	(soli.cod_estsol = estsol.cod_estsol)
        LEFT JOIN sisper_db..sp_pers pers on (soli.rut_solici = pers.rut_person)
        LEFT JOIN fin21_db..es_ccto cc ON (prse.cod_ccto = cc.cod_ccto and prse.cod_unifin = cc.cod_unifin)
        WHERE	soli.nro_solici = @nro_solici

go

GRANT EXECUTE ON Analisis2.sg_prsesSecgen05 TO UsuaVrac
go
