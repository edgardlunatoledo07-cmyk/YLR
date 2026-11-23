import 'dart:async';
import 'package:flutter/material.dart';
import 'content.dart';
import 'state.dart';
import 'ylr_lesson_panel.dart';
import 'ylr_lesson_check_panel.dart';
import 'ylr_route_quiz.dart';
import 'style.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen(
      {super.key,
      required this.lesson,
      required this.state,
      required this.onQuiz});
  final Lesson lesson;
  final YlrState state;
  final VoidCallback onQuiz;
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final selected = widget.state.route!;
    return Scaffold(
      appBar: AppBar(title: const Text('Lección · Y.LR'), centerTitle: false),
      body: SafeArea(
          child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 25),
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Área · ${lesson.category}',
                  style: Theme.of(context).textTheme.bodyMedium),
              YBadge(widget.state.lessonDone(lesson.id)
                  ? 'Completada'
                  : 'En aprendizaje'),
            ]),
            yGap(10),
            Text(lesson.title,
                style: Theme.of(context).textTheme.headlineLarge),
            yGap(8),
            Text(lesson.objective,
                style: Theme.of(context).textTheme.bodyMedium),
            yGap(17),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: YColors.blue.withValues(alpha: .07),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                    children: ['Lectura', 'Recursos', 'Actividad']
                        .asMap()
                        .entries
                        .map(
                          (e) => Expanded(
                              child: TextButton.icon(
                                  onPressed: () => setState(() => tab = e.key),
                                  style: TextButton.styleFrom(
                                      backgroundColor: tab == e.key
                                          ? YColors.blue
                                          : Colors.transparent,
                                      foregroundColor: tab == e.key
                                          ? Colors.white
                                          : YColors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 0)),
                                  icon: Icon(
                                      [
                                        Icons.menu_book_outlined,
                                        Icons.description_outlined,
                                        Icons.check_circle_outline
                                      ][e.key],
                                      size: 16),
                                  label: Text(e.value,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700)))),
                        )
                        .toList())),
            yGap(17),
            if (tab == 0) ..._reading(context, lesson, selected),
            if (tab == 1) ..._resources(context, lesson),
            if (tab == 2) ..._activity(context, lesson),
          ])),
    );
  }

  List<Widget> _reading(BuildContext context, Lesson l, RouteKind r) => [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: YColors.teal.withValues(alpha: .085),
              borderRadius: BorderRadius.circular(19)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.track_changes_rounded, color: YColors.teal),
              const SizedBox(width: 9),
              Expanded(
                  child: Text('Objetivos de aprendizaje',
                      style: Theme.of(context).textTheme.titleMedium))
            ]),
            yGap(11),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.check_circle, color: YColors.teal, size: 19),
              const SizedBox(width: 10),
              Expanded(child: Text(l.objective))
            ]),
            yGap(7),
            const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.check_circle, color: YColors.teal, size: 19),
              SizedBox(width: 10),
              Expanded(
                  child: Text(
                      'Relacionar el contenido con la seguridad y el contexto de atención.'))
            ]),
          ]),
        ),
        yGap(19),
        Text('¿Qué debes saber?',
            style: Theme.of(context).textTheme.headlineSmall),
        yGap(8),
        Text(l.forRoute(r),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 16, height: 1.62)),
        yGap(14),
        YlrLessonPanel(lessonId: l.id, route: r),
        yGap(15),
        if (l.id == 'LES-02')
          ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Container(
                height: 300,
                width: double.infinity,
                color: const Color(0xFFE7F3F8),
                child: Image.asset('assets/illustrations/presion_arterial.png',
                    fit: BoxFit.contain),
              ))
        else
          Container(
            height: 150,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFE9F8FB), Color(0xFFDCEBF8)]),
                borderRadius: BorderRadius.circular(23)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                  l.category == 'Signos vitales'
                      ? Icons.monitor_heart_outlined
                      : l.category == 'Bioseguridad'
                          ? Icons.clean_hands_outlined
                          : l.category == 'Urgencias'
                              ? Icons.emergency_outlined
                              : Icons.health_and_safety_outlined,
                  size: 86,
                  color: YColors.blue),
              const SizedBox(width: 18),
              const Flexible(
                  child: Text(
                      'Contenido ilustrativo\nConsulta los puntos clave',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: YColors.navy))),
            ]),
          ),
        yGap(16),
        Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: YColors.lilac.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(18)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.menu_book_outlined, color: YColors.lilac),
                const SizedBox(width: 8),
                Text('Término clave',
                    style: Theme.of(context).textTheme.titleMedium)
              ]),
              yGap(8),
              Text(l.id == 'LES-02' ? 'Presión arterial' : l.title,
                  style: Theme.of(context).textTheme.titleMedium),
              Text(
                  l.id == 'LES-02'
                      ? glossary['Presión arterial']!
                      : l.objective,
                  style: Theme.of(context).textTheme.bodyMedium),
            ])),
        yGap(13),
        YCard(
            child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(bottom: 12),
                leading: const Icon(Icons.manage_search_outlined,
                    color: YColors.blue),
                title: Text('Profundizar',
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: const Text('Contexto y factores a considerar'),
                children: [
              Text(
                  'La evaluación e interpretación de estos conceptos debe considerar el entorno, el nivel de formación y los protocolos institucionales. Revisa las fuentes y solicita supervisión cuando corresponda.',
                  style: Theme.of(context).textTheme.bodyMedium)
            ])),
        yGap(12),
        Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: YColors.rose.withValues(alpha: .085),
                borderRadius: BorderRadius.circular(18)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.warning_amber_rounded, color: YColors.rose),
                const SizedBox(width: 9),
                Expanded(
                    child: Text('Precauciones importantes',
                        style: Theme.of(context).textTheme.titleMedium))
              ]),
              yGap(7),
              const Text(
                  '• Esta lección es formativa, no una orden de actuación.\n• Sigue protocolos del establecimiento y competencias de tu rol.\n• Ante dudas o urgencias reales, solicita apoyo profesional.'),
            ])),
        yGap(15),
        YButton(
            widget.state.lessonDone(l.id)
                ? 'Lectura completada · ir a evaluación'
                : 'Marcar como leída e ir a evaluación', onPressed: () {
          widget.state.completeLesson(l.id);
          widget.onQuiz();
        }),
        yGap(9),
        OutlinedButton(
            onPressed: () {
              widget.state.completeLesson(l.id);
              Navigator.pop(context);
            },
            child: const Text('Solo marcar lectura completada')),
      ];

  List<Widget> _resources(BuildContext context, Lesson l) => [
        Text('Recursos de la lección',
            style: Theme.of(context).textTheme.headlineSmall),
        yGap(12),
        const YNotice(
            'Las referencias documentales son orientativas y deben revisarse antes de distribuir Y.LR a estudiantes. Las ilustraciones restantes siguen en preparación.'),
        yGap(12),
        YlrLessonBibliography(lessonId: l.id),
        yGap(13),
        YCard(
            child: Row(children: [
          const YIcon(Icons.article_outlined, color: YColors.lilac),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Resumen · ${l.title}',
                    style: Theme.of(context).textTheme.titleMedium),
                Text(l.objective,
                    style: Theme.of(context).textTheme.bodyMedium),
              ]))
        ])),
        yGap(12),
        YCard(
            child: Row(children: [
          const YIcon(Icons.menu_book_outlined, color: YColors.teal),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
                  'Consulta el glosario desde la barra inferior para explorar términos relacionados.',
                  style: Theme.of(context).textTheme.bodyMedium))
        ])),
      ];

  List<Widget> _activity(BuildContext context, Lesson l) => [
        Text('Actividad formativa',
            style: Theme.of(context).textTheme.headlineSmall),
        yGap(12),
        YlrLessonCheckPanel(
          lessonId: l.id,
          onPassed: () => widget.state.completeLesson(l.id),
        ),
        yGap(12),
        YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Evaluación general de tu ruta',
              style: Theme.of(context).textTheme.titleLarge),
          yGap(7),
          const Text(
              '16 preguntas específicas para tu ruta, con corrección y retroalimentación.'),
          yGap(15),
          YButton('Iniciar evaluación', onPressed: widget.onQuiz),
        ])),
        yGap(12),
        const YNotice(
            'Completar la evaluación no certifica competencias clínicas.'),
      ];
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.state});
  final YlrState state;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int current = 0;
  late final List<QuizQuestion> questions;
  late final List<int?> answers;
  bool finished = false;

  @override
  void initState() {
    super.initState();
    questions = YlrRouteQuiz.forRoute(widget.state.route ?? RouteKind.personal);
    answers = List<int?>.filled(questions.length, null);
  }

  int get score => List.generate(questions.length,
          (i) => answers[i] == questions[i].correctIndex ? 1 : 0)
      .fold<int>(0, (sum, value) => sum + value);
  void next() {
    if (current < questions.length - 1) {
      setState(() => current++);
      return;
    }
    if (answers.every((a) => a != null)) {
      setState(() => finished = true);
      widget.state.addScore((score * 100 / questions.length).round());
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[current];
    final picked = answers[current];
    return Scaffold(
      appBar: AppBar(title: const Text('Evaluación · Y.LR')),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
        const YBadge('MODO FORMATIVO', color: YColors.blue),
        yGap(9),
        Text('Evaluación', style: Theme.of(context).textTheme.headlineLarge),
        Text(
            'Ruta ${widget.state.route?.label ?? 'Personal'} · ${questions.length} preguntas',
            style: Theme.of(context).textTheme.titleLarge),
        yGap(9),
        const Text(
            'Repasa los fundamentos de seguridad y cuidados correspondientes a tu ruta.'),
        yGap(14),
        YCard(
            child: Row(children: [
          const YIcon(Icons.school_outlined),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
                  'Al seleccionar una respuesta, verás una explicación para seguir aprendiendo.',
                  style: Theme.of(context).textTheme.bodyMedium))
        ])),
        yGap(13),
        if (finished) ...[
          YCard(
              child: Column(children: [
            const Icon(Icons.emoji_events_rounded,
                color: Color(0xFFF4AA2A), size: 52),
            yGap(9),
            Text('${(score * 100 / questions.length).round()}%',
                style: Theme.of(context).textTheme.headlineLarge),
            Text('$score de ${questions.length} respuestas correctas',
                style: Theme.of(context).textTheme.titleMedium),
            yGap(10),
            Text(
                widget.state.route == RouteKind.personal
                    ? 'Resultado orientativo; no hay nota mínima para esta ruta.'
                    : score * 100 / questions.length >= 70
                        ? 'Buen avance de aprendizaje: continúa repasando las lecciones.'
                        : 'Conviene revisar los contenidos y volver a intentar la evaluación.',
                textAlign: TextAlign.center),
            yGap(14),
            YButton('Volver a practicar',
                icon: Icons.restart_alt_rounded,
                onPressed: () => setState(() {
                      current = 0;
                      finished = false;
                      for (var i = 0; i < answers.length; i++) {
                        answers[i] = null;
                      }
                    })),
          ])),
        ] else ...[
          YCard(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Expanded(
                      child: LinearProgressIndicator(
                          value: (current + 1) / questions.length,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(9),
                          color: YColors.teal)),
                  const SizedBox(width: 10),
                  Text('${current + 1} de ${questions.length}',
                      style: const TextStyle(fontSize: 12))
                ]),
                yGap(17),
                Text(question.text,
                    style: Theme.of(context).textTheme.titleLarge),
                yGap(13),
                ...question.options.asMap().entries.map((e) {
                  final selected = picked == e.key;
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: InkWell(
                        onTap: () => setState(() => answers[current] = e.key),
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 14),
                            decoration: BoxDecoration(
                                color: selected
                                    ? YColors.teal.withValues(alpha: .10)
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: selected
                                        ? YColors.teal
                                        : YColors.border,
                                    width: selected ? 1.7 : 1)),
                            child: Row(children: [
                              CircleAvatar(
                                  radius: 16,
                                  backgroundColor: selected
                                      ? YColors.teal
                                      : YColors.blue.withValues(alpha: .09),
                                  child: Text(String.fromCharCode(65 + e.key),
                                      style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : YColors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              const SizedBox(width: 12),
                              Expanded(child: Text(e.value)),
                              Icon(
                                  selected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color:
                                      selected ? YColors.teal : YColors.muted),
                            ])),
                      ));
                }),
              ])),
          yGap(12),
          if (picked != null)
            Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: (picked == question.correctIndex
                            ? YColors.teal
                            : YColors.rose)
                        .withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                          picked == question.correctIndex
                              ? Icons.check_circle_rounded
                              : Icons.info_outline,
                          color: picked == question.correctIndex
                              ? YColors.teal
                              : YColors.rose),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                                picked == question.correctIndex
                                    ? '¡Correcto!'
                                    : 'Repasemos este concepto',
                                style: Theme.of(context).textTheme.titleMedium),
                            Text(question.explanation),
                          ])),
                    ])),
          yGap(14),
          Row(children: [
            Expanded(
                child: OutlinedButton.icon(
                    onPressed:
                        current == 0 ? null : () => setState(() => current--),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Anterior'))),
            const SizedBox(width: 9),
            Expanded(
                child: YButton(
                    current == questions.length - 1 ? 'Finalizar' : 'Siguiente',
                    onPressed: picked == null ? null : next,
                    icon: Icons.arrow_forward_rounded)),
          ]),
        ],
        yGap(14),
        const YNotice(
            'Evaluación formativa. Los resultados son educativos y no certifican competencias.'),
      ])),
    );
  }
}

class SimulationScreen extends StatefulWidget {
  const SimulationScreen(
      {super.key, required this.state, required this.pressure});
  final YlrState state;
  final bool pressure;
  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen>
    with WidgetsBindingObserver {
  Timer? timer;
  late int remaining;
  bool paused = false;
  bool finished = false;
  bool timedOut = false;
  int interruptions = 0;
  int? choice;
  bool get timed => widget.pressure && widget.state.timerMode != 2;
  @override
  void initState() {
    super.initState();
    remaining = widget.state.timerMode == 1 ? 120 : 60;
    WidgetsBinding.instance.addObserver(this);
    if (timed) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted || paused || finished) return;
        if (remaining > 1) {
          setState(() => remaining--);
        } else {
          setState(() {
            remaining = 0;
            timedOut = true;
            finished = true;
          });
          timer?.cancel();
          widget.state.addSimulation('bajo-presion:tiempo-agotado');
        }
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed &&
        mounted &&
        timed &&
        !finished &&
        !paused) {
      setState(() {
        paused = true;
        interruptions++;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void confirm() {
    if (choice == null || finished) return;
    timer?.cancel();
    setState(() => finished = true);
    widget.state.addSimulation(
        '${widget.pressure ? 'bajo-presion' : 'analisis'}:$choice:interrupciones=$interruptions');
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (remaining % 60).toString().padLeft(2, '0');
    final choices = [
      (
        'Evaluar y solicitar ayuda',
        'Valoro respuesta y respiración, activo apoyo urgente y sigo los protocolos de atención.'
      ),
      (
        'Esperar la identificación',
        'Intento conseguir los documentos antes de solicitar asistencia.'
      ),
      (
        'Revisar pertenencias',
        'Busco información personal antes de activar la respuesta.'
      ),
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.pressure ? 'Bajo presión' : 'Análisis de decisiones')),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
        Row(children: [
          Expanded(
              child: Text('Simulaciones',
                  style: Theme.of(context).textTheme.headlineLarge)),
          YBadge(timed ? '$minutes:$seconds' : 'Sin límite',
              color: YColors.rose),
        ]),
        Text('Casos interactivos para practicar decisiones.',
            style: Theme.of(context).textTheme.bodyMedium),
        yGap(13),
        Container(
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF07547F), Color(0xFF1A85AC)]),
              borderRadius: BorderRadius.circular(22)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            YBadge(widget.pressure ? '⚡ Bajo presión' : 'Análisis',
                color: Colors.white),
            yGap(14),
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                    height: 138,
                    width: double.infinity,
                    child: Image.asset(
                        'assets/illustrations/urgencias_demo.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center))),
            yGap(9),
            const Text('Paciente inconsciente sin identificación',
                style: TextStyle(
                    fontSize: 22,
                    height: 1.12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            yGap(10),
            const Text(
                'Escenario ficticio: en un servicio de urgencias ingresa una persona adulta sin documentos ni acompañantes. Debes priorizar la respuesta inicial dentro de tu rol.',
                style: TextStyle(color: Colors.white, height: 1.45)),
          ]),
        ),
        yGap(15),
        if (timed && !finished)
          Row(children: [
            Expanded(
                child: Text('Interrupciones: $interruptions',
                    style: Theme.of(context).textTheme.bodyMedium)),
            OutlinedButton.icon(
                onPressed: () => setState(() => paused = !paused),
                icon: Icon(paused ? Icons.play_arrow : Icons.pause),
                label: Text(paused ? 'Reanudar' : 'Pausar')),
          ]),
        if (paused && !finished)
          const YNotice('Simulación en pausa. Reanuda para continuar.'),
        yGap(12),
        Text('¿Qué decisión tomas primero?',
            style: Theme.of(context).textTheme.headlineSmall),
        Text('Selecciona una opción y confirma tu decisión.',
            style: Theme.of(context).textTheme.bodyMedium),
        yGap(11),
        ...choices.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: finished || paused
                  ? null
                  : () => setState(() => choice = e.key),
              borderRadius: BorderRadius.circular(18),
              child: YCard(
                  color: choice == e.key
                      ? YColors.teal.withValues(alpha: .09)
                      : null,
                  child: Row(children: [
                    YIcon(
                        [
                          Icons.monitor_heart_outlined,
                          Icons.badge_outlined,
                          Icons.description_outlined
                        ][e.key],
                        color: [
                          YColors.rose,
                          YColors.blue,
                          YColors.teal
                        ][e.key]),
                    const SizedBox(width: 11),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(e.value.$1,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(e.value.$2,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ])),
                    Icon(
                        choice == e.key
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: choice == e.key ? YColors.teal : YColors.muted),
                  ])),
            ))),
        if (!finished)
          YButton('Confirmar decisión',
              icon: Icons.check_circle_outline,
              onPressed: choice == null || paused ? null : confirm),
        if (finished) ...[
          yGap(9),
          YCard(
              color: YColors.teal.withValues(alpha: .09),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        timedOut
                            ? 'Tiempo finalizado'
                            : choice == 0
                                ? 'Buena priorización'
                                : 'Recomendación de refuerzo',
                        style: Theme.of(context).textTheme.titleLarge),
                    yGap(8),
                    const Text(
                        'Ante un compromiso vital no deben retrasarse las acciones urgentes por trámites administrativos. Corresponde activar ayuda, valorar a la persona y cumplir protocolos institucionales dentro de las competencias profesionales.'),
                    yGap(9),
                    Text('Interrupciones registradas: $interruptions',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ])),
        ],
        yGap(13),
        const YNotice(
            'Caso didáctico ficticio. No sustituye entrenamiento ni procedimientos clínicos de emergencia.'),
      ])),
    );
  }
}
