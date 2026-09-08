# Certificación DU288 — próxima release

Paquete acumulativo de cambios de BDD posteriores a `certificacion_03_09_2026`.
Mismo criterio que el paquete anterior: `entrega/` solo PA (pares SQL + TXT con
el mismo código, formatos alternativos), `datos_base/` solo cargas de datos.

```text
certificacion_next/
├── entrega/         PA modificados
├── datos_base/      Cargas y actualizaciones de catálogo
└── README.md        Alcance, orden y pendientes
```

## Orden de ejecución

1. `entrega/sg_fumeuSecgen01.sql`
2. `entrega/sg_fupssSecgen17.sql`
3. `datos_base/01_catalogo_tpps_fijo_variable.sql`

Sin dependencias entre ellos: pueden ejecutarse en cualquier orden. No
requieren cambios de estructura (ni `CREATE TABLE` ni `ALTER TABLE`).

`sg_fupssSecgen17` acompaña un cambio de backend (los borradores dejan de
escribir `sg_fume`). Ver «Quién reserva capacidad» más abajo: ambos cambios se
complementan y conviene liberarlos juntos.

## Contenido

### `entrega/sg_fumeuSecgen01.sql` — sincronización diferencial de meses

**Corrige un bloqueador en producción.** El PA borraba todas las cuotas del
funcionario en cada guardado, aunque los meses no hubieran cambiado. Como
`sg_fuc2` (compensaciones por cuota) tiene FK con `ON DELETE RESTRICT` hacia
`sg_fume`, cualquier funcionario con compensaciones registradas hacía fallar
el guardado completo de la solicitud:

```text
Dependent foreign key constraint violation ... constraint name = 'FK_sg_fuc2_sg_fume'
```

Ahora la sincronización es diferencial:

1. Determina qué cuotas salen (existen y ya no están en la propuesta).
2. Si alguna tiene dependientes en `sg_fuc2` o `sg_fum2`, corta con mensaje de
   negocio en vez de dejar que reviente la FK.
3. Borra solo esas. Las que siguen no se tocan.
4. Inserta solo los meses nuevos, con `nro_cuota = max(existente) + n`.

#### `sg_fuco` y `sg_fuc2` no son la misma cosa

Los dos guards del punto 2 son **redes de seguridad de integridad**, no reglas
de negocio de la etapa de solicitud. Es importante no confundir las tablas:

| Tabla | Qué guarda | FK | Quién la escribe |
|---|---|---|---|
| `sg_fuco` (`id_funprse`, `fec_compro`) | Compensación **declarada** por el solicitante | → `sg_fups` | La solicitud: `sg_fucodSecgen01` + `sg_fucoiSecgen01`, borrado y reinserción completa en cada guardado |
| `sg_fuc2` (`id_funprse`, `nro_cuota`, `fec_comrea`) | Compensación **realizada**, por cuota | → `sg_fume` `RESTRICT` | El flujo de pago. Ningún PA, backend ni frontend de solicitud escribe esta tabla |

`sg_fuco` no tiene ninguna relación con `sg_fume`: cambiar los meses de
ejecución **nunca** puede chocar con las compensaciones que declara el
solicitante. Por eso los mensajes de los guards nombran explícitamente el
proceso de pago; el texto anterior (*"que ya tiene compensaciones
registradas"*) usaba el vocabulario del solicitante para hablar de otra cosa e
inducía a buscar el problema donde no estaba.

En un flujo limpio estos guards son **inalcanzables**: el guard previo de
`cod_estcuo NOT IN (1, 3)` ya bloquea cualquier cuota que haya entrado a
visación o pago, que es la única forma de que existan filas en `sg_fuc2`. Si
alguno se dispara en un ambiente, lo primero a revisar es si hay datos de
prueba residuales en `sg_fuc2`/`sg_fum2` (ver `limpia_datos_pds_desarrollo.sql`).

**Cambio de comportamiento a considerar:** el PA anterior garantizaba que
`nro_cuota` seguía orden cronológico estricto. Ahora prioriza la estabilidad
del número: un mes que se quita y se vuelve a agregar recibe un número nuevo al
final. Es lo que pide S0-013 Q-B10 (*"si debe quedar registrado"*) y lo que
evita romper las FK. El orden cronológico real se deriva de
`ano_prop`/`mes_prop`.

**Detalles de implementación** (no van comentados en el PA, por la regla de
`reglas_estandarizacion_pa.md` §2):

- Lleva `SET NOCOUNT ON`, mismo criterio que `sg_fupsiSecgen01` y
  `sg_fupsdSecgen01`.
- Los dos guards que detectan compensaciones/historial (`sg_fuc2`/`sg_fum2`)
  corren **antes** de `BEGIN TRAN`, no dentro. Se probó primero dentro de la
  transacción (con `ROLLBACK TRAN` condicional antes del `RETURN`) y el puente
  Java (`ExecSQLCallable.java`, driver jConnect `jconn3.jar`) fallaba con
  `010P4: se ha recibido e ignorado un parámetro de salida` al procesar esa
  respuesta -- confirmado con DBeaver: el mismo `EXECUTE` devuelve el mensaje
  de negocio correctamente fuera de la aplicación, así que el PA estaba bien y
  el problema era el puente ante un `SELECT` seguido de `ROLLBACK TRAN` con la
  transacción abierta. Los guards que ya existían antes de esta sesión (falta
  de parámetro, etc.) nunca tuvieron este problema porque siempre retornan
  antes de abrir transacción alguna -- se aplicó el mismo criterio a los
  nuevos.
- Las cuotas que salen se materializan en `#cuotas_salen` y el `DELETE` filtra
  con `IN (SELECT ...)`. Una versión previa usaba columnas sin calificar dentro
  de un `NOT EXISTS` en el `DELETE`, asumiendo que resolverían contra la tabla
  destino; en ASE 12.5 resuelven contra el `FROM` de la subconsulta y fallaba
  con `Invalid column name 'mes_prop'`.
- Los tres `CREATE TABLE` van antes del `BEGIN TRAN`: ASE 12.5 no permite
  `CREATE TABLE` dentro de una transacción multi-statement.
- Todas las construcciones usadas tienen precedente funcionando en este
  repositorio: `SET NOCOUNT ON` (3 PA), tabla temporal con `identity` (el
  `#meses` original), `NOT EXISTS` (15 PA), `IN (SELECT ...)` (18 PA),
  asignación con agregado (`sg_eta2sSecgen01`), `isnull` (30 PA).

**Riesgo pendiente, sin resolver:** el PA aún tiene tres bloques heredados de
la versión anterior (`Error al limpiar meses de ejecucion anteriores`, `Error
al determinar los meses de ejecucion nuevos`, `Error al insertar meses de
ejecucion`) con el mismo patrón `SELECT` + `ROLLBACK TRAN` condicional dentro
de la transacción -- el mismo que causó el 010P4. No se tocaron porque nunca
se reprodujo una falla real de `DELETE`/`INSERT` para confirmar si el puente
también falla ahí, y quitar el `ROLLBACK` sin poder probarlo dejaría una
transacción abierta sin cerrar ante un error real de esas sentencias. Si
alguna vez se dispara uno de esos tres mensajes, revisar si también da 010P4.

### `entrega/sg_fupssSecgen17.sql` — quién reserva capacidad

Este PA arma el historial de PDS previas del funcionario, que alimenta las
validaciones de **tope mensual**, **mes bloqueado por centro de costo** y
**cupo de cuotas**. Su filtro de estados estaba mal en los dos extremos:

| Estado | Antes | Ahora | Motivo |
|---|---|---|---|
| 4 Rechazada | Excluida | Excluida | Correcto: ya no compromete nada |
| 7 Enviada a firma | **Excluida** | **Incluida** | Es un estado activo, prácticamente aprobado. Al ocultarla, una PDS a punto de firmarse era invisible para las validaciones y se podía crear una segunda que chocara con ella |
| 5 Borrador | Incluida | Incluida, pero ya no aparece | Ver abajo |

**Cambio de backend que lo acompaña:** los borradores dejan de escribir
`sg_fume` (`syncNormativeRequestStaffMonths` ahora solo corre al enviar). Antes
un borrador ya bloqueaba meses y consumía cupo de cuotas de otras solicitudes
del funcionario sin que nadie hubiera aprobado nada — y un borrador abandonado
dejaba el mes inutilizable. El borrador no pierde información: los meses se
derivan de `f_inicio`/`f_termino`, que sí quedan en `sg_fups`.

Por eso no hizo falta excluir el estado 5 en el filtro: se corrigió en el
origen (quién escribe) en vez de repartir el criterio entre cada validación
que consume el historial.

Resultado:

- **Borrador** → no escribe, no reserva
- **Enviada / en revisión / aprobada / firmada** → escribe y reserva
- **Rechazada** → filtrada, libera

### `datos_base/01_catalogo_tpps_fijo_variable.sql` — descripción de `sg_tpps`

Cosmético, sin impacto funcional. DU288 usa `cod_tpps` como señal de tipo de
monto (1 = Fijo, 2 = Variable) en vez de agregar una columna nueva. Este script
alinea la descripción del catálogo con ese uso. Ningún consumidor lee
`des_tpps` — se verificó por búsqueda en backend y frontend — así que no altera
comportamiento.

## Verificación pendiente

`sg_fumeuSecgen01` **no está probado contra la base**: es lógica Sybase pura,
sin cobertura automatizada posible. Antes de producción:

| # | Caso | Resultado esperado |
|---|---|---|
| 1 | Guardar sin cambiar meses | Pasa sin tocar `sg_fume` (era el caso que fallaba) |
| 2 | Agregar un mes | Se inserta con número nuevo; los existentes intactos |
| 3 | Quitar un mes | Se borra, sin importar lo que tenga en `sg_fuco` |
| 4 | Quitar un mes con fila en `sg_fuc2` (insertada a mano, el flujo de solicitud no la genera) | Mensaje de negocio, no error 500 ni `010P4` |

El caso 4 es el único que ejercita el guard, y requiere fabricar el dato: en un
ambiente limpio no se alcanza. El caso 3 es el que importa para el flujo real —
las compensaciones del solicitante viven en `sg_fuco` y no bloquean nada.

## No incluido — pendiente de decisión funcional

| Cambio | Estado |
|---|---|
| Persistir `tot_cuotas` (quitar `SELECT @tot_cuotas = NULL` de `sg_fupsiSecgen01` y `sg_fupsuSecgen01`) | Esperando confirmación. Mientras no se haga, el campo "Cuotas esperadas" valida el techo en pantalla pero no queda guardado. |
| Escribir `mto_apagar` por mes en `sg_fume` | Bloqueado por S0-013 **Q-B13** (qué par de columnas representa el mes de ejecución). Ver `reglas_pagos/01_reglas_montos_por_tipo_de_flujo.md`: la recomendación es no persistirlo en la resolución. |
| Qué hacer con `sg_fum2` al quitar una cuota | Pregunta abierta para el diseño del flujo de pago. `sg_fum2` es historial de cambios, pero su FK a `sg_fume` es `ON DELETE RESTRICT`: si el pago escribe historial de una cuota que sigue en estado 1 o 3 (editable), esa cuota **ya no se podría quitar nunca**, y una tabla de auditoría pasaría a funcionar como candado. Las salidas son que el borrado de la cuota arrastre su historial, o que esa FK no sea `RESTRICT`. Hoy no se manifiesta porque ningún proceso escribe `sg_fum2`; el guard queda como red hasta que exista pagos. |

## Advertencia sobre datos existentes

`sg_fups.monto_mes` **no** contiene el monto mensual: los PA de alta y
actualización lo fuerzan a `mto_total`, y `periodos` a `1`, por compatibilidad
con la BDD vigente. El único monto autoritativo es `mto_total`.
