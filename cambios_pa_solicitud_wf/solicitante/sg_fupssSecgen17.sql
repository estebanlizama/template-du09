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

/* Procedimiento : Analisis2.sg_fupssSecgen17

   Entrada :
   @rut_person          -> RUT de la persona. (Opcional)
   @nro_solici_excluir  -> Parametro de entrada. (Opcional)

   Objetivo : Listar el historial de Prestaciones de Servicio (PDS) previas de un funcionario (por RUT), para apoyo de auditoria normativa DGDP (comparar la solicitud actual contra labores anteriores).

   Creacion: 2026/08/19
   Actualizacion: ELA 2026/08/25
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
        fu.id_funprse,
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
        fu.monto_mes,
        fu.tot_cuotas,
        fu.periodos,
        fu.cod_sitm,
        fu.itm_global,
        fu.cod_cargo,
        rtrim(isnull(carg.nom_cargo, '')) AS nom_cargo,
        fu.cod_estfun,
        rtrim(isnull(efun.des_estfun, '')) AS des_estfun,
        fu.dentro_jor,
        fu.cod_contra,
        fu.mes_haber,
        fu.ano_haber,
        fu.mto_haber,
        fu.mto_tope,
        fu.f_cal_tope,
        soli.nro_resolu,
        soli.ano_resolu,
        soli.cod_estsol,
        rtrim(isnull(esol.des_estsol, '')) AS des_estsol,
        soli.f_solicit,
        soli.ano_proces,
        prse.cod_etapa AS cod_etapa_act,
        rtrim(isnull(etapaAct.des_etapa, '')) AS des_etapa_act,
        rslc.num_resolu AS num_resolu_ext,
        rslc.id_docum,

        /* Cuota y estado financiero. LEFT JOIN conserva PDS sin cuotas. */
        fume.nro_cuota,
        fume.ano_prop,
        fume.mes_prop,
        fume.cod_estcuo,
        rtrim(isnull(ecuo.des_estcuo, '')) AS des_estcuo,
        fume.ano_ejec,
        fume.mes_ejec,
        fume.mto_apagar,
        fume.id_evidenc,
        fume.val_licmed,
        fume.val_inabili,
        fume.val_singoce,
        fume.val_ciecc,
        fume.fec_valida,
        fume.rut_autori,
        fume.fec_autori,
        fume.fec_envrem,
        fume.fec_pago,
        fume.ano_pago,
        fume.mes_pago,

        /* Compensacion efectiva vinculada a la cuota pagada/en pago. */
        fuc2.fec_comrea,
        fuc2.hora_ini AS hora_ini_comrea,
        fuc2.hora_ter AS hora_ter_comrea,

        /* Resumen de lo originalmente registrado para la PDS. */
        isnull(fuho.cant_horarios, 0) AS cant_horarios,
        fuho.hora_ini_min AS hora_ejec_ini,
        fuho.hora_ter_max AS hora_ejec_ter,
        isnull(fuco.cant_compensa, 0) AS cant_compensa_plan,
        fuco.fec_compro_min,
        fuco.fec_compro_max,
        fuco.hora_ini_min AS hora_comp_ini,
        fuco.hora_ter_max AS hora_comp_ter
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
    LEFT JOIN secgen_db.dbo.sg_efun efun
        ON efun.cod_estfun = fu.cod_estfun
    LEFT JOIN secgen_db.dbo.sg_eta1 etapaAct
        ON etapaAct.cod_flusol = prse.cod_flusol
       AND etapaAct.cod_etapa = prse.cod_etapa
       AND isnull(etapaAct.vigente, 'S') = 'S'
    LEFT JOIN secgen_db.dbo.sg_rslc rslc
        ON rslc.nro_resolu = soli.nro_resolu
    LEFT JOIN secgen_db.dbo.sg_fume fume
        ON fume.id_funprse = fu.id_funprse
    LEFT JOIN secgen_db.dbo.sg_ecuo ecuo
        ON ecuo.cod_estcuo = fume.cod_estcuo
    LEFT JOIN secgen_db.dbo.sg_fuc2 fuc2
        ON fuc2.id_funprse = fume.id_funprse
       AND fuc2.nro_cuota = fume.nro_cuota
    LEFT JOIN (
        SELECT
            id_funprse,
            count(*) AS cant_horarios,
            min(hora_ini) AS hora_ini_min,
            max(hora_ter) AS hora_ter_max
        FROM secgen_db.dbo.sg_fuho
        GROUP BY id_funprse
    ) fuho
        ON fuho.id_funprse = fu.id_funprse
    LEFT JOIN (
        SELECT
            id_funprse,
            count(*) AS cant_compensa,
            min(fec_compro) AS fec_compro_min,
            max(fec_compro) AS fec_compro_max,
            min(hora_ini) AS hora_ini_min,
            max(hora_ter) AS hora_ter_max
        FROM secgen_db.dbo.sg_fuco
        GROUP BY id_funprse
    ) fuco
        ON fuco.id_funprse = fu.id_funprse
    WHERE fu.rut = @rut_person
      AND (@nro_solici_excluir IS NULL OR fu.nro_solici <> @nro_solici_excluir)
      /* Una PDS rechazada (4) o con resolucion rechazada por un firmante
         (7) no representa una labor real ni un compromiso vigente -- no
         debe contar como coincidencia/conflicto contra la solicitud
         actual. Se filtra aca (no solo en el codigo que consume este PA)
         para que cualquier consumidor futuro quede protegido igual, y
         para no traer ni unir cuotas/horarios de solicitudes que ya no
         importan. */
      AND soli.cod_estsol NOT IN (4, 7)
    ORDER BY soli.f_solicit DESC, fu.id_funprse, fume.nro_cuota, fuc2.fec_comrea
END
GO

GRANT EXECUTE ON Analisis2.sg_fupssSecgen17 TO UsuaVrac
GO
