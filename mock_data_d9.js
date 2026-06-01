const DB_MOCK = {
    funcionarios: [
        {
            rut: '15.890.342-K',
            rut_limpio: '15890342K',
            nombre: 'LIZAMA AILLAPAN ESTEBAN NICOLAS',
            tiene_deudas: false,
            es_pariente: false,
            asignaciones_rol: [],
            contratos: [
                { tipo: 'Contrato Indefinido — Académico', estamento: 'Académico', jerarquia: 'Titular', grado: '4', jornada: '44 Hrs', antiguedad: '12 años 3 meses', bruto: 2142856, liquido: 1684220, itemDirectivo: 'DIR. ACADÉMICO 11' },
                { tipo: 'Contrato Plazo Fijo — Investigativo', estamento: 'Académico', jerarquia: 'Investigador', grado: '10', jornada: '11 Hrs', antiguedad: '5 años 1 mes', bruto: 1200000, liquido: 980000, itemDirectivo: 'ACADÉMICO' },
                { tipo: 'Contrato Honorarios', estamento: 'Profesional', jerarquia: 'Asesor Externo', grado: '15', jornada: 'A Suma Alzada', antiguedad: '1 año', bruto: 600000, liquido: 540000, itemDirectivo: 'NO ACADÉMICO' }
            ],
            deudas: [],
            inhabilidades: [],
            sea_vigente: false,
            compensacion: null
        },
        {
            rut: '16.452.891-2',
            rut_limpio: '164528912',
            nombre: 'SOTO FIGUEROA MARÍA ELENA',
            tiene_deudas: false,
            es_pariente: false,
            asignaciones_rol: [],
            contratos: [
                { tipo: 'Contrato Planta — Administrativo', estamento: 'Administrativo', jerarquia: 'Administrativo Planta', grado: '16', jornada: '44 Hrs', antiguedad: '12 años', bruto: 1084000, liquido: 842500, itemDirectivo: 'NO ACADÉMICO' }
            ],
            deudas: [],
            inhabilidades: [],
            sea_vigente: false,
            compensacion: {
                tipo: 'Compensación Horaria Semanal',
                horas_semanales: 8,
                detalle: [
                    { dia: 'Sábado', horas: 8 }
                ]
            }
        },
        {
            rut: '16.123.456-7',
            rut_limpio: '161234567',
            nombre: 'PEREZ SOTO MARIA JOSE',
            tiene_deudas: false,
            es_pariente: false,
            asignaciones_rol: [],
            contratos: [
                { tipo: 'Contrato Plazo Fijo — Académico', estamento: 'Académico', jerarquia: 'Asistente', grado: '10', jornada: '22 Hrs', antiguedad: '3 años', bruto: 2200000, liquido: 1750000, itemDirectivo: 'ACADÉMICO' }
            ],
            deudas: [],
            inhabilidades: [],
            sea_vigente: true,
            compensacion: null
        }
    ],
    tabla_deudas: [],
    tabla_inhabilidades: [],
    tabla_evidencias_tipo: [
        { id: '1', nombre: 'Informe Técnico Mensual', descripcion: 'Documento detallado de actividades con firmas.' },
        { id: '2', nombre: 'Acta de Conformidad', descripcion: 'Certificado de conformidad firmado por el Jefe de Proyecto.' },
        { id: '3', nombre: 'Base de Datos Entregada', descripcion: 'Base de datos o conjunto de datos recopilados.' }
    ],
    tabla_topes: [
        { estamento: 'Académico', tipo_tope: 'Porcentaje', valor: 0.5, descripcion: 'Hasta 50% de la remuneración bruta mensual' },
        { estamento: 'Administrativo', cargo: 'Profesional', tipo_tope: 'Fijo', valor: 621634, descripcion: 'Tope fijo para cargo Profesional' },
        { estamento: 'Administrativo', cargo: 'Técnico Universitario', tipo_tope: 'Fijo', valor: 553079, descripcion: 'Tope fijo para cargo Técnico Universitario' },
        { estamento: 'Administrativo', cargo: 'Administrativo', tipo_tope: 'Fijo', valor: 553079, descripcion: 'Tope fijo para cargo Administrativo' },
        { estamento: 'Administrativo', cargo: 'Auxiliar', tipo_tope: 'Fijo', valor: 382519, descripcion: 'Tope fijo para cargo Auxiliar' }
    ],
    centros_costo: [
        {
            codigo: '4050.21',
            nombre: 'INSTITUTO DE AGROINDUSTRIA',
            financiamiento_id: '21',
            financiamiento_desc: '21 - Fondos Propios',
            decreto: '0 - DU 288',
            unidad_ejecutora: 'FACULTAD DE INGENIERÍA',
            jefe_rut: '12.345.678-9',
            jefe_nombre: 'DR. MARIO GODOY RIVERA',
            es_estructural: false,
            habilitado: true,
            vigente: true,
            formacion_continua_ok: true,
            descripcion_default: 'Apoyo técnico y profesional en el marco del proyecto de investigación avanzada de la unidad.',
            fecha_inicio: '2026-05-01',
            fecha_fin: '2026-12-31',
            saldo_disponible: 15420000,
            ind_anid: false,
            items_presupuestarios: [
                { cod: '30000', desc: 'Directivos', asignado: 1600000, ejecutado: 0 },
                { cod: '30300', desc: 'Académicos', asignado: 4000000, ejecutado: 420000 },
                { cod: '30600', desc: 'No Académicos', asignado: 1600000, ejecutado: 800000 }
            ]
        },
        {
            codigo: '8120.44',
            nombre: 'INVESTIGACIÓN AVANZADA HIDRÓGENO VERDE',
            financiamiento_id: '44',
            financiamiento_desc: '44 - Terceros',
            decreto: '4 - Resol 4129',
            unidad_ejecutora: 'FACULTAD DE INGENIERÍA',
            jefe_rut: '9.876.543-2',
            jefe_nombre: 'DRA. ELENA SALAZAR',
            es_estructural: false,
            habilitado: true,
            vigente: true,
            formacion_continua_ok: false,
            descripcion_default: 'Desarrollo de investigación en celdas de combustible e hidrógeno.',
            fecha_inicio: '2026-01-01',
            fecha_fin: '2026-12-31',
            saldo_disponible: 2550000,
            ind_anid: true,
            items_presupuestarios: [
                { cod: '30300', desc: 'Académicos', asignado: 2500000, ejecutado: 100000 },
                { cod: '30600', desc: 'No Académicos', asignado: 1000000, ejecutado: 950000 }
            ]
        }
    ],
    prestaciones_de_servicio: [
        {
            id_solicitud: 'PDS-2026-0001',
            estado: 'En Revisión Presupuestaria',
            fecha_creacion: '2026-05-05T10:00:00',
            fecha_envio_revision: '2026-05-06T09:15:00',
            fecha_ingreso_dgdp: '2026-05-15T09:00:00',
            fecha_ingreso_finanzas_facultad: '2026-05-18T09:00:00',
            fecha_ingreso_decano: '2026-05-20T09:00:00',
            fecha_ingreso_finanzas_central: '2026-05-22T09:00:00',
            estado_finanzas_facultad: 'En Revisión Financiera',
            resultado_dgdp: {
                estado: 'Aprobado con Exclusiones',
                operador: 'Franco Valdebenito (Director DGDP)',
                fecha: '15/05/2026'
            },
            resultado_finanzas_facultad: {
                estado: 'Pendiente',
                operador: '',
                fecha: '',
                comentario: ''
            },
            resultado_decano: {
                estado: 'Pendiente',
                operador: '',
                fecha: '',
                comentario: ''
            },
            resultado_finanzas_central: {
                estado: 'Pendiente',
                operador: '',
                fecha: '',
                comentario: ''
            },
            solicitante: {
                rut: '14.223.344-5',
                nombre: 'FRANCO VALDEBENITO',
                rol: 'SOLICITANTE'
            },
            centro_costo: {
                codigo: '4050.21',
                nombre: 'INSTITUTO DE AGROINDUSTRIA'
            },
            jefe_proyecto: {
                rut: '12.345.678-9',
                nombre: 'DR. MARIO GODOY RIVERA'
            },
            aprobacion_jefe_proyecto: {
                nombre: 'DR. MARIO GODOY RIVERA',
                rut: '12.345.678-9',
                fecha_hora: '07/05/2026 11:30',
                estado: 'Aprobado',
                comentario: 'La solicitud cumple plenamente con los objetivos del Instituto de Agroindustria y cuenta con presupuesto suficiente.'
            },
            aprobacion_jefatura_superior: {
                nombre: 'DRA. ELENA SALAZAR',
                rut: '9.876.543-2',
                fecha_hora: '10/05/2026 14:20',
                estado: 'Aprobado',
                comentario: 'Visado por Jefatura Superior para su tramitación urgente ante la Dirección de Gestión y Desarrollo de Personas (DGDP).'
            },
            trazabilidad: [
                { etapa: 'Creación de Solicitud', actor: 'Franco Valdebenito (Solicitante)', fecha: '05/05/2026 10:00', estado: 'Borrador' },
                { etapa: 'Envío a Revisión', actor: 'Franco Valdebenito (Solicitante)', fecha: '06/05/2026 09:15', estado: 'Enviado' },
                { etapa: 'Aprobación Jefe Proyecto', actor: 'Dr. Mario Godoy Rivera (Jefe de Proyecto)', fecha: '07/05/2026 11:30', estado: 'Aprobado', comentario: 'Cumple con objetivos y presupuesto.' },
                { etapa: 'Aprobación Jefatura Superior', actor: 'Dra. Elena Salazar (Jefatura Superior)', fecha: '10/05/2026 14:20', estado: 'Aprobado', comentario: 'Visado para tramitación urgente.' },
                { etapa: 'Auditoría DGDP', actor: 'Franco Valdebenito (Director DGDP)', fecha: '15/05/2026 10:45', estado: 'Aprobado con Exclusiones', comentario: 'Aprobado con exclusión de María José Pérez por tope normativo de Licencia Médica detectada.' },
                { etapa: 'Revisión Finanzas Facultad', actor: 'Unidad de Finanzas - Facultad', fecha: '18/05/2026 09:00', estado: 'En Revisión' }
            ],
            detalles: {
                unidad_ejecutora: 'FACULTAD DE INGENIERÍA',
                tipo_financiamiento: '21 - Fondos Propios',
                decreto_afecto: '0 - DU 288',
                tipo_prestacion: 'Asistencia Técnica',
                descripcion: 'Modernización de procesos para el Instituto de Agroindustria mediante la implementación de nuevos flujos de trabajo en entorno D9/2026, asegurando la trazabilidad y el cumplimiento normativo de las prestaciones de servicio.',
                fecha_inicio: '2026-06-01',
                fecha_fin: '2026-07-31',
                evidencias_requeridas: ['Informe Técnico Mensual', 'Acta de Conformidad'],
                evidencias_detalladas: [
                    { nombre: 'Informe Técnico Mensual', fecha_estimada: '10/07/2026' },
                    { nombre: 'Acta de Conformidad', fecha_estimada: '31/07/2026' }
                ]
            },
            funcionarios: [
                {
                    id_ui: 'lizama',
                    rut: '15.890.342-K',
                    nombre: 'LIZAMA AILLAPAN ESTEBAN NICOLAS',
                    estamento: 'Académico',
                    jerarquia: 'Titular',
                    actividad: 'Diseño de arquitectura de microservicios y validación de reglas de negocio para el proyecto D9.',
                    modalidad: 'Fuera de Jornada',
                    is_sea_vigente: false,
                    contrato_seleccionado: 'Contrato Indefinido — Académico',
                    meses: 2,
                    meses_detalle: 'Junio, Julio 2026',
                    total_pds: 900000,
                    cuotas_mensuales: [
                        { mes: 'Junio 2026', monto_bruto: 450000 },
                        { mes: 'Julio 2026', monto_bruto: 450000 }
                    ],
                    compensacion_detalle: null,
                    estado_revision_dgdp_inicial: 'aprobado',
                    estado_revision_financiera_inicial: 'pendiente',
                    validacion_financiera_previa: null,
                    item_presupuestario_asociado: '30300',
                    categoria_presupuestaria: 'Honorarios Académicos',
                    saldo_item_actual: 3580000,
                    monto_acumulado_item_en_solicitud: 900000,
                    saldo_proyectado_item: 2680000,
                    estado_suficiencia_item: 'suficiente',
                    explicacion_validacion_item: 'El ítem posee saldo disponible suficiente en la cuenta presupuestaria para refrendar el honorario.',
                    prestaciones_solicitadas: {
                        descripcion: 'Diseño de arquitectura y validación de reglas para el proyecto D9',
                        meses: 2,
                        total: 900000
                    },
                    resumen_financiero_actual: { mensual: 450000, total: 900000 },
                    resumen_validaciones_previas: 'Validación Normativa DGDP Aprobada OK el 15/05/2026. Cumple DU 288 y topes contractuales.',
                    revision_finanzas: { estado: 'pendiente', motivo: '', comentario: '', fecha: '', actor: '' },
                    historial_prestaciones: [
                        { codigo: 'PDS-2025-081', cc: '4050.21', periodo: 'Marzo - Mayo 2025', rol: 'Desarrollador Senior', monto: 1350000, estado: 'Pagado' },
                        { codigo: 'PDS-2025-142', cc: '8120.44', periodo: 'Sep - Dic 2025', rol: 'Asesor Técnico', monto: 1800000, estado: 'Pagado' }
                    ],
                    historial_pagos: [
                        { mes: 'Mayo 2026', monto: 450000, estado: 'Procesado' },
                        { mes: 'Abril 2026', monto: 450000, estado: 'Procesado' }
                    ],
                    restricciones_administrativas: {
                        licencias_vigentes: false,
                        permisos_sin_goce: false,
                        observaciones: 'Funcionario activo sin restricciones vigentes.'
                    },
                    parentescos_incompatibilidades: {
                        tiene_parentesco: false,
                        detalle: 'Sin relaciones de parentesco declaradas en el CC.'
                    }
                },
                {
                    id_ui: 'soto',
                    rut: '16.452.891-2',
                    nombre: 'SOTO FIGUEROA MARÍA ELENA',
                    estamento: 'Administrativo',
                    jerarquia: 'Administrativo Planta',
                    actividad: 'Apoyo administrativo en la recopilación de actas, foliación de expedientes físicos y digitalización de documentos para el repositorio de procesos.',
                    modalidad: 'Fuera de Jornada',
                    is_sea_vigente: false,
                    contrato_seleccionado: 'Contrato Planta — Administrativo',
                    meses: 2,
                    meses_detalle: 'Junio, Julio 2026',
                    total_pds: 560000,
                    cuotas_mensuales: [
                        { mes: 'Junio 2026', monto_bruto: 280000 },
                        { mes: 'Julio 2026', monto_bruto: 280000 }
                    ],
                    compensacion_detalle: {
                        tipo: 'Compensación Horaria Semanal',
                        horas_semanales: 8,
                        detalle: [{ dia: 'Sábado', horas: 8 }]
                    },
                    estado_revision_dgdp_inicial: 'aprobado',
                    estado_revision_financiera_inicial: 'pendiente',
                    validacion_financiera_previa: null,
                    item_presupuestario_asociado: '30600',
                    categoria_presupuestaria: 'Honorarios no Académicos',
                    saldo_item_actual: 800000,
                    monto_acumulado_item_en_solicitud: 560000,
                    saldo_proyectado_item: 240000,
                    estado_suficiencia_item: 'suficiente',
                    explicacion_validacion_item: 'El ítem posee saldo disponible en la cuenta presupuestaria para solventar el honorario administrativo.',
                    prestaciones_solicitadas: {
                        descripcion: 'Apoyo administrativo en recopilación de actas y foliación física/digital',
                        meses: 2,
                        total: 560000
                    },
                    resumen_financiero_actual: { mensual: 280000, total: 560000 },
                    resumen_validaciones_previas: 'Aprobación con compensación horaria visada en Etapa 04 el 15/05/2026.',
                    revision_finanzas: { estado: 'pendiente', motivo: '', comentario: '', fecha: '', actor: '' },
                    historial_prestaciones: [
                        { codigo: 'PDS-2025-090', cc: '4050.21', periodo: 'Abril - Junio 2025', rol: 'Apoyo Administrativo', monto: 840000, estado: 'Pagado' }
                    ],
                    historial_pagos: [
                        { mes: 'Mayo 2026', monto: 280000, estado: 'Procesado' }
                    ],
                    restricciones_administrativas: {
                        licencias_vigentes: false,
                        permisos_sin_goce: false,
                        observaciones: 'Jornada extraordinaria autorizada. Compensación horaria visada en Etapa 04.'
                    },
                    parentescos_incompatibilidades: {
                        tiene_parentesco: false,
                        detalle: 'Sin parentescos con autoridades de la Facultad.'
                    }
                },
                {
                    id_ui: 'perez',
                    rut: '16.123.456-7',
                    nombre: 'PEREZ SOTO MARIA JOSE',
                    estamento: 'Académico',
                    jerarquia: 'Asistente',
                    actividad: 'Asesoría experta en diseño experimental y modelación estadística de datos de agroindustria.',
                    modalidad: 'Dentro de Jornada',
                    is_sea_vigente: true,
                    contrato_seleccionado: 'Contrato Plazo Fijo — Académico',
                    meses: 2,
                    meses_detalle: 'Junio, Julio 2026',
                    total_pds: 1200000,
                    cuotas_mensuales: [
                        { mes: 'Junio 2026', monto_bruto: 600000 },
                        { mes: 'Julio 2026', monto_bruto: 600000 }
                    ],
                    compensacion_detalle: null,
                    estado: 'excluido',
                    estado_revision_dgdp_inicial: 'excluido',
                    excluido_por_dgdp: true,
                    fecha_exclusion: '15/05/2026 10:45',
                    etapa_exclusion: 'Auditoría DGDP (Fase 4)',
                    motivo_resumido: 'Licencia Médica Activa detectada al cruce de antecedentes institucionales',
                    comentario: 'Durante la revisión de antecedentes institucionales se detectó licencia médica vigente para el período solicitado (Junio 2026). Según el artículo 14 del DU 288, no corresponde visación de honorarios.',
                    causal: 'Incompatibilidad por reposo médico vigente (Art 14 DU 288)',
                    monto_excluido: 1200000,
                    item_presupuestario_asociado: '30300',
                    saldo_item_actual: 3580000,
                    estado_suficiencia_item: 'suficiente',
                    resumen_validacion_dgdp: 'EXCLUIDO POR DGDP - No cumple requisitos médicos de actividad activa.',
                    estado_revision_financiera_inicial: 'excluido',
                    historial_prestaciones: [
                        { codigo: 'PDS-2025-115', cc: '8120.44', periodo: 'Julio - Nov 2025', rol: 'Investigador Asistente', monto: 3000000, estado: 'Pagado' }
                    ],
                    historial_pagos: [
                        { mes: 'Mayo 2026', monto: 600000, estado: 'Procesado' }
                    ],
                    restricciones_administrativas: {
                        licencias_vigentes: true,
                        permisos_sin_goce: false,
                        observaciones: 'Licencia médica vigente desde 01/06/2026 hasta 15/06/2026 (antecedentes institucionales).'
                    },
                    parentescos_incompatibilidades: {
                        tiene_parentesco: false,
                        detalle: 'Declaración jurada de incompatibilidades al día.'
                    }
                }
            ]
        }
    ]
};
