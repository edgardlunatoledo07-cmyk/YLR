import 'content.dart';
part 'ylr_extra_details.dart';

/// Material didáctico complementario, no protocolo clínico.
/// Fuentes orientadoras: OMS, CDC y MedlinePlus. Adaptación editorial
/// de Y.LR pendiente de revisión docente local.
class YlrLessonDetail {
  const YlrLessonDetail({
    required this.summary,
    required this.points,
    required this.caseQuestion,
    required this.caseAnswer,
    required this.safety,
    required this.personalFocus,
    required this.tensFocus,
    required this.universityFocus,
    required this.sourceTitle,
    required this.sourceUrl,
  });
  final String summary;
  final List<String> points;
  final String caseQuestion;
  final String caseAnswer;
  final String safety;
  final String personalFocus, tensFocus, universityFocus;
  final String sourceTitle, sourceUrl;
  String focusFor(RouteKind route) => switch (route) {
        RouteKind.personal => personalFocus,
        RouteKind.tens => tensFocus,
        RouteKind.universitario => universityFocus,
      };
}

const ylrLessonDetails = <String, YlrLessonDetail>{
  "LES-01": YlrLessonDetail(
    summary:
        "La transmisión cruzada puede ocurrir mediante las manos durante actividades asistenciales. La higiene se realiza según el momento y la técnica indicada; los guantes no sustituyen la limpieza de manos.",
    caseQuestion:
        "Tras ajustar una mesa junto a la cama y antes de ayudar a una persona, ¿qué debes revisar?",
    caseAnswer:
        "Reconocer el contacto con el entorno y efectuar higiene de manos cuando corresponda antes de la siguiente interacción.",
    safety:
        "No uses guantes como sustituto de higiene de manos. La técnica exacta debe practicarse bajo supervisión.",
    personalFocus:
        "Personal: reconoce situaciones cotidianas y los momentos en que conviene limpiar las manos.",
    tensFocus:
        "TENS: distingue el momento de higiene antes y después de las actividades asignadas.",
    universityFocus:
        "Universitario: analiza oportunidades de prevención y vigilancia de cumplimiento.",
    sourceTitle: "OMS · Los cinco momentos de higiene de manos",
    sourceUrl:
        "https://www.who.int/publications/m/item/five-moments-for-hand-hygiene",
    points: <String>[
      "La OMS propone cinco momentos: antes del contacto, antes de una tarea aséptica, después del riesgo de fluidos, después del contacto y después del entorno del paciente.",
      "Identifica la indicación antes de elegir agua y jabón o preparado de base alcohólica, según protocolos y estado de las manos.",
      "La higiene de manos protege tanto a pacientes como a trabajadores.",
    ],
  ),
  "LES-02": YlrLessonDetail(
    summary:
        "La presión arterial se expresa en dos cifras, sistólica y diastólica. La interpretación depende del contexto clínico, la técnica y las condiciones de medición.",
    caseQuestion:
        "Una persona tiene una lectura distinta a su valor habitual después de subir escaleras. ¿Se interpreta sin más?",
    caseAnswer:
        "No: considera actividad previa, reposo, procedimiento y necesidad de repetir la medición o comunicar el hallazgo.",
    safety:
        "Ante dolor torácico, falta de aire o deterioro evidente busca valoración urgente; no esperes a completar un registro.",
    personalFocus:
        "Personal: comprende que ambos valores no son equivalentes y evita autodiagnosticarse con una cifra.",
    tensFocus:
        "TENS: reconoce errores frecuentes de técnica y cuándo comunicar hallazgos.",
    universityFocus:
        "Universitario: analiza tendencias, síntomas asociados y limitaciones de la medición.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
    points: <String>[
      "Verifica que la persona se encuentre en condiciones apropiadas para la medición.",
      "Registra cifras junto con método, brazo y contexto cuando el protocolo lo indique.",
      "Una medida aislada no equivale a un diagnóstico; importa la tendencia y la sintomatología.",
    ],
  ),
  "LES-03": YlrLessonDetail(
    summary:
        "La identificación correcta disminuye el riesgo de intervenir a la persona equivocada. No debe basarse en número de cama, aspecto o diagnóstico.",
    caseQuestion:
        "Dos personas comparten apellido en una sala y hay una muestra por rotular. ¿Qué es lo prioritario?",
    caseAnswer:
        "Usar el procedimiento institucional de verificación de identidad y rotulación en el momento adecuado.",
    safety:
        "Ante discrepancias entre identificación y órdenes, detén la acción no urgente y escala al responsable.",
    personalFocus:
        "Personal: pregunta cómo el equipo verifica correctamente tu identidad.",
    tensFocus:
        "TENS: aplica verificación previa y comunica discrepancias sin improvisar.",
    universityFocus:
        "Universitario: reconoce fallas de proceso y barreras de seguridad verificables.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Aplica al menos los identificadores definidos por el establecimiento.",
      "Verifica identidad antes de procedimientos, administración de medicamentos y obtención de muestras, según protocolo.",
      "En personas que no pueden responder se utilizan mecanismos institucionales alternativos.",
    ],
  ),
  "LES-04": YlrLessonDetail(
    summary:
        "La respiración moviliza aire y facilita el intercambio de gases en los pulmones. Observar la respiración incluye más que contar ciclos.",
    caseQuestion:
        "Una persona refiere que le cuesta respirar y habla en frases cortas. ¿Qué harías?",
    caseAnswer:
        "Reconocer una señal de alarma y solicitar ayuda o valoración clínica de inmediato según el contexto.",
    safety:
        "No utilices la lección para indicar oxígeno, fármacos o maniobras sin competencia y protocolo.",
    personalFocus:
        "Personal: reconoce dificultad respiratoria como motivo para buscar ayuda.",
    tensFocus:
        "TENS: comunica observaciones objetivas y cambios respecto del estado previo.",
    universityFocus:
        "Universitario: relaciona ventilación, intercambio gaseoso y signos de trabajo respiratorio.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
    points: <String>[
      "Identifica vías respiratorias, pulmones y diafragma en el proceso respiratorio.",
      "Observa frecuencia, esfuerzo y capacidad para hablar según la situación.",
      "La presencia de dificultad respiratoria puede requerir valoración inmediata.",
    ],
  ),
  "LES-05": YlrLessonDetail(
    summary:
        "La frecuencia cardíaca representa latidos por minuto. Su significado depende de actividad, edad, medicamentos, síntomas y ritmo.",
    caseQuestion:
        "Tras ejercicio se registra un pulso más rápido. ¿Es igual que en reposo?",
    caseAnswer:
        "No: la actividad puede influir; importa considerar síntomas, reposo y tendencias.",
    safety:
        "No concluyas arritmias ni aconsejes medicación a partir de una palpación aislada.",
    personalFocus:
        "Personal: reconoce que el pulso puede variar en distintas situaciones.",
    tensFocus:
        "TENS: aprende a documentar frecuencia, regularidad y síntomas asociados.",
    universityFocus:
        "Universitario: relaciona frecuencia, perfusión y repercusión clínica.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
    points: <String>[
      "Diferencia frecuencia de regularidad del pulso.",
      "Compara un hallazgo con el contexto clínico y registros anteriores.",
      "Palpitaciones con síncope, dolor torácico o dificultad respiratoria requieren atención urgente.",
    ],
  ),
  "LES-06": YlrLessonDetail(
    summary:
        "La temperatura corporal fluctúa y sus resultados dependen del método y del sitio de medición. La fiebre es un hallazgo que debe interpretarse con otros signos.",
    caseQuestion:
        "Dos termómetros usados en sitios diferentes entregan valores distintos. ¿Cuál es la conclusión?",
    caseAnswer:
        "Revisa los métodos utilizados y comunica los hallazgos con contexto, sin asumir que uno determina un diagnóstico.",
    safety:
        "Si existe compromiso del estado general o deterioro agudo, busca valoración profesional.",
    personalFocus:
        "Personal: comprende por qué una medición aislada no explica toda una enfermedad.",
    tensFocus: "TENS: observa y registra método, cifras y signos acompañantes.",
    universityFocus:
        "Universitario: discute patrones térmicos y sesgos de medición.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
    points: <String>[
      "Registra el valor junto con el método de medición cuando corresponda.",
      "Considera actividad, ambiente y condiciones que modifican la lectura.",
      "No evalúes solo el número; observa el estado general.",
    ],
  ),
  "LES-07": YlrLessonDetail(
    summary:
        "Las precauciones estándar son medidas de prevención aplicables en la atención de todas las personas, adaptadas al riesgo de exposición.",
    caseQuestion:
        "Una persona sin diagnóstico de infección necesita una curación. ¿Pueden omitirse las precauciones?",
    caseAnswer:
        "No. Se aplican según el procedimiento y el riesgo de exposición, con los elementos indicados.",
    safety:
        "El equipo de protección no reemplaza la técnica, la higiene ni la capacitación.",
    personalFocus:
        "Personal: identifica por qué las barreras dependen del procedimiento.",
    tensFocus:
        "TENS: selecciona barreras de acuerdo con protocolos y riesgos del puesto.",
    universityFocus:
        "Universitario: evalúa medidas estándar y precauciones adicionales según transmisión.",
    sourceTitle: "CDC · Precauciones estándar",
    sourceUrl: "https://www.cdc.gov/infection-control/hcp/basics/",
    points: <String>[
      "Incluyen higiene de manos, protección personal según exposición, higiene respiratoria y manejo seguro de equipos.",
      "No se aplican únicamente a personas con infección conocida.",
      "Evalúa el riesgo antes de entrar en contacto con sangre, fluidos o materiales contaminados.",
    ],
  ),
  "LES-08": YlrLessonDetail(
    summary:
        "Los guantes son una barrera de protección para tareas con riesgo específico. Su uso no evita por sí solo la contaminación cruzada.",
    caseQuestion:
        "Tras tocar material contaminado, una persona sigue usando los mismos guantes para manipular objetos limpios. ¿Qué falla?",
    caseAnswer:
        "La continuidad del mismo par puede transportar contaminación; debe aplicarse el cambio y la higiene según protocolo.",
    safety: "No uses guantes dañados, ni los reutilices si son de un solo uso.",
    personalFocus: "Personal: los guantes no significan protección absoluta.",
    tensFocus:
        "TENS: reconoce indicaciones, recambio y retiro seguro con supervisión.",
    universityFocus:
        "Universitario: analiza rutas de contaminación y selección racional de barreras.",
    sourceTitle: "CDC · Precauciones estándar",
    sourceUrl: "https://www.cdc.gov/infection-control/hcp/basics/",
    points: <String>[
      "Se utilizan cuando se prevé contacto con material potencialmente infeccioso según protocolo.",
      "Deben cambiarse entre tareas y pacientes cuando corresponda.",
      "La higiene de manos sigue siendo necesaria en los momentos indicados.",
    ],
  ),
  "LES-09": YlrLessonDetail(
    summary:
        "Una comunicación clara permite comprender necesidades, acordar cuidados y reducir malentendidos. La escucha activa y el respeto son fundamentales.",
    caseQuestion:
        "Una persona asiente al escuchar una explicación, pero parece confundida. ¿Cómo puedes comprobar comprensión?",
    caseAnswer:
        "Invítala respetuosamente a explicar con sus palabras qué entendió, sin culparla.",
    safety:
        "No prometas resultados ni ocultes dudas que deban aclarar profesionales responsables.",
    personalFocus: "Personal: pregunta cuando una indicación no esté clara.",
    tensFocus:
        "TENS: comunica observaciones y solicita supervisión ante dudas.",
    universityFocus:
        "Universitario: incorpora comunicación terapéutica y decisiones compartidas.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Preséntate e informa el propósito de cada interacción de forma comprensible.",
      "Usa preguntas abiertas y confirma que el mensaje fue entendido.",
      "Evita discutir datos privados frente a terceros sin autorización.",
    ],
  ),
  "LES-10": YlrLessonDetail(
    summary:
        "La movilización debe planificarse de acuerdo con estado, indicaciones, comodidad y riesgo de lesiones tanto para la persona como para el equipo.",
    caseQuestion:
        "Una persona está mareada al intentar ponerse de pie. ¿Debes apurar el traslado?",
    caseAnswer:
        "No. Evita una movilización insegura y solicita evaluación o apoyo según el contexto.",
    safety:
        "Esta ficha no enseña maniobras de transferencia; deben entrenarse presencialmente.",
    personalFocus:
        "Personal: evita improvisar traslados de personas dependientes.",
    tensFocus:
        "TENS: comprueba seguridad del entorno y recursos antes de colaborar.",
    universityFocus:
        "Universitario: razona sobre riesgos, plan de cuidados y tolerancia a la actividad.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Evalúa la necesidad de apoyo y ayudas técnicas antes de comenzar.",
      "Considera mareos, dolor, dispositivos y riesgo de caída.",
      "Solicita asistencia cuando el traslado supere las capacidades disponibles.",
    ],
  ),
  "LES-11": YlrLessonDetail(
    summary:
        "La prevención de caídas requiere considerar factores personales y ambientales, no solo mantener el piso despejado.",
    caseQuestion:
        "Una persona con dificultad para caminar quiere levantarse sola por la noche. ¿Qué riesgo identificas?",
    caseAnswer:
        "Mayor probabilidad de caída; favorece asistencia y adapta el entorno según el plan y protocolo.",
    safety:
        "Las medidas restrictivas nunca deben improvisarse como sustituto de supervisión o evaluación.",
    personalFocus: "Personal: identifica obstáculos frecuentes del entorno.",
    tensFocus: "TENS: observa factores de riesgo y comunica cambios.",
    universityFocus:
        "Universitario: relaciona valoración multifactorial y diseño de intervenciones.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Revisa riesgos como alteraciones de movilidad, somnolencia o antecedentes de caídas.",
      "Favorece iluminación, calzado seguro y acceso a apoyos según protocolo.",
      "Las medidas deben individualizarse y reevaluarse ante cambios clínicos.",
    ],
  ),
  "LES-12": YlrLessonDetail(
    summary:
        "El registro asistencial comunica información para la continuidad del cuidado. Debe describir hechos observados y acciones verificables.",
    caseQuestion:
        "Se observa una persona inquieta. ¿Es apropiado registrar simplemente “paciente difícil”?",
    caseAnswer:
        "No. Es preferible consignar observaciones concretas y conductas verificables, según el sistema del centro.",
    safety:
        "Y.LR no debe almacenar datos de pacientes reales, documentos ni fotografías clínicas identificables.",
    personalFocus: "Personal: comprende por qué el registro debe ser objetivo.",
    tensFocus:
        "TENS: comunica y documenta observaciones dentro de atribuciones.",
    universityFocus:
        "Universitario: analiza calidad, trazabilidad y protección de los registros.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Diferencia hallazgos objetivos de interpretaciones personales.",
      "Registra conforme al momento y procedimiento institucional.",
      "Protege la confidencialidad, exactitud y trazabilidad de los datos.",
    ],
  ),
  "LES-13": YlrLessonDetail(
    summary:
        "Disnea es la sensación de dificultad o incomodidad para respirar. Puede tener diversas causas y requiere considerar el contexto y la gravedad.",
    caseQuestion:
        "Una persona expresa falta de aire que aumenta rápidamente. ¿Es adecuado esperar a terminar una evaluación educativa?",
    caseAnswer: "No. Interrumpe la actividad y busca asistencia inmediata.",
    safety:
        "No realices diagnóstico remoto ni ajustes terapias por esta lección.",
    personalFocus: "Personal: aprende a reconocer síntomas preocupantes.",
    tensFocus: "TENS: comunica hallazgos y cambios con prontitud.",
    universityFocus:
        "Universitario: integra subjetividad de la disnea con signos de gravedad.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
    points: <String>[
      "Observa inicio del síntoma y signos acompañantes sin intentar diagnosticar.",
      "Busca ayuda ante empeoramiento, confusión, dolor torácico o respiración muy dificultosa.",
      "En un servicio de salud se comunica de inmediato según protocolo.",
    ],
  ),
  "LES-14": YlrLessonDetail(
    summary:
        "La seguridad de medicamentos comienza antes de la administración y continúa en el seguimiento y la documentación.",
    caseQuestion:
        "Un envase se parece mucho a otro, pero su rotulado genera dudas. ¿Qué corresponde?",
    caseAnswer:
        "No utilizarlo hasta aclarar la discrepancia por canales institucionales.",
    safety:
        "No se incluyen cálculos de dosificación ni instrucciones de administración invasiva.",
    personalFocus:
        "Personal: informa alergias y consulta dudas sobre tus medicamentos.",
    tensFocus:
        "TENS: respeta límites de competencia y mecanismos de doble verificación.",
    universityFocus:
        "Universitario: identifica riesgos sistémicos y conciliación farmacológica.",
    sourceTitle: "OMS · Medication Without Harm",
    sourceUrl: "https://www.who.int/initiatives/medication-without-harm/",
    points: <String>[
      "Comprueba identidad y orden válida conforme al protocolo.",
      "Reconoce alergias, duplicidades, cambios de indicación y situaciones de alto riesgo.",
      "El rol, la supervisión y los sistemas de verificación importan tanto como la destreza técnica.",
    ],
  ),
  "LES-15": YlrLessonDetail(
    summary:
        "El manejo de residuos sanitarios protege a trabajadores, pacientes y comunidad. La segregación depende del tipo de residuo y normativa vigente.",
    caseQuestion:
        "Encuentras un objeto punzante abandonado fuera de su contenedor. ¿Qué debes hacer?",
    caseAnswer:
        "Aisla el riesgo e informa/actúa únicamente según capacitación y protocolo del establecimiento.",
    safety:
        "La clasificación específica puede cambiar entre instituciones y países; sigue regulación local.",
    personalFocus:
        "Personal: reconoce por qué no se deben manipular objetos punzantes encontrados.",
    tensFocus: "TENS: identifica circuitos y señales de segregación.",
    universityFocus:
        "Universitario: relaciona prevención de exposición, gestión y trazabilidad.",
    sourceTitle: "CDC · Precauciones estándar",
    sourceUrl: "https://www.cdc.gov/infection-control/hcp/basics/",
    points: <String>[
      "Distingue residuos comunes de aquellos con riesgo especial.",
      "Utiliza recipientes identificados y circuitos definidos por el centro.",
      "Nunca manipules elementos punzocortantes innecesariamente.",
    ],
  ),
  "LES-16": YlrLessonDetail(
    summary:
        "La confidencialidad protege la información de salud. Solo debe compartirse con personas autorizadas y para fines legítimos.",
    caseQuestion:
        "Un compañero propone enviar una foto de una ficha real a un grupo de estudio. ¿Qué corresponde?",
    caseAnswer:
        "No difundirla; utilizar material ficticio o anonimizado conforme a normas aplicables.",
    safety: "Nunca ingreses información identificable de pacientes en Y.LR.",
    personalFocus: "Personal: reconoce tu derecho a la privacidad.",
    tensFocus: "TENS: mantiene reserva y utiliza canales autorizados.",
    universityFocus:
        "Universitario: discute consentimiento, minimización y riesgos de filtración.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Respeta privacidad en conversaciones, pantallas y documentos.",
      "Evita fotografías, nombres y antecedentes clínicos en herramientas de aprendizaje.",
      "Comunica incidentes de privacidad mediante canales del centro.",
    ],
  ),
  "LES-17": YlrLessonDetail(
    summary:
        "El primer contacto en urgencias prioriza seguridad, reconocimiento del deterioro y activación de ayuda. La respuesta clínica corresponde al personal capacitado.",
    caseQuestion:
        "Una persona colapsa y no responde. ¿Es correcto terminar primero el registro?",
    caseAnswer:
        "No. Activa la respuesta de urgencias de inmediato según los recursos disponibles.",
    safety:
        "La app no enseña reanimación ni maniobras clínicas de emergencia; requiere formación práctica certificada.",
    personalFocus:
        "Personal: identifica la necesidad de activar ayuda sin demora.",
    tensFocus:
        "TENS: reconoce el rol propio y la importancia de comunicar signos críticos.",
    universityFocus:
        "Universitario: vincula priorización, coordinación y valoración inicial supervisada.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Evalúa la seguridad de la escena antes de intervenir.",
      "Activa recursos de emergencia si hay compromiso vital, conforme al contexto.",
      "La valoración estructurada y las intervenciones específicas exigen entrenamiento.",
    ],
  ),
  "LES-18": YlrLessonDetail(
    summary:
        "El trabajo en equipo mejora la continuidad y reduce fallas de coordinación cuando los roles y las comunicaciones son claros.",
    caseQuestion:
        "Durante un cambio de turno se omite informar una caída reciente. ¿Qué puede ocurrir?",
    caseAnswer:
        "Se pierde un antecedente importante para la seguridad; debe comunicarse oportunamente por canales establecidos.",
    safety:
        "El traspaso de información nunca debe incluir datos de pacientes reales en entornos de prueba.",
    personalFocus:
        "Personal: pregunta quién es responsable de resolver tus dudas.",
    tensFocus: "TENS: comunica cambios oportunamente al equipo.",
    universityFocus:
        "Universitario: analiza barreras organizacionales y continuidad asistencial.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
    points: <String>[
      "Comparte datos relevantes en un formato estructurado, cuando corresponda.",
      "Aclara responsabilidades y verifica recepción de información crítica.",
      "Respeta las competencias y reconoce cuándo escalar una preocupación.",
    ],
  ),
  ...ylrExtraDetails,
};
