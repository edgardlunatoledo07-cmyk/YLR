import 'package:flutter/material.dart';
import 'cloud_recovery.dart';
import 'state.dart';
import 'style.dart';

/// Controles manuales para verificar y recuperar la copia de Firestore.
/// No permite acceder al documento de otros usuarios.
class YlrCloudBackupCard extends StatefulWidget {
  const YlrCloudBackupCard({super.key, required this.state});
  final YlrState state;

  @override
  State<YlrCloudBackupCard> createState() => _YlrCloudBackupCardState();
}

class _YlrCloudBackupCardState extends State<YlrCloudBackupCard> {
  bool busy = false;
  String status =
      'El progreso se guarda en este teléfono y se respalda en Firebase.';

  Future<void> _check() async {
    setState(() => busy = true);
    try {
      final remote = await YlrCloudRecovery.readServerBackup();
      if (!mounted) return;
      setState(() {
        if (remote == null) {
          status = 'Aún no hay una copia remota disponible.';
        } else {
          final completed = remote.data['completed'];
          final count = completed is List ? completed.length : 0;
          final date = remote.savedAt?.toLocal();
          final when = date == null
              ? 'fecha desconocida'
              : '${date.day}/${date.month}/${date.year} '
                  '${date.hour.toString().padLeft(2, '0')}:'
                  '${date.minute.toString().padLeft(2, '0')}';
          status = 'Copia encontrada: $count lecciones registradas. '
              'Último respaldo: $when.';
        }
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => status = 'No se pudo consultar la nube: $error');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> _recover() async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Recuperar mi progreso'),
        content: const Text(
          'Se consultará el respaldo de tu cuenta actual. '
          'Las lecciones se unirán sin eliminar las locales. '
          'Los historiales de evaluaciones y simulaciones solo '
          'se ampliarán cuando sean compatibles. '
          'Si se detecta un conflicto, no se modificará nada.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Recuperar'),
          ),
        ],
      ),
    );
    if (approved != true || !mounted) return;

    setState(() => busy = true);
    try {
      final result = await widget.state.recoverFromCloud();
      if (!mounted) return;
      setState(() {
        if (result == null) {
          status = 'No se encontró un respaldo remoto.';
        } else if (result.conflictingHistories) {
          status = 'Se detectaron historiales distintos. '
              'No se alteró el progreso; se requiere revisión antes de fusionar.';
        } else if (!result.changed) {
          status = 'El progreso local ya contiene los datos del respaldo.';
        } else {
          status = 'Recuperado: ${result.completedAdded} lecciones, '
              '${result.scoresAdded} evaluaciones y '
              '${result.simulationsAdded} simulaciones adicionales.';
        }
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => status = 'No se pudo recuperar: $error');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => YCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.cloud_done_outlined, color: YColors.teal),
              const SizedBox(width: 9),
              Expanded(
                child: Text('Mi respaldo en la nube',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ]),
            const SizedBox(height: 8),
            Text(status, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            if (busy) const LinearProgressIndicator(),
            Wrap(spacing: 9, runSpacing: 8, children: [
              OutlinedButton.icon(
                onPressed: busy ? null : _check,
                icon: const Icon(Icons.cloud_outlined),
                label: const Text('Comprobar copia'),
              ),
              FilledButton.icon(
                onPressed: busy ? null : _recover,
                icon: const Icon(Icons.cloud_download_outlined),
                label: const Text('Recuperar progreso'),
              ),
            ]),
            const SizedBox(height: 6),
            Text(
                'Solo tu usuario Firebase actual. '
                'Todavía no recupera cuentas en otro teléfono.',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      );
}
