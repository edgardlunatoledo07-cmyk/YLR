import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:app_enfermeria/src/sync_queue.dart';
import 'package:app_enfermeria/src/sync_status.dart';

/// Escritor controlable: cada llamada queda pendiente hasta que se libera.
class _Writer {
  final List<Map<String, dynamic>> received = [];
  final List<Completer<void>> pending = [];

  Future<void> call(Map<String, dynamic> payload) {
    received.add(payload);
    final completer = Completer<void>();
    pending.add(completer);
    return completer.future;
  }

  void complete(int index, {bool fail = false}) {
    final completer = pending[index];
    if (fail) {
      completer.completeError(StateError('sin red'));
    } else {
      completer.complete();
    }
  }
}

void main() {
  late _Writer writer;
  late List<SyncStatus> statuses;
  late YlrSyncQueue queue;

  setUp(() {
    writer = _Writer();
    statuses = [];
    queue = YlrSyncQueue(
      writer: writer.call,
      onStatus: statuses.add,
      retryBase: const Duration(milliseconds: 10),
      retryMax: const Duration(milliseconds: 20),
    );
  });

  tearDown(() => queue.dispose());

  test('no escribe antes de markReady', () async {
    queue.submit({'v': 1});
    await Future<void>.delayed(Duration.zero);
    expect(writer.received, isEmpty);

    queue.markReady();
    await Future<void>.delayed(Duration.zero);
    expect(writer.received.length, 1);
  });

  test('no hay dos escrituras simultaneas', () async {
    queue.markReady();
    queue.submit({'v': 1});
    queue.submit({'v': 2});
    queue.submit({'v': 3});
    await Future<void>.delayed(Duration.zero);

    expect(writer.received.length, 1, reason: 'solo la primera arranca');

    writer.complete(0);
    await Future<void>.delayed(Duration.zero);
    expect(writer.received.length, 2);
    expect(writer.received.last, {'v': 3}, reason: 'el intermedio se descarta');
  });

  test('un payload nuevo durante una escritura lenta gana', () async {
    queue.markReady();
    queue.submit({'v': 'viejo'});
    await Future<void>.delayed(Duration.zero);

    queue.submit({'v': 'nuevo'});
    writer.complete(0);
    await Future<void>.delayed(Duration.zero);
    writer.complete(1);
    await Future<void>.delayed(Duration.zero);

    expect(writer.received.last, {'v': 'nuevo'});
    expect(queue.hasPending, isFalse);
  });

  test('el payload fallido se conserva y se reintenta', () async {
    queue.markReady();
    queue.submit({'v': 'unico'});
    await Future<void>.delayed(Duration.zero);

    writer.complete(0, fail: true);
    await Future<void>.delayed(const Duration(milliseconds: 40));

    expect(statuses.last.isError, isFalse, reason: 'el reintento ya corrio');
    expect(writer.received.length, 2);
    expect(writer.received.last, {'v': 'unico'});
  });

  test('un payload nuevo desplaza al fallido', () async {
    queue.markReady();
    queue.submit({'v': 'viejo'});
    await Future<void>.delayed(Duration.zero);

    writer.complete(0, fail: true);
    await Future<void>.delayed(Duration.zero);
    queue.submit({'v': 'nuevo'});
    await Future<void>.delayed(Duration.zero);

    expect(writer.received.last, {'v': 'nuevo'});
  });

  test('el estado reporta error con el conteo', () async {
    queue.markReady();
    queue.submit({'v': 1});
    await Future<void>.delayed(Duration.zero);
    writer.complete(0, fail: true);
    await Future<void>.delayed(Duration.zero);

    expect(statuses.last.phase, SyncPhase.error);
    expect(statuses.last.failures, 1);
  });

  test('invalidate descarta lo pendiente y cierra la compuerta', () async {
    queue.markReady();
    queue.submit({'v': 'viejo'});
    await Future<void>.delayed(Duration.zero);
    writer.complete(0, fail: true);
    await Future<void>.delayed(Duration.zero);
    expect(queue.hasPending, isTrue);

    queue.invalidate();
    expect(queue.hasPending, isFalse);
    expect(queue.isReady, isFalse);

    queue.submit({'v': 'nuevo'});
    await Future<void>.delayed(Duration.zero);
    expect(writer.received.length, 1, reason: 'compuerta cerrada');

    queue.markReady();
    await Future<void>.delayed(Duration.zero);
    expect(writer.received.last, {'v': 'nuevo'});
  });

  test('una escritura vieja no pisa el estado de la sesion nueva', () async {
    queue.markReady();
    queue.submit({'v': 'viejo'});
    await Future<void>.delayed(Duration.zero);

    queue.invalidate();
    queue.markReady();
    queue.submit({'v': 'nuevo'});
    await Future<void>.delayed(Duration.zero);

    statuses.clear();
    writer.complete(0, fail: true);
    await Future<void>.delayed(Duration.zero);

    expect(writer.received, [
      {'v': 'viejo'},
      {'v': 'nuevo'},
    ], reason: 'el payload nuevo arranca');
    expect(statuses.map((s) => s.phase).toList(), [SyncPhase.syncing],
        reason: 'solo se reporta la escritura nueva, nunca el error viejo');

    writer.complete(1);
    await Future<void>.delayed(Duration.zero);
    expect(statuses.map((s) => s.phase).toList(),
        [SyncPhase.syncing, SyncPhase.idle]);
  });
}
