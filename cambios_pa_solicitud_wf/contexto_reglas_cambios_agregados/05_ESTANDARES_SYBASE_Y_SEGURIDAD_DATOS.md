# Estándares Sybase ASE y Seguridad de Datos (OWASP)

## 1. Visión General

El backend de **SG-Solicitudes** interactúa con un motor Sybase ASE a través de un pool de conexiones y puente JDBC. Debido a las características del motor y los protocolos de red, se establecen reglas estrictas de diseño de Procedimientos Almacenados y seguridad de datos.

---

## 2. Prevención del Error JDBC `010P4: The server is not ready`

### Causa Raíz del Error:
Cuando un Procedimiento Almacenado abre una transacción (`BEGIN TRANSACTION`) y luego retorna prematuramente debido a una validación (`RETURN 1`) sin haber hecho `ROLLBACK TRANSACTION`, o cuando emite múltiples result sets de conteo (`NOCOUNT` desactivado), el driver JDBC no puede cerrar el stream de datos y arroja:
`com.sybase.jdbc4.jdbc.SybSQLException: 010P4: The server is not ready for the command`

### Patrón Obligatorio de Construcción:

```sql
-- 1. Desactivar conteos de filas para evitar paquetes de red adicionales
SET NOCOUNT ON

-- 2. VALIDACIONES PREVIAS (GUARDS) FUERA DE LA TRANSACCIÓN
IF @nro_soli IS NULL OR @ano_soli IS NULL
BEGIN
    SELECT 'Los parametros de solicitud son obligatorios' AS msg
    RETURN 1
END

IF NOT EXISTS (SELECT 1 FROM sg_soli WHERE nro_soli = @nro_soli AND ano_soli = @ano_soli)
BEGIN
    SELECT 'La solicitud especificada no existe o no esta disponible' AS msg
    RETURN 1
END

-- 3. APERTURA DE TRANSACCIÓN ÚNICAMENTE AL INICIAR OPERACIONES DML
BEGIN TRANSACTION

INSERT INTO sg_fume (...)
VALUES (...)

IF @@ERROR <> 0
BEGIN
    ROLLBACK TRANSACTION
    SELECT 'No fue posible registrar el detalle de la solicitud' AS msg
    RETURN 1
END

-- 4. CIERRE EXITOSO DE TRANSACCIÓN
COMMIT TRANSACTION

SELECT 'Operacion realizada exitosamente' AS msg
RETURN 0
```

---

## 3. Seguridad de Datos (OWASP) y Enmascaramiento de Esquema

1. **Cero Fugas de Infraestructura:**
   - Queda estrictamente prohibido devolver nombres de tablas (`sg_soli`, `sg_fume`, `es_cfer`), nombres de columnas internas (`corr_fuen`, `cod_tpps`) o nombres de bases de datos (`secgen_db`) en los mensajes dirigidos al cliente.
   - *Incorrecto:* `SELECT 'Error en llave foranea sg_fume con sg_fuc2' AS msg`
   - *Correcto:* `SELECT 'No es posible modificar las cuotas porque existen registros de pago asociados' AS msg`
2. **Mensajes Comprensibles y Seguros:**
   - Todo mensaje debe estar redactado en lenguaje de negocio amigable para el usuario final o para el registro en el log de auditoría.

---

## 4. Codificación de Caracteres y Cabeceras (`latin1` Friendly)

Para garantizar la interoperabilidad entre los editores modernos (UTF-8) y la base de datos Sybase configurada en juego de caracteres `iso_1` / `latin1`:

1. **Cabeceras sin Acentos ni Caracteres Especiales:**
   - Las descripciones de los parámetros en la cabecera `/* Procedimiento : ... */` no deben contener tildes (`á`, `é`, `í`, `ó`, `ú`) ni la letra `ñ`.
   - Usar: `Ano`, `Numero`, `Descripcion`, `Parametro`, `Codigo`.
2. **Cero Bloques de Prueba o Código Muerto:**
   - Los archivos `.sql` entregados para certificación o despliegue no deben incluir bloques `/* EXEC ... */` comentados al final ni sentencias comentadas en el cuerpo.
