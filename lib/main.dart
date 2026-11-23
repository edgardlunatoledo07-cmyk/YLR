import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/firebase_pilot.dart';

export 'src/app.dart' show YlrApp;
export 'src/content.dart'
    show RouteKind, RouteLabel, Lesson,
        lessons, glossary, quizQuestions;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const YlrApp());

  unawaited(YlrFirebasePilot.setupPilotUser());
}
