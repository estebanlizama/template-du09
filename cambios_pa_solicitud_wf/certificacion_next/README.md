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

1. `entrega/es_cfersSecgen01.sql`
2. `entrega/sg_fucoiSecgen01.sql`
3. `entrega/sg_fumeuSecgen01.sql`
4. `entrega/sg_fupssSecgen17.sql`
5. `entrega/sg_fupsiSecgen01.sql`
6. `entrega/sg_fupsuSecgen01.sql`
7. `datos_base/01_catalogo_tpps_fijo_variable.sql`

Instalar `es_cfersSecgen01` antes de liberar el backend/frontend que consulta
el calendario. `es_cfersSecgen01` y `sg_fucoiSecgen01` dependen de la tabla
existente `ufro_db.dbo.es_cfer`. Los demás PA no tienen una dependencia de
ejecución entre sí. No se requieren cambios de estructura.

`sg_fupssSecgen17` acompaña un cambio de backend (los borradores dejan de
escribir `sg_fume`). Ver «Quién reserva capacidad» más abajo: ambos cambios se
complementan y conviene liberarlos juntos.

## Contenido

### `entrega/es_cfersSecgen01.sql` — calendario institucional DU288

Recibe un rango inclusivo y retorna, en una sola consulta, `f_feriado`,
`cod_tipfer` y `des_tipfer` para los tipos vigentes del requerimiento:

- `1`: feriado nacional; bloquea ejecución y compensación.
- `2`: feriado universitario; se muestra como información.
- `3`: suspensión de actividades lectivas; se muestra como información.

La descripción se resuelve dentro del PA mediante el catálogo fijo aprobado
para los códigos `1`, `2` y `3`. No se consulta `es_tipfer`, porque esa tabla no
existe o no está publicada bajo `ufro_db.dbo` en el ambiente objetivo. La
cuenta/propietario que instale y ejecute los PA solo debe poder leer
`ufro_db.dbo.es_cfer`. Este permiso no pudo validarse desde el ambiente local;
debe confirmarlo DBA durante la instalación.

El backend consume este PA mediante un endpoint autenticado y calcula las
ocurrencias reales del horario semanal FUHO. En un feriado nacional las horas
programadas se muestran como no ejecutadas y no forman parte del total efectivo
esperado. Si el PA aún no existe, el backend solo admite el respaldo estático
para el pequeño rango que este cubre (`2025-12-30` a `2026-01-02`); fuera de
ese rango falla de forma segura para no afirmar que un año incompleto no tiene
feriados.

### `entrega/sg_fucoiSecgen01.sql` — defensa de feriado nacional

Agrega una validación autoritativa antes del `INSERT`: rechaza un tramo de
compensación si su segmento inicial, o el segmento posterior a medianoche con
duración real, cae en una fecha de `es_cfer` tipo `1`. Los tipos `2` y `3` no
bloquean. Esta defensa complementa la prevalidación del calendario en Vue y la
validación LoopBack; no depende de que el cliente envíe correctamente la fecha.

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

### `entrega/sg_fupsiSecgen01.sql` y `entrega/sg_fupsuSecgen01.sql` — persistir `tot_cuotas`

**Corrige un dato que se perdía en silencio.** Ambos PA recibían `@tot_cuotas`
y lo descartaban antes de escribir: el de alta con `SELECT @tot_cuotas = NULL`,
y el de actualización además con `tot_cuotas = NULL` fijo dentro del `UPDATE`.
El solicitante elegía «Cuotas esperadas», el frontend y el backend lo enviaban
correctamente, y el valor moría en el PA.

Ese `NULL` venía de cuando DU288 no usaba el campo. Hoy `sg_fups.tot_cuotas`
guarda las **cuotas declaradas por el solicitante**, que fijan el techo del
bruto (tope × cuotas, S0-013 Q-C01/Q-C02). Ahora se persiste, con `1` por
defecto si no llega — mismo criterio que `periodos` en esos mismos PA y mismo
valor por defecto que usa el formulario.

`cod_tpps` (1 = Fijo, 2 = Variable) **ya se persistía bien** en ambos PA; su
problema era de lectura y se corrigió en el frontend, que no restauraba ninguno
de los dos campos al reabrir un funcionario guardado.

#### `monto_mes` pasa a contener el monto mensual real

Antes, en DU288, `monto_mes` quedaba igual a `mto_total`: el PA lo defaulteaba a
`@mto_total` y el cliente enviaba el total. La columna se llama «monto mes», se
muestra en el comparador de prestaciones anteriores bajo la etiqueta **«Monto
mensual»** y se usa para contrastar contra un tope mensual — pero contenía un
total. El código lo compensaba dividiendo por los meses en dos lugares, con el
defecto documentado en comentario.

Ahora ambos PA **recalculan siempre** el valor en la rama DU288:

```sql
SELECT @meses_ejec = datediff(month, @f_inicio, @f_termino) + 1
SELECT @monto_mes  = @mto_total / @meses_ejec
```

Decisiones detrás de esto:

- **Se recalcula, no se defaultea.** Un `IF @monto_mes IS NULL` no habría servido:
  el cliente sí manda un valor (el total), así que el PA lo habría persistido
  igual. Al recalcular sin condición, el dato queda al día ante cualquier cambio
  de fechas o de monto, y ningún cliente puede corromperlo.
- **El de actualización usa las fechas persistidas cuando no llegan.** Allí
  `@f_inicio`/`@f_termino` son opcionales (el guard es
  `IS NOT NULL AND … >`), así que el cálculo cae a `isnull(@f_inicio, f_inicio)`
  leyendo la fila existente.
- **Sin rama por tipo.** En Fijo el valor es el monto comprometido; en Variable,
  el promedio estimado. Quién es cuál lo dice `cod_tpps`, igual que `mto_total`
  necesita `cod_moneda`.
- **No hay caso sin datos.** Ambos PA ya exigen `@mto_total` y, en el de alta,
  `@f_inicio`/`@f_termino` con orden validado, antes de llegar a la rama. El
  divisor es siempre ≥ 1: no hace falta un respaldo de `0` ni una estimación
  alternativa. `@mto_total` es `decimal(19,2)`, así que no hay truncamiento
  entero.

> **Regla:** `monto_mes` **no es autoritativo por sí solo; se lee junto a
> `cod_tpps`.** El monto autorizado sigue siendo `mto_total`, y la validación de
> tope sigue siendo `ceil(mto_total ÷ mto_tope) <= tot_cuotas` — que **no** mira
> `monto_mes`. Es deliberado: un `monto_mes` incorrecto no puede abrir un agujero
> en el control del tope.

`periodos` se mantiene en `1`. El producto `periodos × monto_mes` **no** es el
total en DU288 y ningún consumidor lo usa: la resolución toma `s.total`,
`ResolutionDetail` corta con `if (isDu288) return 0`, y el PDF omite el campo.

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

Para `sg_fupsiSecgen01` / `sg_fupsuSecgen01`, el ida y vuelta completo:

| # | Caso | Resultado esperado |
|---|---|---|
| 1 | Guardar borrador con «Variable» y 2 cuotas | `sg_fups.cod_tpps = 2` y `tot_cuotas = 2` |
| 2 | Reabrir el funcionario para editar | Muestra «Variable» y 2 cuotas, no los valores por defecto |
| 3 | Guardar sin informar cuotas | `tot_cuotas = 1`, nunca `NULL` |
| 4 | Solicitud no DU288 | `tot_cuotas` sigue llegando como `NULL` desde el backend; sin cambio de comportamiento |
| 5 | Guardar $900.000 con ejecución oct–dic (3 meses) | `monto_mes = 300000`, `mto_total = 900000` |
| 6 | Editar solo las fechas a oct–nov (2 meses) | `monto_mes` pasa a `450000` **solo**; el cliente no lo envía |
| 7 | Ejecución de 1 mes | `monto_mes = mto_total`; ambas semánticas coinciden |
| 8 | Solicitud no DU288 | `monto_mes` sigue siendo el que envía el cliente; el recálculo no aplica |

`sg_fume.mto_apagar` debe permanecer `NULL` en todos los casos: la resolución no
distribuye el monto por mes, eso lo define el pago. Verificado que ningún PA,
backend ni frontend lo escribe — solo se lee en `sg_fupssSecgen17`.

El calendario institucional y la defensa FUCO también requieren smoke test en
Sybase, porque no existe conexión local con `ufro_db`:

| # | Caso | Resultado esperado |
|---|---|---|
| 5 | Consultar un rango con tipos 1, 2 y 3 | Retorna fecha, código y descripción ordenados |
| 6 | FUHO recurrente sobre fecha tipo 1 | La aplicación muestra la ocurrencia como no ejecutada y descuenta sus horas |
| 7 | Insertar FUCO en fecha tipo 1 | Mensaje de negocio y ninguna fila insertada |
| 8 | Insertar FUCO en fecha tipo 2 o 3 | Permitido si cumple las demás reglas |
| 9 | Tramo FUCO nocturno cuyo segundo segmento toca tipo 1 | Rechazado; si termina exactamente a las 00:00 no crea un segmento vacío |

## No incluido — pendiente de decisión funcional

| Cambio | Estado |
|---|---|
| Escribir `mto_apagar` por mes en `sg_fume` | Bloqueado por S0-013 **Q-B13** (qué par de columnas representa el mes de ejecución). Ver `reglas_pagos/01_reglas_montos_por_tipo_de_flujo.md`: la recomendación es no persistirlo en la resolución. |
| Qué hacer con `sg_fum2` al quitar una cuota | Pregunta abierta para el diseño del flujo de pago. `sg_fum2` es historial de cambios, pero su FK a `sg_fume` es `ON DELETE RESTRICT`: si el pago escribe historial de una cuota que sigue en estado 1 o 3 (editable), esa cuota **ya no se podría quitar nunca**, y una tabla de auditoría pasaría a funcionar como candado. Las salidas son que el borrado de la cuota arrastre su historial, o que esa FK no sea `RESTRICT`. Hoy no se manifiesta porque ningún proceso escribe `sg_fum2`; el guard queda como red hasta que exista pagos. |

## Advertencia sobre datos existentes

`sg_fups.monto_mes` **no** contiene el monto mensual: los PA de alta y
actualización lo fuerzan a `mto_total`, y `periodos` a `1`, por compatibilidad
con la BDD vigente. El único monto autoritativo es `mto_total`.
