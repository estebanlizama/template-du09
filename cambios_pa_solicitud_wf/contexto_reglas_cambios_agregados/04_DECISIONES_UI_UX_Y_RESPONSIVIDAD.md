# Decisiones de Arquitectura: UI/UX y Responsividad Frontend

## 1. Principios de Experiencia de Usuario (UX)

El diseño del flujo de resoluciones y solicitudes (DU288 / DU09) sigue directrices estrictas de usabilidad orientadas a los usuarios académicos y administrativos de la Universidad:

1. **Cero Ruido Técnico (Clean Information):** El usuario solicitante no debe ser abrumado con cálculos internos o diagnósticos de backend (ej: "Horas no ejecutadas: 0", "Días excluidos: 0"). Solo debe ver información accionable y clara.
2. **Claridad Visual Inmediata:** Los estados y restricciones se comunican mediante texto, icono y color semántico; el color nunca es la única señal.
3. **Fluidez y Micro-animaciones:** Todas las transiciones de apertura de modales, popovers y hover en cuadrículas usan transiciones suaves (`transition: all 0.25s ease`).
4. **Datos del Usuario no Destructivos:** Un cambio de período, FUHO o calendario no puede borrar ni reubicar compensaciones sin una acción explícita.
5. **Estado No Disponible no es Estado Vacío:** Mientras el calendario esté cargando, con error o sin fuente confirmada, no se muestran fechas como disponibles.

---

## 2. Eliminación de Componentes y Diagnósticos Redundantes

### Decisión de Retiro de `Du288ExecutionCalendarProjection.vue`:
* **Diagnóstico Previo:** Existía un componente intermedio que proyectaba un calendario de ejecución con múltiples tablas que detallaban meses, semanas y cálculos estadísticos de horas no trabajadas por feriado.
* **Problema:** Generaba confusión en el usuario solicitante, duplicaba información ya disponible en el resumen de cuotas y sobrecargaba la pantalla verticalmente.
* **Resolución:** Se eliminó la proyección estadística intermedia. La gestión de feriados se integró directamente en:
  1. El editor de horario semanal (`StaffExecutionWeeklyGrid.vue`).
  2. El selector de compensaciones (`StaffCompensationSection.vue`).
  3. Los tags de resumen de meses (`ExecutionMonthsTags.vue`).

---

## 3. Optimizaciones Responsivas (Estándar 1240x911 y Móvil)

Las pantallas estándar de los notebooks institucionales operan en resoluciones de **1240px a 1366px de ancho**. Para garantizar una visualización impecable sin desbordamientos ni solapamientos:

### A. Cuadrícula Semanal (`StaffExecutionWeeklyGrid.vue`):
* **Ancho Mínimo de Columna:** Se estableció `min-width: 118px` para cada día laboral (lunes a viernes), con un ancho mínimo del contenedor de `610px`.
* **Scroll Horizontal Limpio:** Se agregó una barra de desplazamiento estilizada (`custom-scrollbar`) para resoluciones menores a `992px`, evitando que los nombres de los días se superpongan con el botón de eliminación de bloque `[x]`.

### B. Formulario de Horarios (`StaffExecutionScheduleSection.vue`):
* **Breakpoint Adaptado:** Se ajustó el breakpoint de columnas a `1199.98px` (en lugar de `991.98px`), de modo que en pantallas de 1240x911 el formulario de ingreso y la cuadrícula semanal se apilen armónicamente sin comprimir los campos.

### C. Editor de Bloques (`StaffExecutionScheduleEditor.vue`):
* **Distribución Equitativa:** Se estandarizaron los inputs de Selección de Día, Hora Inicio y Hora Término en columnas iguales (`col-12 col-sm-4`), asegurando que los selectores numéricos mantengan espacio suficiente para sus iconos y textos.

### D. Sección de Compensaciones (`StaffCompensationSection.vue`):
* **Breakpoint 1279.98px:** El calendario y el panel de registro pasan de dos columnas a una columna antes de comprimirse.
* **Navegación de Meses:** Para períodos extensos se usa un selector nativo de mes con acciones anterior/siguiente. No se renderiza una fila de once o doce botones que obligue a desplazamiento horizontal.
* **Edición Directa:** Seleccionar una fecha válida abre inmediatamente el registro; se elimina el estado intermedio «Editar tramos / Finalizar edición». La confirmación real continúa siendo «Guardar cambios» del funcionario.
* **Estado Vacío:** Si no existe FUHO ni compensaciones, se muestra una instrucción para definir la distribución horaria; no se muestran tres métricas en `0 min` ni el calendario mensual.
* **Fechas Normales:** Las celdas disponibles no repiten la palabra «Disponible». Solo se muestran etiquetas cuando existe una condición relevante: feriado, fecha informativa, compensación registrada o conflicto.
* **Datos Inválidos Existentes:** Una compensación que quedó fuera del período o en feriado nacional permanece visible con la acción «Eliminar». Si su fecha todavía aparece en el mes, la celda puede abrirse para revisarla, pero no admite nuevos tramos.

### E. Resumen de Métricas (`StaffExecutionScheduleSummary.vue`):
* **Stacking en Móvil (`< 480px`):** Las métricas de "Total Horas Semanales", "Días con Actividad" y "Carga Semanal" se transforman automáticamente de fila horizontal a tarjetas apiladas verticales.

---

## 4. Estandarización de Textos y Diccionario (`lang/es/pds.js`)

Todos los textos visibles del flujo se centralizan en el archivo de idioma oficial, siguiendo el lenguaje ubicuo de la UFRO:

* `feriadoNacional`: "Feriado Nacional (No ejecutable)"
* `feriadoUniversitario`: "Feriado Institucional / Conmemorativo"
* `suspensionActividades`: "Suspensión de Actividades Administrativas"
* `topeSemanalAlcanzado`: "Ha alcanzado el tope máximo de 56 horas semanales para esta persona"

---

## 5. Jerarquía de Mensajes y Acciones (ADR-013, `APLICADO`)

1. El estado de carga/error/respaldo del calendario se anuncia una sola vez,
   antes de las secciones que lo consumen. No se duplican alertas en FUHO y
   compensación.
2. El resumen conserva solo tres valores accionables: horas requeridas,
   compensadas y balance faltante/excedido. No se agrega un badge que repita el
   mismo balance.
3. No se muestra un error por «seleccione una fecha» antes de que el usuario
   intente operar. La instrucción del calendario cumple esa función.
4. Los botones deshabilitados deben mantener una razón visible en el contexto:
   calendario pendiente, fecha bloqueada, cero horas requeridas, traslape o
   exceso de carga.
5. En lectura/resumen se usan los mismos componentes y reglas de calendario,
   pero sin controles de mutación.
