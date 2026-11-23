import 'package:flutter/material.dart';
import 'content.dart';
import 'learning.dart';
import 'state.dart';
import 'cloud_backup_card.dart';
import 'ylr_profile_page.dart';
import 'ylr_daily_cards.dart';
import 'ylr_scenarios.dart';
import 'ylr_scenario_page.dart';
import 'style.dart';

class YlrShell extends StatefulWidget {
  const YlrShell({super.key, required this.state});
  final YlrState state;
  @override
  State<YlrShell> createState() => _YlrShellState();
}

class _YlrShellState extends State<YlrShell> {
  int page = 0;
  void navigate(int next) => setState(() => page = next);
  Route<void> _screenRoute(Widget page) => widget.state.reduceMotion
      ? PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero)
      : MaterialPageRoute<void>(builder: (_) => page);
  void openLesson(Lesson lesson) => Navigator.of(context).push(_screenRoute(
      LessonScreen(lesson: lesson, state: widget.state, onQuiz: openQuiz)));
  void openQuiz() =>
      Navigator.of(context).push(_screenRoute(QuizScreen(state: widget.state)));
  void openScenario(YlrScenario scenario) => Navigator.of(context).push(
      _screenRoute(YlrScenarioPage(scenario: scenario, state: widget.state)));
  void openSim(bool pressure) => Navigator.of(context).push(
      _screenRoute(SimulationScreen(state: widget.state, pressure: pressure)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        _header(),
        Expanded(
            child: IndexedStack(index: page, children: [
          _home(),
          LibraryPage(onLesson: openLesson, state: widget.state),
          _practice(),
          _progress(),
          const GlossaryPage(),
          _settings(),
          page == 6
              ? YlrProfilePage(
                  state: widget.state,
                  onSettings: () => navigate(5),
                  onHome: () => navigate(0),
                )
              : const SizedBox.shrink(),
        ])),
      ])),
      bottomNavigationBar: NavigationBar(
        height: 74,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedIndex: page >= 5 ? 0 : page,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: navigate,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Inicio'),
          NavigationDestination(
              icon: Icon(Icons.school_outlined),
              selectedIcon: Icon(Icons.school),
              label: 'Aprender'),
          NavigationDestination(
              icon: Icon(Icons.medical_services_outlined),
              selectedIcon: Icon(Icons.health_and_safety),
              label: 'Practicar'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart_rounded),
              label: 'Progreso'),
          NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book_rounded),
              label: 'Glosario'),
        ],
      ),
    );
  }

  Widget _header() {
    final route = widget.state.route!;
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 7, 12, 9),
        child: Row(children: [
          const Icon(Icons.favorite_rounded, color: YColors.teal, size: 28),
          const SizedBox(width: 5),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Y.LR',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 24, letterSpacing: -1)),
            const Text('APRENDER HOY',
                style: TextStyle(
                    fontSize: 7,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w700,
                    color: YColors.muted)),
          ]),
          const Spacer(),
          PopupMenuButton<RouteKind>(
            tooltip: 'Cambiar ruta educativa',
            onSelected: widget.state.chooseRoute,
            itemBuilder: (_) => RouteKind.values
                .map((r) => PopupMenuItem(value: r, child: Text(r.label)))
                .toList(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              decoration: BoxDecoration(
                  color: YColors.teal.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.medical_services_outlined,
                    color: YColors.blue, size: 17),
                const SizedBox(width: 5),
                Text(route.label,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: YColors.blue)),
                const Icon(Icons.expand_more_rounded,
                    color: YColors.blue, size: 15),
              ]),
            ),
          ),
          InkWell(
            onTap: () => navigate(6),
            borderRadius: BorderRadius.circular(24),
            child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE3EEFA),
                child:
                    Icon(Icons.person_outline, size: 20, color: YColors.blue)),
          ),
        ]));
  }

  Widget _scroller(List<Widget> content) => ListView(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 24), children: content);

  Widget _home() {
    final completed = widget.state.completedForRoute;
    final suggested = lessons.firstWhere((l) => !widget.state.lessonDone(l.id),
        orElse: () => lessons.first);
    return _scroller([
      YTitle('¡Hola! Sigamos aprendiendo',
          subtitle:
              'Tu espacio para aprender, practicar y explorar a tu ritmo.'),
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text('Bienvenido/a, ${widget.state.displayName}',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF066596), Color(0xFF13A0B5)]),
            borderRadius: BorderRadius.circular(22)),
        padding: const EdgeInsets.all(19),
        child: Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const YBadge('CONTINÚA TU APRENDIZAJE', color: Colors.white),
                yGap(11),
                Text(suggested.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        height: 1.12)),
                yGap(8),
                const Text('Lectura, recursos y práctica educativa.',
                    style: TextStyle(color: Color(0xFFE9FAFF), fontSize: 12.5)),
                yGap(13),
                FilledButton.tonal(
                    onPressed: () => openLesson(suggested),
                    child: const Text('Continuar  →')),
              ])),
          const SizedBox(width: 8),
          const Icon(Icons.monitor_heart_outlined,
              size: 78, color: Color(0xFFC9F2F5)),
        ]),
      ),
      yGap(21),
      Row(children: [
        Expanded(
            child: Text('Explora por áreas',
                style: Theme.of(context).textTheme.titleLarge)),
        TextButton(
            onPressed: () => navigate(1), child: const Text('Ver todas  ›')),
      ]),
      SizedBox(
          height: 116,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            _topic('Anatomía', Icons.air_rounded, YColors.rose),
            _topic(
                'Signos vitales', Icons.monitor_heart_outlined, YColors.blue),
            _topic('Bioseguridad', Icons.shield_outlined, YColors.teal),
            _topic(
                'Urgencias', Icons.emergency_outlined, const Color(0xFFFF8A3D)),
            _topic('Ética', Icons.balance_outlined, YColors.lilac),
            _topic(
                'Cuidados', Icons.medical_information_outlined, YColors.blue),
          ])),
      yGap(17),
      const YlrDailyLearningCards(),
      YCard(
          child: Row(children: [
        const YIcon(Icons.show_chart_rounded, color: YColors.teal),
        const SizedBox(width: 13),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Mi progreso · ${widget.state.route!.label}',
              style: Theme.of(context).textTheme.titleMedium),
          Text('$completed de ${lessons.length} lecciones completadas',
              style: Theme.of(context).textTheme.bodyMedium),
          yGap(8),
          LinearProgressIndicator(
              value: completed / lessons.length,
              minHeight: 7,
              borderRadius: BorderRadius.circular(9),
              color: YColors.teal,
              backgroundColor: const Color(0xFFE0E9F0)),
        ])),
        IconButton(
            onPressed: () => navigate(3),
            icon: const Icon(Icons.chevron_right_rounded)),
      ])),
      yGap(13),
      if (!widget.state.simple) ...[
        Row(children: [
          Expanded(
              child: Text('Accesos rápidos',
                  style: Theme.of(context).textTheme.titleLarge))
        ]),
        yGap(11),
        Row(children: [
          Expanded(
              child: _quick('Evaluaciones', '16 preguntas por ruta',
                  Icons.fact_check_outlined, YColors.lilac, openQuiz)),
          const SizedBox(width: 10),
          Expanded(
              child: _quick('Bajo presión', 'Caso interactivo',
                  Icons.timer_outlined, YColors.rose, () => openSim(true))),
        ]),
      ],
      yGap(10),
      const YNotice(
          'Contenido formativo en revisión. No usar como guía de atención clínica ni como certificación.'),
    ]);
  }

  Widget _topic(String label, IconData icon, Color color) => Padding(
        padding: const EdgeInsets.only(right: 9),
        child: SizedBox(
            width: 99,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => navigate(1),
              child: YCard(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        YIcon(icon, color: color),
                        const SizedBox(height: 9),
                        Text(label,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ])),
            )),
      );

  Widget _quick(String label, String subtitle, IconData icon, Color color,
          VoidCallback action) =>
      InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(19),
        child: YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          YIcon(icon, color: color),
          yGap(11),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ])),
      );

  Widget _practice() => _scroller([
        const YTitle('Practicar',
            subtitle:
                'Pon a prueba tus conocimientos con retroalimentación educativa.'),
        _actionCard(
            'Evaluación de conocimientos',
            '16 preguntas por ruta con retroalimentación',
            Icons.fact_check_outlined,
            YColors.lilac,
            openQuiz),
        yGap(12),
        _actionCard(
            'Análisis de decisiones',
            'Caso interactivo sin límite de tiempo',
            Icons.psychology_alt_outlined,
            YColors.teal,
            () => openSim(false)),
        yGap(12),
        _actionCard(
            'Bajo presión',
            'Caso interactivo con cronómetro y resultado',
            Icons.timer_outlined,
            YColors.rose,
            () => openSim(true)),
        yGap(17),
        Text('Casos para resolver',
            style: Theme.of(context).textTheme.titleLarge),
        yGap(7),
        Text(
            'Dos decisiones por caso, con explicación y registro de resultados.',
            style: Theme.of(context).textTheme.bodyMedium),
        yGap(10),
        ...ylrScenarios.map((scenario) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _actionCard(
                  scenario.title,
                  scenario.summary,
                  Icons.psychology_alt_outlined,
                  YColors.teal,
                  () => openScenario(scenario)),
            )),
        yGap(10),
        const YNotice(
            'Estas simulaciones son situaciones ficticias para aprender. No habilitan ni acreditan competencias clínicas.'),
      ]);

  Widget _actionCard(String title, String subtitle, IconData icon, Color color,
          VoidCallback onTap) =>
      InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: YCard(
              child: Row(children: [
            YIcon(icon, color: color, size: 28),
            const SizedBox(width: 13),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ])),
            const Icon(Icons.chevron_right_rounded, color: YColors.blue),
          ])));

  Widget _progress() {
    final done = widget.state.completedForRoute;
    final scores = widget.state.scoresForRoute;
    final percent = (100 * done / lessons.length).round();
    return _scroller([
      YTitle('Mi progreso',
          subtitle:
              'Avance real de tu ruta ${widget.state.route!.label} en este dispositivo.'),
      YlrCloudBackupCard(state: widget.state),
      yGap(12),
      YCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Tu progreso en la ruta ${widget.state.route!.label}',
            style: Theme.of(context).textTheme.titleMedium),
        yGap(16),
        Row(children: [
          SizedBox(
              width: 122,
              height: 122,
              child: Stack(alignment: Alignment.center, children: [
                SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                        value: done / lessons.length,
                        strokeWidth: 12,
                        strokeCap: StrokeCap.round,
                        color: YColors.teal,
                        backgroundColor: const Color(0xFFE0E7EF))),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('$percent%',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 28)),
                  const Text('Completado',
                      style: TextStyle(fontSize: 11, color: YColors.muted)),
                ]),
              ])),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('$done de ${lessons.length}',
                    style: Theme.of(context).textTheme.headlineSmall),
                const Text('lecciones completadas',
                    style: TextStyle(fontSize: 12)),
                yGap(11),
                LinearProgressIndicator(
                    value: done / lessons.length,
                    minHeight: 8,
                    color: YColors.teal,
                    backgroundColor: const Color(0xFFE0E7EF),
                    borderRadius: BorderRadius.circular(9)),
                yGap(8),
                const Text('¡Cada lección cuenta!',
                    style: TextStyle(fontSize: 12, color: YColors.blue)),
              ])),
        ]),
      ])),
      yGap(12),
      Row(children: [
        Expanded(
            child: _metric('${widget.state.completedForRoute}', 'Lecciones',
                Icons.menu_book_outlined, YColors.blue)),
        const SizedBox(width: 8),
        Expanded(
            child: _metric(
                widget.state.bestScore == null
                    ? '—'
                    : '${widget.state.bestScore}%',
                'Mejor evaluación',
                Icons.emoji_events_outlined,
                YColors.teal)),
        const SizedBox(width: 8),
        Expanded(
            child: _metric('${widget.state.simulationCount}', 'Simulaciones',
                Icons.timer_outlined, YColors.lilac)),
      ]),
      yGap(14),
      Text('Evaluaciones', style: Theme.of(context).textTheme.titleLarge),
      yGap(10),
      YCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
            scores.isEmpty
                ? 'Todavía no hay resultados'
                : '${scores.length} intento(s) registrado(s)',
            style: Theme.of(context).textTheme.titleMedium),
        yGap(8),
        Text(
            scores.isEmpty
                ? 'Completa la evaluación para ver tu desempeño.'
                : 'Última puntuación: ${scores.last}% · Mejor: ${widget.state.bestScore}%',
            style: Theme.of(context).textTheme.bodyMedium),
        yGap(9),
        OutlinedButton(
            onPressed: openQuiz, child: const Text('Practicar evaluación')),
      ])),
      yGap(14),
      Text('Te recomendamos', style: Theme.of(context).textTheme.titleLarge),
      yGap(10),
      _actionCard(
          'Reforzar conceptos',
          'Vuelve a revisar higiene de manos, signos vitales y seguridad.',
          Icons.lightbulb_outline_rounded,
          YColors.teal,
          () => navigate(1)),
      yGap(16),
      const YNotice(
          'El historial se guarda en este dispositivo y se respalda en Firebase cuando hay sesión y conexión. No se han registrado horas de estudio ni estadísticas clínicas externas.'),
    ]);
  }

  Widget _metric(String value, String label, IconData icon, Color color) =>
      YCard(
        padding: const EdgeInsets.all(11),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 22, color: color),
          yGap(8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          Text(label,
              style: const TextStyle(fontSize: 10.5, color: YColors.muted),
              maxLines: 2),
        ]),
      );

  Widget _settings() => _scroller([
        _back('Accesibilidad'),
        const YTitle('Accesibilidad',
            subtitle:
                'Personaliza la experiencia para un aprendizaje más cómodo.'),
        YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Apariencia', style: Theme.of(context).textTheme.titleLarge),
          SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Modo oscuro'),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: widget.state.dark,
              onChanged: widget.state.setDark),
        ])),
        yGap(12),
        YCard(
            child: Column(children: [
          SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Texto grande'),
              subtitle: const Text('Aumentar tamaño del texto en la app'),
              value: widget.state.large,
              onChanged: widget.state.setLarge),
          const Divider(),
          SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Contraste reforzado'),
              subtitle: const Text('Bordes y controles más destacados'),
              value: widget.state.contrast,
              onChanged: widget.state.setContrast),
          const Divider(),
          SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Presentación simplificada'),
              subtitle: const Text('Ocultar bloques secundarios de inicio'),
              value: widget.state.simple,
              onChanged: widget.state.setSimple),
          const Divider(),
          SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reducir animaciones'),
              subtitle:
                  const Text('Preferir transiciones sin efectos prolongados'),
              value: widget.state.reduceMotion,
              onChanged: widget.state.setReduceMotion),
        ])),
        yGap(12),
        YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Tiempo en simulaciones',
              style: Theme.of(context).textTheme.titleMedium),
          RadioGroup<int>(
              groupValue: widget.state.timerMode,
              onChanged: (v) {
                if (v != null) widget.state.setTimerMode(v);
              },
              child: Column(
                  children: [
                'Estándar · 60 segundos',
                'Ampliado · 120 segundos',
                'Sin temporizador'
              ]
                      .asMap()
                      .entries
                      .map((e) => RadioListTile<int>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(e.value),
                          value: e.key))
                      .toList())),
        ])),
        yGap(12),
        YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Ruta educativa',
              style: Theme.of(context).textTheme.titleMedium),
          RadioGroup<RouteKind>(
              groupValue: widget.state.route,
              onChanged: (v) {
                if (v != null) widget.state.chooseRoute(v);
              },
              child: Column(
                  children: RouteKind.values
                      .map((r) => RadioListTile<RouteKind>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(r.label),
                          value: r))
                      .toList())),
        ])),
        yGap(12),
        const YNotice(
            'Preferencias, apodo y avatar guardados localmente. El progreso se respalda con tu usuario anónimo de Firebase cuando hay conexión. El código de participante no recupera una cuenta en otro teléfono.'),
      ]);

  Widget _back(String title) => Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
          onPressed: () => navigate(0),
          icon: const Icon(Icons.chevron_left),
          label: Text('Volver · $title')));
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key, required this.onLesson, required this.state});
  final void Function(Lesson) onLesson;
  final YlrState state;
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String search = '';
  String category = 'Todos';
  bool onlyPending = false;
  @override
  Widget build(BuildContext context) {
    final found = lessons
        .where((l) =>
            (category == 'Todos' || l.category == category) &&
            (!onlyPending || !widget.state.lessonDone(l.id)) &&
            '${l.title} ${l.category} ${l.objective}'
                .toLowerCase()
                .contains(search.trim().toLowerCase()))
        .toList();
    return ListView(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 24),
        children: [
          const YTitle('Biblioteca educativa',
              subtitle: 'Explora temas, fundamentos y recursos para tu ruta.'),
          TextField(
              decoration: const InputDecoration(
                  hintText: 'Buscar en la biblioteca...',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (v) => setState(() => search = v)),
          yGap(12),
          SizedBox(
              height: 43,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: topicCategories
                      .map((c) => Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: ChoiceChip(
                              label: Text(c),
                              selected: c == category,
                              onSelected: (_) => setState(() => category = c))))
                      .toList())),
          yGap(12),
          Row(children: [
            Expanded(
                child: Text(
                    '${found.length} lecciones · ${widget.state.completedForRoute} completadas en esta ruta',
                    style: Theme.of(context).textTheme.bodyMedium)),
            FilterChip(
              label: const Text('Pendientes'),
              selected: onlyPending,
              onSelected: (v) => setState(() => onlyPending = v),
            ),
          ]),
          yGap(10),
          if (found.isEmpty)
            const YNotice('No se encontraron lecciones con esos filtros.'),
          ...found.map((l) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => widget.onLesson(l),
                borderRadius: BorderRadius.circular(19),
                child: YCard(
                    child: Row(children: [
                  YIcon(_categoryIcon(l.category),
                      color: _categoryColor(l.category)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(l.title,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 3),
                        Text(l.category,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ])),
                  if (widget.state.lessonDone(l.id))
                    const Icon(Icons.check_circle_rounded, color: YColors.teal)
                  else
                    const Icon(Icons.chevron_right, color: YColors.blue),
                ])),
              ))),
          const YNotice(
              'Material educativo ampliado para pilotaje. Requiere validación docente y revisión de protocolos chilenos antes de uso curricular formal.'),
        ]);
  }
}

IconData _categoryIcon(String c) => switch (c) {
      'Anatomía' => Icons.air,
      'Signos vitales' => Icons.monitor_heart_outlined,
      'Bioseguridad' => Icons.shield_outlined,
      'Urgencias' => Icons.emergency_outlined,
      'Seguridad' => Icons.verified_user_outlined,
      'Ética' => Icons.balance,
      _ => Icons.health_and_safety_outlined,
    };
Color _categoryColor(String c) => switch (c) {
      'Anatomía' => YColors.rose,
      'Signos vitales' => YColors.blue,
      'Bioseguridad' => YColors.teal,
      'Urgencias' => const Color(0xFFEA7A39),
      'Ética' => YColors.lilac,
      _ => YColors.blue,
    };

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key});
  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}

class _GlossaryPageState extends State<GlossaryPage> {
  String search = '';
  String group = 'A-Z';
  @override
  Widget build(BuildContext context) {
    final found = glossary.entries
        .where((e) =>
            '${e.key} ${e.value}'
                .toLowerCase()
                .contains(search.trim().toLowerCase()) &&
            (group == 'A-Z' ||
                (group == 'Signos vitales' &&
                    [
                      'Bradicardia',
                      'Diástole',
                      'Frecuencia cardíaca',
                      'Frecuencia respiratoria',
                      'Hipertensión',
                      'Hipotensión',
                      'Presión arterial',
                      'Pulso',
                      'Saturación de oxígeno',
                      'Sístole',
                      'Taquicardia',
                      'Taquipnea'
                    ].contains(e.key)) ||
                (group == 'Bioseguridad' &&
                    ['Asepsia', 'Bioseguridad', 'Infección'].contains(e.key)) ||
                (group == 'Urgencias' &&
                    ['Cianosis', 'Disnea', 'Sepsis'].contains(e.key))))
        .toList();
    return ListView(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 24),
        children: [
          const YTitle('Glosario',
              subtitle: 'Términos clave para tu aprendizaje en salud.'),
          TextField(
              decoration: const InputDecoration(
                  hintText: 'Buscar en el glosario...',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (v) => setState(() => search = v)),
          yGap(11),
          SizedBox(
              height: 42,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    'A-Z',
                    'Bioseguridad',
                    'Signos vitales',
                    'Urgencias'
                  ]
                      .map((g) => Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: ChoiceChip(
                              label: Text(g),
                              selected: g == group,
                              onSelected: (_) => setState(() => group = g))))
                      .toList())),
          yGap(9),
          if (found.isEmpty) const YNotice('No se encontraron términos.'),
          ...found.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: YCard(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      const YIcon(Icons.menu_book_outlined,
                          color: YColors.lilac),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(e.key,
                              style: Theme.of(context).textTheme.titleLarge)),
                      IconButton(
                          tooltip: 'Definición rápida',
                          icon: const Icon(Icons.open_in_new, size: 18),
                          onPressed: () => _definition(e.key, e.value)),
                    ]),
                    yGap(8),
                    Text(e.value,
                        style: Theme.of(context).textTheme.bodyMedium),
                    yGap(8),
                    TextButton.icon(
                        onPressed: () => _definition(e.key, e.value),
                        icon: const Icon(Icons.article_outlined),
                        label: const Text('Ver definición completa')),
                  ])))),
        ]);
  }

  void _definition(String title, String definition) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(23),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const YBadge('DEFINICIÓN RÁPIDA'),
                      yGap(12),
                      Text(title,
                          style: Theme.of(context).textTheme.headlineSmall),
                      yGap(10),
                      Text(definition,
                          style: Theme.of(context).textTheme.bodyMedium),
                      yGap(18),
                      const YNotice(
                          'Definición educativa introductoria, sujeta a revisión académica.'),
                      yGap(12),
                      YButton('Volver al glosario',
                          icon: Icons.arrow_back,
                          onPressed: () => Navigator.pop(context)),
                    ]))),
      );
}
