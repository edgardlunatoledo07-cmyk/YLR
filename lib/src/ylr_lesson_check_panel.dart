import 'package:flutter/material.dart';
import 'style.dart';
import 'ylr_lesson_checks.dart';

/// Actividad autocorregida de una lección. Los errores ofrecen retroalimentación;
/// la aprobación registra el avance a través de YlrState.
class YlrLessonCheckPanel extends StatefulWidget {
  const YlrLessonCheckPanel({
    super.key,
    required this.lessonId,
    required this.onPassed,
  });
  final String lessonId;
  final VoidCallback onPassed;

  @override
  State<YlrLessonCheckPanel> createState() => _YlrLessonCheckPanelState();
}

class _YlrLessonCheckPanelState extends State<YlrLessonCheckPanel> {
  int? selected;
  bool checked = false;
  bool recorded = false;

  @override
  Widget build(BuildContext context) {
    final item = ylrLessonChecks[widget.lessonId];
    if (item == null) return const SizedBox.shrink();
    final passed = selected == item.correctIndex;
    return YCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comprobación de aprendizaje',
            style: Theme.of(context).textTheme.titleLarge),
        yGap(7),
        Text(item.prompt, style: Theme.of(context).textTheme.bodyMedium),
        yGap(11),
        for (var i = 0; i < item.options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: InkWell(
              onTap: checked ? null : () => setState(() => selected = i),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: selected == i ? YColors.teal : YColors.border,
                      width: selected == i ? 2 : 1),
                  color: selected == i
                      ? YColors.teal.withValues(alpha: .08)
                      : Theme.of(context).colorScheme.surface,
                ),
                child: Row(children: [
                  Icon(
                      selected == i
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: selected == i ? YColors.teal : YColors.muted),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item.options[i])),
                ]),
              ),
            ),
          ),
        if (checked) ...[
          yGap(6),
          YNotice(
              passed
                  ? '¡Bien! ${item.explanation}'
                  : 'Revisa el razonamiento: ${item.explanation}',
              icon: passed
                  ? Icons.check_circle_outline
                  : Icons.lightbulb_outline),
          yGap(8),
        ],
        if (!checked)
          FilledButton.icon(
            onPressed: selected == null
                ? null
                : () {
                    setState(() => checked = true);
                    if (passed && !recorded) {
                      recorded = true;
                      widget.onPassed();
                    }
                  },
            icon: const Icon(Icons.fact_check_outlined),
            label: const Text('Comprobar respuesta'),
          )
        else if (!passed)
          OutlinedButton.icon(
            onPressed: () => setState(() {
              selected = null;
              checked = false;
            }),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Volver a intentar'),
          )
        else
          const Text('Actividad aprobada y guardada en tu progreso.'),
      ],
    ));
  }
}
