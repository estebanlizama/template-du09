# Despliegue FUCO con la estructura actual

El error `Stored procedure 'secgen_db.Analisis2.sg_fucodSecgen01' not found` indica que el backend fue actualizado antes de instalar todos los objetos requeridos en la base de datos conectada.

## Orden obligatorio

No se modifica la tabla ni sus índices. Solo se reemplazan los procedimientos almacenados.

1. `solicitante/sg_fucodSecgen01.sql`
2. `solicitante/sg_fucoiSecgen01.sql`
3. `solicitante/sg_fucosSecgen01.sql`
4. `solicitante/sg_fucouSecgen01.sql`, para mantener compatible el consumidor CSV anterior.
5. `maestros/verificar_despliegue_sg_fuco_multiples_tramos.sql`

Los PA incluyen `GRANT EXECUTE` para `UsuaVrac`. Si la aplicación se conecta con otro usuario o rol, se debe otorgar el permiso equivalente a ese principal.

## Resultado esperado de la verificación

- `dbo.sg_fuco` debe conservar únicamente `id_funprse`, `fec_compro`, `hora_ini` y `hora_ter` para este registro.
- La clave primaria y el índice `PK_sg_fuco` permanecen en `id_funprse + fec_compro`.
- `fec_compro` guarda la fecha y hora real de inicio, permitiendo varios tramos del mismo día sin modificar la PK.
- Cuando `hora_ter < hora_ini`, el término corresponde al día siguiente; ambas fechas deben permanecer dentro del período autorizado.
- Deben aparecer cuatro procedimientos con propietario `Analisis2`.
- Las tres ejecuciones de prueba deben responder con errores funcionales por parámetros faltantes. No deben responder `Stored procedure not found` ni modificar registros.

Después de instalar los objetos no se requiere recompilar el backend. Se puede repetir el guardado que falló; la transacción anterior fue revertida completamente.

## Convención de horarios

- `2026-08-19`, `17:18` a `18:00`: inicia y termina el mismo día.
- `2026-08-19`, `23:00` a `01:00`: inicia el 19 y termina el 20; duración total de 2 horas.
- Dos tramos del mismo día son válidos cuando tienen distintas horas de inicio y no se superponen.
- Un tramo nocturno también se compara con los registros del día siguiente. Por ejemplo, `19/08 23:00-01:00` se superpone con `20/08 00:30-02:00`.
- Horas iguales, como `23:00-23:00`, son inválidas porque la tabla no dispone de una fecha de término explícita para distinguir duración cero de 24 horas.
- El inicio y el término deben quedar dentro del período autorizado y sus segmentos deben corresponder a días hábiles.
