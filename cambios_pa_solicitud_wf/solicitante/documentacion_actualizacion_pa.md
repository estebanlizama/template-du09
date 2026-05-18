# Documentación de Actualización: sg_fupsSecgen01

## Cambios Realizados

### 1. Cambio de Origen de Datos (Mapeo de Grado)
Se migró la lógica de `sisper_db..sp_carg` a `sisper_db..sp_cont`. 
- **Razón**: `sp_cont` contiene el historial y estado vigente de los contratos con mayor detalle financiero y estructural, incluyendo el campo `cod_niv_gr` (Grado) y `total` (Renta Bruta consolidada).
- **Mapeo**: 
    - `con.cod_niv_gr` -> Grado del funcionario.
    - `nig.des_niv_gr` -> Descripción del grado (Escala).

### 2. Implementación de la "Regla del 50%" y Topes Estamentarios
Se añadió una lógica de `CASE` para calcular el `tope_maximo_mensual` según el estamento:
- **Académicos**: 50% de su renta bruta propia.
- **Planta Técnica**: Máximo $621.634.
- **Planta Administrativa**: Máximo $553.079.
- **Planta Auxiliar**: Máximo $382.519.
- **Profesional**: $1.411.396 (Referencia Grado 4).

### 3. Detección de Autoridades (Inhibición)
Se añadió el campo `es_autoridad_inhabilitada`.
- **Lógica**: Verifica si el cargo actual del funcionario pertenece a las categorías directivas (`cod_categ` 1, 2, 5 u 8), las cuales están inhabilitadas para tramitar DU09 según la normativa (Rectoría, Decanatos, etc.).

### 4. Sugerencia de Jornada
- Si el estamento es Académico, sugiere 'D' (Dentro de jornada).
- Si es No Académico, sugiere 'F' (Fuera de jornada), alineado con la normativa de horas extraordinarias vs. labor ordinaria.

## Próximos Pasos Recomendados
1. **Validación en Frontend**: Usar el campo `tope_maximo_mensual` para validar el input del usuario en tiempo real.
2. **Excepción ANID**: Recordar que si el proyecto es ANID, el backend debe ignorar el tope calculado por este procedimiento.
