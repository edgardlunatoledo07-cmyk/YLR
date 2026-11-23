# Y.LR - Fase 3: aplicar cambios a los archivos Dart existentes.
# Ejecutar desde la carpeta raiz del proyecto app_enfermeria.
$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path
$stateFile = Join-Path $root 'lib\src\state.dart'
$screensFile = Join-Path $root 'lib\src\screens.dart'
$source = Join-Path $PSScriptRoot 'lib\src'
if (!(Test-Path $stateFile) -or !(Test-Path $screensFile)) {
  throw 'No se encontro lib/src/state.dart o screens.dart. Ejecuta desde la raiz de app_enfermeria.'
}
if (!(Test-Path (Join-Path $root 'lib\src\progress_sync.dart'))) {
  throw 'Primero instala el parche de fase 2 (progress_sync.dart). No se modifico nada.'
}
$state = Get-Content -LiteralPath $stateFile -Raw -Encoding UTF8
$screens = Get-Content -LiteralPath $screensFile -Raw -Encoding UTF8
$stateMarker = '  void chooseRoute('
$screenMarker = '  Widget _progress() {'
if (!$state.Contains($stateMarker) -or !$screens.Contains($screenMarker)) {
  throw 'La estructura de los archivos es diferente. No se aplico nada; hay que comparar a mano.'
}
if ($state.Contains('Future<YlrRecoveryReport?> recoverFromCloud()') -or $screens.Contains('YlrCloudBackupCard(state: widget.state)')) {
  throw 'La fase 3 ya parece aplicada total o parcialmente. No se modifico nada.'
}
# Prepara todo antes de modificar archivos.
$method = @'

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

    if (addedCompleted > 0 || addedScores > 0 ||
        addedSimulations > 0 || selectedRoute) {
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
'@
$stateNext = $state.Replace("import 'progress_sync.dart';", "import 'progress_sync.dart';`nimport 'cloud_recovery.dart';")
if ($stateNext -eq $state) { throw 'No se encontro el import progress_sync.dart; operacion cancelada.' }
$stateNext = $stateNext.Replace($stateMarker, $method + $stateMarker)
$screensNext = $screens.Replace("import 'state.dart';", "import 'state.dart';`nimport 'cloud_backup_card.dart';")
if ($screensNext -eq $screens) { throw 'No se encontro el import state.dart; operacion cancelada.' }
$start = $screensNext.IndexOf($screenMarker)
$insert = $screensNext.IndexOf('      YCard(child:', $start)
if ($insert -lt 0) { throw 'No se encontro la tarjeta de progreso; operacion cancelada.' }
$screensNext = $screensNext.Insert($insert, "      YlrCloudBackupCard(state: widget.state),`n      yGap(12),`n")
# Respalda primero; luego escribe el parche.
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
Copy-Item $stateFile ($stateFile + '.bak_' + $stamp)
Copy-Item $screensFile ($screensFile + '.bak_' + $stamp)
Copy-Item (Join-Path $source 'cloud_recovery.dart') (Join-Path $root 'lib\src\cloud_recovery.dart')
Copy-Item (Join-Path $source 'cloud_backup_card.dart') (Join-Path $root 'lib\src\cloud_backup_card.dart')
[System.IO.File]::WriteAllText($stateFile, $stateNext, [System.Text.UTF8Encoding]::new($false))
[System.IO.File]::WriteAllText($screensFile, $screensNext, [System.Text.UTF8Encoding]::new($false))
Write-Host 'Fase 3 aplicada. Copias .bak_ guardadas junto a state.dart y screens.dart.' -ForegroundColor Green
Write-Host 'Ejecuta: flutter analyze; flutter test; flutter run -d ce11171b0deb683704'
