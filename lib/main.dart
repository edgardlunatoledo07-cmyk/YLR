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
