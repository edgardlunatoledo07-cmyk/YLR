import 'dart:async';

import 'sync_status.dart';

typedef SyncWriter = Future<void> Function(Map<String, dynamic> payload);

/// Serializa las escrituras de respaldo.
///
/// Dos garantias: nunca hay dos escrituras en curso, y solo sobrevive el
/// payload mas reciente. Una escritura lenta no puede pisar un estado nuevo.
class YlrSyncQueue {
  YlrSyncQueue({
    required SyncWriter writer,
    required void Function(SyncStatus status) onStatus,
    this.retryBase = const Duration(seconds: 2),
    this.retryMax = const Duration(seconds: 30),
  })  : _writer = writer,
        _onStatus = onStatus;

  final SyncWriter _writer;
  final void Function(SyncStatus status) _onStatus;
  final Duration retryBase;
  final Duration retryMax;

  Map<String, dynamic>? _pending;
  bool _running = false;
  bool _ready = false;
  bool _disposed = false;
  int _failures = 0;
  int _epoch = 0;
  Timer? _retry;
  DateTime? _lastSuccess;

  DateTime? get lastSuccess => _lastSuccess;
  bool get hasPending => _pending != null;
  bool get isReady => _ready;

  /// Se llama cuando el documento ya existe y se puede escribir.
  void markReady() {
    if (_disposed) return;
    _ready = true;
    _failures = 0;
    _retry?.cancel();
    _pump();
  }

  void submit(Map<String, dynamic> payload) {
    if (_disposed) return;
    _pending = payload;
    _retry?.cancel();
    _pump();
  }

  /// Reintento manual desde la interfaz.
  void retryNow() {
    if (_disposed || !_ready) return;
    _failures = 0;
    _retry?.cancel();
    _pump();
  }

  /// Cambio de identidad: descarta lo pendiente y cierra la compuerta
  /// hasta que el documento de la cuenta nueva este preparado.
  void invalidate() {
    if (_disposed) return;
    _epoch++;
    _ready = false;
    _pending = null;
    _failures = 0;
    _retry?.cancel();
  }

  void dispose() {
    _disposed = true;
    _retry?.cancel();
    _pending = null;
  }

  Future<void> _pump() async {
    if (_disposed || _running || !_ready) return;
    final payload = _pending;
    if (payload == null) return;

    final epoch = _epoch;
    _running = true;
    _pending = null;
    _onStatus(SyncStatus.syncing());

    try {
      await _writer(payload);
      if (_disposed || epoch != _epoch) return;
      _failures = 0;
      _lastSuccess = DateTime.now();
      if (_pending == null) {
        _onStatus(SyncStatus.idle(lastSuccess: _lastSuccess));
      }
    } catch (error) {
      if (_disposed || epoch != _epoch) return;
      // Solo se recupera el payload fallido si no hay uno mas nuevo.
      _pending ??= payload;
      _failures++;
      _onStatus(SyncStatus.error(
        failures: _failures,
        detail: error.toString(),
      ));
      _scheduleRetry();
    } finally {
      _running = false;
      // Bombea si la compuerta volvio a abrir, sin importar la epoca:
      // el payload pendiente ya es de la sesion nueva.
      if (!_disposed && _ready && _pending != null && _failures == 0) {
        _pump();
      }
    }
  }

  void _scheduleRetry() {
    _retry?.cancel();
    final wait = retryBase * _failures;
    _retry = Timer(wait > retryMax ? retryMax : wait, () {
      if (_disposed) return;
      _pump();
    });
  }
}
