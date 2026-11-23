part 'ylr_extra_lessons.dart';

enum RouteKind { personal, tens, universitario }

extension RouteLabel on RouteKind {
  String get label => switch (this) {
        RouteKind.personal => 'Personal',
        RouteKind.tens => 'TENS',
        RouteKind.universitario => 'Universitario',
      };
  String get description => switch (this) {
        RouteKind.personal =>
          'Cuida de ti y de tu familia con información comprensible.',
        RouteKind.tens => 'Refuerza fundamentos, seguridad y práctica técnica.',
        RouteKind.universitario =>
          'Profundiza en valoración y fundamentos del cuidado.',
      };
}

class Lesson {
  const Lesson(this.id, this.title, this.category, this.basic, this.tens,
      this.uni, this.objective);
  final String id, title, category, basic, tens, uni, objective;
  String forRoute(RouteKind route) => switch (route) {
        RouteKind.personal => basic,
        RouteKind.tens => tens,
        RouteKind.universitario => uni,
      };
}

// Primer lote de contenidos educativos BETA: debe revisarlo un docente clínico.
const lessons = <Lesson>[
  Lesson(
      'LES-01',
      'Higiene de manos',
      'Bioseguridad',
      'La higiene de manos reduce el riesgo de transmitir microorganismos.',
      'La higiene de manos es una medida esencial de prevención. Se realiza en los momentos indicados y según el procedimiento correspondiente.',
      'La higiene de manos forma parte de la prevención y control de infecciones; la técnica y los momentos se adecuan al contexto asistencial.',
      'Reconocer el propósito y los momentos de la higiene de manos.'),
  Lesson(
      'LES-02',
      'Signos vitales: presión arterial',
      'Signos vitales',
      'La presión arterial expresa la fuerza de la sangre sobre las arterias y suele escribirse como dos valores.',
      'La presión arterial tiene un componente sistólico y otro diastólico. Una medición fiable requiere reposo, manguito adecuado y técnica correcta.',
      'La interpretación de la presión arterial exige considerar técnica, tendencia de mediciones, síntomas, antecedentes y contexto clínico.',
      'Distinguir presión sistólica, diastólica y precauciones de medición.'),
  Lesson(
      'LES-03',
      'Identificación segura',
      'Seguridad',
      'Confirmar la identidad de la persona ayuda a prevenir errores de atención.',
      'Antes de una intervención, la identificación se valida con los identificadores y protocolos definidos por el centro.',
      'La verificación de identidad y trazabilidad se integra a los procesos de seguridad del paciente.',
      'Comprender por qué la identificación no debe basarse solo en la habitación.'),
  Lesson(
      'LES-04',
      'Sistema respiratorio',
      'Anatomía',
      'Los pulmones participan en el intercambio de oxígeno y dióxido de carbono.',
      'La evaluación respiratoria básica observa frecuencia, esfuerzo respiratorio y signos de dificultad conforme al ámbito de competencia.',
      'La valoración respiratoria reúne hallazgos clínicos y fisiológicos relevantes para la toma de decisiones supervisadas.',
      'Reconocer estructuras básicas y señales de dificultad respiratoria.'),
  Lesson(
      'LES-05',
      'Frecuencia cardíaca',
      'Signos vitales',
      'El pulso se relaciona con los latidos del corazón.',
      'La frecuencia cardíaca debe observarse junto con ritmo, síntomas y situación de la persona.',
      'La frecuencia y ritmo cardíacos requieren interpretación contextual y correlación con el estado hemodinámico.',
      'Comprender qué representa la frecuencia cardíaca.'),
  Lesson(
      'LES-06',
      'Temperatura corporal',
      'Signos vitales',
      'La temperatura varía según la persona, el momento y el método de medición.',
      'El registro de temperatura debe documentar el método y factores que puedan influir en el resultado.',
      'La evaluación térmica integra la técnica de medición y los signos clínicos asociados.',
      'Reconocer factores que influyen en la medición de temperatura.'),
  Lesson(
      'LES-07',
      'Precauciones estándar',
      'Bioseguridad',
      'Las medidas de protección ayudan a reducir los riesgos de infección.',
      'Las precauciones estándar se aplican según el riesgo de exposición y los protocolos del establecimiento.',
      'La selección de barreras y la higiene ambiental se fundamentan en evaluación del riesgo y normativa vigente.',
      'Explicar por qué las precauciones dependen del procedimiento.'),
  Lesson(
      'LES-08',
      'Uso de guantes',
      'Bioseguridad',
      'Los guantes pueden proteger durante ciertas actividades, pero no reemplazan la higiene de manos.',
      'Los guantes se utilizan cuando corresponde al riesgo y se cambian según la tarea; no sustituyen la higiene de manos.',
      'La indicación y retiro seguro de guantes se integran a la prevención de transmisión cruzada.',
      'Distinguir guantes de higiene de manos.'),
  Lesson(
      'LES-09',
      'Comunicación con pacientes',
      'Cuidados',
      'Escuchar con respeto y explicar con claridad favorece la atención.',
      'La comunicación segura exige escucha activa, lenguaje comprensible y confirmación del entendimiento.',
      'La comunicación terapéutica apoya la valoración integral y las decisiones compartidas.',
      'Reconocer elementos de una comunicación respetuosa.'),
  Lesson(
      'LES-10',
      'Movilización segura',
      'Cuidados',
      'Mover a una persona requiere atención a su comodidad y seguridad.',
      'Antes de movilizar, se consideran indicaciones, ayudas disponibles, estado de la persona y ergonomía.',
      'La planificación de movilización valora riesgos de caídas, lesiones y tolerancia al esfuerzo.',
      'Identificar riesgos generales durante la movilización.'),
  Lesson(
      'LES-11',
      'Prevención de caídas',
      'Seguridad',
      'Mantener el entorno despejado ayuda a prevenir caídas.',
      'La prevención de caídas considera riesgos personales, ambientales y acompañamiento indicado.',
      'Las medidas preventivas combinan evaluación multifactorial y planificación del cuidado.',
      'Reconocer factores que aumentan el riesgo de caída.'),
  Lesson(
      'LES-12',
      'Registro de observaciones',
      'Cuidados',
      'Registrar datos claros ayuda a compartir información importante.',
      'Los registros deben ser oportunos, verificables y fieles a lo observado según las normas del establecimiento.',
      'El registro clínico exige trazabilidad, precisión y resguardo de la confidencialidad.',
      'Comprender la importancia de la documentación objetiva.'),
  Lesson(
      'LES-13',
      'Disnea: concepto',
      'Urgencias',
      'La disnea es la sensación de dificultad o incomodidad al respirar.',
      'La disnea requiere observación y comunicación oportuna de los hallazgos conforme al rol y protocolo.',
      'La disnea se interpreta según inicio, intensidad, hallazgos asociados y evaluación clínica.',
      'Identificar el significado del término disnea.'),
  Lesson(
      'LES-14',
      'Seguridad en medicamentos',
      'Seguridad',
      'Los medicamentos deben utilizarse únicamente de acuerdo con indicaciones adecuadas.',
      'La administración requiere verificar prescripción, identidad, medicamento y los protocolos pertinentes; esta lección no enseña dosificaciones.',
      'La seguridad de medicamentos incluye conciliación, verificación, monitoreo y registro dentro de la competencia profesional.',
      'Reconocer principios generales de seguridad en medicamentos.'),
  Lesson(
      'LES-15',
      'Manejo de residuos',
      'Bioseguridad',
      'Separar correctamente residuos protege a las personas y al ambiente.',
      'La segregación de residuos sigue categorías y recipientes definidos por la normativa local.',
      'La gestión de residuos sanitarios combina clasificación de riesgos y trazabilidad institucional.',
      'Reconocer la importancia de separar residuos.'),
  Lesson(
      'LES-16',
      'Ética y confidencialidad',
      'Ética',
      'La información de salud de una persona merece protección y respeto.',
      'La confidencialidad exige compartir información solo con quienes están autorizados y la necesitan.',
      'La gestión ética de datos considera consentimiento, minimización y normativa aplicable.',
      'Valorar la privacidad y el trato digno.'),
  Lesson(
      'LES-17',
      'Primer contacto en urgencias',
      'Urgencias',
      'Ante una emergencia hay que buscar ayuda adecuada y seguir indicaciones de profesionales y servicios de urgencia.',
      'Ante un compromiso vital se prioriza activar ayuda e iniciar valoración dentro del rol y protocolos; no deben retrasarse medidas urgentes por trámites.',
      'La respuesta inicial integra seguridad de la escena, activación de recursos y valoración ABCDE por personal entrenado.',
      'Comprender por qué solicitar apoyo es prioritario en urgencias.'),
  Lesson(
      'LES-18',
      'Trabajo en equipo',
      'Ética',
      'El trabajo coordinado mejora la comunicación y la seguridad.',
      'Los traspasos de información claros y la definición de responsabilidades favorecen la continuidad del cuidado.',
      'La colaboración interprofesional integra comunicación estructurada, roles y evaluación de resultados.',
      'Identificar el valor de comunicar y coordinar.'),
  ...ylrExtraLessons,
];

const glossary = <String, String>{
  "Alergia medicamentosa":
      "Respuesta inmunitaria adversa a un fármaco; debe verificarse y comunicarse antes de su uso.",
  "Anamnesis":
      "Recopilación estructurada de antecedentes aportados por la persona y fuentes autorizadas.",
  "Autonomía":
      "Derecho y capacidad de participar en decisiones sobre la propia atención según contexto.",
  "Balance hídrico":
      "Comparación documentada de entradas y salidas de líquidos en un periodo definido.",
  "Conciliación de medicamentos":
      "Proceso de comparar y verificar tratamientos durante transiciones de atención.",
  "Confusión aguda":
      "Cambio reciente en atención, orientación o conducta que amerita valoración clínica.",
  "Consentimiento informado":
      "Proceso de recibir información comprensible y decidir libremente según normas aplicables.",
  "Delirium":
      "Síndrome de inicio agudo y curso fluctuante que altera atención y cognición.",
  "Desinfección":
      "Proceso para reducir microorganismos en objetos o superficies según nivel requerido.",
  "Desnutrición":
      "Estado de déficit nutricional que puede afectar funciones y recuperación.",
  "Disfagia":
      "Dificultad para tragar, que puede aumentar el riesgo de aspiración.",
  "Diuresis": "Volumen de orina producido en un intervalo determinado.",
  "Equilibrio electrolítico":
      "Regulación de concentraciones de minerales necesarios para funciones corporales.",
  "Esterilización":
      "Proceso validado destinado a eliminar todas las formas de vida microbiana, incluidas esporas.",
  "Evento adverso":
      "Daño no intencionado asociado a la atención, que requiere análisis y prevención.",
  "Glucemia":
      "Concentración de glucosa en sangre, interpretada según método y contexto.",
  "Hiperglucemia":
      "Glucosa sanguínea elevada respecto de valores de referencia y contexto clínico.",
  "Hipoglucemia":
      "Concentración baja de glucosa capaz de producir síntomas y deterioro.",
  "Lesión por presión":
      "Daño localizado de piel o tejidos causado por presión y a veces fuerzas de cizalla.",
  "Polifarmacia":
      "Uso simultáneo de múltiples medicamentos, cuyo riesgo debe evaluarse individualmente.",
  "Perfusión":
      "Paso de sangre a través de los tejidos para aportar oxígeno y nutrientes.",
  "Precauciones estándar":
      "Prácticas de prevención de infección aplicables a todas las personas atendidas según riesgo.",
  "Reevaluación":
      "Nueva revisión de una condición o respuesta tras un cambio o intervención.",
  "Riesgo de caída":
      "Probabilidad de sufrir una caída influida por factores personales y ambientales.",
  "Triage":
      "Proceso organizado de priorización de atención según urgencia, realizado por personal capacitado.",
  "Valores críticos":
      "Resultados que, conforme a protocolos validados, pueden exigir comunicación urgente.",
  "Vigilancia clínica":
      "Observación y seguimiento sistemáticos de cambios relevantes en el estado de la persona.",
  'Asepsia':
      'Medidas destinadas a evitar la contaminación por microorganismos.',
  'Bioseguridad':
      'Conjunto de medidas para prevenir o reducir riesgos biológicos.',
  'Bradicardia':
      'Frecuencia cardíaca más baja de la esperada para el contexto.',
  'Cianosis':
      'Coloración azulada de piel o mucosas que necesita valoración clínica.',
  'Diástole': 'Fase de relajación del corazón entre contracciones.',
  'Disnea': 'Sensación subjetiva de dificultad o incomodidad al respirar.',
  'Edema': 'Acumulación anormal de líquido en los tejidos.',
  'Eritema': 'Enrojecimiento de la piel.',
  'Frecuencia cardíaca': 'Número de latidos del corazón en un minuto.',
  'Frecuencia respiratoria':
      'Número de ciclos respiratorios realizados en un minuto.',
  'Hemodinámica':
      'Estudio de la circulación y de las fuerzas del flujo sanguíneo.',
  'Hipertensión':
      'Elevación persistente de la presión arterial según criterios de evaluación clínica.',
  'Hipotensión':
      'Presión arterial baja respecto al contexto y evaluación de la persona.',
  'Infección': 'Invasión y multiplicación de microorganismos en un organismo.',
  'Isquemia': 'Reducción del aporte sanguíneo a un tejido.',
  'Oxigenación':
      'Proceso por el cual el organismo recibe y distribuye oxígeno.',
  'Presión arterial':
      'Fuerza de la sangre sobre las arterias, descrita por presión sistólica y diastólica.',
  'Pulso':
      'Manifestación palpable de la onda de presión causada por cada latido.',
  'Saturación de oxígeno':
      'Estimación del porcentaje de hemoglobina que transporta oxígeno.',
  'Sepsis':
      'Disfunción orgánica potencialmente mortal debida a una respuesta desregulada a infección.',
  'Sístole': 'Fase en que el corazón se contrae y expulsa sangre.',
  'Taquicardia':
      'Frecuencia cardíaca más alta de la esperada para el contexto.',
  'Taquipnea':
      'Frecuencia respiratoria más alta de la esperada para el contexto.',
  'Trazabilidad':
      'Capacidad de seguir y documentar acciones, procesos y registros.',
  'Valoración':
      'Proceso sistemático de recopilación e interpretación de información.',
};

const topicCategories = <String>[
  'Todos',
  'Anatomía',
  'Signos vitales',
  'Bioseguridad',
  'Urgencias',
  'Seguridad',
  'Cuidados',
  'Ética'
];

class QuizQuestion {
  const QuizQuestion(
      this.text, this.options, this.correctIndex, this.explanation);
  final String text, explanation;
  final List<String> options;
  final int correctIndex;
}

const quizQuestions = <QuizQuestion>[
  QuizQuestion(
      '¿Qué medida es esencial para reducir la transmisión de microorganismos?',
      [
        'Usar guantes en todo momento',
        'Higiene de manos en los momentos indicados',
        'Limpiar solo al finalizar la jornada',
        'Evitar explicar los procedimientos'
      ],
      1,
      'La higiene de manos en los momentos indicados es esencial; los guantes no la reemplazan.'),
  QuizQuestion(
      '¿Qué afirmación sobre los guantes es correcta?',
      [
        'Sustituyen la higiene de manos',
        'Se reutilizan entre pacientes',
        'Se usan según el riesgo de exposición',
        'Son necesarios para cualquier conversación'
      ],
      2,
      'El uso de guantes se basa en el riesgo y siempre debe acompañarse de higiene de manos cuando corresponde.'),
  QuizQuestion(
      '¿Cómo debe identificarse a un paciente antes de un procedimiento?',
      [
        'Solo con su cama',
        'Por la ropa',
        'Con los identificadores y protocolos establecidos',
        'Con el diagnóstico presunto'
      ],
      2,
      'La identidad debe verificarse mediante identificadores y procedimientos institucionales seguros.'),
  QuizQuestion(
      '¿Qué representan los dos valores de presión arterial?',
      [
        'Temperatura y pulso',
        'Presiones sistólica y diastólica',
        'Peso y estatura',
        'Frecuencia respiratoria y pulso'
      ],
      1,
      'La presión arterial suele expresarse mediante sus componentes sistólico y diastólico.'),
  QuizQuestion(
      '¿Qué debe hacerse ante una urgencia potencialmente vital en un entorno asistencial?',
      [
        'Esperar a completar el papeleo',
        'Solicitar apoyo y seguir el protocolo de respuesta',
        'Buscar primero las pertenencias',
        'Ignorar la falta de identificación'
      ],
      1,
      'Las actuaciones urgentes no deben demorarse por trámites; corresponde activar apoyo y seguir los protocolos.'),
];
