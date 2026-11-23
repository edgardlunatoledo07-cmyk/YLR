import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_enfermeria/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('El catálogo beta contiene 54 lecciones, 52 términos y 5 preguntas', () {
    expect(lessons.length, 54);
    expect(glossary.length, 52);
    expect(quizQuestions.length, 5);
    expect(lessons.first.forRoute(RouteKind.tens),
        isNot(lessons.first.forRoute(RouteKind.personal)));
  });

  testWidgets('Se puede elegir una ruta y abrir el menú principal',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const YlrApp());
    await tester.pumpAndSettle();
    expect(find.text('Aprende a tu ritmo'), findsOneWidget);
    await tester.tap(find.text('TENS').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('¡Hola! Sigamos'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('Biblioteca permite buscar y reporta que no hay resultados',
      (tester) async {
    SharedPreferences.setMockInitialValues({'route': 'tens'});
    await tester.pumpWidget(const YlrApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Aprender'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'termino-inexistente');
    await tester.pumpAndSettle();
    expect(find.textContaining('No se encontraron lecciones'), findsOneWidget);
  });

  testWidgets('Los datos 0.1.1 siguen disponibles en progreso TENS',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'route': 'tens',
      'completed': ['tens:LES-01'],
      'scores': ['67'],
      'simulations': ['analisis:0:continuo'],
    });
    await tester.pumpWidget(const YlrApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Progreso'));
    await tester.pumpAndSettle();
    expect(find.text('1 de 54'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('67%'),
      200,
      scrollable: find.byType(Scrollable).last,
    );

    await tester.pumpAndSettle();

    expect(find.text('67%'), findsOneWidget);
  });

  testWidgets('Abre contenido de la biblioteca', (tester) async {
    SharedPreferences.setMockInitialValues({'route': 'tens'});
    await tester.pumpWidget(const YlrApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Aprender'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Higiene de manos'));
    await tester.pumpAndSettle();
    expect(find.text('Objetivos de aprendizaje'), findsOneWidget);
    expect(find.text('Lectura'), findsOneWidget);
  });
}
