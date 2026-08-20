USE secgen_db
GO

IF EXISTS (
    SELECT 1
    FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid
      AND a.type = 'P'
      AND b.name = 'Analisis2'
      AND a.name = 'sg_fupssSecgen17'
)
    DROP PROCEDURE Analisis2.sg_fupssSecgen17
GO

/*
Procedimiento : Analisis2.sg_fupssSecgen17
Objetivo      : Listar el historial de Prestaciones de Servicio (PDS) previas
                de un funcionario (por RUT), para apoyo de auditoria normativa
                DGDP (comparar la solicitud actual contra labores anteriores).
Parametros    :
    @rut_person         char(9) : RUT del funcionario prestador.
    @nro_solici_excluir int     : Solicitud actual a excluir del historial
                                   (NULL = no excluye ninguna).
Retorna       :
    Una fila por cada PDS previa del funcionario: actividad, periodo,
    fechas de ejecucion, centro de costo, montos, cuotas, cargo, resolucion
    (incluye numero externo y documento), etapa actual (si la solicitud
    previa aun esta en tramite) y estado de la solicitud.
Creacion      : 2026/08/19
Modificacion  : 2026/08/20 - se agregan cod_etapa_act/des_etapa_act (etapa
                actual segun sg_prse + sg_eta1, igual criterio que
                sg_eta1sSecgen02) y num_resolu_ext/id_docum (segun sg_rslc,
                igual criterio que selectResolutionLinkDirect) para que el
                backend no deba resolverlos con consultas adicionales por
                cada fila. El estado de firma del documento (que vive en
                MySecGen, fuera de Sybase) sigue resolviendose aparte.
*/

CREATE PROCEDURE Analisis2.sg_fupssSecgen17
    @rut_person         char(9) = NULL,
    @nro_solici_excluir int     = NULL
AS
BEGIN
    IF @rut_person IS NULL OR ltrim(rtrim(@rut_person)) = ''
    BEGIN
        SELECT 'Falta campo RUT del funcionario' AS msg
        RETURN
    END

    SELECT
        fu.nro_solici,
        prse.actividad,
        fu.motivo AS motivo_funcionario,
        prse.per_desde,
        prse.per_hasta,
        fu.f_inicio,
        fu.f_termino,
        prse.cod_unifin,
        prse.cod_ccto,
        rtrim(isnull(ccto.nom_ab_cct, '')) AS nom_ab_cct,
        fu.mto_total,
        fu.tot_cuotas,
        fu.cod_cargo,
        rtrim(isnull(carg.nom_cargo, '')) AS nom_cargo,
        soli.nro_resolu,
        soli.ano_resolu,
        soli.cod_estsol,
        rtrim(isnull(esol.des_estsol, '')) AS des_estsol,
        soli.f_solicit,
        soli.ano_proces,
        prse.cod_etapa AS cod_etapa_act,
        rtrim(isnull(etapaAct.des_etapa, '')) AS des_etapa_act,
        rslc.num_resolu AS num_resolu_ext,
        rslc.id_docum
    FROM secgen_db.dbo.sg_fups fu
    INNER JOIN secgen_db.dbo.sg_prse prse
        ON prse.nro_solici = fu.nro_solici
    INNER JOIN secgen_db.dbo.sg_soli soli
        ON soli.nro_solici = fu.nro_solici
    LEFT JOIN secgen_db.dbo.sg_esol esol
        ON esol.cod_estsol = soli.cod_estsol
    LEFT JOIN fin21_db..es_ccto ccto
        ON ccto.cod_ccto = prse.cod_ccto
       AND ccto.cod_unifin = prse.cod_unifin
    LEFT JOIN sisper_db.dbo.sp_carg carg
        ON carg.cod_cargo = fu.cod_cargo
    LEFT JOIN secgen_db.dbo.sg_eta1 etapaAct
        ON etapaAct.cod_flusol = prse.cod_flusol
       AND etapaAct.cod_etapa = prse.cod_etapa
       AND isnull(etapaAct.vigente, 'S') = 'S'
    LEFT JOIN secgen_db.dbo.sg_rslc rslc
        ON rslc.nro_resolu = soli.nro_resolu
    WHERE fu.rut = @rut_person
      AND (@nro_solici_excluir IS NULL OR fu.nro_solici <> @nro_solici_excluir)
    ORDER BY soli.f_solicit DESC
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen17 TO UsuaVrac
GO
