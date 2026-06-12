# Requerimientos de SP sg_fupssSecgen11 - Remuneracion Efectuada

## Objetivo

Obtener la remuneracion efectuada de referencia de un funcionario candidato a DU288.

Este SP calcula montos desde haberes historicos (`sisper_db.dbo.ss_habe`) por ficha y mes. No se asocia a un contrato especifico, porque los haberes pueden no tener `cod_contra` informado.

---

## Parametros de Entrada

| Parametro | Tipo | Descripcion |
| :--- | :--- | :--- |
| `@rut` | `char(9)` | RUT del funcionario, sin puntos, sin guion y con digito verificador. |
| `@mes_ano` | `varchar(10)` | Mes de remuneracion opcional. Si no se informa, el SP utiliza el ultimo mes disponible en `ss_habe`. |

---

## Campos Retornados

| Campo en SP | Descripcion |
| :--- | :--- |
| `rut` | RUT del funcionario. |
| `cod_ficha` | Codigo interno de ficha SISPER. |
| `nombre_funcionario` | Nombre completo del funcionario. |
| `mes_remuneracion` | Mes de remuneracion usado para el calculo. |
| `complemento_remuneracion` | Mayor `num_compl` encontrado para el mes seleccionado. |
| `sueldo_base_efectuado` | Monto efectuado de sueldo base, calculado con `num_cuenta = '2001'`. |
| `remuneracion_efectuada` | Suma de haberes efectuados del mes, usando cuentas `2%` y excluyendo las cuentas no consideradas en la regla institucional. |

---

## Reglas

1. **Alcance del dato**
   - El calculo es por funcionario/ficha y mes.
   - No debe interpretarse como sueldo de un contrato especifico.

2. **Mes de calculo**
   - Si `@mes_ano` viene informado, se usa ese mes.
   - Si `@mes_ano` no viene informado, se usa el ultimo mes disponible en `ss_habe` para la ficha.

3. **Complemento**
   - Para el mes seleccionado, se usa el mayor `num_compl`.

4. **Sueldo base efectuado**
   - Se calcula con la cuenta `2001`.

5. **Remuneracion efectuada**
   - Se calcula con cuentas `num_cuenta LIKE '2%'`.
   - Se excluyen las cuentas `2032`, `2043`, `2044`, `2056`, `2066`, `2067`, `2079`, `2090`, `2402`, `2403`, `2414`, `2417` y `2418`.
   - El calculo debe usar los registros que coincidan con la planilla seleccionada por ficha, mes y complemento.

6. **Uso en DU288**
   - Este monto puede usarse como referencia de remuneracion historica del funcionario.
   - No reemplaza ni representa la renta bruta de un contrato especifico.

7. **Tablas utilizadas**
   - `sisper_db..sp_pers`
   - `sisper_db..ss_habe`
   - `sisper_db..sp_para`
   - `fin21_db..es_ccto`
   - Tabla temporal `#Planilla`
