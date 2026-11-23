# Y.LR - Fase 1 completa. Ejecutar en la raiz del repo, sobre una rama nueva.
$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path

if (!(Test-Path (Join-Path $root 'pubspec.yaml'))) {
  throw 'No parece la raiz del repo YLR (falta pubspec.yaml).'
}

$must = @(
  'lib\main.dart', 'lib\src\app.dart', 'lib\src\state.dart',
  'lib\src\firebase_pilot.dart', 'lib\src\progress_sync.dart',
  'lib\src\cloud_backup_card.dart', 'lib\src\ylr_profile_page.dart',
  'firebase.json', 'android\app\src\main\AndroidManifest.xml'
)
foreach ($f in $must) {
  if (!(Test-Path (Join-Path $root $f))) { throw "Falta $f. Rama equivocada?" }
}

function Write-File([string]$relative, [string]$content) {
  $full = Join-Path $root $relative
  $dir = Split-Path -Parent $full
  if ($dir -and !(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  [System.IO.File]::WriteAllText($full, $content, [System.Text.UTF8Encoding]::new($false))
  Write-Host "  + $relative"
}

Write-Host 'Escribiendo archivos de Fase 1...'

Write-File 'firestore.rules' @'
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    function isOwner(uid) {
      return request.auth != null && request.auth.uid == uid;
    }

    // El lenguaje de reglas no permite validar el tipo de cada elemento.
    // Se acota cantidad y longitud total, que es lo que protege el documento.
    function boundedList(value, maxItems, maxTotalChars) {
      return value is list
          && value.size() <= maxItems
          && value.join('').size() <= maxTotalChars;
    }

    function isValidBackup(b) {
      return b is map
          && b.keys().hasOnly(['route', 'completed', 'scores', 'simulations'])
          && (b.get('route', null) == null || b.get('route', null) is string)
          && boundedList(b.get('completed', []), 500, 20000)
          && boundedList(b.get('scores', []), 1000, 20000)
          && boundedList(b.get('simulations', []), 1000, 160000);
    }

    function validCode(code) {
      return code is string && code.matches('^usuario[A-Z0-9]{8}$');
    }

    // Inmutable una vez fijado; los documentos heredados pueden fijarlo.
    function codeStable() {
      return !('participantCode' in resource.data)
          || request.resource.data.participantCode == resource.data.participantCode;
    }

    match /users/{uid} {
      allow read: if isOwner(uid);

      allow create: if isOwner(uid)
          && request.resource.data.keys().hasOnly(
               ['participantCode', 'version', 'createdAt', 'localBackup', 'lastBackupAt'])
          && validCode(request.resource.data.participantCode)
          && request.resource.data.version is string
          && request.resource.data.createdAt == request.time
          && (!('localBackup' in request.resource.data)
              || isValidBackup(request.resource.data.localBackup));

      allow update: if isOwner(uid)
          && request.resource.data.diff(resource.data).affectedKeys()
               .hasOnly(['localBackup', 'lastBackupAt', 'version', 'participantCode'])
          && validCode(request.resource.data.participantCode)
          && codeStable()
          && isValidBackup(request.resource.data.localBackup)
          && (!('createdAt' in resource.data)
              || request.resource.data.createdAt == resource.data.createdAt);

      allow delete: if isOwner(uid);
    }

    match /{document=**} {
      allow read, write: if false;
    }
  }
}
'@

Write-File 'firestore.indexes.json' @'
{
  "indexes": [],
  "fieldOverrides": []
}
'@

Write-File '.firebaserc' @'
{
  "projects": {
    "default": "ylr-beta"
  }
}
'@

Write-File 'firebase.json' @'
{
  "flutter": {
    "platforms": {
      "android": {
        "default": {
          "projectId": "ylr-beta",
          "appId": "1:94157092500:android:e9b3e92b85aec50dd4a681",
          "fileOutput": "android/app/google-services.json"
        }
      },
      "dart": {
        "lib/firebase_options.dart": {
          "projectId": "ylr-beta",
          "configurations": {
            "android": "1:94157092500:android:e9b3e92b85aec50dd4a681"
          }
        }
      }
    }
  },
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "emulators": {
    "firestore": { "port": 8080 },
    "ui": { "enabled": true, "port": 4000 },
    "singleProjectMode": true
  }
}
'@

Write-File 'lib\src\sync_status.dart' @'
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
'@

Write-File 'lib\src\sync_queue.dart' @'
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
'@

Write-File 'lib\src\identity.dart' @'
import 'package:firebase_auth/firebase_auth.dart';

enum YlrLinkOutcome { linked, emailInUse, cancelled, failed }

/// Vinculacion de la cuenta anonima con email.
///
/// Los datos locales no dependen del uid, asi que ninguna rama los pierde.
class YlrIdentity {
  static Future<YlrLinkOutcome> linkWithEmail({
    required String email,
    required String password,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return YlrLinkOutcome.failed;

    final credential = EmailAuthProvider.credential(
      email: email.trim(),
      password: password,
    );

    try {
      await user.linkWithCredential(credential);
      return YlrLinkOutcome.linked;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'credential-already-in-use':
        case 'email-already-in-use':
          return YlrLinkOutcome.emailInUse;
        case 'weak-password':
        case 'invalid-email':
        case 'requires-recent-login':
          return YlrLinkOutcome.cancelled;
        default:
          return YlrLinkOutcome.failed;
      }
    }
  }

  /// Rama de colision: la cuenta ya existia. Entra en ella.
  /// El respaldo de nube pasa a ser el de esa cuenta; lo local se conserva.
  static Future<bool> signInToExisting({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(
        EmailAuthProvider.credential(email: email.trim(), password: password),
      );
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }
}
'@

Write-File 'lib\src\identity_card.dart' @'
import 'package:flutter/material.dart';

import 'identity.dart';
import 'state.dart';
import 'style.dart';

/// Vincula la cuenta anonima con un email para que el progreso sea
/// recuperable. Los datos locales no dependen del uid y no se pierden.
class YlrIdentityCard extends StatefulWidget {
  const YlrIdentityCard({super.key, required this.state});
  final YlrState state;
  @override
  State<YlrIdentityCard> createState() => _YlrIdentityCardState();
}

class _YlrIdentityCardState extends State<YlrIdentityCard> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  bool _showForm = false;
  bool _offerSignIn = false;
  String? _message;
  bool _error = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _link() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    final outcome = await YlrIdentity.linkWithEmail(
      email: _email.text,
      password: _password.text,
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = false;
      switch (outcome) {
        case YlrLinkOutcome.linked:
          _message = 'Cuenta vinculada. Ya podés recuperar el progreso.';
          _showForm = false;
        case YlrLinkOutcome.emailInUse:
          _message = 'Ese email ya tiene cuenta.';
          _offerSignIn = true;
        case YlrLinkOutcome.cancelled:
          _message = 'Revisá el email y usá al menos 6 caracteres de contraseña.';
          _error = true;
        case YlrLinkOutcome.failed:
          _message = 'No se pudo vincular. Intentá de nuevo.';
          _error = true;
      }
    });
  }

  Future<void> _signInExisting() async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Entrar en una cuenta existente'),
        content: const Text(
          'El progreso de este teléfono se conserva, pero no se fusiona. '
          'El próximo respaldo reemplazará la copia en la nube de esa cuenta '
          'con el progreso local de este teléfono.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Entrar igual'),
          ),
        ],
      ),
    );
    if (approved != true || !mounted) return;

    setState(() => _busy = true);
    final ok = await YlrIdentity.signInToExisting(
      email: _email.text,
      password: _password.text,
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = !ok;
      _offerSignIn = false;
      _message = ok
          ? 'Entraste en esa cuenta. El próximo respaldo usará su progreso '
              'y reemplazará la copia anterior de esa cuenta.'
          : 'Contraseña incorrecta para esa cuenta.';
    });
    if (ok) {
      widget.state.invalidateSync();
      await widget.state.save();
    }
  }

  @override
  Widget build(BuildContext context) => YCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.key_outlined, color: YColors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Cuenta recuperable',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ]),
            const SizedBox(height: 8),
            Text(
              'Hoy tu cuenta es anónima: si borrás los datos de la app, '
              'perdés el acceso al respaldo. Vinculá un email para evitarlo.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (_message != null) ...[
              const SizedBox(height: 10),
              YNotice(_message!,
                  icon: _error ? Icons.info_outline : Icons.check_circle_outline),
            ],
            if (_showForm) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  helperText: 'Mínimo 6 caracteres',
                ),
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                FilledButton.icon(
                  onPressed: _busy ? null : _link,
                  icon: const Icon(Icons.link_rounded),
                  label: const Text('Vincular'),
                ),
                TextButton(
                  onPressed: _busy ? null : () => setState(() => _showForm = false),
                  child: const Text('Cancelar'),
                ),
              ]),
            ] else if (_offerSignIn) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _busy ? null : _signInExisting,
                icon: const Icon(Icons.login_rounded),
                label: const Text('Entrar en esa cuenta'),
              ),
            ] else ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _busy ? null : () => setState(() => _showForm = true),
                icon: const Icon(Icons.add_link_rounded),
                label: const Text('Vincular email'),
              ),
            ],
            if (_busy) ...[
              const SizedBox(height: 10),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      );
}
'@

Write-File 'lib\src\progress_sync.dart' @'
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Construccion y escritura del respaldo. La cola decide cuando se escribe.
class YlrProgressSync {
  static const String appVersion = '0.2.0-beta';

  /// Deriva el codigo de participante del uid. Fuente unica.
  static String participantCode(String uid) =>
      'usuario${uid.substring(0, 8).toUpperCase()}';

  static Map<String, dynamic>? buildPayload({
    required String? route,
    required List<String> completed,
    required List<String> scores,
    required List<String> simulations,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    return <String, dynamic>{
      'participantCode': participantCode(user.uid),
      'version': appVersion,
      'localBackup': <String, dynamic>{
        'route': route,
        'completed': List<String>.of(completed),
        'scores': List<String>.of(scores),
        'simulations': List<String>.of(simulations),
      },
      'lastBackupAt': FieldValue.serverTimestamp(),
    };
  }

  /// Lanza si no puede escribir, para que la cola marque el error y reintente.
  static Future<void> write(Map<String, dynamic> payload) async {
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase no inicializado');
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw StateError('Sin sesion de Firebase');
    }
    if (payload['participantCode'] != participantCode(user.uid)) {
      throw StateError('Payload de una sesion anterior');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(payload, SetOptions(merge: true))
        .timeout(const Duration(seconds: 20));
  }
}
'@

Write-File 'lib\src\firebase_pilot.dart' @'
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'progress_sync.dart';

class YlrFirebasePilot {
  /// Prepara el documento del usuario. Devuelve true solo si quedo listo.
  static Future<bool> setupPilotUser() async {
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser ?? (await auth.signInAnonymously()).user;
      if (user == null) return false;

      final reference =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      var snapshot = await reference
          .get(const GetOptions(source: Source.server))
          .timeout(const Duration(seconds: 20));

      if (!snapshot.exists) {
        await reference.set({
          'participantCode': YlrProgressSync.participantCode(user.uid),
          'version': YlrProgressSync.appVersion,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)).timeout(const Duration(seconds: 20));

        snapshot = await reference
            .get(const GetOptions(source: Source.server))
            .timeout(const Duration(seconds: 20));
      }

      if (!snapshot.exists) return false;

      final existingBackup = snapshot.data()?['localBackup'] != null;
      if (!existingBackup) {
        final prefs = await SharedPreferences.getInstance();
        await reference.set({
          'localBackup': <String, dynamic>{
            'route': prefs.getString('route'),
            'completed': prefs.getStringList('completed') ?? [],
            'scores': prefs.getStringList('scores') ?? [],
            'simulations': prefs.getStringList('simulations') ?? [],
          },
          'lastBackupAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)).timeout(const Duration(seconds: 20));
      }

      debugPrint('YLR: perfil de Firebase listo');
      return true;
    } catch (error) {
      debugPrint('YLR: no se pudo preparar Firebase: $error');
      return false;
    }
  }
}
'@

Write-File 'lib\src\cloud_backup_card.dart' @'
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
'@

Write-File 'lib\main.dart' @'
import 'package:flutter/material.dart';

import 'src/app.dart';

export 'src/app.dart' show YlrApp;
export 'src/content.dart'
    show RouteKind, RouteLabel, Lesson,
        lessons, glossary, quizQuestions;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const YlrApp());
}
'@

Write-File 'lib\src\app.dart' @'
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'content.dart';
import 'firebase_pilot.dart';
import 'screens.dart';
import 'state.dart';
import 'style.dart';

class YlrApp extends StatefulWidget {
  const YlrApp({super.key});
  @override
  State<YlrApp> createState() => _YlrAppState();
}

class _YlrAppState extends State<YlrApp> with WidgetsBindingObserver {
  static const _attempts = 3;

  bool _bootstrapping = false;
  bool _firebaseInitialized = false;

  late final YlrState state;
  @override
  void initState() {
    super.initState();
    state = YlrState()..addListener(_refresh);
    state.onNeedsBootstrap = () => unawaited(_bootstrapFirebase());
    WidgetsBinding.instance.addObserver(this);
    state.restore();
    unawaited(_bootstrapFirebase());
  }

  /// Inicializar Firebase y preparar el usuario son pasos separados:
  /// si el segundo falla, se reintenta sin volver a inicializar.
  Future<void> _bootstrapFirebase() async {
    if (_bootstrapping || state.firebaseReady) return;
    _bootstrapping = true;
    try {
      if (!_firebaseInitialized) {
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        }
        _firebaseInitialized = true;
      }
      for (var attempt = 1; attempt <= _attempts; attempt++) {
        if (await YlrFirebasePilot.setupPilotUser()) {
          if (!mounted) return;
          state.markFirebaseReady();
          return;
        }
        if (attempt < _attempts) {
          await Future<void>.delayed(Duration(seconds: 3 * attempt));
        }
      }
    } catch (error) {
      debugPrint('YLR: bootstrap de Firebase falló: $error');
    } finally {
      _bootstrapping = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    if (lifecycle == AppLifecycleState.resumed && !state.firebaseReady) {
      unawaited(_bootstrapFirebase());
    }
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    state.onNeedsBootstrap = null;
    state.removeListener(_refresh);
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Y.LR · Aprender hoy, cuidar siempre',
        theme: yTheme(false, state.contrast),
        darkTheme: yTheme(true, state.contrast),
        themeMode: state.dark ? ThemeMode.dark : ThemeMode.light,
        builder: (context, child) {
          final m = MediaQuery.of(context);
          final baseScale = m.textScaler.scale(16) / 16;
          return MediaQuery(
              data: m.copyWith(
                  textScaler:
                      TextScaler.linear(baseScale * (state.large ? 1.17 : 1))),
              child: child!);
        },
        home: !state.ready
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : state.route == null
                ? _Welcome(state: state)
                : YlrShell(state: state),
      );
}

class _Welcome extends StatelessWidget {
  const _Welcome({required this.state});
  final YlrState state;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: ListView(padding: const EdgeInsets.all(23), children: [
          const SizedBox(height: 20),
          const YBadge('PLATAFORMA EDUCATIVA · BETA'),
          const SizedBox(height: 20),
          const Icon(Icons.favorite_rounded, size: 58, color: YColors.teal),
          yGap(10),
          Text('Y.LR',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 42),
              textAlign: TextAlign.center),
          Text('APRENDER HOY · CUIDAR SIEMPRE',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
          yGap(32),
          Text('Aprende a tu ritmo',
              style: Theme.of(context).textTheme.headlineLarge),
          Text(
              'Elige tu ruta educativa. Podrás cambiarla luego sin perder el progreso de las otras.',
              style: Theme.of(context).textTheme.bodyMedium),
          yGap(22),
          ...RouteKind.values.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: YCard(
                  child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: YIcon(
                    r == RouteKind.personal
                        ? Icons.home_rounded
                        : r == RouteKind.tens
                            ? Icons.medical_services_outlined
                            : Icons.school_outlined,
                    color: r == RouteKind.personal
                        ? YColors.rose
                        : r == RouteKind.tens
                            ? YColors.teal
                            : YColors.lilac),
                title: Text(r.label,
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(r.description,
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => state.chooseRoute(r),
              )))),
          yGap(10),
          const YNotice(
              'Prototipo educativo con contenidos de demostración. No sustituye la formación supervisada ni instrucciones clínicas institucionales.'),
        ])),
      );
}
'@

Write-File 'lib\src\state.dart' @'
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
      final payload = YlrProgressSync.buildPayload(
        route: route?.name,
        completed: completed.toList(),
        scores: List<String>.of(scores),
        simulations: List<String>.of(simulations),
      );
      if (payload != null) _syncQueue.submit(payload);
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
'@

Write-File 'test\sync_queue_test.dart' @'
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

    expect(statuses, isEmpty, reason: 'el fallo viejo se ignora');
    expect(writer.received.length, 2, reason: 'el payload nuevo arranca');
  });
}
'@

Write-File 'rules-tests\package.json' @'
{
  "name": "ylr-rules-tests",
  "private": true,
  "scripts": {
    "test": "mocha --timeout 20000 rules.test.js"
  },
  "devDependencies": {
    "@firebase/rules-unit-testing": "^4.0.0",
    "firebase": "^11.0.0",
    "mocha": "^10.7.0"
  }
}
'@

Write-File 'rules-tests\rules.test.js' @'
const { initializeTestEnvironment, assertFails, assertSucceeds } = require('@firebase/rules-unit-testing');
const { doc, getDoc, setDoc, serverTimestamp } = require('firebase/firestore');
const path = require('path');
const fs = require('fs');

const PROJECT_ID = 'ylr-beta';
const UID = 'abc12345xyz';
const CODE = 'usuarioABC12345';

let env;

function ctx(uid) {
  return env.authenticatedContext(uid).firestore();
}

function backup(extra = {}) {
  return {
    participantCode: CODE,
    version: '0.2.0-beta',
    localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
    lastBackupAt: new Date(),
    ...extra,
  };
}

before(async () => {
  env = await initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: { rules: fs.readFileSync(path.resolve(__dirname, '..', 'firestore.rules'), 'utf8') },
  });
});

after(async () => { await env.cleanup(); });

beforeEach(async () => { await env.clearFirestore(); });

async function seed(uid = UID) {
  await env.withSecurityRulesDisabled(async (c) => {
    await setDoc(doc(c.firestore(), 'users', uid), {
      participantCode: CODE,
      version: '0.2.0-beta',
      createdAt: new Date(),
      localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
      lastBackupAt: new Date(),
    });
  });
}

it('el dueno lee su documento', async () => {
  await seed();
  await assertSucceeds(getDoc(doc(ctx(UID), 'users', UID)));
});

it('un extrano no lee el documento ajeno', async () => {
  await seed();
  await assertFails(getDoc(doc(ctx('otroUid999'), 'users', UID)));
});

it('crea con forma valida', async () => {
  await assertSucceeds(setDoc(doc(ctx(UID), 'users', UID), {
    ...backup(),
    createdAt: serverTimestamp(),
  }));
});

it('rechaza create sin participantCode', async () => {
  const { participantCode, ...rest } = backup();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    ...rest,
    createdAt: serverTimestamp(),
  }));
});

it('acepta update de localBackup', async () => {
  await seed();
  await assertSucceeds(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'tens', completed: ['tens:LES-01'], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza update con participantCode invalido', async () => {
  await seed();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: 'otro',
    localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza una lista fuera de tope', async () => {
  await seed();
  const huge = Array.from({ length: 1001 }, (_, i) => `personal:${i}`);
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'personal', completed: [], scores: huge, simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza cambiar participantCode por otro codigo valido', async () => {
  await seed();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: 'usuarioZZZZ9999',
    localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('permite fijar participantCode en un documento heredado', async () => {
  await env.withSecurityRulesDisabled(async (c) => {
    await setDoc(doc(c.firestore(), 'users', UID), {
      version: '0.1.0',
      localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
      lastBackupAt: new Date(),
    });
  });
  await assertSucceeds(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'personal', completed: ['personal:LES-01'], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza un elemento que no es string', async () => {
  await seed();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'personal', completed: [{ x: 1 }], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});
'@

# --- S (opcional): etiqueta del manifiesto ---
Write-File 'android\app\src\main\AndroidManifest.xml' @'
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.INTERNET"/>
    <application
        android:label="Y.LR"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
'@

# --- P: edicion quirurgica del perfil ---
$profilePath = Join-Path $root 'lib\src\ylr_profile_page.dart'
$p = [System.IO.File]::ReadAllText($profilePath)

if (!$p.Contains('YlrIdentityCard(state: state)')) {
  if (!$p.Contains("        Text('Mis rutas educativas',")) {
    throw 'Ancla de rutas educativas no encontrada. No se modifico el perfil.'
  }
  $p = $p.Replace(
    "        Text('Mis rutas educativas',",
    "        YlrIdentityCard(state: state),`n        yGap(17),`n        Text('Mis rutas educativas',")
}

if (!$p.Contains("import 'identity_card.dart';")) {
  if (!$p.Contains("import 'content.dart';")) {
    throw 'Ancla de import no encontrada. No se modifico el perfil.'
  }
  $p = $p.Replace("import 'content.dart';", "import 'content.dart';`nimport 'identity_card.dart';")
}

[System.IO.File]::WriteAllText($profilePath, $p, [System.Text.UTF8Encoding]::new($false))
Write-Host '  ~ lib\src\ylr_profile_page.dart'

# --- R: .gitignore por append ---
$ignore = Join-Path $root '.gitignore'
$current = if (Test-Path $ignore) { [System.IO.File]::ReadAllText($ignore) } else { '' }
if (!$current.Contains('rules-tests/node_modules/')) {
  if ($current.Length -gt 0 -and !$current.EndsWith("`n")) { $current += "`n" }
  $current += "rules-tests/node_modules/`n"
  [System.IO.File]::WriteAllText($ignore, $current, [System.Text.UTF8Encoding]::new($false))
  Write-Host '  ~ .gitignore'
}

Write-Host ''
Write-Host 'Fase 1 escrita. Sin desplegar reglas.' -ForegroundColor Green
Write-Host 'Siguiente: git status; git diff > fase-1.patch; flutter analyze; flutter test'
