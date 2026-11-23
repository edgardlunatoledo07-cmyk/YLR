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
