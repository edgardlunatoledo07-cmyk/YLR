import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_enfermeria/src/content.dart';
import 'package:app_enfermeria/src/state.dart';
import 'package:app_enfermeria/src/ylr_lesson_details.dart';
import 'package:app_enfermeria/src/ylr_lesson_checks.dart';
import 'package:app_enfermeria/src/ylr_route_quiz.dart';
import 'package:app_enfermeria/src/ylr_scenarios.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('La biblioteca contiene 54 lecciones únicas y 52 términos', () {
    expect(lessons.length, 54);
    expect(glossary.length, 52);
    expect(lessons.map((lesson) => lesson.id).toSet().length, 54);
    expect(ylrLessonDetails.keys.toSet(),
        lessons.map((lesson) => lesson.id).toSet());
    expect(ylrLessonChecks.keys.toSet(),
        lessons.map((lesson) => lesson.id).toSet());
    for (final lesson in lessons) {
      expect(topicCategories, contains(lesson.category));
      for (final route in RouteKind.values) {
        expect(lesson.forRoute(route), isNotEmpty);
      }
    }
  });

  test('Las 3 rutas tienen evaluaciones válidas', () {
    for (final route in RouteKind.values) {
      final questions = YlrRouteQuiz.forRoute(route);
      expect(questions.length, 16);
      for (final question in questions) {
        expect(question.correctIndex, inInclusiveRange(0, 3));
        expect(question.options.length, 4);
      }
    }
  });

  test('Los casos contienen decisiones válidas', () {
    expect(ylrScenarios.length, 6);
    for (final scenario in ylrScenarios) {
      for (final step in scenario.steps) {
        expect(step.correct, inInclusiveRange(0, step.answers.length - 1));
      }
    }
  });

  test('El progreso sigue estando separado por ruta', () async {
    SharedPreferences.setMockInitialValues({});
    final state = YlrState();
    await state.restore();
    state.chooseRoute(RouteKind.personal);
    state.completeLesson('LES-54');
    state.chooseRoute(RouteKind.tens);
    state.completeLesson('LES-19');
    await state.save();
    expect(state.lessonDone('LES-19'), isTrue);
    expect(state.lessonDone('LES-54'), isFalse);
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completed') ?? [];
    expect(completed, contains('personal:LES-54'));
    expect(completed, contains('tens:LES-19'));
    state.dispose();
  });
}
