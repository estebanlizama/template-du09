use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
           where a.uid  = b.uid
             and a.type = 'P'
             and b.name = 'Analisis2'
             and a.name = 'sg_prsesSecgen08')
    drop procedure Analisis2.sg_prsesSecgen08
go

/* Procedimiento : sg_prsesSecgen08

    Entrada  :
        @rut_solici -> Rut funcionario solicitante

    Objetivo :
        Listar prestaciones de servicios en espera asociadas al solicitante,
        incluyendo la modalidad de prestacion desde sg_prse.cod_modprs.

    Creacion     : CHL 2022/12/27
    Actualizacion: PDS Fase 2 - agrega cod_modprs para filtrar modalidad

*/

create procedure Analisis2.sg_prsesSecgen08
    @rut_solici varchar(9) = NULL
as
begin
    if @rut_solici is null
    begin
        select 'Falta campo Rut Solicitud' msg
        return
    end

    SELECT
        soli.nro_solici,
        soli.cod_tipsol,
        prse.cod_modprs,
        prse.cc_global,
        prse.pry_global,
        soli.f_solicit,
        soli.f_ultmodif,
        tiposol.des_tipsol,
        estsol.des_estsol,
        (pers.nom_nombre + ' ' + pers.nom_appate + ' ' + pers.nom_apmate) as nombre,
        SUM(funps.mto_total) AS total
    FROM
        secgen_db.dbo.sg_prse prse
        JOIN secgen_db.dbo.sg_soli soli
            ON prse.nro_solici = soli.nro_solici
        JOIN secgen_db.dbo.sg_tsol tiposol
            ON soli.cod_tipsol = tiposol.cod_tipsol
        JOIN secgen_db.dbo.sg_esol estsol
            ON soli.cod_estsol = estsol.cod_estsol
            AND soli.cod_estsol IN (1, 2, 5, 6)
        JOIN secgen_db.dbo.sg_fups funps
            ON soli.nro_solici = funps.nro_solici
        LEFT JOIN sisper_db..sp_pers pers
            ON pers.rut_person = soli.rut_solici
    WHERE
        soli.rut_solici = @rut_solici
    GROUP BY
        soli.nro_solici,
        prse.cod_modprs,
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
        pers.rut_person,
        pers.nom_nombre,
        pers.nom_appate,
        pers.nom_apmate
    ORDER BY
        soli.f_creacion DESC
end
go

grant execute on Analisis2.sg_prsesSecgen08 to UsuaVrac
go

/*
EXECUTE secgen_db.Analisis2.sg_prsesSecgen08 @rut_solici = '092867439'
*/
