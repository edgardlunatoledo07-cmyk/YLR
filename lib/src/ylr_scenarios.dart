class YlrScenarioStep {
  const YlrScenarioStep(
      this.prompt, this.answers, this.correct, this.explanation);
  final String prompt, explanation;
  final List<String> answers;
  final int correct;
}

class YlrScenario {
  const YlrScenario(this.id, this.title, this.summary, this.level, this.steps);
  final String id, title, summary, level;
  final List<YlrScenarioStep> steps;
}

const ylrScenarios = <YlrScenario>[
  YlrScenario(
      'identidad',
      'Dos pacientes, nombres similares',
      'Escenario ficticio de identificación antes de una intervención.',
      'Seguridad', [
    YlrScenarioStep(
        'Encuentras a dos personas con apellidos muy similares. ¿Cómo previenes confusiones?',
        [
          'Confirmas identificadores conforme al protocolo',
          'Usas el número de habitación',
          'Te guías por apariencia'
        ],
        0,
        'Los identificadores formales evitan errores ligados al entorno.'),
    YlrScenarioStep(
        'Una pulsera no coincide con la documentación. ¿Qué haces?',
        [
          'Supones un error menor y continúas',
          'Detienes la acción no urgente y avisas',
          'Cambias tú la pulsera sin validar'
        ],
        1,
        'Una discrepancia de identidad debe resolverse por el conducto autorizado.'),
  ]),
  YlrScenario(
      'infecciones',
      'Interrupción durante higiene',
      'Escenario ficticio de prevención de contaminación cruzada.',
      'Bioseguridad', [
    YlrScenarioStep(
        'Tras manipular material contaminado vas a tocar material limpio. ¿Qué decisión tomas?',
        [
          'Conservas los mismos guantes',
          'Realizas el cambio y la higiene indicados',
          'Solo te secas los guantes'
        ],
        1,
        'Las barreras no reemplazan la higiene entre tareas.'),
    YlrScenarioStep(
        'Te piden usar un dispositivo compartido sin limpieza previa. ¿Cómo respondes?',
        [
          'Sigues el proceso de limpieza/desinfección aprobado',
          'Lo usas por parecer limpio',
          'Aplicas cualquier mezcla química'
        ],
        0,
        'El reprocesamiento debe seguir instrucciones institucionales.'),
  ]),
  YlrScenario(
      'deterioro',
      'Cambio respiratorio inesperado',
      'Escenario ficticio de reconocimiento de deterioro y comunicación.',
      'Urgencias', [
    YlrScenarioStep(
        'Una persona previamente estable empieza a hablar entrecortado y se agita. ¿Qué priorizas?',
        [
          'Esperar a que termine el turno',
          'Atribuirlo a ansiedad',
          'Solicitar valoración/ayuda urgente según el contexto'
        ],
        2,
        'Los cambios respiratorios importantes requieren atención inmediata.'),
    YlrScenarioStep(
        'El oxímetro muestra un valor aparentemente normal, pero el esfuerzo sigue aumentando.',
        [
          'Desestimas los síntomas',
          'Comunicas hallazgos y no dependes de una sola lectura',
          'Ajustas tratamientos por tu cuenta'
        ],
        1,
        'La clínica y los límites de la medición deben considerarse juntos.'),
  ]),
  YlrScenario('medicamentos', 'Lista de medicamentos distinta',
      'Escenario ficticio de conciliación y alergias.', 'Seguridad', [
    YlrScenarioStep(
        'Durante una transición aparecen dos listas de medicamentos diferentes.',
        [
          'Informas y solicitas conciliación responsable',
          'Eliges la lista más reciente por apariencia',
          'Omites una de las listas'
        ],
        0,
        'Las discrepancias deben aclararse, no resolverse por suposiciones.'),
    YlrScenarioStep(
        'Una alerta de alergia no figura en la indicación disponible.',
        [
          'La ignoras si no hay síntomas actuales',
          'Borras la alerta',
          'Detienes la acción no urgente y consultas'
        ],
        2,
        'La seguridad exige verificar antecedentes y discrepancias.'),
  ]),
  YlrScenario('movilidad', 'Levantarse con mareos',
      'Escenario ficticio de prevención de caídas.', 'Cuidados', [
    YlrScenarioStep(
        'Una persona se marea al ponerse de pie. ¿Qué haces?',
        [
          'Evitas continuar el traslado inseguro y pides apoyo',
          'Aceleras el traslado',
          'La dejas caminar sola'
        ],
        0,
        'La tolerancia al movimiento y el riesgo deben valorarse.'),
    YlrScenarioStep(
        'La entrega de turno no registra una caída anterior.',
        [
          'Omites la información',
          'Lo comunicas usando el canal establecido',
          'Solo lo conversas informalmente'
        ],
        1,
        'La continuidad del cuidado depende de información relevante y verificable.'),
  ]),
  YlrScenario(
      'comunicacion',
      'Una indicación mal entendida',
      'Escenario ficticio de comunicación terapéutica y confidencialidad.',
      'Ética', [
    YlrScenarioStep(
        'La persona asiente, pero parece no comprender una explicación.',
        [
          'La invitas a explicar qué entendió',
          'Repites sin escuchar',
          'Das por hecho que comprendió'
        ],
        0,
        'Comprobar comprensión favorece una comunicación segura.'),
    YlrScenarioStep(
        'Alguien propone compartir una foto de una ficha real con el grupo del curso.',
        [
          'La publicas si tapa el nombre',
          'La sustituyes por un caso completamente ficticio',
          'La envías por un chat informal'
        ],
        1,
        'Los datos clínicos no pertenecen a la beta educativa.'),
  ]),
];
