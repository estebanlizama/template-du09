use secgen_db
go

if exists (select 1
             from sysobjects a, sysusers b
            where a.uid = b.uid
              and a.type = 'P'
              and b.name = 'Analisis2'
              and a.name = 'sg_histsSecgen02')
begin
    drop procedure Analisis2.sg_histsSecgen02
end
go

/* Procedimiento : sg_histsSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : select Registro de históricos de solicitud, resolución

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/

create procedure Analisis2.sg_histsSecgen02
    @nro_solici int = null
    as
        SELECT
            pers.nom_nombre + '' + pers.nom_appate + '' + pers.nom_apmate as nombre,
            per1.des_perfil, hist.id_tipacc, tacc.des_accion, hist.f_creacion,
            hist.observaci
        FROM
            secgen_db..sg_hist hist
        LEFT JOIN secgen_db..sg_tacc tacc on (hist.id_tipacc = tacc.id_tipacc)
        LEFT JOIN sisper_db..sp_pers pers on (hist.rut_accion = pers.rut_person)
        LEFT JOIN sistema_db..bd_per1 per1 on (hist.id_perfil = per1.cod_perfil AND per1.cod_sistem = 'SG' AND per1.cod_modulo = 'SISSOLIC')
        WHERE hist.nro_solici = @nro_solici
        ORDER BY hist.f_creacion
go

grant execute on Analisis2.sg_histsSecgen02 to UsuaVrac
go
