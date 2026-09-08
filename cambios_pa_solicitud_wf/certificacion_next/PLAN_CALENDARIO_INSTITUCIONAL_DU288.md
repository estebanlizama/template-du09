# Plan end-to-end — calendario institucional FUHO/FUCO DU288

**Estado:** regla funcional confirmada por el usuario e implementación end-to-end aplicada  
**Fecha:** 2026-09-08  
**Alcance:** PA Sybase, backend LoopBack 4, Vuex, Nuxt 2/Vue 2 y componentes DU288

## 0. Fuentes y estado de las decisiones

| Fuente | Estado | Uso en este plan |
|---|---|---|
| `estandar_visual/estandar_visual_obligatorio_du288.md` | Vigente y obligatorio | Fuente canónica para estructura, tokens, estados, accesibilidad y responsive |
| `assets/css/pds-du288.css` y componentes DU288 actuales | Implementado | Patrones visuales que se deben extender sin crear un sistema paralelo |
| `lang/es/pds.js` y `utils/services-provision/normative/messages.js` | Implementado | Catálogos donde deben vivir los textos y mensajes |
| Tipos 1, 2 y 3 de `es_cfer` | Dato esperado de BDD | Los tres se consultan y clasifican |
| Solo tipo 1 bloquea ejecución y compensación | Aprobado 2026-09-08 | Implementado en proyección, prevalidación, backend y PA FUCO |
| Catálogo estático anual | Parcial y explícito | Respaldo limitado a 2025-12-30/2026-01-02; fuera de cobertura se bloquea de forma segura |

Las referencias antes desactualizadas del comentario inicial de
`assets/css/pds-du288.css`, el catastro visual y la guía de desarrollo fueron
corregidas para apuntar a `estandar_visual/estandar_visual_obligatorio_du288.md`
sin duplicar el estándar.

También existe una diferencia entre estándar y código observado:

- `PdsDu288RequestForm.vue` concatena varios errores mediante `errors.join(...)`
  en un toast, aunque el estándar exige un resumen superior con lista;
- la clase `pds-ui-validation-summary` existe, pero actualmente no tiene un
  consumidor localizado;
- `StaffCompensationSection.vue` mantiene textos visibles y partes de
  `ariaLabel` escritos directamente en el componente;
- los textos secundarios del calendario usan actualmente 9/10 px, bajo el
  mínimo obligatorio de 11 px.

El alcance de interfaz de esta implementación debe corregir estas diferencias
en los elementos tocados por el calendario institucional.

## 1. Regla funcional propuesta

Las fechas registradas en `ufro_db.dbo.es_cfer` deben consultarse y mostrarse
con su clasificación. Solo el feriado nacional es limitante:

| Código | Descripción | Ejecución FUHO | Compensación FUCO | Carácter |
|---:|---|---|---|---|
| 1 | Feriado nacional | No se ejecuta | No se permite | Bloqueante |
| 2 | Feriado universitario | Se permite y se identifica | Se permite y se identifica | Informativo |
| 3 | Suspensión de actividades lectivas | Se permite y se identifica | Se permite y se identifica | Informativo |

Consecuencias:

1. Una ocurrencia FUHO que caiga en un feriado nacional no se ejecuta.
2. Solo las horas del feriado nacional se descuentan del total esperado.
3. La compensación requerida se calcula usando las horas efectivas, después
   de descontar los feriados nacionales.
4. El usuario no puede seleccionar un feriado nacional para FUCO.
5. Los tipos 2 y 3 no bloquean ni descuentan: identifican la ejecución o
   compensación que se haya comprometido en ese día.
6. Frontend, backend y PA de inserción FUCO aplican la misma clasificación.

## 2. Distinción necesaria entre FUHO y FUCO

### 2.1 FUHO

`sg_fuho` representa una distribución semanal recurrente por día de semana y
rango horario. No guarda fechas calendario individuales.

Por lo tanto, un feriado nacional lunes no debe impedir registrar el horario
recurrente de los lunes. El sistema debe conservar el horario y excluir
únicamente la ocurrencia correspondiente a ese feriado nacional al proyectar
el período. Si el lunes corresponde a un tipo 2 o 3, la ocurrencia permanece
efectiva y se presenta con su clasificación informativa.

Ejemplo:

```text
Horario recurrente: lunes 09:00–13:00
Feriado nacional: lunes 14/09/2026

Resultado:
- Los demás lunes mantienen 4 h.
- El 14/09/2026 muestra “Actividad no ejecutada”.
- El 14/09/2026 aporta 0 h efectivas y 4 h excluidas.
```

No se modifica el PA de inserción de `sg_fuho`, porque no recibe una fecha
calendario concreta que pueda validarse.

### 2.2 FUCO

`sg_fuco` sí registra una fecha concreta en `fec_compro`. El feriado nacional
se bloquea antes de seleccionarlo, nuevamente al validar el payload en backend
y finalmente en `sg_fucoiSecgen01`. Los tipos 2 y 3 permanecen seleccionables,
pero el tramo muestra el tipo de día comprometido.

## 3. Procedimientos almacenados

### 3.1 PA nuevo: `Analisis2.es_cfersSecgen01`

Responsabilidad única: obtener las fechas institucionales de un rango y su
tipo en la misma consulta.

Entradas:

```text
@f_inicio  datetime
@f_termino datetime
```

Salida:

```text
f_feriado
cod_tipfer
des_tipfer
```

Consulta base:

```sql
SELECT
    c.f_feriado,
    c.cod_tipfer,
    CASE c.cod_tipfer
        WHEN 1 THEN 'Feriado nacional'
        WHEN 2 THEN 'Feriado universitario'
        WHEN 3 THEN 'Suspension de actividades lectivas'
        ELSE 'Tipo no informado'
    END AS des_tipfer
FROM ufro_db.dbo.es_cfer c
WHERE datediff(day, @f_inicio, c.f_feriado) >= 0
  AND datediff(day, c.f_feriado, @f_termino) >= 0
  AND c.cod_tipfer IN (1, 2, 3)
ORDER BY c.f_feriado, c.cod_tipfer
```

La descripción se integra con `CASE` porque `ufro_db.dbo.es_tipfer` no existe
o no está publicada en el ambiente objetivo. `es_cfer` permanece como fuente
autoritativa de las fechas y códigos; el PA no depende de un owner alternativo
no verificado.

Archivos de entrega:

```text
certificacion_next/entrega/es_cfersSecgen01.sql
certificacion_next/entrega/es_cfersSecgen01.txt
```

El par SQL/TXT debe mantenerse idéntico y agregarse al orden de ejecución del
README de certificación.

### 3.2 PA modificado: `Analisis2.sg_fucoiSecgen01`

Motivo de la modificación: la prevalidación del frontend mejora la experiencia
pero no protege la base ante payloads manipulados, clientes antiguos, llamadas
directas o una omisión futura del backend.

Antes del `INSERT INTO sg_fuco`, el PA debe validar:

1. Que el día inicial no sea sábado ni domingo.
2. Que el día inicial no exista en `ufro_db.dbo.es_cfer` con tipo 1.
3. Si el tramo cruza medianoche, aplicar las mismas validaciones al día final.
4. Devolver un mensaje de negocio sin exponer tablas ni bases internas.

Mensaje esperado:

```text
Error: La fecha seleccionada no esta habilitada para compensacion
```

### 3.3 PA que no se modifica: `Analisis2.sg_fumeuSecgen01`

`sg_fume` representa meses/cuotas propuestos, no días. Un mes sigue siendo un
mes de ejecución aunque contenga feriados. Las excepciones diarias modifican
las horas efectivas, no la existencia del mes.

## 4. Contrato backend

### 4.1 Modelo normalizado

Crear un modelo de respuesta específico, sin exponer la fila Sybase cruda:

```ts
interface Du288InstitutionalDate {
  date: string;
  typeCode: 1 | 2 | 3;
  typeDescription: string;
  isBlocking: boolean;
  blocksExecution: boolean;
  blocksCompensation: boolean;
}

interface Du288InstitutionalCalendarResponse {
  from: string;
  to: string;
  source: 'database' | 'fallback';
  dates: Du288InstitutionalDate[];
}
```

Fechas de entrada y salida: `YYYY-MM-DD`.

El backend deriva las banderas; no confía en textos descriptivos:

```text
typeCode = 1 → isBlocking = true
typeCode = 2 o 3 → isBlocking = false
```

### 4.2 Repositorio

Agregar la consulta `selectInstitutionalDates` al registro
`service-provision-request.ts` y un método de repositorio que:

1. reciba el rango normalizado;
2. llame `runReadOnlyOutsideTransaction`;
3. transforme fecha, código y descripción;
4. elimine duplicados exactos;
5. ordene por fecha y código.

### 4.3 Servicio de calendario y fallback

Crear un servicio central para que endpoint y validación de guardado consuman
exactamente la misma fuente.

Reglas del fallback:

1. Se activa únicamente cuando el PA no existe en el ambiente.
2. No debe ocultar timeouts, pérdida de conexión u otros errores de BDD.
3. La lista estática vive solo en backend y usa el mismo contrato normalizado.
4. La respuesta indica `source: 'fallback'`.
5. Antes de liberar, el catálogo estático debe contener el calendario completo
   de cada año soportado; los cuatro registros disponibles son solo una muestra.

Si fallan tanto PA como fallback válido para el rango, el sistema trabaja en
modo seguro: no permite confirmar el funcionario ni enviar la solicitud.

### 4.4 Endpoint

Agregar un endpoint autenticado:

```text
GET /requests/service-provision/normative/institutional-calendar
    ?from=2026-01-01
    &to=2026-12-31
```

Validaciones de borde:

- ambos parámetros obligatorios;
- formato `YYYY-MM-DD`;
- `from <= to`;
- rango máximo compatible con el límite DU288;
- respuesta de error segura y sin detalles Sybase.

### 4.5 Validación de guardado/envío

La validación backend debe consultar el calendario una sola vez para el rango
general de la solicitud y reutilizarlo para todos los funcionarios. Se evita
una consulta por funcionario.

Para cada funcionario:

1. Expandir FUHO por fecha y por segmento horario.
2. Si un segmento cae en un feriado nacional, contabilizarlo como excluido y
   no como efectivo.
3. Si un segmento cae en un tipo 2 o 3, mantenerlo como efectivo y adjuntar su
   clasificación informativa.
4. Calcular el total esperado de FUCO desde las horas efectivas.
5. Rechazar todo tramo FUCO cuyo segmento inicial o final caiga en feriado
   nacional. Un tipo 2 o 3 no se rechaza.
6. Mantener las validaciones actuales de período, lunes a viernes, jornada,
   duplicidad, superposición y máximo semanal.

El cálculo por segmento es obligatorio para tramos nocturnos. Por ejemplo, si
un tramo va de lunes 23:00 a martes 01:00 y el martes es feriado nacional, la
hora del lunes puede ser efectiva y la hora del martes queda excluida. Si el
martes es tipo 2 o 3, ambas horas siguen siendo efectivas y el segundo segmento
queda identificado con el tipo correspondiente.

## 5. Fuente única de cálculo en frontend

Crear un helper puro, probado y reutilizable:

```js
getExecutionCalendarProjection({
  schedules,
  periodFrom,
  periodTo,
  institutionalDates,
})
```

Salida propuesta:

```js
{
  totalScheduledMinutes: 2160,
  totalExcludedMinutes: 480,
  totalEffectiveMinutes: 1680,
  months: [
    {
      key: '2026-01',
      scheduledMinutes: 2160,
      excludedMinutes: 480,
      effectiveMinutes: 1680,
      days: [
        {
          date: '2026-01-01',
          scheduledMinutes: 240,
          excludedMinutes: 240,
          effectiveMinutes: 0,
          isInstitutionalDate: true,
          isBlocking: true,
          typeCode: 1,
          typeDescription: 'Feriado nacional',
        },
      ],
    },
  ],
}
```

Todos los cálculos se realizan en minutos enteros. Las horas/minutos se
formatean solo al presentar.

Funciones existentes que deben consumir esa proyección o aceptar el calendario:

- `getExpectedScheduleHoursByDate`;
- `getExpectedScheduleHoursByWeek`;
- `getCompensationWorkloadEvaluation`;
- `getCompensationWeeklySummary`;
- `isCompensationDateAllowedByPeriod`.

## 6. Vuex y carga de datos

Extender `store/provision-request.js` con:

```text
state.institutionalCalendarByRange
state.institutionalCalendarLoading
state.institutionalCalendarError
```

Agregar la acción `getInstitutionalCalendar`.

Comportamiento:

1. Cargar al existir un rango general válido.
2. Consultar una vez el rango completo; los períodos individuales son
   subconjuntos del rango general.
3. Cachear por clave `from|to`.
4. Evitar que una respuesta antigua sobrescriba una consulta más reciente.
5. Limpiar o recargar si cambia el rango.

## 7. Vistas y componentes afectados

### 7.1 Vistas principales

| Vista | Archivo | Impacto |
|---|---|---|
| Nueva solicitud DU288 | `pages/services-provision/new-request-du288.vue` | Usa el formulario y debe cargar el calendario del rango |
| Edición/borrador/corrección | `pages/services-provision/new-request-du288.vue` con ID | Misma estructura; recalcula al cambiar fechas |
| Detalle de solicitud | `pages/services-provision/_id/index.vue` | Debe mostrar la proyección efectiva en modo lectura |

### 7.2 Componentes principales

| Componente | Cambio |
|---|---|
| `PdsDu288RequestForm.vue` | Orquestar carga, estados, props y validación antes de agregar funcionario/enviar |
| `Du288StaffRequestSection.vue` | Entregar rango y fechas institucionales a FUHO/FUCO |
| `StaffExecutionScheduleSection.vue` | Mostrar distribución efectiva mensual sin cambiar el editor semanal |
| `StaffCompensationSection.vue` | Deshabilitar solo feriados nacionales, etiquetar tipos 2 y 3 y recalcular requerido |
| `Du288StaffSummarySection.vue` | Mostrar métricas efectivas y pasar calendario a los modales de consulta |
| `Du288CompensationCalendarModal.vue` | Mostrar la clasificación y los feriados nacionales bloqueados también en solo lectura |
| `Du288ValidationSummary.vue` nuevo | Mostrar una lista accesible de errores de guardado/envío y permitir llevar el foco a la sección afectada |

### 7.3 Componentes visuales propuestos

Crear `Du288ExecutionMonthProjection.vue` para representar los meses y sus
excepciones. Debe ser reutilizado en creación, edición, corrección y lectura.

Como FUHO y FUCO navegarán por los mismos meses, extraer un componente común
`Du288MonthNavigation.vue`. El patrón ya quedará utilizado en dos lugares, por
lo que la extracción es obligatoria según el estándar visual DU288.

Reutilizar `AppLoadingState` o `SectionLoadingState` para la carga local. Los
componentes de presentación reciben fechas ya normalizadas y no llaman Axios ni
mutan Vuex directamente.

No modificar componentes `dna`; el cambio es exclusivo de DU288.

### 7.4 Vistas secundarias

`ResolutionDetail.vue` actualmente muestra el horario recurrente. En esta
entrega no debe recalcular ni alterar el documento jurídico histórico, salvo
que se apruebe explícitamente incorporar el detalle de fechas institucionales
en la resolución. El detalle operativo de solicitud sí mostrará la proyección.

## 8. Diseño visual propuesto

### 8.1 Integración con la estructura existente

No se reemplaza el diseño actual:

- FUHO conserva el resumen/editor a la izquierda y la semana recurrente a la
  derecha. La proyección mensual se agrega debajo de esa grilla y dentro de la
  misma `pds-ui-time-section`.
- FUCO conserva la navegación mensual, la cuadrícula de cinco días y el panel
  lateral de tramos. Se amplía cada objeto `day` con la clasificación
  institucional.
- El detalle y `Du288CompensationCalendarModal.vue` reutilizan los mismos
  componentes con `isReadOnly`; no se crea una variante visual separada.

### 8.2 Proyección FUHO

Dentro de FUHO, después del editor y la semana recurrente:

```text
Distribución efectiva del período
Enero 2026

[ Horas programadas 36 h ] [ Horas no ejecutadas 8 h ] [ Horas efectivas 28 h ]

01/01/2026  Feriado nacional
              Actividad no ejecutada · 4 h excluidas

02/01/2026  Feriado universitario
              Actividad programada · 4 h efectivas
```

Si una fecha institucional no coincide con un tramo FUHO, se puede listar como
contexto del mes, pero muestra `Sin actividad programada` y aporta `0 h`.

### 8.3 Calendario FUCO

Cada día mantiene el botón actual y agrega estado semántico:

| Caso | Apariencia | Interacción | Texto compacto |
|---|---|---|---|
| Día normal | Base existente | Habilitado | `Disponible` o sus tramos |
| Tipo 1 | Error/bloqueo con icono y texto | Deshabilitado | `Feriado nacional` / `No disponible` |
| Tipo 2 | Información neutral | Habilitado | `Feriado universitario` |
| Tipo 3 | Información neutral | Habilitado | `Suspensión de actividades lectivas` |

Al seleccionar tipos 2 o 3, el panel lateral muestra el tipo antes del editor:

```text
02/01/2026
Feriado universitario · Puede registrar compensación en esta fecha.
```

No se dispara toast por seleccionar un tipo 2 o 3; la explicación es contextual
y permanece visible. El tipo 1 no abre el editor.

Si existe una compensación persistida o recibida en tipo 1, el día y el tramo se
muestran como error, sin borrarlos silenciosamente:

```text
La compensación del 01/01/2026 no es válida porque corresponde a un feriado
nacional. Reubique o elimine el tramo.
```

### 8.4 Lenguaje visual obligatorio

- título de sección de 14 px y peso 700;
- fechas visibles en `DD/MM/YYYY`;
- horas como `4 h`, `1 h 30 min` o `45 min`, nunca decimales;
- métricas con `pds-ui-metrics-grid` y `pds-ui-metric-card` existentes;
- `--pds-du288-danger*` únicamente para feriado nacional bloqueante;
- `--pds-du288-info*` para feriado universitario y suspensión lectiva;
- color acompañado siempre de icono y texto;
- navegación mensual por botones con foco visible y `aria-pressed`;
- textos exclusivamente en `lang/es/pds.js` o en el catálogo normativo;
- sin colores hexadecimales ni estilos inline nuevos;
- estados de carga, vacío, error, fallback y solo lectura;
- texto mínimo de 11 px. Al tocar el calendario se normalizan los textos actuales
  de 9/10 px relacionados con los días y conflictos;
- `aria-label` de cada día compuesto por fecha, tipo, disponibilidad, horas y
  conflictos; alertas dinámicas con `role="alert"` y carga con `role="status"`;
- responsive validado en 1366, 1024, 768 y 375 px.

El calendario conserva su desplazamiento horizontal interno en móvil; no debe
generar desplazamiento horizontal de página.

### 8.5 Catálogo de mensajes propuesto

Textos visuales nuevos bajo `request.institutionalCalendar` en `lang/es/pds.js`:

| Clave propuesta | Mensaje |
|---|---|
| `title` | `Calendario institucional` |
| `executionTitle` | `Distribución efectiva del período` |
| `loading` | `Consultando calendario institucional...` |
| `empty` | `No existen fechas institucionales dentro del período de ejecución.` |
| `fallback` | `Se está utilizando el calendario institucional de respaldo para este período.` |
| `loadError` | `No fue posible obtener el calendario institucional. Intente nuevamente antes de continuar.` |
| `scheduledHours` | `Horas programadas` |
| `excludedHours` | `Horas no ejecutadas` |
| `effectiveHours` | `Horas efectivas` |
| `nationalHoliday` | `Feriado nacional` |
| `universityHoliday` | `Feriado universitario` |
| `teachingSuspension` | `Suspensión de actividades lectivas` |
| `notAvailable` | `No disponible` |
| `noScheduledActivity` | `Sin actividad programada` |
| `executionNotPerformed` | `Actividad no ejecutada` |
| `executionScheduled` | `Actividad programada` |
| `compensationAllowed` | `Puede registrar compensación en esta fecha.` |
| `retry` | `Reintentar` |

Mensajes de validación nuevos en
`utils/services-provision/normative/messages.js`:

| Clave propuesta | Mensaje |
|---|---|
| `compensationNationalHoliday(date)` | `La compensación del {date} no es válida porque corresponde a un feriado nacional. Reubique o elimine el tramo.` |
| `institutionalCalendarPending` | `Espere mientras se valida el calendario institucional.` |
| `institutionalCalendarUnavailable` | `No fue posible validar el calendario institucional del período de ejecución.` |

Textos existentes de compensación que deben ajustarse para no llamar “día
hábil” a todos los casos permitidos:

| Clave existente | Nuevo mensaje |
|---|---|
| `request.compensation.calendarInstruction` | `Seleccione una fecha habilitada del calendario para registrar sus horas de compensación.` |
| `request.compensation.conditionValidDates` | `Todas las fechas pertenecen al período y están habilitadas para compensación.` |
| `request.compensation.selectDateError` | `Seleccione una fecha habilitada dentro del período de ejecución.` |
| `request.compensation.rangeOutsidePeriod` | `El tramo termina fuera del período o en una fecha no habilitada.` |

El PA devuelve un mensaje de negocio estable y sin nombres técnicos:

```text
Error: La fecha seleccionada corresponde a un feriado nacional y no admite compensacion
```

La lógica usa `typeCode`/`isBlocking`; nunca compara los mensajes traducidos
para decidir si una fecha está habilitada.

### 8.6 Flujo visual esperado

1. Al completar o cambiar el período, Vuex inicia la consulta y ambas secciones
   muestran carga local; FUCO queda temporalmente deshabilitado.
2. Al resolver el calendario, FUHO recalcula la distribución mensual y FUCO
   marca los tres tipos.
3. Un tipo 1 permanece visible, explica el motivo y no permite abrir el editor.
4. Un tipo 2 o 3 permite seleccionar y registrar, mostrando la clasificación en
   el día, panel lateral, tramo guardado y modo lectura.
5. Una compensación tipo 1 preexistente aparece en el tramo, resumen del
   funcionario y resumen superior de validación.
6. Guardar borrador puede omitir reglas completas de envío, pero nunca puede
   persistir una nueva compensación en tipo 1 porque es una regla de integridad.
7. Enviar vuelve a consultar/revalidar en backend y recalcula las horas; el
   frontend no es la autoridad final.

## 9. Validaciones frontend

### 9.1 Antes de agregar o actualizar funcionario

- el calendario debe estar cargado o existir fallback completo;
- el total esperado debe provenir de horas efectivas;
- ninguna compensación puede caer en feriado nacional;
- si una compensación previamente cargada queda sobre un feriado nacional, se
  marca como error y se solicita reubicarla; no se elimina silenciosamente;
- si cae en tipo 2 o 3, se conserva y muestra su clasificación sin error.

### 9.2 Antes de guardar borrador

Mantener integridad mínima. No permitir persistir una compensación en feriado
nacional. Las demás reglas normativas revisables conservan la política actual de
borrador. Una fila inválida nunca se elimina automáticamente.

### 9.3 Antes de enviar

- calendario resuelto obligatoriamente;
- cero FUCO en feriados nacionales;
- compensación total igual a ejecución efectiva;
- sin errores de carga ni fechas fuera del rango.

### 9.4 Estados de carga/error

Mientras se carga el calendario:

- mostrar `SectionLoadingState` dentro de FUHO/FUCO con región viva;
- deshabilitar selección de fechas FUCO;
- evitar confirmar o enviar hasta contar con una fuente válida.

Estados completos:

- `loading`: carga local, sin bloquear el resto de la página;
- `empty`: estado neutral indicando que el rango no contiene fechas
  institucionales;
- `success`: proyección y calendario disponibles;
- `fallback`: `b-alert` de advertencia con el mensaje catalogado;
- `error`: alerta de sección con acción `Reintentar` y toast técnico breve una
  sola vez;
- `pending-validation`: no se interpreta como éxito;
- `read-only`: misma información, sin controles de edición.

Los errores múltiples de envío se agregan a `pds-ui-validation-summary`; no se
concatenan en un toast extenso. El toast se reserva para el fallo técnico general
y el detalle accionable queda en la sección correspondiente. Al mostrarse el
resumen se mueve el foco a su título; cada error identifica funcionario, fecha y
acción correctiva, sin mostrar RUT completo ni detalles de BDD.

## 10. Validaciones backend y defensa en profundidad

El backend no confía en las fechas ni en los totales calculados por el cliente.
Debe reconstruir la proyección con horario, período y calendario institucional.

Capas de protección:

```text
Frontend: evita selección y explica el impacto
    ↓
Backend: recalcula y rechaza un feriado nacional manipulado
    ↓
sg_fucoiSecgen01: protege la integridad ante cualquier consumidor
```

El cliente no debe enviar `totalExpectedHours` como dato autoritativo. Puede
enviarse solo con propósito visual; el servidor siempre lo recalcula.

## 11. Pruebas

### 11.1 PA

- rango con tipos 1, 2 y 3;
- rango sin fechas;
- límites inclusivos;
- fecha inicial posterior a final;
- correspondencia de descripción para los códigos 1, 2 y 3;
- permisos cruzados entre `secgen_db` y `ufro_db`;
- compensación normal, fin de semana, feriado nacional, tipos informativos y
  cruce de medianoche.

### 11.2 Backend

- transformación del resultado del PA;
- fallback solamente ante PA ausente;
- propagación de otros errores de BDD;
- consulta única por solicitud con varios funcionarios;
- exclusión de horas FUHO solo en feriado nacional;
- fecha institucional sin horario: descuento cero;
- tipo 2 y 3 con horario: horas efectivas conservadas y clasificación presente;
- rechazo FUCO para tipo 1;
- aceptación y clasificación FUCO para tipos 2 y 3;
- tramo nocturno que toca una fecha bloqueada;
- paridad del total esperado con frontend.

### 11.3 Frontend/helper

- agrupación por mes;
- períodos parciales;
- fecha civil sin desplazamiento por zona horaria;
- FUHO recurrente conservado y solo la ocurrencia tipo 1 excluida;
- ocurrencias tipo 2 y 3 efectivas e identificadas;
- recalculo inmediato de programadas, excluidas y efectivas;
- día FUCO deshabilitado con motivo;
- compensación cargada sobre tipo 1 marcada como error;
- compensación cargada sobre tipos 2 y 3 permitida y etiquetada;
- estados loading, empty, error, fallback y read-only;
- `aria-label` del día con fecha, clasificación, disponibilidad y horas;
- tipo 2 o 3 informado inline sin toast innecesario;
- múltiples errores mostrados como lista en el resumen superior;
- foco enviado al resumen y navegación completa por teclado;
- textos visibles obtenidos desde los catálogos, sin literales nuevos en el
  template.

### 11.4 Recorrido end-to-end

1. Crear solicitud con un período que contiene tipos 1, 2 y 3.
2. Registrar FUHO cuyo día semanal coincide con esas fechas.
3. Confirmar que solo el tipo 1 aparece como no ejecutado y reduce el total.
4. Confirmar que tipos 2 y 3 permanecen efectivos y muestran su clasificación.
5. Intentar seleccionar el tipo 1 en FUCO y confirmar bloqueo visual.
6. Registrar FUCO en tipos 2 y 3 y confirmar que se permite y etiqueta.
7. Enviar un payload tipo 1 manipulado y confirmar rechazo backend.
8. Intentar inserción directa tipo 1 mediante `sg_fucoiSecgen01` y confirmar
   rechazo.
9. Guardar borrador, reabrir y confirmar la misma proyección.
10. Abrir detalle solo lectura y ambos modales.
11. Repetir con el PA ausente y fallback activo.
12. Provocar varios errores y confirmar resumen superior, foco y toast técnico
    breve.
13. Verificar 1366, 1024, 768 y 375 px sin scroll horizontal de página.

## 12. Orden de implementación

1. Completar y validar el catálogo estático de respaldo.
2. Crear `es_cfersSecgen01` en SQL/TXT y actualizar README.
3. Crear modelos, consulta de repositorio y servicio de calendario.
4. Crear endpoint autenticado.
5. Integrar calendario en validación backend y corregir cálculo segmentado.
6. Modificar `sg_fucoiSecgen01` con el guard definitivo.
7. Agregar Vuex, cache y manejo de estados.
8. Crear helper de proyección y pruebas unitarias.
9. Crear el resumen accesible y completar los textos catalogados.
10. Implementar proyección visual FUHO.
11. Bloquear tipo 1 y clasificar tipos 2 y 3 en FUCO.
12. Integrar resumen de funcionario y modos de solo lectura.
13. Corregir referencias obsoletas al estándar visual.
14. Ejecutar pruebas, `npm run lint:du288-ui`, lint general, build y revisión
    responsive.

## 13. Criterios de aceptación

- Solo el tipo 1 bloquea ejecución efectiva y compensación.
- Los tipos 2 y 3 permiten ejecución y compensación y se muestran como
  información contextual.
- El horario FUHO recurrente no se elimina por contener una fecha bloqueada.
- Cada fecha institucional muestra tipo y efecto; solo el tipo 1 muestra horas
  descontadas.
- Los totales programado, excluido y efectivo son visibles y coherentes.
- El total requerido FUCO usa únicamente horas efectivas.
- FUCO no permite seleccionar ni guardar un feriado nacional.
- FUCO permite tipos 2 y 3 y mantiene visible su clasificación.
- Frontend y backend producen el mismo resultado en minutos.
- Un payload manipulado es rechazado por backend.
- Una inserción directa inválida es rechazada por `sg_fucoiSecgen01`.
- El PA nuevo entrega fecha, código y descripción en una sola llamada.
- `sg_fumeuSecgen01` y la estructura de `sg_fume` no cambian.
- Creación, edición, corrección y lectura reutilizan los mismos componentes.
- Los mensajes indican el problema y la acción posible; tipos 2 y 3 no generan
  mensajes de error.
- Los errores múltiples aparecen en un resumen accesible y no en un toast
  concatenado.
- La información de cada día puede comprenderse sin depender solo del color.
- La interfaz cumple el estándar visual DU288 y pasa lint/build.

## 14. Riesgo pendiente antes de liberar

El fallback no puede considerarse seguro con solo estas cuatro filas:

```text
2025-12-30 tipo 2
2025-12-31 tipo 2
2026-01-01 tipo 1
2026-01-02 tipo 2
```

La implementación no usa estas filas como si fueran un año completo: si el PA
no está instalado y el rango solicitado excede la cobertura indicada, responde
como calendario no disponible y bloquea el guardado/envío. Antes de liberar se
debe instalar el PA y confirmar sus permisos de lectura, o entregar un catálogo
de respaldo completo por cada año habilitado.
