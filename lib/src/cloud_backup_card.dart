import 'package:flutter/material.dart';

import 'state.dart';
import 'style.dart';
import 'sync_status.dart';

/// Superficie del estado de sincronizacion. La recuperacion en otro
/// telefono vuelve en la etapa del esquema de simulaciones.
class YlrCloudBackupCard extends StatelessWidget {
  const YlrCloudBackupCard({super.key, required this.state});
  final YlrState state;

  String _when(DateTime? date) {
    if (date == null) return 'todavía sin respaldo';
    final local = date.toLocal();
    return '${local.day}/${local.month}/${local.year} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final status = state.syncStatus;
    final (IconData icon, Color color, String title, String detail) =
        switch (status) {
      SyncStatus(phase: SyncPhase.error) => (
          Icons.cloud_off_outlined,
          YColors.rose,
          'No se pudo respaldar',
          'El progreso en este teléfono está a salvo. '
              'Intento ${status.failures} fallido.',
        ),
      SyncStatus(phase: SyncPhase.syncing) => (
          Icons.cloud_upload_outlined,
          YColors.blue,
          'Guardando respaldo',
          'Enviando una copia a la nube.',
        ),
      _ => (
          Icons.cloud_done_outlined,
          YColors.teal,
          'Mi respaldo en la nube',
          'Último respaldo: ${_when(status.lastSuccess)}',
        ),
    };

    return YCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color),
            const SizedBox(width: 9),
            Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ]),
          const SizedBox(height: 8),
          Text(detail, style: Theme.of(context).textTheme.bodyMedium),
          if (status.isError) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: state.retrySync,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
            ),
          ],
          const SizedBox(height: 6),
          Text(
            'Solo tu usuario Firebase actual. Recuperar en otro teléfono '
            'llega en la próxima etapa.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
