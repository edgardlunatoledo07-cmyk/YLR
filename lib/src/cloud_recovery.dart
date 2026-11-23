import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Copia remota perteneciente al usuario autenticado actualmente.
class YlrCloudBackup {
  const YlrCloudBackup({required this.data, this.savedAt});
  final Map<String, dynamic> data;
  final DateTime? savedAt;
}

/// Recuperación explícita; nunca sustituye automáticamente el progreso local.
class YlrCloudRecovery {
  static Future<YlrCloudBackup?> readServerBackup() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw StateError('Todavía no hay una sesión de Firebase activa');
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get(const GetOptions(source: Source.server))
        .timeout(const Duration(seconds: 20));

    if (!snapshot.exists) return null;
    final document = snapshot.data();
    final raw = document?['localBackup'];
    if (raw is! Map) return null;

    final timestamp = document?['lastBackupAt'];
    return YlrCloudBackup(
      data: Map<String, dynamic>.from(raw),
      savedAt: timestamp is Timestamp ? timestamp.toDate() : null,
    );
  }
}

/// Resultado de recuperación. Los historiales divergentes no se mezclan.
class YlrRecoveryReport {
  const YlrRecoveryReport({
    required this.completedAdded,
    required this.scoresAdded,
    required this.simulationsAdded,
    required this.conflictingHistories,
  });

  final int completedAdded;
  final int scoresAdded;
  final int simulationsAdded;
  final bool conflictingHistories;

  bool get changed =>
      completedAdded > 0 || scoresAdded > 0 || simulationsAdded > 0;
}
