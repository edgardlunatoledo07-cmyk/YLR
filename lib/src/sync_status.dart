enum SyncPhase { idle, syncing, error }

/// Estado visible de la sincronizacion. Sin esto, un fallo de red
/// queda solo en el log y el usuario nunca se entera.
class SyncStatus {
  SyncStatus.idle({this.lastSuccess})
      : phase = SyncPhase.idle,
        failures = 0,
        detail = null;

  SyncStatus.syncing()
      : phase = SyncPhase.syncing,
        failures = 0,
        detail = null,
        lastSuccess = null;

  SyncStatus.error({required this.failures, required this.detail})
      : phase = SyncPhase.error,
        lastSuccess = null;

  final SyncPhase phase;
  final int failures;
  final String? detail;
  final DateTime? lastSuccess;

  bool get isError => phase == SyncPhase.error;
  bool get isBusy => phase == SyncPhase.syncing;
}
