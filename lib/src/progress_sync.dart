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
