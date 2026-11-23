import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Envia una copia del progreso sin interferir con SharedPreferences.
///
/// No recupera progreso remoto ni fusiona dos dispositivos: eso se
/// implementara cuando exista una identidad recuperable (p. ej. Google).
class YlrProgressSync {
  static Future<void> upload({
    required String? route,
    required List<String> completed,
    required List<String> scores,
    required List<String> simulations,
  }) async {
    // Copiar las listas impide que cambios posteriores alteren el respaldo
    // de esta operacion mientras se procesa una escritura asincrona.
    final backup = <String, dynamic>{
      'route': route,
      'completed': List<String>.of(completed),
      'scores': List<String>.of(scores),
      'simulations': List<String>.of(simulations),
    };

    try {
      // En tests o al arrancar sin Firebase la informacion sigue local.
      if (Firebase.apps.isEmpty) {
        debugPrint(
            'YLR Sync: Firebase aun no inicializado; progreso local disponible');
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint('YLR Sync: sin sesion; progreso local disponible');
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'localBackup': backup,
        'lastBackupAt': FieldValue.serverTimestamp(),
      });
      debugPrint('YLR Sync: progreso confirmado en Firestore');
    } on FirebaseException catch (error) {
      debugPrint('YLR Sync: ${error.code}: ${error.message}');
    } catch (error) {
      debugPrint('YLR Sync: error inesperado: $error');
    }
  }
}
