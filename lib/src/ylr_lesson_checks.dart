class YlrLessonCheckQuestion {
  const YlrLessonCheckQuestion(
      this.prompt, this.options, this.correctIndex, this.explanation);
  final String prompt, explanation;
  final List<String> options;
  final int correctIndex;
}

/// Actividades específicas para todas las lecciones; casos simulados, sin pacientes reales.
const ylrLessonChecks = <String, YlrLessonCheckQuestion>{
  "LES-19": YlrLessonCheckQuestion(
      "Una persona está visiblemente agitada al respirar, pero el oxímetro parece normal. ¿Qué importa más?",
      <String>[
        "Se debe reconocer el deterioro y solicitar valoración; la lectura no descarta una urgencia.",
        "Dar por seguro que no hay riesgo respiratorio.",
        "Modificar el oxígeno sin consultar."
      ],
      0,
      "Orientación: Se debe reconocer el deterioro y solicitar valoración; la lectura no descarta una urgencia."),
  "LES-20": YlrLessonCheckQuestion(
      "Una persona empieza a respirar con gran esfuerzo y habla entrecortado. ¿Esperarías la próxima ronda?",
      <String>[
        "Esperar horas porque aún puede hablar.",
        "No: informa y activa ayuda según gravedad y protocolo.",
        "Asignar un diagnóstico sin observar."
      ],
      1,
      "Orientación: No: informa y activa ayuda según gravedad y protocolo."),
  "LES-21": YlrLessonCheckQuestion(
      "Alguien dice tener mucho dolor aunque parece tranquilo. ¿Es válido restarle importancia?",
      <String>[
        "Desestimar el relato si no hay gestos.",
        "Aconsejar un medicamento sin indicación.",
        "No. Escucha, registra y solicita valoración según el contexto."
      ],
      2,
      "Orientación: No. Escucha, registra y solicita valoración según el contexto."),
  "LES-22": YlrLessonCheckQuestion(
      "Una persona antes conversadora deja de responder de manera habitual. ¿Qué haces?",
      <String>[
        "Reconoce el cambio, protege su seguridad y solicita valoración inmediata.",
        "Esperar a que se normalice solo.",
        "Concluir que solo tiene sueño."
      ],
      0,
      "Orientación: Reconoce el cambio, protege su seguridad y solicita valoración inmediata."),
  "LES-23": YlrLessonCheckQuestion(
      "Un registro no incluye pérdidas relevantes, pero muestra un balance normal. ¿Puedes confiar plenamente?",
      <String>[
        "Registrar un balance definitivo sin aclaración.",
        "No: faltan datos; deben aclararse las omisiones.",
        "Inventar los valores ausentes."
      ],
      1,
      "Orientación: No: faltan datos; deben aclararse las omisiones."),
  "LES-24": YlrLessonCheckQuestion(
      "Una persona mayor está confusa y ha ingerido poco líquido. ¿Basta con ofrecerle agua?",
      <String>[
        "Interpretarlo como sed habitual sin cambios.",
        "Restringir líquidos por decisión propia.",
        "No; necesita valoración del cambio de conciencia y de su estado general."
      ],
      2,
      "Orientación: No; necesita valoración del cambio de conciencia y de su estado general."),
  "LES-25": YlrLessonCheckQuestion(
      "Una persona pregunta si puede suspender su tratamiento porque hoy se siente bien. ¿Qué explicarías?",
      <String>[
        "Que no debe suspenderlo sin conversar con su equipo tratante.",
        "Indicar suspensión del tratamiento.",
        "Decir que la diabetes ya se curó."
      ],
      0,
      "Orientación: Que no debe suspenderlo sin conversar con su equipo tratante."),
  "LES-26": YlrLessonCheckQuestion(
      "Una persona con diabetes aparece somnolienta y no responde bien. ¿Se le debe dar algo por boca?",
      <String>[
        "Dar de beber pese a que no responde bien.",
        "No si no puede tragar con seguridad; activa ayuda urgente y sigue protocolo.",
        "Dejarlo solo y esperar."
      ],
      1,
      "Orientación: No si no puede tragar con seguridad; activa ayuda urgente y sigue protocolo."),
  "LES-27": YlrLessonCheckQuestion(
      "Un manguito inadecuado entrega una cifra inesperada. ¿Cuál es el siguiente paso seguro?",
      <String>[
        "Elegir la cifra sin revisar el manguito.",
        "Cambiar la medicación por cuenta propia.",
        "Verificar condiciones y repetir según protocolo; informar si hay síntomas o gravedad."
      ],
      2,
      "Orientación: Verificar condiciones y repetir según protocolo; informar si hay síntomas o gravedad."),
  "LES-28": YlrLessonCheckQuestion(
      "Una persona pregunta si comer mejor elimina por completo su riesgo de infarto. ¿Qué respondes?",
      <String>[
        "No elimina todo el riesgo; es una medida útil dentro de un seguimiento individual.",
        "Afirmar que el riesgo desaparece totalmente.",
        "Afirmar que no se puede prevenir nada."
      ],
      0,
      "Orientación: No elimina todo el riesgo; es una medida útil dentro de un seguimiento individual."),
  "LES-29": YlrLessonCheckQuestion(
      "Una persona produce mucha menos orina que antes. ¿Qué harías con la observación?",
      <String>[
        "Indicar un diurético inmediatamente.",
        "Regístrala correctamente y comunícala oportunamente.",
        "Ignorar el cambio porque solo es orina."
      ],
      1,
      "Orientación: Regístrala correctamente y comunícala oportunamente."),
  "LES-30": YlrLessonCheckQuestion(
      "El resultado de una medición no concuerda con la condición observada. ¿Qué haces?",
      <String>[
        "Registrar el resultado como diagnóstico definitivo.",
        "Aplicar una dosis decidida por la app.",
        "Se revisa el procedimiento y se comunica para valoración o confirmación según protocolo."
      ],
      2,
      "Orientación: Se revisa el procedimiento y se comunica para valoración o confirmación según protocolo."),
  "LES-31": YlrLessonCheckQuestion(
      "Una persona permanece inmóvil y presenta una zona rojiza persistente. ¿Se ignora si no duele?",
      <String>[
        "No: informa y solicita valoración; el dolor puede estar ausente.",
        "Ignorar la zona si no se queja.",
        "Aplicar una técnica invasiva sin supervisión."
      ],
      0,
      "Orientación: No: informa y solicita valoración; el dolor puede estar ausente."),
  "LES-32": YlrLessonCheckQuestion(
      "Una persona expresa incomodidad por la exposición durante el aseo. ¿Qué mejora la atención?",
      <String>[
        "Continuar sin explicar ni cubrir a la persona.",
        "Explicar, pedir permiso y proteger su privacidad.",
        "Decirle que su privacidad no importa."
      ],
      1,
      "Orientación: Explicar, pedir permiso y proteger su privacidad."),
  "LES-33": YlrLessonCheckQuestion(
      "Una persona dice estar desesperada y teme pedir ayuda. ¿Cómo comenzar?",
      <String>[
        "Minimizar lo que expresa.",
        "Prometer que no pedirás ayuda pase lo que pase.",
        "Escucha, evita juzgar y facilita apoyo profesional oportuno."
      ],
      2,
      "Orientación: Escucha, evita juzgar y facilita apoyo profesional oportuno."),
  "LES-34": YlrLessonCheckQuestion(
      "Una persona mayor presenta confusión de inicio reciente. ¿Es normal por la edad?",
      <String>[
        "No: requiere valoración y comunicación oportuna.",
        "Atribuirlo a envejecimiento normal.",
        "Esperar un mes para comunicarlo."
      ],
      0,
      "Orientación: No: requiere valoración y comunicación oportuna."),
  "LES-35": YlrLessonCheckQuestion(
      "Un niño tiene respiración trabajosa y está menos activo. ¿Conviene observarlo sin avisar?",
      <String>[
        "Aplicar criterios de adultos y no avisar.",
        "No: buscar evaluación o ayuda urgente según gravedad.",
        "Decir que todos los niños respiran igual."
      ],
      1,
      "Orientación: No: buscar evaluación o ayuda urgente según gravedad."),
  "LES-36": YlrLessonCheckQuestion(
      "Una persona informa más dolor después de una intervención indicada. ¿Qué corresponde?",
      <String>[
        "No registrar el aumento del dolor.",
        "Recomendar una dosis nueva desde la app.",
        "Registrar el cambio y avisar para reevaluación."
      ],
      2,
      "Orientación: Registrar el cambio y avisar para reevaluación."),
  "LES-37": YlrLessonCheckQuestion(
      "El registro indica alergia, pero la hoja de indicaciones no la menciona. ¿Qué haces?",
      <String>[
        "Detienes la acción no urgente y consultas al responsable.",
        "Administrar por apariencia y resolver después.",
        "Borrar el dato de alergia sin verificar."
      ],
      0,
      "Orientación: Detienes la acción no urgente y consultas al responsable."),
  "LES-38": YlrLessonCheckQuestion(
      "Durante un traslado aparecen dos listas con tratamientos distintos. ¿Qué se hace?",
      <String>[
        "Elegir arbitrariamente una de las listas.",
        "Informar la discrepancia y solicitar conciliación al equipo autorizado.",
        "Ignorar una de las fuentes sin aclarar."
      ],
      1,
      "Orientación: Informar la discrepancia y solicitar conciliación al equipo autorizado."),
  "LES-39": YlrLessonCheckQuestion(
      "Se detecta un error antes de afectar a alguien. ¿Vale la pena comunicarlo?",
      <String>[
        "No avisar porque no hubo daño.",
        "Publicar el caso con datos identificables.",
        "Sí, según el sistema de reporte; los casi errores aportan aprendizaje."
      ],
      2,
      "Orientación: Sí, según el sistema de reporte; los casi errores aportan aprendizaje."),
  "LES-40": YlrLessonCheckQuestion(
      "La lateralidad registrada en la ficha no coincide con la indicación. ¿Se sigue adelante?",
      <String>[
        "No: se detiene y aclara la discrepancia con el equipo responsable.",
        "Continuar y corregir documentos después.",
        "Ignorar la discrepancia de lateralidad."
      ],
      0,
      "Orientación: No: se detiene y aclara la discrepancia con el equipo responsable."),
  "LES-41": YlrLessonCheckQuestion(
      "Un envoltorio estéril está roto. ¿Puede utilizarse de todos modos?",
      <String>[
        "Usarlo porque parece limpio.",
        "No; debe retirarse del uso y seguir el procedimiento institucional.",
        "Sellar el paquete roto y llamarlo estéril."
      ],
      1,
      "Orientación: No; debe retirarse del uso y seguir el procedimiento institucional."),
  "LES-42": YlrLessonCheckQuestion(
      "Una superficie está visiblemente sucia. ¿Basta con rociar desinfectante?",
      <String>[
        "Rociar sin considerar la suciedad visible.",
        "Mezclar productos para intensificar el efecto.",
        "No: se requiere seguir el procedimiento adecuado de limpieza y desinfección."
      ],
      2,
      "Orientación: No: se requiere seguir el procedimiento adecuado de limpieza y desinfección."),
  "LES-43": YlrLessonCheckQuestion(
      "Un estudiante usa guantes para tocar todo el entorno y su teléfono. ¿Qué problema hay?",
      <String>[
        "Aumenta riesgo de contaminación cruzada.",
        "Mantener siempre los mismos guantes.",
        "Usar el teléfono con guantes contaminados."
      ],
      0,
      "Orientación: Aumenta riesgo de contaminación cruzada."),
  "LES-44": YlrLessonCheckQuestion(
      "Se traslada a una persona sin informar un cambio relevante. ¿Qué riesgo aparece?",
      <String>[
        "Trasladar sin entregar antecedentes.",
        "Pérdida de continuidad; hay que comunicar el cambio al equipo receptor.",
        "Posponer la identidad hasta el destino."
      ],
      1,
      "Orientación: Pérdida de continuidad; hay que comunicar el cambio al equipo receptor."),
  "LES-45": YlrLessonCheckQuestion(
      "Dices solamente “se ve mal” al entregar un turno. ¿Qué falta?",
      <String>[
        "No decir nada por no tener diagnóstico.",
        "Enviar un mensaje informal con datos privados.",
        "Describir el cambio, su inicio, las observaciones y la urgencia."
      ],
      2,
      "Orientación: Describir el cambio, su inicio, las observaciones y la urgencia."),
  "LES-46": YlrLessonCheckQuestion(
      "Una persona con sospecha de infección presenta confusión nueva y dificultad respiratoria. ¿Qué haces?",
      <String>[
        "Buscar ayuda urgente y comunicar el deterioro observado.",
        "Esperar a terminar la documentación.",
        "Indicar antibióticos sin valoración."
      ],
      0,
      "Orientación: Buscar ayuda urgente y comunicar el deterioro observado."),
  "LES-47": YlrLessonCheckQuestion(
      "Una persona comienza a hablar con dificultad y mueve menos un brazo. ¿Esperarías a ver si pasa?",
      <String>[
        "Esperar a que los síntomas desaparezcan.",
        "No: se requiere activar atención de urgencia de inmediato.",
        "Dar medicamentos para probar."
      ],
      1,
      "Orientación: No: se requiere activar atención de urgencia de inmediato."),
  "LES-48": YlrLessonCheckQuestion(
      "Una persona presenta presión en el pecho, sudor frío y malestar intenso. ¿Qué haces?",
      <String>[
        "Concluir que siempre es estrés.",
        "Esperar porque no conoce su diagnóstico.",
        "Solicita atención urgente y sigue el protocolo de emergencia."
      ],
      2,
      "Orientación: Solicita atención urgente y sigue el protocolo de emergencia."),
  "LES-49": YlrLessonCheckQuestion(
      "Una quemadura afecta cara o respiración. ¿Puede esperar a la próxima consulta?",
      <String>[
        "No: requiere valoración de urgencia.",
        "Tratar la lesión facial solo con remedios caseros.",
        "Minimizar la dificultad respiratoria."
      ],
      0,
      "Orientación: No: requiere valoración de urgencia."),
  "LES-50": YlrLessonCheckQuestion(
      "Un compañero quiere subir una foto de una ficha real a la app. ¿Es apropiado?",
      <String>[
        "Compartir la imagen en un grupo de estudio.",
        "No. Deben utilizarse datos ficticios y canales autorizados.",
        "Tapar el nombre sin revisar otros identificadores."
      ],
      1,
      "Orientación: No. Deben utilizarse datos ficticios y canales autorizados."),
  "LES-51": YlrLessonCheckQuestion(
      "Una persona dice que no entendió lo que firmó. ¿Qué corresponde?",
      <String>[
        "Insistir que la firma reemplaza toda explicación.",
        "Ignorar la duda y continuar sin aclararla.",
        "Facilitar aclaración con el profesional responsable antes de avanzar, según situación."
      ],
      2,
      "Orientación: Facilitar aclaración con el profesional responsable antes de avanzar, según situación."),
  "LES-52": YlrLessonCheckQuestion(
      "En el turno siguiente nadie conoce una caída previa. ¿Qué faltó?",
      <String>[
        "Un traspaso claro con antecedentes relevantes y confirmación.",
        "Limitarse a decir que todo va bien.",
        "Omitir el evento porque ya pasó."
      ],
      0,
      "Orientación: Un traspaso claro con antecedentes relevantes y confirmación."),
  "LES-53": YlrLessonCheckQuestion(
      "Una persona tose repetidamente al beber agua. ¿Se debe insistir para que termine?",
      <String>[
        "Insistir con líquidos pese a la tos repetida.",
        "No; detén la acción no urgente y solicita orientación clínica.",
        "Aumentar la velocidad de la alimentación."
      ],
      1,
      "Orientación: No; detén la acción no urgente y solicita orientación clínica."),
  "LES-54": YlrLessonCheckQuestion(
      "Una familia pregunta si cuidados paliativos significa abandonar todos los cuidados. ¿Qué responderías?",
      <String>[
        "Afirmar que ya no recibirá ningún cuidado.",
        "Ignorar necesidades emocionales y familiares.",
        "No: se orientan a aliviar sufrimiento y brindar apoyo integral."
      ],
      2,
      "Orientación: No: se orientan a aliviar sufrimiento y brindar apoyo integral."),
  "LES-01": YlrLessonCheckQuestion(
      "Tras ajustar una mesa junto a la cama y antes de ayudar a una persona, ¿qué debes revisar?",
      <String>[
        "Continuar con los mismos guantes sin higiene.",
        "Reconocer el contacto con el entorno y efectuar higiene de manos cuando corresponda antes de la siguiente interacción.",
        "Asegurar que no hay ningún microorganismo."
      ],
      1,
      "Orientación: Reconocer el contacto con el entorno y efectuar higiene de manos cuando corresponda antes de la siguiente interacción."),
  "LES-02": YlrLessonCheckQuestion(
      "Una persona tiene una lectura distinta a su valor habitual después de subir escaleras. ¿Se interpreta sin más?",
      <String>[
        "Elegir la cifra más alta sin revisar técnica.",
        "Interpretar un valor sin contexto.",
        "No: considera actividad previa, reposo, procedimiento y necesidad de repetir la medición o comunicar el hallazgo."
      ],
      2,
      "Orientación: No: considera actividad previa, reposo, procedimiento y necesidad de repetir la medición o comunicar el hallazgo."),
  "LES-03": YlrLessonCheckQuestion(
      "Dos personas comparten apellido en una sala y hay una muestra por rotular. ¿Qué es lo prioritario?",
      <String>[
        "Usar el procedimiento institucional de verificación de identidad y rotulación en el momento adecuado.",
        "Guiarse solamente por número de cama.",
        "Asumir identidad por aspecto."
      ],
      0,
      "Orientación: Usar el procedimiento institucional de verificación de identidad y rotulación en el momento adecuado."),
  "LES-04": YlrLessonCheckQuestion(
      "Una persona refiere que le cuesta respirar y habla en frases cortas. ¿Qué harías?",
      <String>[
        "Esperar hasta que deje de hablar por completo.",
        "Reconocer una señal de alarma y solicitar ayuda o valoración clínica de inmediato según el contexto.",
        "Atribuirlo a nervios sin valoración."
      ],
      1,
      "Orientación: Reconocer una señal de alarma y solicitar ayuda o valoración clínica de inmediato según el contexto."),
  "LES-05": YlrLessonCheckQuestion(
      "Tras ejercicio se registra un pulso más rápido. ¿Es igual que en reposo?",
      <String>[
        "Ignorar síntomas y solo mirar el reloj.",
        "Afirmar diagnóstico a partir de un pulso.",
        "No: la actividad puede influir; importa considerar síntomas, reposo y tendencias."
      ],
      2,
      "Orientación: No: la actividad puede influir; importa considerar síntomas, reposo y tendencias."),
  "LES-06": YlrLessonCheckQuestion(
      "Dos termómetros usados en sitios diferentes entregan valores distintos. ¿Cuál es la conclusión?",
      <String>[
        "Revisa los métodos utilizados y comunica los hallazgos con contexto, sin asumir que uno determina un diagnóstico.",
        "Diagnosticar sin considerar el método.",
        "Ocultar el valor que no coincide."
      ],
      0,
      "Orientación: Revisa los métodos utilizados y comunica los hallazgos con contexto, sin asumir que uno determina un diagnóstico."),
  "LES-07": YlrLessonCheckQuestion(
      "Una persona sin diagnóstico de infección necesita una curación. ¿Pueden omitirse las precauciones?",
      <String>[
        "Omitir precauciones si no hay diagnóstico conocido.",
        "No. Se aplican según el procedimiento y el riesgo de exposición, con los elementos indicados.",
        "Usar guantes como única protección siempre."
      ],
      1,
      "Orientación: No. Se aplican según el procedimiento y el riesgo de exposición, con los elementos indicados."),
  "LES-08": YlrLessonCheckQuestion(
      "Tras tocar material contaminado, una persona sigue usando los mismos guantes para manipular objetos limpios. ¿Qué falla?",
      <String>[
        "Continuar con los mismos guantes en objetos limpios.",
        "Suponer que los guantes sustituyen higiene.",
        "La continuidad del mismo par puede transportar contaminación; debe aplicarse el cambio y la higiene según protocolo."
      ],
      2,
      "Orientación: La continuidad del mismo par puede transportar contaminación; debe aplicarse el cambio y la higiene según protocolo."),
  "LES-09": YlrLessonCheckQuestion(
      "Una persona asiente al escuchar una explicación, pero parece confundida. ¿Cómo puedes comprobar comprensión?",
      <String>[
        "Invítala respetuosamente a explicar con sus palabras qué entendió, sin culparla.",
        "Repetir más fuerte sin comprobar comprensión.",
        "Dar por entendido porque asiente."
      ],
      0,
      "Orientación: Invítala respetuosamente a explicar con sus palabras qué entendió, sin culparla."),
  "LES-10": YlrLessonCheckQuestion(
      "Una persona está mareada al intentar ponerse de pie. ¿Debes apurar el traslado?",
      <String>[
        "Forzar el traslado aunque esté mareado.",
        "No. Evita una movilización insegura y solicita evaluación o apoyo según el contexto.",
        "Hacerlo sin solicitar apoyo."
      ],
      1,
      "Orientación: No. Evita una movilización insegura y solicita evaluación o apoyo según el contexto."),
  "LES-11": YlrLessonCheckQuestion(
      "Una persona con dificultad para caminar quiere levantarse sola por la noche. ¿Qué riesgo identificas?",
      <String>[
        "No intervenir porque la persona insiste.",
        "Aplicar restricciones improvisadas.",
        "Mayor probabilidad de caída; favorece asistencia y adapta el entorno según el plan y protocolo."
      ],
      2,
      "Orientación: Mayor probabilidad de caída; favorece asistencia y adapta el entorno según el plan y protocolo."),
  "LES-12": YlrLessonCheckQuestion(
      "Se observa una persona inquieta. ¿Es apropiado registrar simplemente “paciente difícil”?",
      <String>[
        "No. Es preferible consignar observaciones concretas y conductas verificables, según el sistema del centro.",
        "Inventar observaciones que no se realizaron.",
        "Registrar juicios personales como hechos."
      ],
      0,
      "Orientación: No. Es preferible consignar observaciones concretas y conductas verificables, según el sistema del centro."),
  "LES-13": YlrLessonCheckQuestion(
      "Una persona expresa falta de aire que aumenta rápidamente. ¿Es adecuado esperar a terminar una evaluación educativa?",
      <String>[
        "Esperar a que empeore sin informar.",
        "No. Interrumpe la actividad y busca asistencia inmediata.",
        "Indicar medicación por la app."
      ],
      1,
      "Orientación: No. Interrumpe la actividad y busca asistencia inmediata."),
  "LES-14": YlrLessonCheckQuestion(
      "Un envase se parece mucho a otro, pero su rotulado genera dudas. ¿Qué corresponde?",
      <String>[
        "Administrar pese a dudas de identificación.",
        "Elegir por apariencia del envase.",
        "No utilizarlo hasta aclarar la discrepancia por canales institucionales."
      ],
      2,
      "Orientación: No utilizarlo hasta aclarar la discrepancia por canales institucionales."),
  "LES-15": YlrLessonCheckQuestion(
      "Encuentras un objeto punzante abandonado fuera de su contenedor. ¿Qué debes hacer?",
      <String>[
        "Aisla el riesgo e informa/actúa únicamente según capacitación y protocolo del establecimiento.",
        "Mezclar todos los residuos en una bolsa.",
        "Ignorar protocolos del centro."
      ],
      0,
      "Orientación: Aisla el riesgo e informa/actúa únicamente según capacitación y protocolo del establecimiento."),
  "LES-16": YlrLessonCheckQuestion(
      "Un compañero propone enviar una foto de una ficha real a un grupo de estudio. ¿Qué corresponde?",
      <String>[
        "Publicar la historia en redes sociales.",
        "No difundirla; utilizar material ficticio o anonimizado conforme a normas aplicables.",
        "Compartir datos porque es una tarea académica."
      ],
      1,
      "Orientación: No difundirla; utilizar material ficticio o anonimizado conforme a normas aplicables."),
  "LES-17": YlrLessonCheckQuestion(
      "Una persona colapsa y no responde. ¿Es correcto terminar primero el registro?",
      <String>[
        "Esperar los documentos antes de activar ayuda.",
        "Buscar pertenencias como prioridad.",
        "No. Activa la respuesta de urgencias de inmediato según los recursos disponibles."
      ],
      2,
      "Orientación: No. Activa la respuesta de urgencias de inmediato según los recursos disponibles."),
  "LES-18": YlrLessonCheckQuestion(
      "Durante un cambio de turno se omite informar una caída reciente. ¿Qué puede ocurrir?",
      <String>[
        "Se pierde un antecedente importante para la seguridad; debe comunicarse oportunamente por canales establecidos.",
        "Omitir el evento en la entrega.",
        "Suponer que el otro turno ya sabe."
      ],
      0,
      "Orientación: Se pierde un antecedente importante para la seguridad; debe comunicarse oportunamente por canales establecidos."),
};
