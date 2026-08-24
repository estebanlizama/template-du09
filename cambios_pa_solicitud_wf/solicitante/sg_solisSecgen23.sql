USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_solisSecgen23'
)
    DROP PROCEDURE Analisis2.sg_solisSecgen23
GO

/*
Procedimiento : Analisis2.sg_solisSecgen23
Objetivo      : Obtener el detalle de aprobaciones (sg_apso) de una
                solicitud, para armar el flujo organizacional completo
                en el frontend (historial por etapa).

Cambio (2026-08-21): se agregan apso.cod_flusol y apso.cod_etapa al
SELECT. Ambas columnas ya existen en sg_apso (ver diagrama_secgen), pero
la version anterior no las traia. Sin ellas, el frontend
(service-provision-request.controller.ts, RequestApproval.model.ts) no
podia enlazar cada registro de aprobacion con su etapa real, y caia a un
respaldo posicional por orden cronologico. Ese respaldo se desalinea
cuando una solicitud vuelve a pasar por la misma etapa tras ser devuelta
a correccion (queda una fila de sg_apso adicional por cada ciclo), lo
que hacia aparecer el comentario de una devolucion anterior pegado a una
etapa que en el ciclo actual esta "Aprobada". Con cod_etapa/cod_flusol
disponibles, el match correcto por etapa vuelve a funcionar y ese
respaldo deja de ser necesario en el caso normal.

Compatibilidad: Sybase ASE 12.5.
*/
CREATE PROCEDURE Analisis2.sg_solisSecgen23
    @nro_solici int = NULL
AS
BEGIN
    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Falta campo numero de solicitud' AS msg
        RETURN
    END

    SELECT
        apso.nro_aproba,
        apso.nro_solici,
        apso.rut_usua,
        apso.cod_estapr,
        apso.comentario,
        apso.f_aprobac,
        apso.f_creacion,
        apso.f_ultmodif,
        apso.cod_flusol,
        apso.cod_etapa,
        soli.nro_resolu
    FROM secgen_db.dbo.sg_soli soli
    INNER JOIN secgen_db.dbo.sg_apso apso
        ON soli.nro_solici = apso.nro_solici
    WHERE soli.nro_solici = @nro_solici
      AND apso.cod_estapr != 4
    ORDER BY apso.f_ultmodif DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_solisSecgen23 TO UsuaVrac
GO

/*
execute secgen_db.Analisis2.sg_solisSecgen23 @nro_solici = 739
*/
