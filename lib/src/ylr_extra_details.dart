// Desarrollo adicional para las 36 lecciones del catálogo ampliado.
part of 'ylr_lesson_details.dart';

const ylrExtraDetails = <String, YlrLessonDetail>{
  "LES-19": YlrLessonDetail(
    summary:
        "El oxímetro estima qué proporción de hemoglobina transporta oxígeno; no reemplaza observar cómo respira la persona. Antes de comunicar una lectura, observa perfusión, movimiento, esmalte u otras condiciones que puedan alterar la señal.",
    points: <String>[
      "Es una estimación indirecta, no una prueba diagnóstica autónoma.",
      "Una cifra aislada necesita relacionarse con síntomas y calidad de señal.",
      "La dificultad respiratoria puede requerir ayuda aunque la pantalla parezca normal.",
    ],
    caseQuestion:
        "Una persona está visiblemente agitada al respirar, pero el oxímetro parece normal. ¿Qué importa más?",
    caseAnswer:
        "Se debe reconocer el deterioro y solicitar valoración; la lectura no descarta una urgencia.",
    safety:
        "No ajustar oxígeno por cuenta propia: requiere indicación y competencias.",
    personalFocus:
        "Personal: El oxímetro estima qué proporción de hemoglobina transporta oxígeno; no reemplaza observar cómo respira la persona.",
    tensFocus:
        "TENS: Antes de comunicar una lectura, observa perfusión, movimiento, esmalte u otras condiciones que puedan alterar la señal.",
    universityFocus:
        "Universitario: Relaciona la saturación periférica con ventilación, perfusión y limitaciones del método; interpreta tendencias y estado clínico.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
  ),
  "LES-20": YlrLessonDetail(
    summary:
        "La respiración tiene una frecuencia y un esfuerzo; cambios persistentes merecen atención. Registra frecuencia, esfuerzo, pausas y cambios respecto del estado previo según protocolo.",
    points: <String>[
      "El patrón incluye frecuencia, ritmo y esfuerzo visible.",
      "Los cambios bruscos pueden ser más importantes que una cifra aislada.",
      "La comunicación oportuna evita demoras ante deterioro.",
    ],
    caseQuestion:
        "Una persona empieza a respirar con gran esfuerzo y habla entrecortado. ¿Esperarías la próxima ronda?",
    caseAnswer: "No: informa y activa ayuda según gravedad y protocolo.",
    safety: "La interpretación no sustituye valoración clínica urgente.",
    personalFocus:
        "Personal: La respiración tiene una frecuencia y un esfuerzo; cambios persistentes merecen atención.",
    tensFocus:
        "TENS: Registra frecuencia, esfuerzo, pausas y cambios respecto del estado previo según protocolo.",
    universityFocus:
        "Universitario: Analiza frecuencia, profundidad, ritmo y signos de fatiga ventilatoria, con evaluación sistemática.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
  ),
  "LES-21": YlrLessonDetail(
    summary:
        "El dolor es una experiencia personal: escuchar cómo lo describe la persona ayuda a cuidarla. Pregunta localización, intensidad, momento de inicio y cambios; documenta sin minimizar el relato.",
    points: <String>[
      "El relato de la persona es central, incluso cuando no hay signos visibles.",
      "Importan localización, evolución e impacto funcional.",
      "Tras una intervención autorizada se reevalúa y documenta la respuesta.",
    ],
    caseQuestion:
        "Alguien dice tener mucho dolor aunque parece tranquilo. ¿Es válido restarle importancia?",
    caseAnswer:
        "No. Escucha, registra y solicita valoración según el contexto.",
    safety: "No recomendar fármacos o dosis desde una escala aislada.",
    personalFocus:
        "Personal: El dolor es una experiencia personal: escuchar cómo lo describe la persona ayuda a cuidarla.",
    tensFocus:
        "TENS: Pregunta localización, intensidad, momento de inicio y cambios; documenta sin minimizar el relato.",
    universityFocus:
        "Universitario: Integra valoración de dolor, funcionalidad, factores agravantes y respuesta a intervenciones indicadas.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-22": YlrLessonDetail(
    summary:
        "Una disminución súbita de respuesta o confusión puede indicar un problema serio. Observa respuesta habitual, cambios recientes y capacidad para responder; comunica de inmediato alteraciones agudas.",
    points: <String>[
      "Compara las respuestas actuales con el estado habitual.",
      "La desorientación de inicio reciente necesita evaluación.",
      "La alteración de conciencia puede comprometer la seguridad y requiere apoyo rápido.",
    ],
    caseQuestion:
        "Una persona antes conversadora deja de responder de manera habitual. ¿Qué haces?",
    caseAnswer:
        "Reconoce el cambio, protege su seguridad y solicita valoración inmediata.",
    safety:
        "No sustituye formación en escalas neurológicas o manejo de vía aérea.",
    personalFocus:
        "Personal: Una disminución súbita de respuesta o confusión puede indicar un problema serio.",
    tensFocus:
        "TENS: Observa respuesta habitual, cambios recientes y capacidad para responder; comunica de inmediato alteraciones agudas.",
    universityFocus:
        "Universitario: Organiza observación neurológica básica y reconoce límites de herramientas como Glasgow sin aplicarlas fuera de formación.",
    sourceTitle: "MedlinePlus · Primeros auxilios",
    sourceUrl: "https://medlineplus.gov/spanish/firstaid.html",
  ),
  "LES-23": YlrLessonDetail(
    summary:
        "El organismo necesita un equilibrio de líquidos; las pérdidas y entradas son importantes. Distingue entradas y salidas, observa variaciones y registra solo mediciones efectivamente obtenidas.",
    points: <String>[
      "El registro debe identificar periodo y unidad de medida.",
      "Los datos incompletos pueden inducir decisiones equivocadas.",
      "Los hallazgos deben comunicarse junto con el estado general.",
    ],
    caseQuestion:
        "Un registro no incluye pérdidas relevantes, pero muestra un balance normal. ¿Puedes confiar plenamente?",
    caseAnswer: "No: faltan datos; deben aclararse las omisiones.",
    safety:
        "No indicar restricción ni aporte de líquidos basándose solo en esta lección.",
    personalFocus:
        "Personal: El organismo necesita un equilibrio de líquidos; las pérdidas y entradas son importantes.",
    tensFocus:
        "TENS: Distingue entradas y salidas, observa variaciones y registra solo mediciones efectivamente obtenidas.",
    universityFocus:
        "Universitario: Analiza balance hídrico junto con función renal, perfusión, signos y limitaciones de registros incompletos.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-24": YlrLessonDetail(
    summary:
        "La sed, el color de orina y el estado general pueden aportar pistas, pero no diagnostican deshidratación por sí solos. Observa ingesta reportada, mucosas, diuresis, mareos y cambios, según rol y supervisión.",
    points: <String>[
      "Las necesidades de líquidos varían según edad y enfermedades.",
      "La incapacidad para beber o la alteración del estado mental merece atención.",
      "Los cambios importantes deben comunicarse sin esperar confirmación casera.",
    ],
    caseQuestion:
        "Una persona mayor está confusa y ha ingerido poco líquido. ¿Basta con ofrecerle agua?",
    caseAnswer:
        "No; necesita valoración del cambio de conciencia y de su estado general.",
    safety:
        "Las restricciones de líquidos y enfermedades cardíacas o renales requieren indicaciones profesionales.",
    personalFocus:
        "Personal: La sed, el color de orina y el estado general pueden aportar pistas, pero no diagnostican deshidratación por sí solos.",
    tensFocus:
        "TENS: Observa ingesta reportada, mucosas, diuresis, mareos y cambios, según rol y supervisión.",
    universityFocus:
        "Universitario: Relaciona hidratación con perfusión, medicamentos, comorbilidades y evaluación integral.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
  ),
  "LES-25": YlrLessonDetail(
    summary:
        "La diabetes altera el control de glucosa en sangre; requiere acompañamiento y seguimiento. Reconoce la importancia de adherencia, alimentación, controles indicados y síntomas que deban comunicarse.",
    points: <String>[
      "La glucosa es fuente de energía y su regulación involucra hormonas.",
      "El seguimiento necesita un plan individualizado.",
      "No toda alteración de glucosa se maneja de la misma manera.",
    ],
    caseQuestion:
        "Una persona pregunta si puede suspender su tratamiento porque hoy se siente bien. ¿Qué explicarías?",
    caseAnswer: "Que no debe suspenderlo sin conversar con su equipo tratante.",
    safety: "No ajustar insulina ni medicamentos a partir de esta ficha.",
    personalFocus:
        "Personal: La diabetes altera el control de glucosa en sangre; requiere acompañamiento y seguimiento.",
    tensFocus:
        "TENS: Reconoce la importancia de adherencia, alimentación, controles indicados y síntomas que deban comunicarse.",
    universityFocus:
        "Universitario: Distingue mecanismos generales de alteración de glucosa, riesgos y continuidad del cuidado.",
    sourceTitle: "MedlinePlus · Diabetes tipo 2",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/000313.htm",
  ),
  "LES-26": YlrLessonDetail(
    summary:
        "Un descenso de glucosa puede provocar temblores, sudoración, confusión y, en casos graves, pérdida de conciencia. Reconoce síntomas, comunica la situación y sigue el protocolo de comprobación y respuesta correspondiente al rol.",
    points: <String>[
      "Los síntomas pueden variar y no son exclusivos de la glucosa baja.",
      "La confusión o inconsciencia requieren respuesta urgente.",
      "Es importante conocer el plan individual y el protocolo de atención.",
    ],
    caseQuestion:
        "Una persona con diabetes aparece somnolienta y no responde bien. ¿Se le debe dar algo por boca?",
    caseAnswer:
        "No si no puede tragar con seguridad; activa ayuda urgente y sigue protocolo.",
    safety: "No administrar comida o bebida a alguien con conciencia alterada.",
    personalFocus:
        "Personal: Un descenso de glucosa puede provocar temblores, sudoración, confusión y, en casos graves, pérdida de conciencia.",
    tensFocus:
        "TENS: Reconoce síntomas, comunica la situación y sigue el protocolo de comprobación y respuesta correspondiente al rol.",
    universityFocus:
        "Universitario: Analiza riesgos, desencadenantes y necesidad de seguimiento tras un episodio, incluyendo deterioro neurológico.",
    sourceTitle: "MedlinePlus · Hipoglucemia",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/000386.htm",
  ),
  "LES-27": YlrLessonDetail(
    summary:
        "Una lectura aislada no define por sí sola hipertensión o hipotensión. Considera reposo, técnica, posición y registro repetido cuando esté indicado.",
    points: <String>[
      "La técnica importa para la confiabilidad de la cifra.",
      "Los síntomas acompañantes cambian la urgencia de la valoración.",
      "Comparar mediciones ayuda más que reaccionar a una sola lectura.",
    ],
    caseQuestion:
        "Un manguito inadecuado entrega una cifra inesperada. ¿Cuál es el siguiente paso seguro?",
    caseAnswer:
        "Verificar condiciones y repetir según protocolo; informar si hay síntomas o gravedad.",
    safety:
        "No modificar tratamiento antihipertensivo por una lectura aislada.",
    personalFocus:
        "Personal: Una lectura aislada no define por sí sola hipertensión o hipotensión.",
    tensFocus:
        "TENS: Considera reposo, técnica, posición y registro repetido cuando esté indicado.",
    universityFocus:
        "Universitario: Integra tendencia, comorbilidades y posibles errores de medición en la interpretación supervisada.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
  ),
  "LES-28": YlrLessonDetail(
    summary:
        "El tabaquismo, la presión alta y otros factores pueden aumentar el riesgo cardiovascular. Refuerza mensajes preventivos aprobados y evita juicios sobre hábitos personales.",
    points: <String>[
      "Los factores pueden modificarse o no modificarse.",
      "La prevención combina hábitos y controles de salud.",
      "El riesgo individual requiere evaluación profesional.",
    ],
    caseQuestion:
        "Una persona pregunta si comer mejor elimina por completo su riesgo de infarto. ¿Qué respondes?",
    caseAnswer:
        "No elimina todo el riesgo; es una medida útil dentro de un seguimiento individual.",
    safety:
        "No calcular riesgo clínico individual sin herramientas y valoración validadas.",
    personalFocus:
        "Personal: El tabaquismo, la presión alta y otros factores pueden aumentar el riesgo cardiovascular.",
    tensFocus:
        "TENS: Refuerza mensajes preventivos aprobados y evita juicios sobre hábitos personales.",
    universityFocus:
        "Universitario: Reconoce interacción entre factores modificables, antecedentes y desigualdad en acceso a cuidado.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-29": YlrLessonDetail(
    summary:
        "Los riñones filtran la sangre y participan en el equilibrio de agua y sustancias. Relaciona diuresis observada, hidratación y alertas, sin inferir diagnóstico desde un solo dato.",
    points: <String>[
      "Los riñones ayudan a eliminar productos de desecho.",
      "Influyen en el equilibrio hídrico y de electrolitos.",
      "Los cambios de diuresis deben evaluarse en su contexto.",
    ],
    caseQuestion:
        "Una persona produce mucha menos orina que antes. ¿Qué harías con la observación?",
    caseAnswer: "Regístrala correctamente y comunícala oportunamente.",
    safety:
        "No sugerir diuréticos, hidratación forzada ni otras intervenciones sin indicación.",
    personalFocus:
        "Personal: Los riñones filtran la sangre y participan en el equilibrio de agua y sustancias.",
    tensFocus:
        "TENS: Relaciona diuresis observada, hidratación y alertas, sin inferir diagnóstico desde un solo dato.",
    universityFocus:
        "Universitario: Comprende función de filtración, regulación y contexto de deterioro renal en la planificación del cuidado.",
    sourceTitle: "MedlinePlus · Signos vitales",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/002341.htm",
  ),
  "LES-30": YlrLessonDetail(
    summary:
        "Un medidor de glucosa entrega una lectura que debe interpretarse dentro de un plan de cuidado. Identifica persona, equipo, trazabilidad y precauciones de bioseguridad antes de una medición autorizada.",
    points: <String>[
      "Solo personal autorizado debe realizar procedimientos invasivos según normas.",
      "La muestra y el equipo pueden afectar el resultado.",
      "Una lectura discordante con síntomas exige revisión oportuna.",
    ],
    caseQuestion:
        "El resultado de una medición no concuerda con la condición observada. ¿Qué haces?",
    caseAnswer:
        "Se revisa el procedimiento y se comunica para valoración o confirmación según protocolo.",
    safety: "No incluye técnica invasiva ni decisiones de dosificación.",
    personalFocus:
        "Personal: Un medidor de glucosa entrega una lectura que debe interpretarse dentro de un plan de cuidado.",
    tensFocus:
        "TENS: Identifica persona, equipo, trazabilidad y precauciones de bioseguridad antes de una medición autorizada.",
    universityFocus:
        "Universitario: Reconoce factores preanalíticos, control de calidad y la necesidad de confirmar resultados discordantes.",
    sourceTitle: "MedlinePlus · Hipoglucemia",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/000386.htm",
  ),
  "LES-31": YlrLessonDetail(
    summary:
        "Permanecer mucho tiempo en una posición puede dañar la piel, sobre todo si existe movilidad limitada. Observa cambios cutáneos, humedad y factores de riesgo; comunica y cumple el plan preventivo.",
    points: <String>[
      "La presión prolongada puede comprometer tejidos.",
      "La prevención requiere medidas individualizadas y vigilancia de la piel.",
      "El enrojecimiento persistente o herida requiere valoración.",
    ],
    caseQuestion:
        "Una persona permanece inmóvil y presenta una zona rojiza persistente. ¿Se ignora si no duele?",
    caseAnswer:
        "No: informa y solicita valoración; el dolor puede estar ausente.",
    safety:
        "Los cambios de posición deben adaptarse al plan clínico y seguridad.",
    personalFocus:
        "Personal: Permanecer mucho tiempo en una posición puede dañar la piel, sobre todo si existe movilidad limitada.",
    tensFocus:
        "TENS: Observa cambios cutáneos, humedad y factores de riesgo; comunica y cumple el plan preventivo.",
    universityFocus:
        "Universitario: Integra movilidad, nutrición, perfusión y reevaluación del riesgo en el cuidado integral.",
    sourceTitle: "MedlinePlus · Prevención de lesiones por presión",
    sourceUrl:
        "https://medlineplus.gov/spanish/ency/patientinstructions/000147.htm",
  ),
  "LES-32": YlrLessonDetail(
    summary:
        "El aseo favorece el bienestar, la dignidad y la observación de la piel. Planifica intimidad, consentimiento, temperatura ambiental y apoyo seguro según dependencia.",
    points: <String>[
      "La persona conserva derecho a privacidad durante el aseo.",
      "Favorece participación según capacidad y preferencias.",
      "Los cambios observados deben comunicarse de forma respetuosa.",
    ],
    caseQuestion:
        "Una persona expresa incomodidad por la exposición durante el aseo. ¿Qué mejora la atención?",
    caseAnswer: "Explicar, pedir permiso y proteger su privacidad.",
    safety:
        "No improvisar movilizaciones ni cuidados de dispositivos fuera del rol.",
    personalFocus:
        "Personal: El aseo favorece el bienestar, la dignidad y la observación de la piel.",
    tensFocus:
        "TENS: Planifica intimidad, consentimiento, temperatura ambiental y apoyo seguro según dependencia.",
    universityFocus:
        "Universitario: Integra preferencias, autonomía, riesgo de lesión y prevención de infecciones en cuidados básicos.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-33": YlrLessonDetail(
    summary:
        "Escuchar sin juzgar y reconocer señales de crisis puede facilitar el acceso a ayuda. Comunica preocupaciones por cambios conductuales y respeta la privacidad y la derivación.",
    points: <String>[
      "Escuchar con empatía es más útil que minimizar sentimientos.",
      "No se debe prometer confidencialidad absoluta ante riesgo grave.",
      "La crisis requiere una respuesta segura según protocolo.",
    ],
    caseQuestion:
        "Una persona dice estar desesperada y teme pedir ayuda. ¿Cómo comenzar?",
    caseAnswer: "Escucha, evita juzgar y facilita apoyo profesional oportuno.",
    safety:
        "No diagnosticar ni dar consejos que sustituyan intervención de salud mental.",
    personalFocus:
        "Personal: Escuchar sin juzgar y reconocer señales de crisis puede facilitar el acceso a ayuda.",
    tensFocus:
        "TENS: Comunica preocupaciones por cambios conductuales y respeta la privacidad y la derivación.",
    universityFocus:
        "Universitario: Reconoce sufrimiento psíquico como parte del cuidado integral y la necesidad de evaluación profesional.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-34": YlrLessonDetail(
    summary:
        "Las personas mayores tienen necesidades diversas; la edad no determina por sí sola dependencia. Reconoce cambios funcionales, preferencias y riesgos de caídas, delirium o deshidratación.",
    points: <String>[
      "Pregunta por autonomía y preferencias individuales.",
      "La confusión aguda no debe asumirse como envejecimiento normal.",
      "El entorno puede adaptarse para apoyar la independencia.",
    ],
    caseQuestion:
        "Una persona mayor presenta confusión de inicio reciente. ¿Es normal por la edad?",
    caseAnswer: "No: requiere valoración y comunicación oportuna.",
    safety: "No atribuir síntomas agudos automáticamente a la edad.",
    personalFocus:
        "Personal: Las personas mayores tienen necesidades diversas; la edad no determina por sí sola dependencia.",
    tensFocus:
        "TENS: Reconoce cambios funcionales, preferencias y riesgos de caídas, delirium o deshidratación.",
    universityFocus:
        "Universitario: Integra evaluación funcional, polifarmacia y decisiones centradas en la persona.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-35": YlrLessonDetail(
    summary:
        "En niñas y niños los signos de enfermedad pueden diferir de los adultos. Observa respiración, respuesta, hidratación y cambios informados por cuidadores, comunicándolos según protocolo.",
    points: <String>[
      "La edad modifica la interpretación de signos vitales.",
      "El cuidador puede aportar cambios relevantes del estado habitual.",
      "La dificultad respiratoria, deshidratación grave o baja respuesta requieren ayuda.",
    ],
    caseQuestion:
        "Un niño tiene respiración trabajosa y está menos activo. ¿Conviene observarlo sin avisar?",
    caseAnswer: "No: buscar evaluación o ayuda urgente según gravedad.",
    safety:
        "No aplicar dosis ni umbrales de adultos a la población pediátrica.",
    personalFocus:
        "Personal: En niñas y niños los signos de enfermedad pueden diferir de los adultos.",
    tensFocus:
        "TENS: Observa respiración, respuesta, hidratación y cambios informados por cuidadores, comunicándolos según protocolo.",
    universityFocus:
        "Universitario: Considera variaciones según edad, evaluación pediátrica y comunicación con la familia.",
    sourceTitle: "MedlinePlus · Primeros auxilios",
    sourceUrl: "https://medlineplus.gov/spanish/firstaid.html",
  ),
  "LES-36": YlrLessonDetail(
    summary:
        "Importa conocer si el dolor cambia con el tiempo y afecta la actividad. Utiliza escalas indicadas, documenta contexto y comunica cambios o falta de alivio.",
    points: <String>[
      "La misma escala facilita comparar registros sucesivos.",
      "El dolor nuevo o intenso merece evaluación en contexto.",
      "El registro distingue el relato de la persona de la observación del equipo.",
    ],
    caseQuestion:
        "Una persona informa más dolor después de una intervención indicada. ¿Qué corresponde?",
    caseAnswer: "Registrar el cambio y avisar para reevaluación.",
    safety: "No recomendar analgésicos específicos ni ajustes de dosis.",
    personalFocus:
        "Personal: Importa conocer si el dolor cambia con el tiempo y afecta la actividad.",
    tensFocus:
        "TENS: Utiliza escalas indicadas, documenta contexto y comunica cambios o falta de alivio.",
    universityFocus:
        "Universitario: Analiza reevaluación, intensidad, funcionalidad y factores que distorsionan la medición.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-37": YlrLessonDetail(
    summary:
        "Informar alergias y reacciones previas ayuda a prevenir daño. Verifica antecedentes documentados y comunica discrepancias antes de una acción delegada.",
    points: <String>[
      "No suponer que ausencia de registro significa ausencia de alergias.",
      "Las reacciones previas deben describirse de forma específica.",
      "Una discrepancia se aclara antes de actuar.",
    ],
    caseQuestion:
        "El registro indica alergia, pero la hoja de indicaciones no la menciona. ¿Qué haces?",
    caseAnswer: "Detienes la acción no urgente y consultas al responsable.",
    safety:
        "Nunca realizar pruebas de exposición a medicamentos por cuenta propia.",
    personalFocus:
        "Personal: Informar alergias y reacciones previas ayuda a prevenir daño.",
    tensFocus:
        "TENS: Verifica antecedentes documentados y comunica discrepancias antes de una acción delegada.",
    universityFocus:
        "Universitario: Integra verificación de alergias y diferenciación entre alergia y efectos adversos en sistemas de seguridad.",
    sourceTitle: "OMS · Medicación sin daño",
    sourceUrl: "https://www.who.int/initiatives/medication-without-harm",
  ),
  "LES-38": YlrLessonDetail(
    summary:
        "Una lista actualizada de medicamentos evita confusiones al cambiar de atención. Ayuda a identificar información incompleta y comunica diferencias entre listas según tu rol.",
    points: <String>[
      "Deben considerarse tratamientos prescritos y productos que la persona utiliza.",
      "Las transiciones de cuidado aumentan el riesgo de omisión.",
      "El equipo responsable debe resolver discrepancias documentadas.",
    ],
    caseQuestion:
        "Durante un traslado aparecen dos listas con tratamientos distintos. ¿Qué se hace?",
    caseAnswer:
        "Informar la discrepancia y solicitar conciliación al equipo autorizado.",
    safety: "No decidir suspensión o sustitución de medicamentos desde la app.",
    personalFocus:
        "Personal: Una lista actualizada de medicamentos evita confusiones al cambiar de atención.",
    tensFocus:
        "TENS: Ayuda a identificar información incompleta y comunica diferencias entre listas según tu rol.",
    universityFocus:
        "Universitario: Explica conciliación farmacológica en transiciones y su impacto en eventos prevenibles.",
    sourceTitle: "OMS · Medicación sin daño",
    sourceUrl: "https://www.who.int/initiatives/medication-without-harm",
  ),
  "LES-39": YlrLessonDetail(
    summary:
        "Comunicar errores y situaciones inseguras permite aprender y prevenir daños. Conoce canales institucionales de aviso, conserva datos objetivos y evita ocultar incidentes.",
    points: <String>[
      "Reportar no equivale automáticamente a atribuir culpa.",
      "Los datos deben ser verificados y manejados con confidencialidad.",
      "Las barreras de sistema reducen recurrencia.",
    ],
    caseQuestion:
        "Se detecta un error antes de afectar a alguien. ¿Vale la pena comunicarlo?",
    caseAnswer:
        "Sí, según el sistema de reporte; los casi errores aportan aprendizaje.",
    safety: "No publicar datos personales de personas involucradas.",
    personalFocus:
        "Personal: Comunicar errores y situaciones inseguras permite aprender y prevenir daños.",
    tensFocus:
        "TENS: Conoce canales institucionales de aviso, conserva datos objetivos y evita ocultar incidentes.",
    universityFocus:
        "Universitario: Distingue incidente, evento adverso y casi falla; considera mejoras de sistemas.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-40": YlrLessonDetail(
    summary:
        "Antes de una cirugía el equipo realiza verificaciones para reducir errores. Reconoce propósito de identidad, procedimiento, documentación y comunicación segura.",
    points: <String>[
      "La verificación se hace en momentos definidos del proceso.",
      "La participación del equipo mejora detección de discrepancias.",
      "La documentación y el consentimiento se revisan según normativa.",
    ],
    caseQuestion:
        "La lateralidad registrada en la ficha no coincide con la indicación. ¿Se sigue adelante?",
    caseAnswer:
        "No: se detiene y aclara la discrepancia con el equipo responsable.",
    safety: "No es un manual de preparación de pabellón ni técnica quirúrgica.",
    personalFocus:
        "Personal: Antes de una cirugía el equipo realiza verificaciones para reducir errores.",
    tensFocus:
        "TENS: Reconoce propósito de identidad, procedimiento, documentación y comunicación segura.",
    universityFocus:
        "Universitario: Analiza listas de verificación y coordinación de equipo sin sustituir protocolos quirúrgicos.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-41": YlrLessonDetail(
    summary:
        "Algunos instrumentos necesitan procesos especiales para eliminar microorganismos. Diferencia limpieza, desinfección y esterilización; cumple los circuitos institucionales.",
    points: <String>[
      "La limpieza suele preceder a otros procesos de reprocesamiento.",
      "Un paquete dañado o dudoso debe tratarse según protocolo, no asumirse estéril.",
      "La trazabilidad permite revisar controles de proceso.",
    ],
    caseQuestion:
        "Un envoltorio estéril está roto. ¿Puede utilizarse de todos modos?",
    caseAnswer:
        "No; debe retirarse del uso y seguir el procedimiento institucional.",
    safety: "No proporciona parámetros operativos de esterilización.",
    personalFocus:
        "Personal: Algunos instrumentos necesitan procesos especiales para eliminar microorganismos.",
    tensFocus:
        "TENS: Diferencia limpieza, desinfección y esterilización; cumple los circuitos institucionales.",
    universityFocus:
        "Universitario: Relaciona nivel de riesgo del dispositivo y controles documentados del reprocesamiento.",
    sourceTitle: "CDC · Precauciones estándar",
    sourceUrl:
        "https://www.cdc.gov/infection-control/hcp/basics/standard-precautions.html",
  ),
  "LES-42": YlrLessonDetail(
    summary:
        "Mantener superficies limpias reduce oportunidades de transmisión de microorganismos. Identifica superficies frecuentes de contacto y sigue productos y tiempos definidos por el centro.",
    points: <String>[
      "La limpieza retira suciedad y materia orgánica.",
      "La desinfección emplea un proceso apto para reducir microorganismos.",
      "Los productos y métodos se eligen según instrucciones autorizadas.",
    ],
    caseQuestion:
        "Una superficie está visiblemente sucia. ¿Basta con rociar desinfectante?",
    caseAnswer:
        "No: se requiere seguir el procedimiento adecuado de limpieza y desinfección.",
    safety: "No mezclar químicos ni improvisar concentraciones.",
    personalFocus:
        "Personal: Mantener superficies limpias reduce oportunidades de transmisión de microorganismos.",
    tensFocus:
        "TENS: Identifica superficies frecuentes de contacto y sigue productos y tiempos definidos por el centro.",
    universityFocus:
        "Universitario: Relaciona clasificación de superficies, riesgo y verificación de cumplimiento.",
    sourceTitle: "CDC · Precauciones estándar",
    sourceUrl:
        "https://www.cdc.gov/infection-control/hcp/basics/standard-precautions.html",
  ),
  "LES-43": YlrLessonDetail(
    summary:
        "Mascarillas, guantes y protección ocular se emplean según actividad y exposición prevista. Evalúa riesgo de exposición y sigue protocolos de colocación, retiro y eliminación.",
    points: <String>[
      "No existe un único EPP apropiado para toda situación.",
      "La selección depende de vía de transmisión y tarea.",
      "El uso incorrecto puede contaminar otras superficies.",
    ],
    caseQuestion:
        "Un estudiante usa guantes para tocar todo el entorno y su teléfono. ¿Qué problema hay?",
    caseAnswer: "Aumenta riesgo de contaminación cruzada.",
    safety:
        "La selección de respiradores y entrenamiento requieren protocolos locales.",
    personalFocus:
        "Personal: Mascarillas, guantes y protección ocular se emplean según actividad y exposición prevista.",
    tensFocus:
        "TENS: Evalúa riesgo de exposición y sigue protocolos de colocación, retiro y eliminación.",
    universityFocus:
        "Universitario: Analiza selección racional de EPP junto con controles administrativos y ambientales.",
    sourceTitle: "CDC · Precauciones estándar",
    sourceUrl:
        "https://www.cdc.gov/infection-control/hcp/basics/standard-precautions.html",
  ),
  "LES-44": YlrLessonDetail(
    summary:
        "El traslado requiere preparar información y condiciones de seguridad de la persona. Comprueba identificación, condiciones del entorno, dispositivos y comunicación antes de colaborar.",
    points: <String>[
      "La identificación acompaña todas las transiciones.",
      "Es importante anticipar necesidades y riesgos durante el recorrido.",
      "La entrega de información debe ser clara y verificable.",
    ],
    caseQuestion:
        "Se traslada a una persona sin informar un cambio relevante. ¿Qué riesgo aparece?",
    caseAnswer:
        "Pérdida de continuidad; hay que comunicar el cambio al equipo receptor.",
    safety: "No movilizar sin ayudas o capacitación requerida.",
    personalFocus:
        "Personal: El traslado requiere preparar información y condiciones de seguridad de la persona.",
    tensFocus:
        "TENS: Comprueba identificación, condiciones del entorno, dispositivos y comunicación antes de colaborar.",
    universityFocus:
        "Universitario: Planifica riesgos asociados al transporte y continuidad entre unidades.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-45": YlrLessonDetail(
    summary:
        "Describir qué cambió y cuándo ayuda a transmitir una preocupación. Usa observaciones concretas y canales establecidos para avisar cambios.",
    points: <String>[
      "Diferencia observación objetiva de interpretación personal.",
      "Avisa cambios importantes sin esperar un registro rutinario.",
      "La información mínima útil incluye situación y contexto.",
    ],
    caseQuestion:
        "Dices solamente “se ve mal” al entregar un turno. ¿Qué falta?",
    caseAnswer:
        "Describir el cambio, su inicio, las observaciones y la urgencia.",
    safety:
        "No compartir información clínica en mensajería informal sin autorización.",
    personalFocus:
        "Personal: Describir qué cambió y cuándo ayuda a transmitir una preocupación.",
    tensFocus:
        "TENS: Usa observaciones concretas y canales establecidos para avisar cambios.",
    universityFocus:
        "Universitario: Organiza información relevante y confirma que el equipo receptor la comprendió.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-46": YlrLessonDetail(
    summary:
        "Una infección acompañada de deterioro importante puede convertirse en una urgencia. Reconoce cambios agudos, comunica signos de gravedad y activa protocolos de respuesta.",
    points: <String>[
      "No basta con identificar fiebre para confirmar sepsis.",
      "El deterioro del estado mental o respiratorio puede ser relevante.",
      "El tiempo de reconocimiento y atención influye en la seguridad.",
    ],
    caseQuestion:
        "Una persona con sospecha de infección presenta confusión nueva y dificultad respiratoria. ¿Qué haces?",
    caseAnswer: "Buscar ayuda urgente y comunicar el deterioro observado.",
    safety:
        "No usar estas notas para diagnosticar sepsis o indicar antibióticos.",
    personalFocus:
        "Personal: Una infección acompañada de deterioro importante puede convertirse en una urgencia.",
    tensFocus:
        "TENS: Reconoce cambios agudos, comunica signos de gravedad y activa protocolos de respuesta.",
    universityFocus:
        "Universitario: Relaciona disfunción orgánica, infección y necesidad de evaluación y tratamiento oportunos.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-47": YlrLessonDetail(
    summary:
        "La debilidad súbita de un lado, dificultad al hablar o alteraciones repentinas pueden indicar un accidente cerebrovascular. Reconoce signos repentinos y activa recursos de urgencia; registra hora conocida de inicio si el protocolo lo exige.",
    points: <String>[
      "El inicio repentino importa incluso si los síntomas mejoran.",
      "La demora puede reducir opciones de tratamiento.",
      "La respuesta adecuada es solicitar atención urgente.",
    ],
    caseQuestion:
        "Una persona comienza a hablar con dificultad y mueve menos un brazo. ¿Esperarías a ver si pasa?",
    caseAnswer: "No: se requiere activar atención de urgencia de inmediato.",
    safety:
        "No indicar medicamentos ni trasladar por cuenta propia si existe sistema local de emergencias.",
    personalFocus:
        "Personal: La debilidad súbita de un lado, dificultad al hablar o alteraciones repentinas pueden indicar un accidente cerebrovascular.",
    tensFocus:
        "TENS: Reconoce signos repentinos y activa recursos de urgencia; registra hora conocida de inicio si el protocolo lo exige.",
    universityFocus:
        "Universitario: Interpreta la relevancia temporal y del circuito asistencial para sospecha de ACV.",
    sourceTitle: "MedlinePlus · Accidente cerebrovascular",
    sourceUrl: "https://medlineplus.gov/spanish/ency/article/000726.htm",
  ),
  "LES-48": YlrLessonDetail(
    summary:
        "El dolor o presión en el pecho acompañado de malestar puede necesitar evaluación urgente. No minimiza síntomas nuevos; comunica localización, tiempo y acompañantes al responsable.",
    points: <String>[
      "No toda molestia torácica tiene una causa única.",
      "Síntomas acompañantes modifican la preocupación clínica.",
      "Es peligroso retrasar ayuda para completar trámites.",
    ],
    caseQuestion:
        "Una persona presenta presión en el pecho, sudor frío y malestar intenso. ¿Qué haces?",
    caseAnswer: "Solicita atención urgente y sigue el protocolo de emergencia.",
    safety:
        "No recomendar aspirina ni otro medicamento sin indicación profesional.",
    personalFocus:
        "Personal: El dolor o presión en el pecho acompañado de malestar puede necesitar evaluación urgente.",
    tensFocus:
        "TENS: No minimiza síntomas nuevos; comunica localización, tiempo y acompañantes al responsable.",
    universityFocus:
        "Universitario: Analiza síntomas y diagnósticos diferenciales desde una perspectiva supervisada y de seguridad.",
    sourceTitle: "MedlinePlus · Primeros auxilios",
    sourceUrl: "https://medlineplus.gov/spanish/firstaid.html",
  ),
  "LES-49": YlrLessonDetail(
    summary:
        "Las quemaduras pueden ocurrir con líquidos calientes, fuego o agentes químicos. Identifica riesgos de seguridad y la necesidad de ayuda ante quemaduras graves.",
    points: <String>[
      "Importan extensión, profundidad, localización y condiciones de la persona.",
      "Las quemaduras químicas o eléctricas ameritan evaluación especializada.",
      "La seguridad de la escena protege a quienes ayudan.",
    ],
    caseQuestion:
        "Una quemadura afecta cara o respiración. ¿Puede esperar a la próxima consulta?",
    caseAnswer: "No: requiere valoración de urgencia.",
    safety:
        "No aplicar sustancias caseras ni manipular heridas extensas según indicaciones improvisadas.",
    personalFocus:
        "Personal: Las quemaduras pueden ocurrir con líquidos calientes, fuego o agentes químicos.",
    tensFocus:
        "TENS: Identifica riesgos de seguridad y la necesidad de ayuda ante quemaduras graves.",
    universityFocus:
        "Universitario: Distingue medidas preventivas y criterios generales de derivación sin enseñar tratamientos invasivos.",
    sourceTitle: "MedlinePlus · Primeros auxilios",
    sourceUrl: "https://medlineplus.gov/spanish/firstaid.html",
  ),
  "LES-50": YlrLessonDetail(
    summary:
        "Fotos, nombres y antecedentes de pacientes reales no deben compartirse en aplicaciones de prueba. Evita registrar datos identificables fuera de sistemas autorizados y usa casos ficticios.",
    points: <String>[
      "Un código de participante no debe contener datos sensibles.",
      "La autorización de uso debe cubrir finalidad y acceso.",
      "Los casos docentes pueden diseñarse sin identificar a nadie.",
    ],
    caseQuestion:
        "Un compañero quiere subir una foto de una ficha real a la app. ¿Es apropiado?",
    caseAnswer: "No. Deben utilizarse datos ficticios y canales autorizados.",
    safety: "Y.LR no almacena registros clínicos reales.",
    personalFocus:
        "Personal: Fotos, nombres y antecedentes de pacientes reales no deben compartirse en aplicaciones de prueba.",
    tensFocus:
        "TENS: Evita registrar datos identificables fuera de sistemas autorizados y usa casos ficticios.",
    universityFocus:
        "Universitario: Explica minimización de datos, control de acceso y seguridad al compartir información educativa.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-51": YlrLessonDetail(
    summary:
        "Comprender una intervención y poder preguntar forma parte del respeto a las personas. Reconoce la necesidad de informar al profesional responsable cuando exista una duda o negativa.",
    points: <String>[
      "No basta con obtener una firma si no existe comprensión adecuada.",
      "Una persona puede pedir aclaraciones y expresar rechazo.",
      "Las normas dependen de la legislación y el tipo de atención.",
    ],
    caseQuestion:
        "Una persona dice que no entendió lo que firmó. ¿Qué corresponde?",
    caseAnswer:
        "Facilitar aclaración con el profesional responsable antes de avanzar, según situación.",
    safety: "No reemplaza la Ley 20.584 ni asesoría legal o ética local.",
    personalFocus:
        "Personal: Comprender una intervención y poder preguntar forma parte del respeto a las personas.",
    tensFocus:
        "TENS: Reconoce la necesidad de informar al profesional responsable cuando exista una duda o negativa.",
    universityFocus:
        "Universitario: Relaciona autonomía, capacidad, documentación y excepciones legales según contexto.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-52": YlrLessonDetail(
    summary:
        "Durante un cambio de turno es importante decir lo que ocurrió y qué se necesita. Ordena situación, antecedentes, observaciones y solicitud según método institucional.",
    points: <String>[
      "La estructura disminuye olvidos en información crítica.",
      "El receptor debe poder aclarar dudas.",
      "Evita interpretaciones sin respaldo o lenguaje ambiguo.",
    ],
    caseQuestion:
        "En el turno siguiente nadie conoce una caída previa. ¿Qué faltó?",
    caseAnswer: "Un traspaso claro con antecedentes relevantes y confirmación.",
    safety: "No compartir datos identificables en prácticas educativas.",
    personalFocus:
        "Personal: Durante un cambio de turno es importante decir lo que ocurrió y qué se necesita.",
    tensFocus:
        "TENS: Ordena situación, antecedentes, observaciones y solicitud según método institucional.",
    universityFocus:
        "Universitario: Evalúa comunicación estructurada, verificación de recepción y riesgos de omisiones.",
    sourceTitle: "OMS · Guía curricular de seguridad del paciente",
    sourceUrl: "https://www.who.int/publications/i/item/9789241501958",
  ),
  "LES-53": YlrLessonDetail(
    summary:
        "Toser o atragantarse durante comidas puede señalar dificultad para tragar. Observa señales de deglución insegura y comunica; sigue indicaciones individualizadas de alimentación.",
    points: <String>[
      "La textura y vía de alimentación dependen de evaluación profesional.",
      "La tos repetida al comer requiere atención.",
      "La posición, vigilancia y apoyo siguen el plan indicado.",
    ],
    caseQuestion:
        "Una persona tose repetidamente al beber agua. ¿Se debe insistir para que termine?",
    caseAnswer:
        "No; detén la acción no urgente y solicita orientación clínica.",
    safety:
        "No modificar consistencias ni alimentar a alguien con deglución insegura sin indicación.",
    personalFocus:
        "Personal: Toser o atragantarse durante comidas puede señalar dificultad para tragar.",
    tensFocus:
        "TENS: Observa señales de deglución insegura y comunica; sigue indicaciones individualizadas de alimentación.",
    universityFocus:
        "Universitario: Analiza riesgo de aspiración, evaluación interdisciplinaria y adaptación del plan.",
    sourceTitle: "MedlinePlus · Prevención de lesiones por presión",
    sourceUrl:
        "https://medlineplus.gov/spanish/ency/patientinstructions/000147.htm",
  ),
  "LES-54": YlrLessonDetail(
    summary:
        "Los cuidados paliativos buscan aliviar sufrimiento y apoyar calidad de vida de personas y familias. Escucha necesidades, protege intimidad y comunica síntomas o cambios al equipo tratante.",
    points: <String>[
      "El confort incluye dimensiones físicas, emocionales y sociales.",
      "La familia y cuidadores también pueden necesitar apoyo.",
      "Las decisiones deben respetar preferencias y comunicación profesional.",
    ],
    caseQuestion:
        "Una familia pregunta si cuidados paliativos significa abandonar todos los cuidados. ¿Qué responderías?",
    caseAnswer:
        "No: se orientan a aliviar sufrimiento y brindar apoyo integral.",
    safety:
        "No sugerir sedación, analgesia o cambios de tratamiento desde la app.",
    personalFocus:
        "Personal: Los cuidados paliativos buscan aliviar sufrimiento y apoyar calidad de vida de personas y familias.",
    tensFocus:
        "TENS: Escucha necesidades, protege intimidad y comunica síntomas o cambios al equipo tratante.",
    universityFocus:
        "Universitario: Integra enfoque biopsicosocial y espiritual, alivio del sufrimiento y objetivos de cuidado compartidos.",
    sourceTitle: "OMS · Cuidados paliativos",
    sourceUrl:
        "https://www.who.int/es/news-room/fact-sheets/detail/palliative-care",
  ),
};
