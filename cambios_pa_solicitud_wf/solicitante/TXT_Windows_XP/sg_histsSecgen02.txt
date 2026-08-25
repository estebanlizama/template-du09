USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_histsSecgen02'
)
    DROP PROCEDURE Analisis2.sg_histsSecgen02
GO

/* Procedimiento : Analisis2.sg_histsSecgen02

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : select Registro de histA³ricos de solicitud, resoluciA³n

   Creacion: AI 2023/03/15
   Actualizacion: SSY 2023/03/21
*/
CREATE PROCEDURE Analisis2.sg_histsSecgen02
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

GRANT EXECUTE ON Analisis2.sg_histsSecgen02 TO UsuaVrac
go
