import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'content.dart';
import 'progress_sync.dart';
import 'cloud_recovery.dart';

class YlrState extends ChangeNotifier {
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

      // El guardado local tiene prioridad. Firebase se actualiza aparte
      // para que un problema de red no impida usar Y.LR.
      unawaited(YlrProgressSync.upload(
        route: route?.name,
        completed: completed.toList(),
        scores: List<String>.of(scores),
        simulations: List<String>.of(simulations),
      ));
    } catch (e) {
      debugPrint('YLR: no fue posible guardar las preferencias: $e');
    }
  }

  /// Recupera datos de este mismo UID sin borrar los datos locales.
  /// Cuando los historiales divergen, cancela la operación completa.
  Future<YlrRecoveryReport?> recoverFromCloud() async {
    final remote = await YlrCloudRecovery.readServerBackup();
    if (remote == null) return null;

    final data = remote.data;
    const prefixes = ['personal', 'tens', 'universitario'];

    List<String> strings(dynamic value) => value is List
        ? value.whereType<String>().toList(growable: false)
        : const <String>[];

    final remoteCompleted = strings(data['completed'])
        .where((entry) => prefixes.any((p) => entry.startsWith('$p:')))
        .toSet();
    final remoteScores = strings(data['scores'])
        .where((entry) => prefixes.any((p) => entry.startsWith('$p:')))
        .toList();
    final remoteSimulations = strings(data['simulations'])
        .where((entry) => prefixes.any((p) => entry.startsWith('$p|')))
        .toList();

    bool compatible(List<String> a, List<String> b) {
      final count = a.length < b.length ? a.length : b.length;
      for (var index = 0; index < count; index++) {
        if (a[index] != b[index]) return false;
      }
      return true;
    }

    // Los resultados antiguos no tienen identificador único por intento.
    // Si no comparten el mismo prefijo, no es seguro fusionarlos.
    if (!compatible(scores, remoteScores) ||
        !compatible(simulations, remoteSimulations)) {
      return const YlrRecoveryReport(
        completedAdded: 0,
        scoresAdded: 0,
        simulationsAdded: 0,
        conflictingHistories: true,
      );
    }

    final beforeCompleted = completed.length;
    completed.addAll(remoteCompleted);
    final addedCompleted = completed.length - beforeCompleted;

    final addedScores = remoteScores.length > scores.length
        ? remoteScores.length - scores.length
        : 0;
    if (addedScores > 0) {
      scores.addAll(remoteScores.skip(scores.length));
    }

    final addedSimulations = remoteSimulations.length > simulations.length
        ? remoteSimulations.length - simulations.length
        : 0;
    if (addedSimulations > 0) {
      simulations.addAll(remoteSimulations.skip(simulations.length));
    }

    var selectedRoute = false;
    if (route == null && data['route'] is String) {
      for (final value in RouteKind.values) {
        if (value.name == data['route']) {
          route = value;
          selectedRoute = true;
          break;
        }
      }
    }

    if (addedCompleted > 0 ||
        addedScores > 0 ||
        addedSimulations > 0 ||
        selectedRoute) {
      notifyListeners();
      await save();
    }

    return YlrRecoveryReport(
      completedAdded: addedCompleted,
      scoresAdded: addedScores,
      simulationsAdded: addedSimulations,
      conflictingHistories: false,
    );
  }

  void setNickname(String value) {
    nickname = value.trim();
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
