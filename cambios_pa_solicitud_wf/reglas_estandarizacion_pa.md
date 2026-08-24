# Reglas de Estandarización para Procedimientos Almacenados (PA)

Este documento detalla las reglas de codificación, formato y seguridad que deben seguir todos los Procedimientos Almacenados (PA) del sistema, específicamente enfocadas en la limpieza del código y la seguridad de la información.

## 1. Bloque de Comentarios Superior (Cabecera)

Todo Procedimiento Almacenado debe comenzar con un bloque de comentarios estrictamente formateado.

**Estructura Obligatoria:**
```sql
/* Procedimiento : [nombre_del_pa]

   Entrada :
   @[parametro_1]       -> [Descripción sin tildes ni caracteres especiales]. (Obligatorio/Opcional)
   @[parametro_2]       -> [Descripción sin tildes ni caracteres especiales]. (Obligatorio/Opcional)

   Objetivo : [Descripción de 1 o 2 líneas sobre lo que hace el PA]

   Creacion: [Iniciales] [YYYY/MM/DD]
   Actualizacion: [Iniciales] [YYYY/MM/DD] (o "Sin registro")
*/
```

### Reglas Específicas de la Cabecera:
- **Sin Caracteres Especiales:** Para evitar problemas de codificación (`latin1` vs `UTF-8`) entre el motor de Sybase y los distintos editores de texto en Windows, **está estrictamente prohibido usar tildes o la letra "ñ"** en las descripciones de los parámetros. 
  - *Correcto:* `Numero`, `Parametro`, `Ano`, `Codigo`, `Prestacion`.
  - *Incorrecto:* `Número`, `Parámetro`, `Año`, `Código`, `Prestación`.
- **Sección de Entrada Dinámica:** Si un PA no recibe parámetros, la sección `Entrada :` debe eliminarse por completo. No debe dejarse la etiqueta vacía ni decir "Sin parámetros".
- **Limpieza del Objetivo:** El campo `Objetivo` debe ser un resumen limpio. **NO** se deben dejar manuales de uso, descripciones de parámetros duplicados ni notas de desarrollador colgando dentro de este bloque. Solo se permite mantener un sub-bloque `TODO :` si hay funcionalidad pendiente explícita.
- **Sincronización:** Todos los parámetros listados en la cabecera deben existir exactamente igual en la declaración `CREATE PROCEDURE`, indicando claramente con `(Opcional)` si poseen `= NULL` o `(Obligatorio)` si no lo poseen.

## 2. Limpieza de Código Residual

- **Cero 'EXECUTE' Comentados:** No deben existir bloques de prueba tipo `/* EXECUTE ... */` o `EXEC secgen_db...` comentados al final del archivo. Las pruebas deben ejecutarse en la consola SQL y no quedar registradas en el código fuente del procedimiento base.

## 3. Seguridad de Datos (OWASP) y Manejo de Errores

Los Procedimientos Almacenados interactúan directamente con el Frontend a través de la capa de servicios. Por motivos de seguridad:

- **Ocultamiento de Infraestructura:** Queda **estrictamente prohibido** devolver nombres de tablas, columnas internas, nombres de bases de datos o detalles de arquitectura en los mensajes de retorno (`msg` o `mensaje`) enviados por el PA.
  - *Incorrecto:* `SELECT 'El flujo no existe en la tabla sg_tfls' AS mensaje`
  - *Correcto:* `SELECT 'El flujo no existe o no está configurado' AS mensaje`
- **Mensajes Orientados al Usuario:** Los mensajes de error de validaciones de negocio deben estar redactados pensando en que podrían ser expuestos al usuario final o al log de auditoría sin exponer la estructura de la BDD.
