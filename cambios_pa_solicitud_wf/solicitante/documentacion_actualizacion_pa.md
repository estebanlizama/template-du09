# Documentación de Actualización: sg_fupssSecgen01 y sg_fupssSecgen03

## Cambios Realizados (2026/05/20)

### 1. Implementación Real de `flag_inh_cargo`

Se reemplazó el placeholder `'PENDIENTE'` / `'N'` por la lógica real de inhabilidad por cargo según **DU09/2026 (DU288)**.

**Fuente de datos**: `sisper_db..sp_cont.cod_cargo` → `sisper_db..sp_carg.cod_tipcar`

**Reglas implementadas** (en orden de prioridad):

| Prioridad | Condición | Resultado |
|---|---|---|
| 1 | Permiso Sin Goce de Sueldo vigente (`sp_ause.cod_tipaus = '2'`) | `'S'` |
| 2 | Unidad de Contraloría (`cod_unidad LIKE '004004%'`) | `'S'` |
| 3 | Decano (`cod_cargo=3110`) sin ANID (`@ind_anid='N'`) | `'S'` |
| 4 | Decano (`cod_cargo=3110`) con ANID (`@ind_anid='S'`) | `'N'` (excepción) |
| 5 | Director Instituto Independiente (`cod_cargo=3120`) | `'N'` (permitido) |
| 6 | Cualquier Directivo (`cod_tipcar='5'`) | `'S'` |
| 7 | Resto de cargos | `'N'` |

### 2. Nuevo Parámetro `@ind_anid`

Ambos SPs ahora reciben `@ind_anid char(1) = 'N'`.

- **Origen**: Campo `secgen_db..sg_prse.ind_anid`, leído al seleccionar el Centro de Costo.
- **El backend** debe pasar este parámetro al llamar el SP.

### 3. Nuevo campo `flag_perm_sin_goce`

Añadido para que el frontend pueda mostrar un indicador diferenciado ("Permiso Sin Goce de Sueldo") separado del indicador genérico de inhabilidad por cargo.

### 4. Nuevo campo `flag_es_dir_inst_indep`

`'S'` cuando `cod_cargo = 3120` (Director Instituto Independiente). El frontend debe mostrar una alerta informativa de que aplica tope de Nivel C calculado anualmente.

### 5. Nuevo JOIN con `sp_carg`

Se añadió `INNER JOIN sisper_db..sp_carg carg ON carg.cod_cargo = con.cod_cargo` para obtener `cod_tipcar` y `nom_cargo` directamente en el resultado.

---

## Próximos Pasos

1. **Validación de licencias médicas**: Confirmar `cod_tipaus` exacto para licencias médicas en `sisper_db..sp_taus` (producción).
2. **Deudas institucionales**: Integrar con módulo de Cobranzas para `flag_tiene_deudas` (Regla efectiva desde 01/01/2027).
3. **Frontend P01-B07**: Mostrar indicador visual por cada flag:
   - `flag_inh_cargo = 'S'` → 🔴 Bloquear botón "Agregar Funcionario".
   - `flag_es_dir_inst_indep = 'S'` → 🟡 Mostrar alerta de tope Nivel C.
   - `flag_perm_sin_goce = 'S'` → 🔴 Mostrar mensaje específico de permiso.
4. **Excepción ANID en topes**: El backend debe ignorar `tope_maximo_mensual` si `ind_anid = 'S'`.
