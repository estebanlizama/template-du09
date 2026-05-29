const DB_MOCK = {
    funcionarios: [
        {
            rut: '19.477.728-0',
            rut_limpio: '194777280',
            nombre: 'LIZAMA AILLAPAN ESTEBAN NICOLAS',
            tiene_deudas: true,
            es_pariente: false,
            asignaciones_rol: [
                { rol: 'Director de Departamento', unidad: 'Dpto. de Ingeniería', desde: '01/01/2023', hasta: '31/12/2026', item: '30000', itemDesc: 'Directivo', bloquea: true }
            ],
            contratos: [
                { tipo: 'Contrato Indefinido — Académico', estamento: 'Académico', jerarquia: 'Titular', grado: '8', jornada: '44 Hrs', antiguedad: '12 años 3 meses', bruto: 3240000, liquido: 2650000, itemDirectivo: 'DIR. ACADÉMICO 11' },
                { tipo: 'Contrato Plazo Fijo — Investigativo', estamento: 'Académico', jerarquia: 'Investigador', grado: '10', jornada: '11 Hrs', antiguedad: '5 años 1 mes', bruto: 1200000, liquido: 980000, itemDirectivo: 'ACADÉMICO' },
                { tipo: 'Contrato Honorarios', estamento: 'Profesional', jerarquia: 'Asesor Externo', grado: '15', jornada: 'A Suma Alzada', antiguedad: '1 año', bruto: 600000, liquido: 540000, itemDirectivo: 'NO ACADÉMICO' }
            ],
            deudas: [
                { tipo: 'Rendición Pendiente', monto: 120000, descripcion: 'Falta rendir viático de pasajes a Santiago del 12/03/2026', dias_mora: 45 },
                { tipo: 'Biblioteca', monto: 15000, descripcion: 'Multa por devolución tardía de libro "Software Engineering"', dias_mora: 10 }
            ],
            inhabilidades: [
                { tipo: 'Sumario Administrativo', descripcion: 'Sumario administrativo en curso, Fiscalía N° 2026-114', fecha_registro: '2026-02-10' }
            ],
            sea_vigente: false,
            compensacion: null
        },
        {
            rut: '15.654.321-0',
            rut_limpio: '156543210',
            nombre: 'FUENTES MEZA CARLOS HERNAN',
            tiene_deudas: false,
            es_pariente: false,
            asignaciones_rol: [],
            contratos: [
                { tipo: 'Contrato Indefinido — Administrativo', estamento: 'Administrativo', jerarquia: 'Técnico Universitario', grado: '12', jornada: '44 Hrs', antiguedad: '5 años', bruto: 850000, liquido: 688500, itemDirectivo: 'NO ACADÉMICO' }
            ],
            deudas: [],
            inhabilidades: [],
            sea_vigente: false,
            compensacion: {
                tipo: 'Compensación Horaria Semanal',
                horas_semanales: 4,
                detalle: [
                    { dia: 'Lunes', horas: 2 },
                    { dia: 'Miércoles', horas: 2 }
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
                { tipo: 'Contrato Plazo Fijo — Académico', estamento: 'Académico', jerarquia: 'Asistente', grado: '10', jornada: '22 Hrs', antiguedad: '3 años', bruto: 1450000, liquido: 1150000, itemDirectivo: 'ACADÉMICO' }
            ],
            deudas: [],
            inhabilidades: [],
            sea_vigente: true,
            compensacion: null
        }
    ],
    tabla_deudas: [
        { rut: '19.477.728-0', tipo: 'Rendición Pendiente', monto: 120000, descripcion: 'Falta rendir viático de pasajes a Santiago del 12/03/2026', dias_mora: 45 },
        { rut: '19.477.728-0', tipo: 'Biblioteca', monto: 15000, descripcion: 'Multa por devolución tardía de libro "Software Engineering"', dias_mora: 10 }
    ],
    tabla_inhabilidades: [
        { rut: '19.477.728-0', tipo: 'Sumario Administrativo', descripcion: 'Sumario administrativo en curso, Fiscalía N° 2026-114', fecha_registro: '2026-02-10' }
    ],
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
            items_presupuestarios: [
                { cod: '30000', desc: 'Directivos', asignado: 1600000, ejecutado: 0 },
                { cod: '30300', desc: 'Académicos', asignado: 1600000, ejecutado: 420000 },
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
            items_presupuestarios: [
                { cod: '30300', desc: 'Académicos', asignado: 2500000, ejecutado: 100000 },
                { cod: '30600', desc: 'No Académicos', asignado: 1000000, ejecutado: 950000 }
            ]
        }
    ],
    prestaciones_de_servicio: [
        {
            id_solicitud: 'PDS-2026-0001',
            estado: 'En Revisión (Jefe Proyecto)',
            fecha_creacion: '2026-05-05T10:00:00',
            centro_costo: {
                codigo: '4050.21',
                nombre: 'INSTITUTO DE AGROINDUSTRIA'
            },
            jefe_proyecto: {
                rut: '12.345.678-9',
                nombre: 'DR. MARIO GODOY RIVERA'
            },
            detalles: {
                unidad_ejecutora: 'FACULTAD DE INGENIERÍA',
                tipo_financiamiento: '21 - Fondos Propios',
                decreto_afecto: '0 - DU 288',
                descripcion: 'Modernización de procesos para el Instituto de Agroindustria mediante la implementación de nuevos flujos de trabajo en entorno D9/2026, asegurando la trazabilidad y el cumplimiento normativo de las prestaciones de servicio.',
                fecha_inicio: '2026-06-01',
                fecha_fin: '2026-07-31',
                evidencias_requeridas: ['Informe Técnico Mensual', 'Acta de Conformidad']
            },
            funcionarios: [
                {
                    rut: '19.477.728-0',
                    nombre: 'LIZAMA AILLAPAN ESTEBAN NICOLAS',
                    estamento: 'Académico',
                    jerarquia: 'Titular',
                    actividad: 'Diseño de arquitectura de microservicios y validación de reglas de negocio para el proyecto D9.',
                    modalidad: 'Fuera de Jornada',
                    is_sea_vigente: false,
                    contrato_seleccionado: 'Contrato Indefinido — Académico',
                    meses: 2,
                    meses_detalle: 'Junio, Julio 2026',
                    total_pds: 900000
                },
                {
                    rut: '15.654.321-0',
                    nombre: 'FUENTES MEZA CARLOS HERNAN',
                    estamento: 'Administrativo',
                    jerarquia: 'Técnico Universitario',
                    actividad: 'Apoyo administrativo en levantamiento de procesos y gestión de documentación técnica.',
                    modalidad: 'Fuera de Jornada',
                    is_sea_vigente: false,
                    contrato_seleccionado: 'Contrato Indefinido — Administrativo',
                    meses: 1,
                    meses_detalle: 'Junio 2026',
                    total_pds: 350000
                },
                {
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
                    total_pds: 1200000
                }
            ]
        }
    ]
};
