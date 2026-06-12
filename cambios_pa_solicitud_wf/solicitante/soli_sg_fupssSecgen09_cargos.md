# Requerimientos de SP sg_fupssSecgen09 y Cargos Vigentes DU288

## Objetivo

Obtener la lista de asignaciones y designaciones vigentes asociadas a un funcionario candidato a una solicitud de Prestación de Servicios Normativa (DU288).

Este Stored Procedure (SP) se ejecuta al consultar las designaciones o cargos activos asociados a un RUT en el sistema.

---

## Parámetro de Entrada

| Parámetro | Tipo | Descripción |
| :--- | :--- | :--- |
| `@rut` | `char(9)` | RUT del funcionario, sin puntos, sin guion y con dígito verificador. |

---

## Mapeo de Campos (Variables y Racional)

La siguiente tabla detalla la correspondencia entre los campos retornados por el SP en Sybase, las propiedades del DTO en el Backend (LoopBack 4) y el motivo o por qué de su inclusión.

| Campo en SP (Sybase) | Propiedad Backend (LB4) | Descripción / Por qué se requiere |
| :--- | :--- | :--- |
| `rut` | `rut` | Identificador único del funcionario para asociación y control de la solicitud. |
| `cod_ficha` | `codFicha` | Código interno de ficha del funcionario usado en el payload final de guardado. |
| `cod_design` | `codDesign` | Código de la designación/cargo asignado para trazabilidad. |
| `cod_cargo` | `codCargo` | Código del cargo asignado en la designación. |
| `nom_cargo` | `nomCargo` | Nombre descriptivo del cargo o designación. |
| `vigente_cargo` | `vigenteCargo` | Estado de vigencia del cargo en la tabla maestra. |
| `cod_unidad` | `codUnidad` | Código de la unidad organizativa del desempeño. |
| `des_unidad` | `desUnidad` | Nombre de la unidad donde se ejerce el cargo. |
| `cod_des_su` | `codDesSu` | Subcódigo identificador del tipo de designación. |
| `vigencia` | `vigencia` | Estado de vigencia de la designación. |
| `f_inicio` | `fechaInicio` | Fecha de inicio formal de la designación. |
| `f_termino` | `fechaTermino` | Fecha de término formal de la designación. |
| `con_asign` | `conAsign` | Indicador si tiene asignación de funciones o beneficios asociados. |
| `hora_dedid` | `horaDedid` | Horas semanales dedicadas a la designación. |
| `observ` | `observ` | Observaciones registradas sobre la designación. |

---

## Reglas de Filtrado y Negocio (Base de Datos)

1. **Vigencia del Registro:**
   - La designación o cargo debe encontrarse en estado vigente (`vigencia = '0'`).
2. **Vigencia Temporal:**
   - La fecha de inicio de la designación debe ser menor o igual a la fecha actual (`f_inicio <= getdate()`).
   - La fecha de término debe ser nula o bien mayor o igual a la fecha actual (`f_termino IS NULL OR f_termino >= getdate()`).
3. **Validación de Parámetro Obligatorio (Fail Fast):**
   - Si `@rut` no se especifica o está vacío, el SP retorna un mensaje descriptivo y detiene su ejecución inmediatamente.
4. **Ordenamiento de Resultados:**
   - Los resultados se deben ordenar priorizando la fecha de inicio de forma descendente y luego por el identificador de la designación de forma descendente.

---
