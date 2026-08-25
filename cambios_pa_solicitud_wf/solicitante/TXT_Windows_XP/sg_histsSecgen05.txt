USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_histsSecgen05'
)
    DROP PROCEDURE Analisis2.sg_histsSecgen05
GO

/* Procedimiento : Analisis2.sg_histsSecgen05

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)

   Objetivo : Obtener el registro de la Aºltima devoluciA³n a observaciA³n (id_tipacc = 4) para una solicitud de prestacion de servicios. CreaciA³n: UFRO 2026

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_histsSecgen05
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

GRANT EXECUTE ON Analisis2.sg_histsSecgen05 TO UsuaVrac
go
