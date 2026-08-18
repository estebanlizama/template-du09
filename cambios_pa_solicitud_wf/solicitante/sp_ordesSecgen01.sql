USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sp_ordesSecgen01'
)
    DROP PROCEDURE Analisis2.sp_ordesSecgen01
GO

/*
Compatibilidad temporal. La aplicacion ya no ofrece contextos para crear o
editar por representacion; este PA retorna solamente la identidad personal.
*/
CREATE PROCEDURE Analisis2.sp_ordesSecgen01
    @rut_actor char(9) = NULL,
    @fecha_eval datetime = NULL
AS
BEGIN
    IF @rut_actor IS NULL OR ltrim(rtrim(@rut_actor)) = ''
    BEGIN
        SELECT convert(varchar(40), NULL) context_key,
            convert(varchar(20), NULL) context_type,
            convert(char(9), NULL) rut_actor,
            convert(char(9), NULL) rut_titular,
            convert(varchar(255), NULL) nombre_titular,
            convert(int, NULL) cod_organi_representado,
            convert(varchar(100), NULL) cargo_representado,
            convert(varchar(10), NULL) cod_design,
            convert(varchar(2), NULL) cod_des_su,
            convert(varchar(40), NULL) tipo_representacion,
            convert(varchar(10), NULL) fuente,
            convert(datetime, NULL) fecha_desde,
            convert(datetime, NULL) fecha_hasta,
            convert(char(1), NULL) titular_ausente,
            convert(varchar(10), NULL) numero_resolucion,
            'NO_VIGENTE' estado_resolucion,
            'N' puede_ver, 'N' puede_crear, 'N' puede_editar,
            'N' puede_decidir, 'N' puede_firmar,
            'Falta RUT del usuario autenticado' mensaje
        RETURN
    END

    SELECT 'PERSONAL' context_key, 'PERSONAL' context_type,
        @rut_actor rut_actor, @rut_actor rut_titular,
        ltrim(rtrim(isnull(actor.nom_nombre, '') + ' ' +
                    isnull(actor.nom_appate, '') + ' ' +
                    isnull(actor.nom_apmate, ''))) nombre_titular,
        convert(int, NULL) cod_organi_representado,
        convert(varchar(100), NULL) cargo_representado,
        convert(varchar(10), NULL) cod_design,
        convert(varchar(2), NULL) cod_des_su,
        'PERSONAL' tipo_representacion, 'JWT' fuente,
        convert(datetime, NULL) fecha_desde,
        convert(datetime, NULL) fecha_hasta,
        convert(char(1), NULL) titular_ausente,
        convert(varchar(10), NULL) numero_resolucion,
        'VIGENTE' estado_resolucion,
        'S' puede_ver, 'S' puede_crear, 'S' puede_editar,
        'S' puede_decidir, 'S' puede_firmar,
        convert(varchar(255), NULL) mensaje
    FROM sisper_db.dbo.sp_pers actor
    WHERE actor.rut_person = @rut_actor
END
GO

GRANT EXECUTE ON Analisis2.sp_ordesSecgen01 TO UsuaVrac
GO
