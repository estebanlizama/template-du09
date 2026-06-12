# Requerimientos de SP sg_fupssSecgen08 y Ficha Laboral DU288

## Objetivo

Obtener la lista de contratos vigentes y contratos base activos asociados a un funcionario candidato a una solicitud de Prestación de Servicios Normativa (DU288).

Este Stored Procedure (SP) se ejecuta al consultar los contratos asociados a un RUT en el sistema.

---

## Parámetro de Entrada

| Parámetro | Tipo | Descripción |
| :--- | :--- | :--- |
| `@rut` | `char(9)` | RUT del funcionario, sin puntos, sin guion y con dígito verificador. |

---

## Mapeo de Campos (Variables y Racional)

La siguiente tabla detalla la correspondencia entre los campos retornados por el SP en Sybase.

| Campo en SP (Sybase) | Propiedad Backend (LB4) | Descripción / Por qué se requiere |
| :--- | :--- | :--- |
| `rut` | `rut` | Identificador único del funcionario para asociación y control de la solicitud. |
| `nombre_funcionario` | `nombreFuncionario` | Nombre completo del funcionario. |
| `cod_ficha` | `codFicha` | Código interno de ficha del funcionario usado en el payload final de guardado. |
| `cta_email` | `email` | Correo institucional del funcionario para comunicaciones. |
| `id_contrato` | `idContrato` | ID de contrato del funcionario para registrar la relación laboral de la PDS. |
| `cod_contra` | `codContrato` | Código del contrato para trazabilidad institucional de la postulación. |
| `des_calida` | `calidad` / `tipoVinculacion` | Calidad contractual del contrato. Se excluye únicamente Honorarios mediante `cod_calida <> '01'`. |
| `nom_cargo` | `cargo` | Nombre descriptivo del cargo ocupado en dicho contrato. |
| `des_unidad` | `unidad` | Unidad organizativa donde se desempeña el funcionario. |
| `des_estame` | `estamento` | Estamento (Académico o Administrativo) para validar SEA, compensación y topes. |
| `des_niv_gr` | `nivelGrado` | Grado o nivel del contrato para el tope mensual de planta si aplica. |
| `des_jerpla` | `jerarquia` | Jerarquía o planta para fines de categorización interna del contrato. |
| `des_jornad` | `jornada` | Jornada laboral (Completa, Media, etc.). |
| `num_horas` | `numHoras` | Horas de jornada semanales para evaluar compensaciones y límite diario de 12 horas. |
| `f_inicio_d` | `fechaInicio` | Fecha de inicio del decreto para el cálculo estricto de la antigüedad del contrato. |
| `f_termin_d` | `fechaTerminoDecreto`| Fecha de vencimiento formal del decreto del contrato. |
| `f_termino` | `fechaTermino` | Fecha de término del contrato de personal para verificar validez cronológica. |
| `des_vigen` | `vigenciaContrato` | Glosa descriptiva del estado de vigencia del contrato. |
| `vigen_cont` | `vigenCont` | Código de vigencia del contrato utilizado para validar contratos vigentes (`0`) o en trámite (`2`). |
| `prof_acad` | `profAcad` | Indicador si es profesional académico para lógica de SEA y compensación. |
| `principal` | `principal` | Bandera para ordenar y priorizar el contrato principal primero en la lista. |

---

## Reglas de Filtrado y Negocio (Base de Datos)

1. **Vigencia Temporal:**
   - La consulta del SP debe retornar contratos vigentes y en trámite (`vigen_cont IN ('0', '2')`).
2. **Calidad contractual habilitada:**
   - La consulta del SP debe filtrar por código de calidad contractual, no por texto descriptivo.
   - Se excluye únicamente `cod_calida = '01'`, correspondiente a Honorarios.
   - Las demás calidades contractuales se consideran habilitadas para ser informadas por el PA.
3. **Remuneración**
   - Este SP no retorna renta bruta.
   - La remuneración efectuada del funcionario se obtiene mediante `sg_fupssSecgen11`, como dato separado por ficha y mes.
4. **Ordenamiento de Resultados:**
   - Los contratos se deben ordenar priorizando el contrato principal primero y luego por el identificador del contrato.

---
