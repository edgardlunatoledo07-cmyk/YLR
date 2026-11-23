import 'package:flutter/material.dart';

import 'state.dart';
import 'style.dart';
import 'ylr_scenarios.dart';

/// Escenarios breves de dos decisiones; resultados locales y respaldo en nube.
class YlrScenarioPage extends StatefulWidget {
  const YlrScenarioPage(
      {super.key, required this.scenario, required this.state});
  final YlrScenario scenario;
  final YlrState state;

  @override
  State<YlrScenarioPage> createState() => _YlrScenarioPageState();
}

class _YlrScenarioPageState extends State<YlrScenarioPage> {
  int step = 0;
  int? picked;
  bool checked = false;
  bool finished = false;
  int correct = 0;

  void check() {
    if (picked == null || checked) return;
    setState(() {
      checked = true;
      if (picked == widget.scenario.steps[step].correct) correct++;
    });
  }

  void next() {
    if (step + 1 >= widget.scenario.steps.length) {
      final total = widget.scenario.steps.length;
      widget.state.addSimulation('caso-${widget.scenario.id}:$correct/$total');
      setState(() => finished = true);
    } else {
      setState(() {
        step++;
        checked = false;
        picked = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scenario = widget.scenario;
    final question = scenario.steps[step];
    return Scaffold(
      appBar: AppBar(title: Text(scenario.title)),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          YBadge(scenario.level),
          yGap(10),
          Text(scenario.title,
              style: Theme.of(context).textTheme.headlineLarge),
          yGap(6),
          Text(scenario.summary, style: Theme.of(context).textTheme.bodyMedium),
          yGap(16),
          if (finished) ...[
            YCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Icon(Icons.verified_outlined,
                      size: 45, color: YColors.teal),
                  yGap(9),
                  Text('Escenario finalizado',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(
                      'Decisiones correctas: $correct de ${scenario.steps.length}'),
                  yGap(8),
                  const Text(
                      'Resultado guardado. Puedes volver a practicar cuando quieras.'),
                  yGap(13),
                  FilledButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver a practicar')),
                ])),
          ] else ...[
            LinearProgressIndicator(
                value: (step + 1) / scenario.steps.length,
                minHeight: 7,
                color: YColors.teal),
            yGap(9),
            Text('Decisión ${step + 1} de ${scenario.steps.length}',
                style: Theme.of(context).textTheme.titleSmall),
            yGap(12),
            YCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(question.prompt,
                      style: Theme.of(context).textTheme.titleLarge),
                  yGap(10),
                  RadioGroup<int>(
                    groupValue: picked,
                    onChanged: (v) {
                      if (!checked) {
                        setState(() {
                          picked = v;
                        });
                      }
                    },
                    child: Column(children: [
                      for (var i = 0; i < question.answers.length; i++)
                        RadioListTile<int>(
                          title: Text(question.answers[i]),
                          value: i,
                          contentPadding: EdgeInsets.zero,
                        ),
                    ]),
                  ),
                  if (checked) ...[
                    yGap(12),
                    YNotice(question.explanation,
                        icon: Icons.lightbulb_outline),
                    yGap(12),
                  ],
                  if (!checked)
                    FilledButton(
                        onPressed: picked == null ? null : check,
                        child: const Text('Confirmar decisión'))
                  else
                    FilledButton.icon(
                        onPressed: next,
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(step + 1 == scenario.steps.length
                            ? 'Terminar'
                            : 'Siguiente')),
                ])),
          ],
          yGap(15),
          const YNotice(
              'Simulación ficticia para aprendizaje. No instruye intervenciones fuera del rol ni certifica competencias.'),
        ],
      )),
    );
  }
}
