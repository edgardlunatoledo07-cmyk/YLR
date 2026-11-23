import 'content.dart';

/// Evaluaciones diferenciadas por ruta (16 preguntas por nivel).
/// La puntuación queda en el historial de la ruta seleccionada.
class YlrRouteQuiz {
  static List<QuizQuestion> forRoute(RouteKind route) => switch (route) {
        RouteKind.personal => personal,
        RouteKind.tens => tens,
        RouteKind.universitario => universitario,
      };

  static const personal = <QuizQuestion>[
    QuizQuestion(
        '¿Para qué sirve principalmente la higiene de manos?',
        [
          'Eliminar toda enfermedad',
          'Disminuir la transmisión de microorganismos',
          'Evitar cualquier consulta médica',
          'Reemplazar las vacunas'
        ],
        1,
        'La higiene de manos ayuda a reducir la transmisión; no elimina todos los riesgos.'),
    QuizQuestion(
        '¿Cuál es una señal que exige buscar ayuda urgente?',
        [
          'Somnolencia habitual después de almorzar',
          'Sed después de caminar',
          'Dificultad respiratoria intensa',
          'Necesidad de descansar'
        ],
        2,
        'Una dificultad respiratoria intensa necesita valoración urgente.'),
    QuizQuestion(
        '¿Qué representan los dos números de la presión arterial?',
        [
          'Peso y altura',
          'Frecuencia y temperatura',
          'Sistólica y diastólica',
          'Pulso y saturación'
        ],
        2,
        'La presión arterial suele expresarse como presión sistólica sobre diastólica.'),
    QuizQuestion(
        '¿Por qué no se debe compartir una fotografía de una ficha clínica?',
        [
          'Ocupa espacio',
          'Puede vulnerar la privacidad',
          'Reduce la batería',
          'No es útil para aprender'
        ],
        1,
        'Los datos de salud son confidenciales; utiliza ejemplos ficticios.'),
    QuizQuestion(
        '¿Qué debes hacer si no comprendes una indicación médica?',
        [
          'Inventar su significado',
          'Preguntar al equipo de salud',
          'Omitirla siempre',
          'Buscar consejos de cualquiera'
        ],
        1,
        'Pedir una aclaración evita malentendidos.'),
    QuizQuestion(
        '¿Los guantes reemplazan la higiene de manos?',
        [
          'Sí, siempre',
          'Solo cuando sean nuevos',
          'No, son medidas diferentes',
          'Solo fuera del hospital'
        ],
        2,
        'Los guantes no sustituyen la higiene de manos.'),
    QuizQuestion(
        '¿Qué puede disminuir el riesgo de caídas en casa?',
        [
          'Dejar pasillos oscuros',
          'Mantener obstáculos en el suelo',
          'Mejorar iluminación y retirar obstáculos',
          'Caminar rápido siempre'
        ],
        2,
        'Un entorno despejado e iluminado es una de las medidas preventivas.'),
    QuizQuestion(
        '¿Qué uso corresponde a Y.LR?',
        [
          'Diagnosticar pacientes',
          'Reemplazar una indicación profesional',
          'Aprender y repasar conocimientos básicos',
          'Administrar medicamentos automáticamente'
        ],
        2,
        'Y.LR es una herramienta educativa, no un sistema de decisiones clínicas.'),
    QuizQuestion(
        "¿Qué debes hacer si alguien presenta una dificultad respiratoria evidente?",
        <String>[
          "Animarlo a esperar varias horas",
          "Solicitar ayuda o atención urgente",
          "Asumir que el oxímetro siempre basta",
          "Recomendar medicación"
        ],
        1,
        "Los signos respiratorios importan aunque no conozcamos la causa."),
    QuizQuestion(
        "Un oxímetro doméstico indica un valor que no coincide con la persona. Lo adecuado es…",
        <String>[
          "Ignorar síntomas y confiar solo en pantalla",
          "Cambiar el tratamiento",
          "Considerar calidad de señal, síntomas y buscar valoración",
          "Inventar otra lectura"
        ],
        2,
        "La medición es una estimación y debe interpretarse en contexto."),
    QuizQuestion(
        "Una persona presenta dificultad repentina para hablar y mover un brazo. ¿Qué prioridad hay?",
        <String>[
          "Activar urgencias",
          "Dejarla dormir",
          "Esperar al día siguiente",
          "Dar fármacos propios"
        ],
        0,
        "Los síntomas súbitos de ACV exigen atención inmediata."),
    QuizQuestion(
        "¿Qué significa respetar privacidad en el cuidado?",
        <String>[
          "Explicar el caso a desconocidos",
          "Compartir fotos de fichas",
          "Publicar información sin nombre",
          "Proteger datos, espacio y consentimiento"
        ],
        3,
        "La confidencialidad también se aplica al aprendizaje."),
    QuizQuestion(
        "Una zona de piel sigue roja en alguien con movilidad limitada. Debes…",
        <String>[
          "Avisar y pedir valoración",
          "Ignorarla sin dolor",
          "Masajearla vigorosamente",
          "Aplicar cualquier crema"
        ],
        0,
        "La valoración temprana apoya prevención de lesiones por presión."),
    QuizQuestion(
        "Los cuidados paliativos buscan…",
        <String>[
          "Suspender siempre todos los cuidados",
          "Aliviar sufrimiento y apoyar calidad de vida",
          "Evitar hablar con la familia",
          "Limitarse al momento de morir"
        ],
        1,
        "Atienden necesidades físicas y psicosociales en conjunto."),
    QuizQuestion(
        "¿Es razonable interrumpir un tratamiento crónico porque hoy se siente bien?",
        <String>[
          "Sí, siempre",
          "Sí, sin informar",
          "No, debe consultar con equipo tratante",
          "Solo si lo sugiere una app"
        ],
        2,
        "Las modificaciones de tratamiento necesitan asesoría profesional."),
    QuizQuestion(
        "Ante dolor torácico intenso con sudor frío, corresponde…",
        <String>[
          "Esperar a que pase",
          "Concluir que es ansiedad",
          "Ocultarlo para evitar preocupación",
          "Buscar ayuda urgente"
        ],
        3,
        "Los síntomas pueden indicar una urgencia que debe evaluarse."),
  ];

  static const tens = <QuizQuestion>[
    QuizQuestion(
        'Antes de una tarea con riesgo de exposición, ¿qué corresponde?',
        [
          'Omitir higiene de manos si hay guantes',
          'Evaluar riesgo y aplicar precauciones apropiadas',
          'Usar siempre el mismo equipo de protección',
          'Confiar solo en la apariencia del paciente'
        ],
        1,
        'Las precauciones estándar dependen de la tarea y no del diagnóstico conocido.'),
    QuizQuestion(
        'Antes de un procedimiento, el identificador seguro se verifica mediante…',
        [
          'Número de habitación',
          'Aspecto del paciente',
          'Identificadores oficiales según protocolo',
          'Solo el diagnóstico'
        ],
        2,
        'La identificación se verifica mediante mecanismos institucionales establecidos.'),
    QuizQuestion(
        '¿Cuál es un registro clínico más objetivo?',
        [
          'Paciente complicado',
          'Muy mal comportamiento',
          'Se observa respiración rápida y refiere falta de aire',
          'Está haciendo teatro'
        ],
        2,
        'Se documentan hallazgos observables y expresiones de la persona.'),
    QuizQuestion(
        'Si un resultado de presión arterial parece discordante, lo primero es…',
        [
          'Diagnosticar hipertensión',
          'Revisar técnica, contexto y síntomas',
          'Administrar un medicamento',
          'Ignorar siempre el dato'
        ],
        1,
        'La validez de la medición y el contexto son fundamentales.'),
    QuizQuestion(
        '¿Qué ocurre si se usan los mismos guantes en tareas sucias y limpias?',
        [
          'Mejora la asepsia',
          'Puede ocurrir contaminación cruzada',
          'No cambia el riesgo',
          'Evita toda infección'
        ],
        1,
        'Los guantes pueden transportar microorganismos entre superficies.'),
    QuizQuestion(
        'Ante dificultad respiratoria progresiva observada, corresponde…',
        [
          'Esperar a terminar documentos',
          'Comunicar y activar ayuda según protocolo',
          'No avisar a nadie',
          'Diagnosticar la causa'
        ],
        1,
        'Un deterioro potencialmente grave requiere escalamiento oportuno.'),
    QuizQuestion(
        '¿Qué se hace ante discrepancia en el rotulado de un medicamento?',
        [
          'Administrarlo por apariencia',
          'Corregirlo de memoria',
          'Detener la acción y aclararlo por conducto seguro',
          'Ignorar el nombre'
        ],
        2,
        'Las dudas de identificación deben resolverse antes de la administración.'),
    QuizQuestion(
        '¿Qué tipo de dato NO corresponde introducir en una app educativa?',
        [
          'Caso ficticio',
          'Definición general',
          'Nombre y ficha real identificable de un paciente',
          'Pregunta de examen ficticia'
        ],
        2,
        'Los datos identificables de pacientes requieren protección y no pertenecen al piloto.'),
    QuizQuestion(
        "Una persona muestra cambios agudos en su estado de conciencia. En tu rol, corresponde…",
        <String>[
          "Esperar la próxima ronda",
          "Informar y activar protocolo",
          "Decidir el diagnóstico",
          "Prescribir un medicamento"
        ],
        1,
        "Un deterioro neurológico necesita comunicación oportuna."),
    QuizQuestion(
        "Al registrar balance hídrico, faltan pérdidas relevantes. Es correcto…",
        <String>[
          "Inventar un promedio",
          "Cerrar el balance como completo",
          "Reconocer la omisión y comunicarla",
          "Registrar solo el valor favorable"
        ],
        2,
        "El registro incompleto debe identificarse como tal."),
    QuizQuestion(
        "Tras retirar guantes usados en una tarea contaminada debes…",
        <String>[
          "Realizar higiene de manos según indicación",
          "Tocar el teléfono sin higiene",
          "Usar ese par en otra tarea",
          "Guardar los guantes"
        ],
        0,
        "El uso de guantes no reemplaza higiene de manos."),
    QuizQuestion(
        "Una alerta de alergia difiere de la indicación. La conducta segura es…",
        <String>[
          "Administrar igual",
          "Cambiar el medicamento por criterio propio",
          "Ignorar el registro",
          "Detener acción no urgente y consultar"
        ],
        3,
        "Las discrepancias se resuelven antes de la acción."),
    QuizQuestion(
        "Un paciente tose repetidamente al beber líquidos. Lo adecuado es…",
        <String>[
          "Insistir que termine",
          "Detener e informar según plan",
          "Cambiar la dieta sin indicación",
          "Acostarlo de inmediato"
        ],
        1,
        "La posible disfagia requiere evaluación."),
    QuizQuestion(
        "Una persona tiene piel enrojecida en una zona de apoyo. Se debe…",
        <String>[
          "Ignorar por no ser herida abierta",
          "Aplicar productos sin indicación",
          "Registrar y comunicar el cambio",
          "Esperar una semana"
        ],
        2,
        "Un signo temprano requiere valoración y cuidados planificados."),
    QuizQuestion(
        "En un traslado entre unidades, corresponde…",
        <String>[
          "Confirmar identidad y comunicar condiciones relevantes",
          "Omitir entrega verbal",
          "Trasladar sin revisar seguridad",
          "Dejar dispositivos sin control"
        ],
        0,
        "Las transiciones son puntos críticos de seguridad."),
    QuizQuestion(
        "Si sospechas sepsis por deterioro agudo, dentro de tu rol es prioritario…",
        <String>[
          "Elegir antibióticos",
          "Esperar confirmación casera",
          "Hacer diagnóstico definitivo",
          "Escalar el cambio y activar protocolo"
        ],
        3,
        "El deterioro debe comunicarse sin retraso."),
  ];

  static const universitario = <QuizQuestion>[
    QuizQuestion(
        '¿Qué enfoque favorece interpretar cambios de signos vitales?',
        [
          'Una cifra aislada sin contexto',
          'Tendencias, técnica y estado clínico',
          'Solo el valor máximo',
          'Preferencia del observador'
        ],
        1,
        'El razonamiento clínico integra tendencias, medición y valoración.'),
    QuizQuestion(
        'En seguridad del paciente, una identificación inadecuada suele considerarse…',
        [
          'Un detalle estético',
          'Una falla de proceso que requiere barreras',
          'Un dato irrelevante',
          'Un problema solo administrativo'
        ],
        1,
        'La identidad es una barrera esencial contra errores asistenciales.'),
    QuizQuestion(
        '¿Qué caracteriza las precauciones estándar?',
        [
          'Solo se aplican con diagnóstico confirmado',
          'Se basan en evaluación de riesgo en toda atención',
          'Solo aplican en pabellón',
          'Dependen del aspecto de la persona'
        ],
        1,
        'Se aplican ampliamente y se ajustan al riesgo previsto.'),
    QuizQuestion(
        'Ante una persona con disnea, ¿qué perspectiva es apropiada?',
        [
          'Concluir etiología desde la queja',
          'Integrar percepción subjetiva y signos asociados',
          'Ignorar síntomas si no hay cifras',
          'Dar un diagnóstico inmediato'
        ],
        1,
        'La disnea es subjetiva y necesita evaluación contextual.'),
    QuizQuestion(
        '¿Qué mejora la calidad de un traspaso de turno?',
        [
          'Comunicación estructurada con confirmación',
          'Comentarios vagos',
          'Datos incompletos',
          'Suponer que el receptor ya sabe'
        ],
        0,
        'La estructura y verificación reducen pérdidas de información relevante.'),
    QuizQuestion(
        'Respecto de seguridad de medicamentos, es prioritario…',
        [
          'Reducir toda verificación',
          'Conciliación y detección de discrepancias',
          'Administrar siempre rápidamente',
          'Omitir alergias'
        ],
        1,
        'La conciliación y verificación forman parte de sistemas de uso seguro.'),
    QuizQuestion(
        'Si dos mediciones difieren por técnica, la respuesta correcta es…',
        [
          'Elegir automáticamente la mayor',
          'Analizar técnica y repetir según protocolo',
          'Ignorar la menor',
          'Registrar solo una'
        ],
        1,
        'Los errores de medición requieren revisión antes de extraer conclusiones.'),
    QuizQuestion(
        '¿Qué principio protege la privacidad en el aprendizaje?',
        [
          'Compartir fichas reales',
          'Minimización y uso de casos ficticios',
          'Publicar fotos clínicas identificables',
          'Permitir acceso universal a registros'
        ],
        1,
        'La enseñanza debe respetar minimización de datos y confidencialidad.'),
    QuizQuestion(
        "Una lectura de saturación discordante con clínica requiere…",
        <String>[
          "Ajustar oxígeno sin evaluación",
          "Correlacionar con signos y limitaciones técnicas",
          "Descartar hipoxemia automáticamente",
          "Ignorar perfusión"
        ],
        1,
        "La oximetría puede tener limitaciones de medición."),
    QuizQuestion(
        "El análisis de un evento adverso debe centrarse en…",
        <String>[
          "Culpa individual sin datos",
          "Ocultar la falla",
          "Factores de sistema y barreras de seguridad",
          "Eliminar todas las notificaciones"
        ],
        2,
        "La seguridad mejora analizando procesos y causas contribuyentes."),
    QuizQuestion(
        "El cambio súbito de orientación en una persona mayor debe…",
        <String>[
          "Motivar evaluación de posible delirium y otras causas",
          "Atribuirse a edad",
          "Considerarse habitual",
          "Ignorarse en registros"
        ],
        0,
        "La confusión aguda no es consecuencia normal del envejecimiento."),
    QuizQuestion(
        "Ante listas divergentes de medicación en una transición, es clave…",
        <String>[
          "Elegir una al azar",
          "Interrumpir todo sin criterio",
          "Copiar ambas sin revisar",
          "Conciliar y resolver discrepancias con equipo responsable"
        ],
        3,
        "La conciliación reduce errores en transiciones."),
    QuizQuestion(
        "Respecto de la disfagia, la recomendación más segura es…",
        <String>[
          "Indicar textura desde una app",
          "Valorar riesgo y seguir evaluación interdisciplinaria",
          "Insistir con líquidos siempre",
          "Ignorar tos al alimentarse"
        ],
        1,
        "La alteración de la deglución necesita evaluación individual."),
    QuizQuestion(
        "Una evaluación del dolor basada solo en el número es…",
        <String>[
          "Siempre suficiente",
          "Equivalente al diagnóstico",
          "Incompleta sin funcionalidad, contexto y tendencia",
          "Innecesaria"
        ],
        2,
        "El dolor debe evaluarse de modo integral."),
    QuizQuestion(
        "En seguridad perioperatoria, discrepancia de lateralidad exige…",
        <String>[
          "Detener y resolver antes de avanzar",
          "Continuar y corregir después",
          "Dejarlo a memoria del equipo",
          "Reducir verificaciones"
        ],
        0,
        "Las listas de seguridad buscan detectar errores evitables."),
    QuizQuestion(
        "Un plan de cuidados paliativos de calidad incorpora…",
        <String>[
          "Solo analgesia",
          "Solo decisiones administrativas",
          "Solo expectativas del personal",
          "Objetivos compartidos y dimensiones biopsicosociales"
        ],
        3,
        "El apoyo incluye confort, autonomía y necesidades de familia."),
  ];
}
