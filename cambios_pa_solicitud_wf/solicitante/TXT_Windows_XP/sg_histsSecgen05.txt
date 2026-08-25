use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
      where a.uid  = b.uid
        and a.type = 'P'
        and b.name = 'Analisis2'
        and a.name = 'sg_histsSecgen05')
   drop procedure Analisis2.sg_histsSecgen05
go

/* Procedimiento : sg_histsSecgen05

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtener el registro de la última devolución a observación (id_tipacc = 4) para una solicitud de prestacion de servicios. Creación: UFRO 2026

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/

create procedure Analisis2.sg_histsSecgen05
    @nro_solici int = null
    as
        SELECT
            hist.id_perfil,
            sp.nom_perfil,
            sp.des_perfil,
            hist.f_creacion
        FROM secgen_db.dbo.sg_hist hist
        INNER JOIN secgen_db.dbo.sg_perf sp
            ON hist.id_perfil = sp.id_perfil
        WHERE hist.cod_tipsol = 1
            AND hist.nro_solici = @nro_solici
            AND hist.id_tipacc = 4
        ORDER BY hist.f_creacion DESC, hist.id_histor DESC
go

grant execute on Analisis2.sg_histsSecgen05 to UsuaVrac
go
