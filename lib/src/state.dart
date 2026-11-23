import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'content.dart';
import 'progress_sync.dart';
import 'sync_queue.dart';
import 'sync_status.dart';

class YlrState extends ChangeNotifier {
  YlrState() {
    _syncQueue = YlrSyncQueue(
      writer: YlrProgressSync.write,
      onStatus: (status) {
        syncStatus = status;
        notifyListeners();
      },
    );
  }

  late final YlrSyncQueue _syncQueue;
  SyncStatus syncStatus = SyncStatus.idle();
  bool firebaseReady = false;
  VoidCallback? onNeedsBootstrap;

  RouteKind? route;
  bool dark = false;
  bool large = false;
  bool simple = false;
  bool contrast = false;
  bool reduceMotion = false;
  bool ready = false;
  String nickname = '';
  int avatarIndex = 0;
  String get displayName =>
      nickname.trim().isEmpty ? 'usuario.predeterminado' : nickname.trim();
  int timerMode = 0; // 0: estándar, 1: ampliado, 2: sin temporizador.
  final Set<String> completed = {};
  final List<String> scores = [];
  final List<String> simulations = [];

  @override
  void dispose() {
    _syncQueue.dispose();
    super.dispose();
  }

  void markFirebaseReady() {
    firebaseReady = true;
    _syncQueue.markReady();
    // Reenvia lo que se guardo localmente antes de tener sesion.
    _submitCurrentState();
  }

  void retrySync() => _syncQueue.retryNow();

  /// Se llama cuando la sesion pasa a otra cuenta. La cola se cierra y se
  /// vuelve a preparar el documento; el proximo guardado arma payload nuevo.
  void invalidateSync() {
    firebaseReady = false;
    _syncQueue.invalidate();
    syncStatus = SyncStatus.idle();
    notifyListeners();
    onNeedsBootstrap?.call();
  }

  Future<void> restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString('route');
      for (final value in RouteKind.values) {
        if (value.name == saved) route = value;
      }
      dark = prefs.getBool('dark') ?? false;
      large = prefs.getBool('large') ?? false;
      simple = prefs.getBool('simple') ?? false;
      contrast = prefs.getBool('contrast') ?? false;
      reduceMotion = prefs.getBool('reduceMotion') ?? false;
      timerMode = (prefs.getInt('timerMode') ?? 0).clamp(0, 2).toInt();
      nickname = (prefs.getString('nickname') ?? '').trim();
      if (nickname.length > 24) nickname = nickname.substring(0, 24);
      avatarIndex = (prefs.getInt('avatarIndex') ?? 0).clamp(0, 5).toInt();
      completed.addAll(prefs.getStringList('completed') ?? []);
      final routePrefix = route?.name ?? 'personal';
      scores.addAll((prefs.getStringList('scores') ?? [])
          .map((s) => s.contains(':') ? s : '$routePrefix:$s'));
      simulations.addAll((prefs.getStringList('simulations') ?? []).map((s) =>
          s.startsWith('personal|') ||
                  s.startsWith('tens|') ||
                  s.startsWith('universitario|')
              ? s
              : '$routePrefix|$s'));
    } catch (e) {
      debugPrint('YLR: almacenamiento local no disponible: $e');
    }
    ready = true;
    notifyListeners();
  }

  /// Encola el estado actual. No escribe preferencias.
  void _submitCurrentState() {
    final payload = YlrProgressSync.buildPayload(
      route: route?.name,
      completed: completed.toList(),
      scores: List<String>.of(scores),
      simulations: List<String>.of(simulations),
    );
    if (payload != null) _syncQueue.submit(payload);
  }

  Future<void> save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (route != null) await prefs.setString('route', route!.name);
      await prefs.setBool('dark', dark);
      await prefs.setBool('large', large);
      await prefs.setBool('simple', simple);
      await prefs.setBool('contrast', contrast);
      await prefs.setBool('reduceMotion', reduceMotion);
      await prefs.setInt('timerMode', timerMode);
      await prefs.setString('nickname', nickname);
      await prefs.setInt('avatarIndex', avatarIndex);
      await prefs.setStringList('completed', completed.toList());
      await prefs.setStringList('scores', scores);
      await prefs.setStringList('simulations', simulations);

      // El guardado local tiene prioridad. El respaldo pasa por la cola,
      // que descarta estados superados y reintenta los fallos.
      if (!firebaseReady) onNeedsBootstrap?.call();
      _submitCurrentState();
    } catch (e) {
      debugPrint('YLR: no fue posible guardar las preferencias: $e');
    }
  }

  void setNickname(String value) {
    final trimmed = value.trim();
    nickname = trimmed.length > 24 ? trimmed.substring(0, 24) : trimmed;
    notifyListeners();
    unawaited(save());
  }

  void setAvatarIndex(int value) {
    avatarIndex = value.clamp(0, 5).toInt();
    notifyListeners();
    unawaited(save());
  }

  void chooseRoute(RouteKind next) {
    route = next;
    notifyListeners();
    save();
  }

  void setDark(bool value) {
    dark = value;
    notifyListeners();
    save();
  }

  void setLarge(bool value) {
    large = value;
    notifyListeners();
    save();
  }

  void setSimple(bool value) {
    simple = value;
    notifyListeners();
    save();
  }

  void setContrast(bool value) {
    contrast = value;
    notifyListeners();
    save();
  }

  void setReduceMotion(bool value) {
    reduceMotion = value;
    notifyListeners();
    save();
  }

  void setTimerMode(int value) {
    timerMode = value;
    notifyListeners();
    save();
  }

  bool lessonDone(String id) => completed.contains('${route?.name}:$id');
  void completeLesson(String id) {
    completed.add('${route?.name}:$id');
    notifyListeners();
    save();
  }

  void addScore(int value) {
    scores.add('${route?.name}:$value');
    notifyListeners();
    save();
  }

  void addSimulation(String result) {
    simulations.add('${route?.name}|$result');
    notifyListeners();
    save();
  }

  int get completedForRoute =>
      completed.where((s) => s.startsWith('${route?.name}:')).length;
  List<int> get scoresForRoute => scores
      .where((s) => s.startsWith('${route?.name}:'))
      .map((s) => int.tryParse(s.split(':').last))
      .whereType<int>()
      .toList();
  int get simulationCount =>
      simulations.where((s) => s.startsWith('${route?.name}|')).length;
  int? get bestScore {
    final values = scoresForRoute;
    if (values.isEmpty) return null;
    return values.reduce((a, b) => a > b ? a : b);
  }
}
