# Reglas de Estandarización para Procedimientos Almacenados (PA)

Este documento detalla las reglas de codificación, formato, arquitectura y seguridad que deben seguir todos los Procedimientos Almacenados (PA) del sistema, alineadas con los manuales institucionales de la DINFO (DINFO-CSG-DEF-00003 / DINFO-CSG-DEF-00004) y los estándares del proyecto SG-Solicitudes / DU288.

---

## 1. Estructura Canónica de 5 Bloques

Todo script de Procedimiento Almacenado debe seguir estrictamente la secuencia de 5 bloques:

```sql
use secgen_db
go

if exists (select 1 from sysobjects a, sysusers b
              where a.uid  = b.uid
                and a.type = 'P'
                and b.name = 'Analisis2'
                and a.name = 'sg_soliuSecgen01')
   drop procedure Analisis2.sg_soliuSecgen01

go

/* Procedimiento : sg_soliuSecgen01

   Entrada :
   @nro_solici          -> Numero de solicitud. (Opcional)
   @cod_estsol          -> Codigo de estado de solicitud. (Opcional)
   @rut_solici          -> RUT del solicitante. (Opcional)

   Objetivo : Actualizar estado de la solicitud

   Creacion: ELA 2026/08/24
   Actualizacion: Sin registro
*/
create procedure Analisis2.sg_soliuSecgen01
    @nro_solici int = null,
    @cod_estsol tinyint = null,
    @rut_solici char(9) = null
as

if @nro_solici is null
begin
    select 'Falta campo Numero Solicitud' as msg
    return
end

begin tran

update sg_soli
   set cod_estsol = @cod_estsol
 where nro_solici = @nro_solici
   and rut_solici = @rut_solici

if @@transtate = 2 or @@transtate = 3
begin
    select 'Error al actualizar informacion de solicitud. Se aborta el procedimiento' as msg
    if @@transtate = 2
        rollback tran
    return
end

commit tran
go

grant execute on Analisis2.sg_soliuSecgen01 to UsuaVrac
go
```

---

## 2. Reglas de Formato y Sintaxis SQL

### 2.1. Uso Exclusivo de Minúsculas en SQL y Tipos
* **Palabras Clave en Minúsculas:** Todas las sentencias y cláusulas SQL deben escribirse en minúsculas (`select`, `from`, `where`, `insert into`, `update`, `delete`, `declare`, `set`, `as`, `and`, `or`, `not`, `if`, `exists`, `begin`, `end`, `return`, `create procedure`, `drop procedure`, `grant execute on`, `order by`, `group by`, `having`, `left join`, `inner join`, `begin tran`, `commit tran`, `rollback tran`, etc.).
* **Tipos de Datos en Minúsculas:** `int`, `smallint`, `tinyint`, `varchar(...)`, `char(...)`, `datetime`, `numeric(...)`, `decimal(...)`, `float`, `money`, `bit`, `text`.
* **Funciones del Sistema en Minúsculas:** `getdate()`, `charindex(...)`, `substring(...)`, `convert(...)`, `count(...)`, `sum(...)`, `max(...)`, `min(...)`, `object_id(...)`, `isnull(...)`, `rtrim(...)`, `ltrim(...)`.
* **Tablas Temporales:** En minúsculas (ej. `create table #meses (...)`, `drop table #meses`).
* **Literales de Texto:** Los textos entre comillas simples conservan su formato original (ej. `'OK'`, `'S'`, `'N'`, `'Falta campo...'`).

### 2.2. Saltos de Línea y Espaciado de Cabecera
* **Cierre de Comentario `*/` y `create procedure`:** No debe haber líneas en blanco entre el cierre `*/` y el inicio de `create procedure Analisis2.<nombre_pa>`.
* **Identación de Parámetros:** 4 espacios por parámetro, declarando cada parámetro en su propia línea.
* **Ubicación de `as`:** La palabra `as` va en su propia línea después del último parámetro, seguida de una línea en blanco antes de comenzar la lógica.
* **Prohibición de Líneas Colapsadas:** Queda prohibido agrupar en una sola línea la cabecera, parámetros y primeras sentencias.

---

## 3. Bloque de Comentarios Superior (Cabecera)

**Estructura Obligatoria:**
```sql
/* Procedimiento : [nombre_del_pa]

   Entrada :
   @[parametro_1]       -> [Descripcion sin tildes ni caracteres especiales]. (Obligatorio/Opcional)
   @[parametro_2]       -> [Descripcion sin tildes ni caracteres especiales]. (Obligatorio/Opcional)

   Objetivo : [Descripcion de 1 o 2 lineas sobre lo que hace el PA]

   Creacion: [Iniciales] [YYYY/MM/DD]
   Actualizacion: Sin registro
*/
```

### Reglas Específicas de la Cabecera:
* **Sin Caracteres Especiales (ASCII 7-bit):** Para evitar problemas de codificación (`latin1` vs `UTF-8`) con el cliente Sybase y Windows XP/Server, **está estrictamente prohibido usar tildes o la letra "ñ"** en las descripciones.
  * *Correcto:* `Numero`, `Parametro`, `Ano`, `Codigo`, `Prestacion`.
  * *Incorrecto:* `Número`, `Parámetro`, `Año`, `Código`, `Prestación`.
* **Línea Base Inicial:** Para la entrega inicial del repositorio, el campo de actualización debe registrarse como `Actualizacion: Sin registro`.
* **Sección de Entrada Dinámica:** Si un PA no recibe parámetros, la sección `Entrada :` se omite.
* **Limpieza del Objetivo:** Debe ser conciso (1 a 2 líneas). No duplicar documentación de parámetros ni manuales dentro del objetivo.

---

## 4. Codificación de Archivos y Saltos de Línea

* **Extensión:** `.txt`
* **Codificación:** ASCII puro de 7 bits (0 bytes $> 127$).
* **Fin de Línea (EOL):** Windows CRLF (`\r\n`).

---

## 5. Limpieza de Código Residual

* **Cero 'EXECUTE' Comentados:** No deben existir bloques de prueba comentados (`/* execute ... */`) al final del archivo.
* **Cero Comentarios Informales en el Cuerpo:** No incluir notas de desarrollo (`ADR-xxx`, `DU288`, `backend`, `TODO`). El código SQL debe ser auto-explicativo.

---

## 6. Seguridad de Datos (OWASP) y Manejo de Errores

* **Ocultamiento de Infraestructura:** Queda prohibido devolver nombres de tablas o detalles internos en los mensajes (`msg` o `mensaje`) enviados al frontend.
  * *Incorrecto:* `select 'El flujo no existe en la tabla sg_tfls' as msg`
  * *Correcto:* `select 'El flujo no existe o no se encuentra configurado' as msg`
* **Contrato de Retorno:** Todo PA de mutación (`insert`/`update`/`delete`) o validación debe mantener consistencia con los contratos esperados por la capa de servicios backend (`select 1 as status, 'OK' as msg` o mensajes descriptivos de error).
