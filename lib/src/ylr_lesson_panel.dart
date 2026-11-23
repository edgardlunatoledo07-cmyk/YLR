import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'content.dart';
import 'style.dart';
import 'ylr_lesson_details.dart';

/// Ampliación editorial reutilizable para toda la biblioteca educativa.
class YlrLessonPanel extends StatelessWidget {
  const YlrLessonPanel(
      {super.key, required this.lessonId, required this.route});
  final String lessonId;
  final RouteKind route;

  @override
  Widget build(BuildContext context) {
    final item = ylrLessonDetails[lessonId];
    if (item == null) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Explicación y fundamentos',
          style: Theme.of(context).textTheme.titleLarge),
      yGap(8),
      Text(item.summary,
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55)),
      yGap(12),
      YCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Puntos esenciales',
            style: Theme.of(context).textTheme.titleMedium),
        yGap(8),
        ...item.points.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.check_circle_outline,
                    color: YColors.teal, size: 20),
                const SizedBox(width: 9),
                Expanded(
                    child:
                        Text(p, style: Theme.of(context).textTheme.bodyMedium)),
              ]),
            )),
      ])),
      yGap(11),
      YCard(
          color: YColors.blue.withValues(alpha: .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.school_outlined, color: YColors.blue),
                const SizedBox(width: 8),
                Expanded(
                    child: Text('Enfoque · ${route.label}',
                        style: Theme.of(context).textTheme.titleMedium)),
              ]),
              yGap(8),
              Text(item.focusFor(route),
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          )),
      yGap(11),
      YCard(
          child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 11),
        leading: const Icon(Icons.psychology_outlined, color: YColors.lilac),
        title: Text('Caso para reflexionar',
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(item.caseQuestion,
            style: Theme.of(context).textTheme.bodyMedium),
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Respuesta orientativa: ${item.caseAnswer}',
                style: Theme.of(context).textTheme.bodyMedium,
              )),
        ],
      )),
      yGap(10),
      YNotice(item.safety, icon: Icons.health_and_safety_outlined),
      yGap(13),
    ]);
  }
}

/// Fuentes mostradas en Recursos, sin requerir plugins de navegación.
class YlrLessonBibliography extends StatelessWidget {
  const YlrLessonBibliography({super.key, required this.lessonId});
  final String lessonId;

  @override
  Widget build(BuildContext context) {
    final item = ylrLessonDetails[lessonId];
    if (item == null) return const SizedBox.shrink();
    return YCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.library_books_outlined, color: YColors.teal),
        const SizedBox(width: 8),
        Expanded(
            child: Text('Fuente para profundizar',
                style: Theme.of(context).textTheme.titleMedium)),
      ]),
      yGap(9),
      Text(item.sourceTitle, style: Theme.of(context).textTheme.bodyMedium),
      yGap(6),
      SelectableText(item.sourceUrl,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: YColors.blue)),
      yGap(9),
      OutlinedButton.icon(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: item.sourceUrl));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Enlace copiado. Puedes abrirlo en tu navegador.')),
            );
          }
        },
        icon: const Icon(Icons.copy_outlined),
        label: const Text('Copiar referencia'),
      ),
      Text(
          'Material educativo adaptado para Y.LR. Pendiente de revisión por un docente clínico y de adecuación a protocolos chilenos.',
          style: Theme.of(context).textTheme.bodySmall),
    ]));
  }
}
