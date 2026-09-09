# Decisiones de Arquitectura: UI/UX y Responsividad Frontend

## 1. Principios de Experiencia de Usuario (UX)

El diseño del flujo de resoluciones y solicitudes (DU288 / DU09) sigue directrices estrictas de usabilidad orientadas a los usuarios académicos y administrativos de la Universidad:

1. **Cero Ruido Técnico (Clean Information):** El usuario solicitante no debe ser abrumado con cálculos internos o diagnósticos de backend (ej: "Horas no ejecutadas: 0", "Días excluidos: 0"). Solo debe ver información accionable y clara.
2. **Claridad Visual Inmediata:** Los estados y restricciones (feriados, advertencias de tope) se comunican visualmente mediante badges con colores estándar (`danger`, `warning`, `info`, `success`).
3. **Fluidez y Micro-animaciones:** Todas las transiciones de apertura de modales, popovers y hover en cuadrículas usan transiciones suaves (`transition: all 0.25s ease`).

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
* **Ancho Mínimo de Columna:** Se estableció `min-width: 118px` para cada día (Lunes a Domingo), con un ancho mínimo del contenedor de `610px`.
* **Scroll Horizontal Limpio:** Se agregó una barra de desplazamiento estilizada (`custom-scrollbar`) para resoluciones menores a `992px`, evitando que los nombres de los días se superpongan con el botón de eliminación de bloque `[x]`.

### B. Formulario de Horarios (`StaffExecutionScheduleSection.vue`):
* **Breakpoint Adaptado:** Se ajustó el breakpoint de columnas a `1199.98px` (en lugar de `991.98px`), de modo que en pantallas de 1240x911 el formulario de ingreso y la cuadrícula semanal se apilen armónicamente sin comprimir los campos.

### C. Editor de Bloques (`StaffExecutionScheduleEditor.vue`):
* **Distribución Equitativa:** Se estandarizaron los inputs de Selección de Día, Hora Inicio y Hora Término en columnas iguales (`col-12 col-sm-4`), asegurando que los selectores numéricos mantengan espacio suficiente para sus iconos y textos.

### D. Sección de Compensaciones (`StaffCompensationSection.vue`):
* **Breakpoint 1279.98px:** Permite que en pantallas de 1240px los campos de fecha, hora inicio, hora término y motivo se distribuyan en un diseño de dos filas equilibradas, con un `min-width: 85px` en los inputs de hora para evitar el corte del texto "08:30".

### E. Resumen de Métricas (`StaffExecutionScheduleSummary.vue`):
* **Stacking en Móvil (`< 480px`):** Las métricas de "Total Horas Semanales", "Días con Actividad" y "Carga Semanal" se transforman automáticamente de fila horizontal a tarjetas apiladas verticales.

---

## 4. Estandarización de Textos y Diccionario (`lang/es/pds.js`)

Todos los textos visibles del flujo se centralizan en el archivo de idioma oficial, siguiendo el lenguaje ubicuo de la UFRO:

* `feriadoNacional`: "Feriado Nacional (No ejecutable)"
* `feriadoUniversitario`: "Feriado Institucional / Conmemorativo"
* `suspensionActividades`: "Suspensión de Actividades Administrativas"
* `topeSemanalAlcanzado`: "Ha alcanzado el tope máximo de 56 horas semanales para esta persona"
