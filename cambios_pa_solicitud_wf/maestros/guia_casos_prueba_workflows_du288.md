# Guía Maestra de Casos de Prueba - Workflows DU288 / PDS (UFRO 2026)

Este documento detalla los **escenarios de prueba, combinaciones de RUTs, cargos institucionales y orden exacto de visación** para certificar todos los flujos de trabajo del módulo de Prestación de Servicios (PDS - DU288).

---

## 🏛️ 1. Matriz de Flujos DU288 y Reglas Generales

El flujo se determina automáticamente según el `cod_unidad` del Centro de Costo (`fin21_db..es_ccto` -> `fin21_db..es_ufin`):

| Flujo | Tipo de Flujo | Prefijo de Unidad | Autoridad Intermedia | Autoridad Superior |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **Facultad** | `06`, `07`, `08`, `09`, `17`, `18` | Director/Encargado Finanzas Facultad | Decano |
| **2** | **Investigación** | Proyectos clasificados Investigación | Director de Investigación (`cod_organi 301`) | VRIP (`cod_organi 299`) |
| **3** | **DITT** | Proyectos Innovación / Transferencia | Director DITT (`cod_organi 303`) | VRIP (`cod_organi 299`) |
| **4** | **Instituto** | `1610`, `1611`, `1612`, `1613`, `1620` | Director del Instituto correspondiente | VRIP (`cod_organi 299`) |
| **5** | **VRAF** | `03` | DGDP (`cod_organi 50`) | VRAF (`cod_organi 39`) |
| **6** | **VRAC** | `02` | Vicerrector Académico (`cod_organi 17`) | DGDP / Finanzas |
| **7** | **VIPRE** | `19` | Vicerrectora de Pregrado (`cod_organi 704`)| DGDP / Finanzas |
| **8** | **VRIP** | `16` (resto) | Vicerrector de Investigación (`cod_organi 299`)| DGDP / Finanzas |

---

## 📌 Reglas de Omisión y Deduplicación de Etapas

1. **Una misma persona no debe visar dos veces la misma solicitud:** Si un usuario tiene múltiples roles en el trámite (ej. es Jefe Directo y además Decano, o es Jefe de Proyecto y además Jefe Directo), la etapa previa se **omite** y la visación se realiza en la etapa más avanzada con el expediente completo.
2. **Excepciones que NUNCA se omiten:**
   * **Solicitante (`cod_perfil = 6`):** Es el creador/presentador de la solicitud. Si se omitiese, se rompería la vía de devolución para correcciones.
   * **Etapas de Firma Oficial (Secretario General `cod_perfil = 14` y VRAF `cod_perfil = 23`):** La firma es un acto solemne e indelegable que valida legalmente la Resolución Exenta.

---

## 🧪 2. Casos de Prueba - Flujo 1: Facultades

---

### Caso 1.1: Flujo Normal de Facultad (Ingeniería)
* **Centro de Costo:** `7010` / `0` (Decanato Facultad de Ingeniería)
* **Jefe de Proyecto:** `067453743` (Cristian Bornhardt Brachmann)
* **Funcionario a Contratar:** `087962717` (Jeanette del Pilar Poza Aravena)
* **Jefe Directo del Funcionario:** `080837291` (Galo Eduardo Paiva - Director Depto. Sistemas)

#### 📋 Secuencia de Visación Esperada:
```text
1. Solicitante:             92867439  (Creador de la solicitud)
2. Jefe de Proyecto:        067453743 (Cristian Bornhardt)
3. Jefe Directo Funcionario:080837291 (Galo Paiva)
4. Director Finanzas Fac.:  11966330K (Jorge Antune - cod_organi 835)
5. Decano:                  081574340 (Plinio Durán - cod_organi 135)
6. DGDP:                    129856963 (Joaquín Bascuñán - cod_organi 50)
7. Director Finanzas Cent.: 14220231K (Miguel Sandoval - sp_orde 41)
8. Jefe de Decretación:     120134280 (Decretación)
9. Firma Secretario General:57525967  (Secretaría General)
10. Firma VRAF:             13158007K (Jorge Petit-Breuilh - VRAF)
11. Director Legalidad:     122504255 (Asesoría Jurídica)
12. Contralor Universitario:076636699 (Roberto Contreras - cod_organi 68)
13. Archivo Universitario:  108617802 (Marco Antonio Mena - sp_orde 77)
```

---

### Caso 1.2: Omisión JP = Jefe Directo del Funcionario
> **Objetivo:** Verificar que cuando el Jefe de Proyecto es la misma persona que la jefatura directa del funcionario en su unidad de desempeño, la etapa 26 (Jefe Directo) se omite.

* **Centro de Costo:** `7030` / `0` (Depto. Ingeniería de Sistemas)
* **Jefe de Proyecto:** `080837291` (Galo Eduardo Paiva)
* **Funcionario a Contratar:** `087962717` (Jeanette del Pilar Poza Aravena)
* **Jefe Directo del Funcionario:** `080837291` (Galo Eduardo Paiva)

#### 📋 Secuencia de Visación Esperada:
```text
1. Solicitante:             92867439  (Presenta)
2. Jefe de Proyecto:        080837291 (Galo Paiva - VISA AQUÍ)
3. Jefe Directo:            [OMITIDA AUTOMÁTICAMENTE - Razón: Mismo responsable que etapa anterior]
4. Director Finanzas Fac.:  11966330K (Jorge Antune)
5. Decano:                  081574340 (Plinio Durán)
6. DGDP:                    129856963 (Joaquín Bascuñán)
7. Director Finanzas Cent.: 14220231K (Miguel Sandoval)
... (Siguen etapas 8 a 13 normales)
```

---

### Caso 1.3: Omisión JP = Decano de la Facultad
> **Objetivo:** Si el Decano administra directamente un Centro de Costo como Jefe de Proyecto, visa como JP y se omite la etapa de Decanatura para no duplicar su firma previa a DGDP.

* **Centro de Costo:** `8010` / `0` (Decanato Fac. Educación) o `5810` / `0` (Decanato Odontología)
* **Jefe de Proyecto:** `137324784` (Gonzalo Oporto - Decano Odontología)
* **Funcionario a Contratar:** Funcionario de Odontología

#### 📋 Secuencia de Visación Esperada:
```text
1. Solicitante:             92867439  (Presenta)
2. Jefe de Proyecto:        137324784 (Gonzalo Oporto - VISA COMO JP)
3. Jefe Directo:            Jefe de la unidad del funcionario
4. Director Finanzas Fac.:  091015102 (Álvaro Carrera - cod_organi 602)
5. Decano:                  [OMITIDA - Razón: Reaparece en etapa de JP]
6. DGDP:                    129856963 (Joaquín Bascuñán)
... (Siguen etapas 7 a 13 normales)
```

---

### Caso 1.4: Omisión JP = Director DGDP
> **Objetivo:** Si el Director de Gestión y Desarrollo de Personas figura como Jefe de Proyecto de un centro de costo, se omite su visación en la etapa 25 de JP y se consolida en la etapa de DGDP.

* **Jefe de Proyecto:** `129856963` (Joaquín Bascuñán - DGDP)
* **Funcionario:** Cualquier funcionario elegible

#### 📋 Secuencia de Visación Esperada:
```text
1. Solicitante:             92867439  (Presenta)
2. Jefe de Proyecto:        [OMITIDA - Razón: Es el Director DGDP y visa en etapa central]
3. Jefe Directo:            Jefe de la unidad del funcionario
4. Director Finanzas Fac.:  Director de la facultad
5. Decano:                  Decano de la facultad
6. DGDP:                    129856963 (Joaquín Bascuñán - VISA CON EXPEDIENTE COMPLETO)
7. Director Finanzas Cent.: 14220231K (Miguel Sandoval)
... (Siguen etapas 8 a 13 normales)
```

---

### Caso 1.5: Bloqueo por Conflicto de Interés (Funcionario = Jefe de Proyecto)
> **Regla Institucional:** Un funcionario **no puede percibir asignación de un proyecto donde él mismo es el Jefe de Proyecto**.

* **Jefe de Proyecto:** `056024069` (Aliro Contreras)
* **Funcionario a Contratar:** `056024069` (Aliro Contreras)
* **Resultado Esperado:** 
  * El sistema backend y frontend bloquea la incorporación con error normativo:
    `DU288_APPLICANT_IS_STAFF` / `CONFLICTO_FUNCIONARIO: El Jefe de Proyecto no puede aprobar su propia contratación`.

---

## 🧪 3. Casos de Prueba - Flujo 4: Institutos

---

### Caso 3.1: Instituto de Agroindustria
* **Centro de Costo:** `1610` / `0` (Instituto de Agroindustria - Unidad `16100000`)
* **Jefe de Proyecto:** `090143328` (Luis Eduardo Torralbo - Director Agroindustria `cod_organi 268`)
* **Funcionario:** Funcionario asignado al instituto

#### 📋 Secuencia de Visación Esperada:
```text
1. Solicitante:             92867439  (Presenta)
2. Jefe de Proyecto:        090143328 (Luis Torralbo)
3. Jefe Directo:            [Si JP = JD se omite; si no, visa jefatura directa]
4. Director Instituto:      090143328 (Luis Torralbo - cod_organi 268) -> [Se consolida si es JP]
5. VRIP (Autoridad Sup.):   112615229 (Rodrigo Navia - cod_organi 299)
6. DGDP:                    129856963 (Joaquín Bascuñán)
7. Finanzas Central:        14220231K (Miguel Sandoval)
... (Siguen etapas 8 a 13 de Decretación, Firmas y Legalidad)
```

---

### Caso 3.2: Instituto de Informática Educativa (IIE)
* **Centro de Costo:** `1612` / `0` (Unidad `16120000`)
* **Jefe de Proyecto:** `095264956` (Juan Enrique Hinostroza - Director IIE `cod_organi 297`)
* **Autoridad Superior:** `112615229` (Rodrigo Navia - VRIP `cod_organi 299`)

---

## 🧪 4. Casos de Prueba - Flujos de Vicerrectorías

---

### Caso 4.1: Flujo 6 - Vicerrectoría Académica (VRAC)
* **Centro de Costo:** `2010` / `0` (Unidad `02010000`)
* **Titular Activo:** `129302895` (Renato Alexis Hunter - `cod_organi 17`)
* **Subrogante Activo (`sp_orde 3`):** `068123240` (Carlos Sergio Schulz)

#### 📋 Secuencia de Visación Esperada:
```text
1. Solicitante:             92867439
2. Jefe de Proyecto:        Jefe asignado al proyecto VRAC
3. Jefe Directo:            Jefe directo del funcionario
4. VRAC (Titular/Subrog.):  129302895 (Renato Hunter) o 068123240 (Carlos Schulz - S)
5. DGDP:                    129856963 (Joaquín Bascuñán)
6. Finanzas Central:        14220231K (Miguel Sandoval)
... (Siguen etapas 7 a 13)
```

---

### Caso 4.2: Flujo 7 - Vicerrectoría de Pregrado (VIPRE)
* **Centro de Costo:** `1901` / `0` (Unidad `19010000`)
* **Titular Activo:** `105476353` (Emma Amanda Bensch - `cod_organi 704`)

---

### Caso 4.3: Flujo 8 - Vicerrectoría de Investigación y Postgrado (VRIP)
* **Centro de Costo:** `1601` / `0` (Unidad `16010000`)
* **Titular Activo:** `112615229` (Rodrigo Javier Navia - `cod_organi 299`)

---

### Caso 4.4: Flujo 5 - Vicerrectoría de Administración y Finanzas (VRAF)
* **Centro de Costo:** `3010` / `0` (Unidad `03010000`)
* **Titular Activo:** `13158007K` (Jorge Andrés Petit-Breuilh - `cod_organi 39`)
* **Subrogante Activo (`sp_orde 40`):** `070589850` (Emma Rosa Seguel)

---

## 🧪 5. Casos de Múltiples Funcionarios (Jefaturas Directas en Paralelo)

---

### Caso 5.1: Dos Funcionarios de Distintas Facultades
> **Objetivo:** Validar que la etapa 26 (Jefe Directo) maneja asignaciones paralelas cuando en la misma solicitud se contrata a personas con dependencias jerárquicas distintas.

* **Funcionario 1:** `087962717` (Jeanette Poza - Depto. Sistemas -> Jefe Directo: `080837291` Galo Paiva).
* **Funcionario 2:** Funcionario de Cs. Químicas (`053890474` Mario Pino Barra).
* **Comportamiento Esperado:**
  * En la etapa 26, el sistema crea dos aprobaciones pendientes en `sg_apso` en paralelo.
  * La solicitud no avanza a la siguiente etapa (Director de Finanzas Facultad) hasta que **ambos jefes directos hayan visado favorablemente**.

---

## 📊 6. Tabla Resumen de RUTs Institucionales Activos

| RUT | Nombre Completo | Cargo / Dependencia Principal | Rol en Flujo DU288 |
| :---: | :--- | :--- | :--- |
| **`92867439`** | *Usuario Solicitante* | Creador Solicitudes | Solicitante (`cod_perfil = 6`) |
| **`067453743`** | Cristian Bornhardt Brachmann | Director Depto. Ing. Química | Jefe de Proyecto (`cod_perfil = 25`) |
| **`080837291`** | Galo Eduardo Paiva | Director Depto. Ing. Sistemas | Jefe Directo / JP (`cod_perfil = 26/25`) |
| **`087962717`** | Jeanette del Pilar Poza | Secretaria Depto. Sistemas | Funcionaria Nómina (`sg_fups`) |
| **`11966330K`** | Jorge Eduardo Antune Gaete | Dir. Finanzas Fac. Ingeniería | Dir. Finanzas Fac. (`cod_organi 835`) |
| **`081574340`** | Plinio Donosor Durán | Decano Fac. Ingeniería | Decano (`cod_organi 135`) |
| **`091015102`** | Álvaro Emilio Carrera | Dir. Finanzas Fac. Odontología | Dir. Finanzas Fac. (`cod_organi 602`) |
| **`137324784`** | Gonzalo Hernán Oporto | Decano Fac. Odontología | Decano (`cod_organi 586`) |
| **`115007602`** | Marco Antonio Vásquez | Dir. Finanzas Fac. Cs. Jurídicas| Dir. Finanzas Fac. (`cod_organi 642`) |
| **`131443633`** | Paulina Alejandra Sanhueza | Decana Fac. Cs. Jurídicas | Decana (`cod_organi 623`) |
| **`088556992`** | Fernando Santiago Pavez | Dir. Finanzas Fac. Educación | Dir. Finanzas Fac. (`cod_organi 838`) |
| **`123619501`** | Alejandro Suazo | Dir. Finanzas Fac. Cs. Agropec. | Dir. Finanzas Fac. (`cod_organi 847`) |
| **`090143328`** | Luis Eduardo Torralbo | Directora Suplente Agroindustria| Director Instituto (`cod_organi 268`) |
| **`095264956`** | Juan Enrique Hinostroza | Director Inst. Inf. Educativa | Director Instituto (`cod_organi 297`) |
| **`129302895`** | Renato Alexis Hunter | Vicerrector Académico | VRAC (`cod_organi 17`) |
| **`068123240`** | Carlos Sergio Schulz | Subrogante VRAC | VRAC Subrogante (`sp_orde 3`) |
| **`105476353`** | Emma Amanda Bensch | Vicerrectora de Pregrado | VIPRE (`cod_organi 704`) |
| **`112615229`** | Rodrigo Javier Navia | Vicerrector de Investigación | VRIP (`cod_organi 299`) |
| **`129856963`** | Joaquín Antonio Bascuñán | Director Gestión de Personas | DGDP (`cod_organi 50`) |
| **`14220231K`** | Miguel Ángel Sandoval | Director de Finanzas | Finanzas Central (`sp_orde 41`) |
| **`120134280`** | *Jefe de Decretación* | Decretación Rectoría | Decretación (`cod_perfil = 12`) |
| **`57525967`** | *Secretaría General* | Secretaría General | Firma Secretario General (`cod_perfil = 14`)|
| **`13158007K`** | Jorge Andrés Petit-Breuilh | Vicerrector Adm. y Finanzas | Firma VRAF (`cod_perfil = 23`) |
| **`122504255`** | *Director Asesoría Jurídica*| Dirección de Legalidad | Control Legalidad (`cod_perfil = 16`) |
| **`076636699`** | Roberto David Contreras | Contralor Universitario | Contraloría (`cod_perfil = 17`) |
| **`108617802`** | Marco Antonio Mena | Encargado Archivo General | Archivo Universitario (`sp_orde 77`) |
