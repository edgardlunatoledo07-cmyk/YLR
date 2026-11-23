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
