USE secgen_db
GO

IF EXISTS (
    SELECT 1 FROM sysobjects a, sysusers b
    WHERE a.uid = b.uid AND a.type = 'P'
      AND b.name = 'Analisis2' AND a.name = 'sg_padeuSecgen01'
)
    DROP PROCEDURE Analisis2.sg_padeuSecgen01
GO

/* Procedimiento : Analisis2.sg_padeuSecgen01

   Entrada :
   @id_funprse          -> Identificador de la funcion/prestacion. (Opcional)
   @nro_solici           -> Numero de solicitud a la que pertenece el detalle de pago. (Opcional)
   @asignaciones_csv     -> Lista de asignaciones mes propuesto -> cuota de pago, formato
                             nro_cuota:nro_cuota_pago:monto separados por punto y coma. (Opcional)
   @es_anid              -> 'S' si el centro de costo es ANID (exento del maximo de 2 cuotas de
                             pago por año, MOD-11); usa 'N' si no se envia. (Opcional)
   @cod_estdet           -> Estado inicial del detalle de pago; usa 1 (Propuesta) si no se envia. (Opcional)

   Objetivo : Sincronizar de forma transaccional las asignaciones de meses propuestos (sg_fume) a
   cuotas de pago reales (sg_pade.nro_cuota_pago) de un funcionario DU288. Cada mes propuesto debe
   existir previamente en sg_fume para ese mismo id_funprse. Sin @es_anid = 'S', ninguna asignacion
   puede usar un nro_cuota_pago mayor a 2 (Decreto 009/2026, numeral 6).

   Creacion: ELA 2026/09/04
*/
CREATE PROCEDURE Analisis2.sg_padeuSecgen01
    @id_funprse int = NULL,
    @nro_solici int = NULL,
    @asignaciones_csv varchar(1000) = NULL,
    @es_anid char(1) = 'N',
    @cod_estdet int = 1
AS
BEGIN
    IF @id_funprse IS NULL
    BEGIN
        SELECT 'Error: Falta ID del funcionario' AS msg
        RETURN
    END

    IF @nro_solici IS NULL
    BEGIN
        SELECT 'Error: Falta numero de solicitud' AS msg
        RETURN
    END

    IF NOT EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_fups
        WHERE id_funprse = @id_funprse
          AND nro_solici = @nro_solici
    )
    BEGIN
        SELECT 'Error: El funcionario especificado no existe para esa solicitud' AS msg
        RETURN
    END

    -- Validar que si ya existen detalles de pago persistidos, solo se permita
    -- modificar si estan en estado editable: 1 (Propuesta) o 3 (Observada) --
    -- mismo criterio que ya usa sg_fumeuSecgen01 sobre sg_fume.
    IF EXISTS (
        SELECT 1
        FROM secgen_db.dbo.sg_pade
        WHERE id_funprse = @id_funprse
          AND cod_estdet NOT IN (1, 3)
    )
    BEGIN
        SELECT 'Error: No se pueden modificar los detalles de pago porque estan en proceso de visacion o pago' AS msg
        RETURN
    END

    CREATE TABLE #asignaciones (
        nro_cuota tinyint NOT NULL,
        nro_cuota_pago tinyint NOT NULL,
        mto_solpag decimal(19,2) NOT NULL
    )

    -- Validar todo el CSV antes de modificar los detalles persistidos.
    IF @asignaciones_csv IS NOT NULL AND ltrim(rtrim(@asignaciones_csv)) <> ''
    BEGIN
        DECLARE @pos int
        DECLARE @chunk varchar(60)
        DECLARE @col1 int
        DECLARE @col2 int
        DECLARE @str_cuota varchar(10)
        DECLARE @str_cuota_pago varchar(10)
        DECLARE @str_monto varchar(20)

        SELECT @asignaciones_csv = @asignaciones_csv + ';'

        WHILE charindex(';', @asignaciones_csv) > 0
        BEGIN
            SELECT @pos = charindex(';', @asignaciones_csv)
            SELECT @chunk = ltrim(rtrim(substring(@asignaciones_csv, 1, @pos - 1)))
            SELECT @asignaciones_csv = substring(
                @asignaciones_csv,
                @pos + 1,
                char_length(@asignaciones_csv) - @pos
            )

            IF @chunk <> ''
            BEGIN
                SELECT @col1 = charindex(':', @chunk)
                IF @col1 <= 1 OR @col1 = char_length(@chunk)
                BEGIN
                    SELECT 'Error: Formato de asignacion invalido. Use nro_cuota:nro_cuota_pago:monto' AS msg
                    RETURN
                END

                SELECT @str_cuota = ltrim(rtrim(substring(@chunk, 1, @col1 - 1)))
                SELECT @col2 = charindex(':', @chunk, @col1 + 1)
                IF @col2 <= @col1 + 1 OR @col2 = char_length(@chunk)
                BEGIN
                    SELECT 'Error: Formato de asignacion invalido. Use nro_cuota:nro_cuota_pago:monto' AS msg
                    RETURN
                END

                SELECT @str_cuota_pago = ltrim(rtrim(substring(@chunk, @col1 + 1, @col2 - @col1 - 1)))
                SELECT @str_monto = ltrim(rtrim(substring(@chunk, @col2 + 1, char_length(@chunk) - @col2)))

                IF @str_cuota = '' OR patindex('%[^0-9]%', @str_cuota) > 0
                BEGIN
                    SELECT 'Error: nro_cuota no numerico' AS msg
                    RETURN
                END

                IF @str_cuota_pago = '' OR patindex('%[^0-9]%', @str_cuota_pago) > 0
                BEGIN
                    SELECT 'Error: nro_cuota_pago no numerico' AS msg
                    RETURN
                END

                IF @str_monto = '' OR patindex('%[^0-9.]%', @str_monto) > 0
                BEGIN
                    SELECT 'Error: monto invalido' AS msg
                    RETURN
                END

                IF @es_anid <> 'S' AND convert(tinyint, @str_cuota_pago) > 2
                BEGIN
                    SELECT 'Error: El maximo de cuotas de pago es 2 (numeral 6), salvo ANID' AS msg
                    RETURN
                END

                IF convert(tinyint, @str_cuota_pago) < 1 OR convert(tinyint, @str_cuota_pago) > 12
                BEGIN
                    SELECT 'Error: nro_cuota_pago fuera de rango (1 a 12)' AS msg
                    RETURN
                END

                IF NOT EXISTS (
                    SELECT 1
                    FROM secgen_db.dbo.sg_fume
                    WHERE id_funprse = @id_funprse
                      AND nro_cuota = convert(tinyint, @str_cuota)
                )
                BEGIN
                    SELECT 'Error: El mes propuesto (nro_cuota) no existe en sg_fume para este funcionario' AS msg
                    RETURN
                END

                IF EXISTS (
                    SELECT 1
                    FROM #asignaciones
                    WHERE nro_cuota = convert(tinyint, @str_cuota)
                )
                BEGIN
                    SELECT 'Error: Mes propuesto duplicado en la lista de asignaciones' AS msg
                    RETURN
                END

                INSERT INTO #asignaciones (nro_cuota, nro_cuota_pago, mto_solpag)
                VALUES (
                    convert(tinyint, @str_cuota),
                    convert(tinyint, @str_cuota_pago),
                    convert(decimal(19,2), @str_monto)
                )
            END
        END
    END

    BEGIN TRAN

    DELETE FROM secgen_db.dbo.sg_pade
    WHERE id_funprse = @id_funprse

    IF @@error <> 0
    BEGIN
        SELECT 'Error al limpiar detalles de pago anteriores' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    INSERT INTO secgen_db.dbo.sg_pade (
        nro_solici,
        id_funprse,
        nro_cuota,
        nro_cuota_pago,
        mto_solpag,
        cod_estdet
    )
    SELECT
        @nro_solici,
        @id_funprse,
        nro_cuota,
        nro_cuota_pago,
        mto_solpag,
        @cod_estdet
    FROM #asignaciones

    IF @@error <> 0
    BEGIN
        SELECT 'Error al insertar detalles de pago' AS msg
        IF @@transtate = 2 ROLLBACK TRAN
        RETURN
    END

    COMMIT TRAN
    SELECT 'Detalles de pago actualizados correctamente' AS msg
END
GO

GRANT EXECUTE ON Analisis2.sg_padeuSecgen01 TO UsuaVrac
GO
