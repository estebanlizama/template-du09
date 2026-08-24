use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_prsesSecgen07')


   drop procedure Analisis2.sg_prsesSecgen07
go

/* Procedimiento : sg_prsesSecgen07

    Entrada  :
        @rut_solici         -> Rut Funcionario Solicitud

    Objetivo : select Prestación de servicios

    Creacion: CHL 2022/12/27
    Actualizacion: AI 2023/01/24 -- Se agrega nuevo join con tabla sg_apcc, para obtener nombre de centro de costo

*/

create procedure  Analisis2.sg_prsesSecgen07
    @cod_estsol int
    as

    if @cod_estsol is null
    begin
        select 'Falta campo codigo de estado de solicitud' msg
        return
    end
        SELECT
            prse.nro_solici,
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
            apcc.nro_solici,
            apcc.nom_cencos,
            SUM(funps.mto_total) AS total
        FROM
            sg_prse prse
        JOIN sg_soli soli ON  (prse.nro_solici = soli.nro_solici)
        RIGHT JOIN sg_apcc apcc ON (soli.nro_solici = apcc.nro_solici)
        JOIN sg_tsol tiposol ON   (soli.cod_tipsol = tiposol.cod_tipsol)
        JOIN sg_esol estsol ON    (soli.cod_estsol = estsol.cod_estsol)
        JOIN sg_fups funps ON (soli.nro_solici = funps.nro_solici)

        WHERE
            soli.cod_estsol = @cod_estsol
        GROUP BY
            apcc.nro_solici,
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
            estsol.des_estsol

go

grant execute on Analisis2.sg_prsesSecgen07 to UsuaVrac
go

/*
EXECUTE secgen_db.Analisis2.sg_prsesSecgen07 @cod_estsol = 2
 */
