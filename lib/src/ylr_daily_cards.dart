import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'style.dart';

/// Tres tarjetas editoriales educativas, sin notificaciones ni datos clínicos.
class YlrDailyLearningCards extends StatelessWidget {
  const YlrDailyLearningCards({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Un concepto cada día',
              style: Theme.of(context).textTheme.titleLarge),
          yGap(10),
          _tile(
              context,
              Icons.lightbulb_outline,
              'CONSEJO DE SEGURIDAD',
              'Los guantes no sustituyen la higiene de manos. Antes y después de una actividad de cuidado, revisa cuándo corresponde higienizarlas.',
              YColors.teal),
          yGap(9),
          _tile(
              context,
              Icons.medical_information_outlined,
              'TÉRMINO DESTACADO',
              'Fibrodisplasia osificante progresiva (FOP): enfermedad genética rara asociada a variantes de ACVR1 que produce formación de hueso fuera del esqueleto y limita la movilidad. No debe confundirse con una lesión muscular común.',
              YColors.lilac),
          yGap(4),
          Padding(
              padding: const EdgeInsets.only(left: 7),
              child: TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(const ClipboardData(
                    text:
                        'https://rarediseases.info.nih.gov/diseases/6445/fibrodysplasia-ossificans-progressiva/',
                  ));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Fuente NIH/GARD copiada para consultar.')),
                    );
                  }
                },
                icon: const Icon(Icons.copy_all_outlined, size: 17),
                label: const Text('Fuente: NIH/GARD · copiar enlace'),
              )),
          yGap(3),
          _tile(
              context,
              Icons.psychology_outlined,
              'MINICASO FICTICIO',
              'Una persona dice que no entiende una explicación recibida. ¿Qué mejora la seguridad? Escucharla y confirmar la comprensión mediante palabras sencillas.',
              YColors.blue),
          yGap(14),
        ],
      );

  Widget _tile(BuildContext context, IconData icon, String label, String body,
          Color color) =>
      YCard(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        YIcon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: .5)),
          yGap(6),
          Text(body, style: Theme.of(context).textTheme.bodyMedium),
        ])),
      ]));
}
