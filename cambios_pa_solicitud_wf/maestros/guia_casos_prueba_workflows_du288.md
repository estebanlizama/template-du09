# Guía de Casos de Prueba — Workflows DU288 / PDS (UFRO 2026)

Escenarios, RUT y secuencia de visación esperada para certificar los flujos del módulo de Prestación de Servicios.

Los RUT y cargos de este documento están verificados contra la base de certificación (ver §7).

---

## 1. Matriz de flujos

El flujo se determina por el `cod_unidad` del Centro de Costo (`fin21_db..es_ccto` → `fin21_db..es_ufin`).

| Flujo | Tipo | Prefijo de unidad | Etapas | Autoridad intermedia | Autoridad superior |
| :---: | :--- | :--- | :---: | :--- | :--- |
| 1 | Facultad | `06`, `07`, `08`, `09`, `17`, `18` | 13 | Director/Encargado Finanzas Facultad | Decano |
| 2 | Investigación | Proyectos de investigación | 13 | Director de Investigación (301) | VRIP (299) |
| 3 | DITT | Innovación / transferencia | 13 | Director DITT (303) | VRIP (299) |
| 4 | Instituto | `1610`, `1611`, `1612`, `1613`, `1620` | 13 | Director del Instituto | VRIP (299) |
| 5 | VRAF | `03` | 11 | DGDP (50) | VRAF (39) |
| 6 | VRAC | `02` | 12 | Vicerrector Académico (17) | DGDP / Finanzas |
| 7 | VIPRE | `19` | 12 | Vicerrectora de Pregrado (704) | DGDP / Finanzas |
| 8 | VRIP | `16` (resto) | 12 | Vicerrector de Investigación (299) | DGDP / Finanzas |

### Etapas del Flujo 1 (referencia)

| Etapa | Nombre | `cod_perfil` | `cod_organi` |
| :---: | :--- | :---: | :---: |
| 10 | Solicitante | 6 | — |
| 20 | Jefe de Proyecto | 25 | — |
| 30 | Jefe Directo Funcionario | 26 | — |
| 40 | Director o Encargado Facultad | 8 | — |
| 50 | Decano | 27 | — |
| 60 | Director DGDP | 13 | 50 |
| 70 | Director Finanzas | 10 | 41 |
| 80 | Jefe Decretación | 12 | 449 |
| 90 | Secretario General | 14 | 73 |
| 100 | VRAF | 23 | 39 |
| 110 | Director Legalidad | 16 | 612 |
| 120 | Contralor Universitario | 17 | 68 |
| 130 | Jefe Archivo Universitario (final) | 18 | 77 |

Las etapas 10 a 50 no fijan `cod_organi`: se resuelven por estrategia o por la unidad del centro de costo.

---

## 2. Reglas de omisión

**Regla general.** Una misma persona no visa dos veces la misma solicitud. Si reaparece como responsable en una etapa posterior, **se omite la etapa temprana** y la visación queda en la más avanzada, que llega con el expediente completo.

**Perfiles que nunca se omiten.** Cada uno ejecuta un acto propio que no queda cubierto porque la persona revise en otra etapa.

| `cod_perfil` | Etapa | Acto propio |
| :---: | :--- | :--- |
| 6 | Solicitante | Presenta. Omitirlo rompe la devolución a corrección |
| 10 | Director de Finanzas | Control presupuestario |
| 12 | Jefe de Decretación | Decretación |
| 13 | Director DGDP | Control de gestión de personas |
| 14 | Secretario General | Firma |
| 16 | Director de Legalidad | Control de legalidad |
| 17 | Contralor Universitario | Contraloría |
| 18 | Jefe Archivo Universitario | Cierre del expediente |
| 23 | VRAF | Firma |

Todos los demás sí pueden omitirse: Jefe de Proyecto (25), Jefe Directo (26), Director o Encargado de Facultad (8), Decano (27), Directores de Instituto, DITT e Investigación.

**Jefatura Directa condicionada por jornada.** La etapa 30 solo existe si `sg_fups.dentro_jor` es `S` o `D`. Con `N` (fuera de jornada) esa etapa no se ejecuta, y por lo tanto tampoco puede haber coincidencia con ella.

---

## 3. Orden recomendado de pruebas

Cada bloque asume que el anterior pasó. Una omisión no se puede diagnosticar si el recorrido base falla.

| Orden | Bloque | Qué certifica |
| :---: | :--- | :--- |
| 1 | §4.1 Recorrido base | Las 13 etapas se recorren y asignan en orden |
| 2 | §4.2 Omisión por responsable repetido | La etapa temprana se omite y la posterior visa |
| 3 | §4.3 Jornada | La etapa 30 no se ejecuta fuera de jornada |
| 4 | §4.4 Subrogancia y escalamiento | Resuelve por ORDE/AUFI y por conflicto de interés |
| 5 | §4.5 Bloqueos | El sistema impide lo que debe impedir |
| 6 | §4.6 Múltiples funcionarios | Asignaciones paralelas en la etapa 30 |
| 7 | §5 Otros flujos | Institutos y Vicerrectorías |

---

## 4. Casos de prueba — Flujo 1 (Facultad)

### 4.1 Recorrido base, sin alteraciones

* Centro de Costo: `7010` / `0` — Decanato Facultad de Ingeniería
* Jefe de Proyecto: `067453743`
* Funcionario: `087962717`, **dentro de jornada**
* Jefe Directo del funcionario: `080837291`

Secuencia esperada:

```text
10  Solicitante                   092867439
20  Jefe de Proyecto              067453743
30  Jefe Directo Funcionario      080837291
40  Director o Encargado Facultad 11966330K
50  Decano                        081574340
60  Director DGDP                 129856963
70  Director Finanzas             14220231K
80  Jefe Decretación              120134280
90  Secretario General            057525967   (por subrogancia, ver §4.4)
100 VRAF                          13158007K
110 Director Legalidad            122504255
120 Contralor Universitario       076636699
130 Jefe Archivo Universitario    108617802
```

**Qué observar:** las 13 etapas se crean en `sg_apso`; el modal de envío muestra únicamente el bloque *Siguiente etapa y responsable*, sin aviso de continuidad.

---

### 4.2 Omisión por responsable repetido

#### 4.2.1 Jefe de Proyecto = Jefe Directo

* Centro de Costo: `7030` / `0`
* Jefe de Proyecto: `080837291`
* Funcionario: `087962717`, **dentro de jornada**
* Jefe Directo del funcionario: `080837291`

```text
10  Solicitante              092867439
20  Jefe de Proyecto         OMITIDA
30  Jefe Directo Funcionario 080837291   ← visa aquí
40 … 130                     recorrido normal
```

**Qué observar:** el modal de envío oculta el bloque de responsable y muestra el aviso de continuidad con la etapa omitida y el destino real. En `sg_apso` no existe fila para la etapa 20; en el historial queda la línea de omisión con `id_perfil = 25`. En el flujo organizacional la etapa 20 aparece como omitida, no como aprobada.

#### 4.2.2 Jefe de Proyecto = Decano

* Jefe de Proyecto: un Decano vigente que además administre el centro de costo
* Funcionario: cualquiera elegible

```text
20  Jefe de Proyecto  OMITIDA
50  Decano            ← visa aquí
```

**Precondición.** Requiere un decanato con titular vigente. Los decanatos de Educación (`204`) y Cs. Agropecuarias (`248`) no tienen titular vigente, por lo que no sirven para este caso. Decanatos disponibles: Ingeniería `081574340` (135), Odontología `137324784` (586), Cs. Jurídicas `131443633` (623).

#### 4.2.3 Jefe de Proyecto = Director DGDP

* Jefe de Proyecto: `129856963`

```text
20  Jefe de Proyecto  OMITIDA
60  Director DGDP     129856963   ← visa aquí, con expediente completo
```

#### 4.2.4 Jefe de Proyecto con rol de firma posterior

* Jefe de Proyecto: una persona que además ocupe Secretario General (14), VRAF (23), Legalidad (16) o Contraloría (17)

```text
20  Jefe de Proyecto  OMITIDA
90/100/110/120        firma o control       ← acto propio, nunca se omite
```

**Qué observar:** la etapa de firma no se omite aunque la persona ya haya visado antes. Revisión y firma son actos distintos.

---

### 4.3 Jornada del funcionario

#### 4.3.1 Fuera de jornada

* Funcionario con `dentro_jor = 'N'`

```text
20  Jefe de Proyecto         visa normalmente
30  Jefe Directo Funcionario NO SE EJECUTA
40 … 130                     recorrido normal
```

**Qué observar:** el modal de envío no muestra aviso de continuidad — el recorrido inmediato no cambia. El aviso aparece cuando el Jefe de Proyecto valida y el destino pasa a ser la etapa 30, con motivo `OUTSIDE_WORKDAY`.

#### 4.3.2 Fuera de jornada con Jefe de Proyecto = Jefe Directo

* Jefe de Proyecto: `080837291`
* Funcionario: `087962717`, con `dentro_jor = 'N'`

**Qué observar:** no se omite la etapa 20. Al no existir la etapa 30 no hay coincidencia posible, y el Jefe de Proyecto visa normalmente.

---

### 4.4 Subrogancia y escalamiento

#### 4.4.1 Subrogancia por organización sin titular

* Etapa 90, Secretario General (`cod_organi 73`)

La organización no tiene titular vigente, de modo que resuelve por AUFI y visa `057525967` como subrogante.

**Qué observar:** el modal muestra el recuadro *Revisión por subrogancia* con el cargo titular; el flujo organizacional muestra el distintivo `SUBROGANTE`.

#### 4.4.2 Resolución por delegado

* Etapas cuyo responsable resuelve por `sp_orde` y no por `sp_orco`: `080837291` (155), `14220231K` (41), `108617802` (77), `067453743` (151)

**Qué observar:** la cadena `ORCO → ORDE → AUFI` resuelve igual. Una verificación que consulte solo `sp_orco` no los encontraría.

#### 4.4.3 Escalamiento por conflicto de interés

* Funcionario de la prestación: el Decano titular de la facultad
* Etapa 50

**Qué observar:** la etapa se resuelve contra el VRAC (`cod_organi 17`) en lugar del decanato. El modal muestra el aviso *Revisión asignada a la jefatura superior*. El flujo continúa: no es un bloqueo.

---

### 4.5 Bloqueos esperados

| Caso | Configuración | Resultado esperado |
| :--- | :--- | :--- |
| Funcionario = Jefe de Proyecto | JP y funcionario con el mismo RUT | Rechazo con `DU288_APPLICANT_IS_STAFF` |
| Etapa sin responsable vigente | Organización sin titular, delegado ni subrogante | `NO_ENCONTRADO`, envío bloqueado |
| Más de un titular vigente | Organización con dos ORCO vigentes | `AMBIGUO`, envío bloqueado |
| Contrato que no cubre el período | Ejecución fuera de la vigencia del contrato | Rechazo al incorporar, con motivo legible |

---

### 4.6 Múltiples funcionarios

* Funcionario 1: `087962717` — jefatura directa `080837291`
* Funcionario 2: funcionario de otra unidad, con jefatura directa distinta

**Qué observar:** en la etapa 30 se crean dos aprobaciones pendientes en paralelo. La solicitud no avanza a la etapa 40 hasta que ambas jefaturas hayan visado. Si una de las dos está fuera de jornada, solo se crea la otra.

---

## 5. Otros flujos

### 5.1 Flujo 4 — Institutos

| Caso | Centro de Costo | Unidad | Jefe de Proyecto / Director | Autoridad superior |
| :--- | :--- | :--- | :--- | :--- |
| Agroindustrias | `1610` / `0` | `16100000` | `090143328` (268) | `112615229` (299) |
| Informática Educativa | `1612` / `0` | `16120000` | `095264956` (297) | `112615229` (299) |

Cuando el Director del Instituto es además Jefe de Proyecto, se omite la etapa 20 y visa en la etapa del Instituto.

**Topes.** Es el único flujo donde aplica `sg_toca`. Ver §7.4 para los contratos que activan la regla.

### 5.2 Flujos 5 a 8 — Vicerrectorías

| Flujo | Centro de Costo | Unidad | Titular | Subrogante |
| :---: | :--- | :--- | :--- | :--- |
| 6 VRAC | `2010` / `0` | `02010000` | `129302895` (17) | `068123240` (`sp_orde 3`) |
| 7 VIPRE | `1901` / `0` | `19010000` | `105476353` (704) | — |
| 8 VRIP | `1601` / `0` | `16010000` | `112615229` (299) | — |
| 5 VRAF | `3010` / `0` | `03010000` | `13158007K` (39) | `070589850` (`sp_orde 40`) |

En el Flujo 6 conviene probar el recorrido con el titular y luego con el subrogante.

---

## 6. RUT institucionales

Todos verificados contra `sp_orco` / `sp_orde` (§7.3).

| RUT | Nombre | Resuelve por | `cod_organi` | Rol en el flujo |
| :---: | :--- | :---: | :---: | :--- |
| `092867439` | Pamela Ibarra Palma | — | — | Solicitante (perfil 6) |
| `087962717` | Jeanette Poza Aravena | — | — | Funcionaria de nómina |
| `043598961` | Héctor Henríquez Quintana | — | — | Funcionario de nómina |
| `067453743` | Cristian Bornhardt | ORDE | 151 | Jefe de Proyecto (perfil 25) |
| `080837291` | Galo Paiva Cravero | ORDE | 155 | Jefe Directo / Jefe de Proyecto |
| `11966330K` | Jorge Antune Gaete | ORCO | 835 | Dir. Finanzas Fac. Ingeniería |
| `123619501` | Alejandro Suazo | ORCO | 847 | Dir. Finanzas Fac. Cs. Agropecuarias |
| `091015102` | Álvaro Carrera | ORCO | 602 | Dir. Finanzas Fac. Odontología |
| `115007602` | Marco Vásquez | ORCO | 642 | Dir. Finanzas Fac. Cs. Jurídicas |
| `088556992` | Fernando Pavez | ORCO | 838 | Dir. Finanzas Fac. Educación |
| `081574340` | Plinio Durán García | ORCO | 135 | Decano Fac. Ingeniería |
| `137324784` | Gonzalo Oporto | ORCO | 586 | Decano Fac. Odontología |
| `131443633` | Paulina Sanhueza | ORCO | 623 | Decana Fac. Cs. Jurídicas |
| `090143328` | Luis Torralbo | ORCO | 268 | Director Instituto Agroindustrias |
| `095264956` | Juan Hinostroza | ORCO | 297 | Director Instituto Inf. Educativa |
| `129302895` | Renato Hunter | ORCO | 17 | VRAC titular |
| `068123240` | Carlos Schulz | ORDE | 3 | VRAC subrogante |
| `105476353` | Emma Bensch | ORCO | 704 | VIPRE |
| `112615229` | Rodrigo Navia | ORCO | 299 | VRIP |
| `129856963` | Joaquín Bascuñán | ORCO | 50 | DGDP (perfil 13) |
| `14220231K` | Miguel Sandoval | ORDE | 41 | Director de Finanzas (perfil 10) |
| `120134280` | Cristian Monte Inostroza | ORCO | 449 y 829 | Jefe de Decretación (perfil 12) |
| `057525967` | María Cecilia Fuentes | AUFI | — | Secretaría General (perfil 14), subrogante |
| `13158007K` | Jorge Petit-Breuilh | ORCO | 39 | VRAF (perfil 23) |
| `122504255` | Gustavo Becerra | ORCO | 612 | Director de Legalidad (perfil 16) |
| `076636699` | Roberto Contreras | ORCO | 68 | Contralor Universitario (perfil 17) |
| `108617802` | Marco Mena Valdebenito | ORDE | 77 | Jefe Archivo Universitario (perfil 18) |

### RUT no utilizables

| RUT | Motivo |
| :---: | :--- |
| `129300892` Carlos del Valle | Decanato de Educación (204) con `vigente = 'N'` |
| `056024069` Aliro Contreras | Decanato de Cs. Agropecuarias (248) con `vigente = 'N'` |

---

## 7. Verificación contra la base de datos

Consultas de solo lectura ejecutadas el **2026-08-31** contra el ambiente de certificación.

### 7.1 Flujos y etapas vigentes

```sql
SELECT f.cod_flusol, RTRIM(f.des_flusol) AS flujo, COUNT(e.cod_etapa) AS etapas
FROM secgen_db.dbo.sg_tfls f
LEFT JOIN secgen_db.dbo.sg_eta1 e
  ON e.cod_flusol = f.cod_flusol AND ISNULL(e.vigente,'S') = 'S'
GROUP BY f.cod_flusol, f.des_flusol
ORDER BY f.cod_flusol
```

Resultado: Facultad 13, Investigación 13, DITT 13, Instituto 13, VRAF 11, VRAC 12, VIPRE 12, VRIP 12.

### 7.2 Etapas del Flujo 1

```sql
SELECT cod_etapa, RTRIM(des_etapa) AS des_etapa, cod_perfil, cod_organi, est_final
FROM secgen_db.dbo.sg_eta1
WHERE cod_flusol = 1 ORDER BY cod_etapa
```

Resultado: el detalle está en la tabla de §1.

### 7.3 Titularidad y delegación

```sql
SELECT c.rut_person, c.cod_organi, RTRIM(o.des_organi) AS cargo
FROM sisper_db.dbo.sp_orco c
LEFT JOIN ufro_db.dbo.es_orga o ON o.cod_organi = c.cod_organi
WHERE c.vigente = 'S' AND c.rut_person IN (...)
-- idem contra sisper_db.dbo.sp_orde para delegaciones
```

Resultado: el detalle está en la tabla de §6.

**Secretaría General sin titular vigente**

```sql
SELECT c.rut_person, c.vigente, ISNULL(c.ausente,'N') AS ausente
FROM sisper_db.dbo.sp_orco c WHERE c.cod_organi = 73
```

| rut_person | vigente | ausente |
| :---: | :---: | :---: |
| `074306799` | N | N |

La única fila está no vigente, por lo que la etapa 90 resuelve por AUFI.

### 7.4 Topes por cargo — `sg_toca`

```sql
SELECT cod_cargo, cod_unidad, mto_tope, vigente, f_inicio, f_termino
FROM secgen_db.dbo.sg_toca
```

| cod_cargo | cod_unidad | Unidad | mto_tope |
| :---: | :---: | :--- | ---: |
| 3120 | 16100000 | Instituto de Agroindustrias | 2.566.751 |
| 3120 | 16110000 | Instituto del Medio Ambiente | 2.397.930 |
| 3120 | 16120000 | Instituto de Informática Educativa | 2.645.633 |
| 3120 | 16130000 | Instituto Estudios Indígenas e Intercult. | 2.471.469 |
| 3120 | 16140000 | Instituto Des. Local y Regional (IDER) | 2.554.357 |
| 3120 | 16150000 | Instituto de Innovación y Emprendimiento | 1.851.943 |

Todas vigentes desde `2026-01-01`, sin término.

`sg_toca` no cubre a los funcionarios comunes: para ellos el tope mensual se calcula sobre la remuneración (50%, Decreto 009/2026 numeral 2). Que el PA devuelva vacío para una secretaria o un profesional no es un defecto.

**Contratos que activan la regla**

| RUT | Contratos | Cargo / Unidad | Tope |
| :---: | :--- | :--- | ---: |
| `090143328` | 53788, 68093, 68895, 87210 | 3120 / 16100000 | 2.566.751 |
| `095264956` | 33848, 46539, 47970, 62490, 63448, 64513, 80993 | 3120 / 16120000 | 2.645.633 |

Sus demás contratos usan otros cargos y caen al cálculo por remuneración, aunque la persona sea Director de Instituto.

**Institutos sin regla de tope.** La matriz de §1 lista `1620` (Núcleos de Desarrollo Científico-Tecnológico), que no tiene fila en `sg_toca`. En cambio sí la tienen `1614` (IDER) y `1615` (Innovación y Emprendimiento), que la matriz no menciona. Conviene alinear ambas fuentes antes de certificar el Flujo 4.
