import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YlrFirebasePilot {
  static Future<void> setupPilotUser() async {
    try {
      // 1. Verificar el proyecto Firebase.
      final project = Firebase.app().options.projectId;
      debugPrint('YLR Proyecto Firebase: $project');

      // 2. Recuperar o crear usuario anónimo.
      final auth = FirebaseAuth.instance;

      final user = auth.currentUser ?? (await auth.signInAnonymously()).user;

      if (user == null) {
        throw StateError(
          'No se pudo obtener el usuario Firebase',
        );
      }

      debugPrint('YLR: Autenticación correcta');

      // 3. Referencia al documento del usuario.
      final reference =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // 4. Consultar directamente el servidor.
      var snapshot = await reference
          .get(
            const GetOptions(source: Source.server),
          )
          .timeout(const Duration(seconds: 20));

      debugPrint(
        'YLR Existe en servidor: ${snapshot.exists}',
      );

      // 5. Crear perfil si todavía no existe.
      if (!snapshot.exists) {
        final code = 'usuario${user.uid.substring(0, 8).toUpperCase()}';

        await reference.set({
          'participantCode': code,
          'version': '0.2.0-beta',
          'createdAt': FieldValue.serverTimestamp(),
        }).timeout(const Duration(seconds: 20));

        debugPrint('YLR: Nuevo usuario creado');

        snapshot = await reference
            .get(
              const GetOptions(source: Source.server),
            )
            .timeout(const Duration(seconds: 20));
      }

      if (!snapshot.exists) {
        throw StateError(
          'No se encontró el documento del usuario',
        );
      }

      debugPrint('YLR: Usuario verificado');

      // 6. Comprobar si existe un respaldo.
      final existingBackup = snapshot.data()?['localBackup'] != null;

      if (!existingBackup) {
        // 7. Leer el progreso local de Y.LR.
        final prefs = await SharedPreferences.getInstance();

        final localBackup = <String, dynamic>{
          'route': prefs.getString('route'),
          'completed': prefs.getStringList('completed') ?? [],
          'scores': prefs.getStringList('scores') ?? [],
          'simulations': prefs.getStringList('simulations') ?? [],
        };

        // 8. Guardar el primer respaldo en Firestore.
        await reference.update({
          'localBackup': localBackup,
          'lastBackupAt': FieldValue.serverTimestamp(),
        }).timeout(const Duration(seconds: 20));

        debugPrint(
          'YLR: Primer respaldo enviado correctamente',
        );
      } else {
        debugPrint(
          'YLR: Ya existe un respaldo. '
          'No se sobrescribieron los datos.',
        );
      }

      // 9. Verificar el resultado en el servidor.
      final verified = await reference
          .get(
            const GetOptions(source: Source.server),
          )
          .timeout(const Duration(seconds: 20));

      final data = verified.data();

      debugPrint(
        'YLR Usuario: ${data?['participantCode']}',
      );

      debugPrint(
        'YLR: respaldo confirmado = '
        '${data?['localBackup'] != null}',
      );

      debugPrint(
        'YLR: Conexión Firebase finalizada',
      );
    } on FirebaseException catch (error) {
      debugPrint(
        'YLR Firebase error: ${error.code}',
      );

      debugPrint(
        'YLR Detalle: ${error.message}',
      );
    } catch (error) {
      debugPrint('YLR Error: $error');
    }
  }
}
