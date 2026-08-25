USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_prsesSecgen12'
)
    DROP PROCEDURE Analisis2.sg_prsesSecgen12
GO

/* Procedimiento : Analisis2.sg_prsesSecgen12

   Entrada :
   @rut_solici          -> RUT del solicitante. (Opcional)

   Objetivo : Seleccionar solicitudes historicas prestaciA³n de servicios listas para aprobar por rut

   Creacion: AI 2023/05/11
   Actualizacion: Sin registro
*/
CREATE PROCEDURE Analisis2.sg_prsesSecgen12
    @rut_solici varchar(9) = NULL
    as

    if @rut_solici is null
    begin
        select 'Falta campo Rut solicitante' msg
        return
    end
             SELECT soli.nro_solici, actividad, per_desde, per_hasta, rut_jefpro, cod_unifin,
            cod_ccto, cc_global, pry_global, rut_solici, nro_resolu, soli.cod_estsol,
            soli.cod_tipsol, f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol, SUM(funps.mto_total) as total
        FROM secgen_db.dbo.sg_prse prse
        JOIN secgen_db.dbo.sg_soli soli
            ON (prse.nro_solici = soli.nro_solici)
        JOIN secgen_db.dbo.sg_tsol tiposol
            ON (soli.cod_tipsol = tiposol.cod_tipsol)
        JOIN secgen_db.dbo.sg_esol estsol
            ON (soli.cod_estsol = estsol.cod_estsol) AND (soli.cod_estsol IN (1,2,5))
        JOIN secgen_db.dbo.sg_fups funps
            ON (soli.nro_solici = funps.nro_solici)
        JOIN secgen_db.dbo.sg_apso apso
            ON (soli.nro_solici = apso.nro_solici) AND (apso.cod_estapr IN (1,2,3))
        WHERE soli.rut_solici = @rut_solici OR (apso.rut_usua = @rut_solici)
        GROUP BY soli.nro_solici, actividad, per_desde, per_hasta, rut_jefpro, cod_unifin,
            cod_ccto, cc_global, pry_global, rut_solici, nro_resolu, soli.cod_estsol,
            soli.cod_tipsol, f_solicit, soli.f_creacion, soli.f_ultmodif, tiposol.des_tipsol, estsol.des_estsol
        ORDER BY soli.f_creacion DESC
go

GRANT EXECUTE ON Analisis2.sg_prsesSecgen12 TO UsuaVrac
go
