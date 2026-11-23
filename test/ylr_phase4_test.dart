import 'package:flutter_test/flutter_test.dart';
import 'package:app_enfermeria/src/content.dart';
import 'package:app_enfermeria/src/state.dart';
import 'package:app_enfermeria/src/ylr_lesson_details.dart';
import 'package:app_enfermeria/src/ylr_route_quiz.dart';
import 'package:app_enfermeria/src/ylr_lesson_checks.dart';
import 'package:app_enfermeria/src/ylr_scenarios.dart';

void main() {
  test('Las 54 lecciones tienen contenido ampliado y fuentes', () {
    expect(lessons.length, 54);
    expect(ylrLessonDetails.length, lessons.length);
    for (final lesson in lessons) {
      final detail = ylrLessonDetails[lesson.id];
      expect(detail, isNotNull);
      expect(detail!.points.length, greaterThanOrEqualTo(3));
      expect(detail.sourceUrl, startsWith('https://'));
      for (final route in RouteKind.values) {
        expect(detail.focusFor(route), isNotEmpty);
      }
    }
  });

  test('Hay 16 preguntas distintas por cada ruta', () {
    for (final route in RouteKind.values) {
      final questions = YlrRouteQuiz.forRoute(route);
      expect(questions.length, 16);
      for (final question in questions) {
        expect(question.options.length, 4);
        expect(question.correctIndex, inInclusiveRange(0, 3));
        expect(question.explanation, isNotEmpty);
      }
    }
    expect(
        YlrRouteQuiz.personal.first.text, isNot(YlrRouteQuiz.tens.first.text));
  });

  test('Cada lección tiene un caso interactivo', () {
    expect(ylrLessonChecks.length, lessons.length);
    final ids = lessons.map((l) => l.id).toSet();
    expect(ids.length, lessons.length);
    for (final lesson in lessons) {
      final check = ylrLessonChecks[lesson.id];
      expect(check, isNotNull);
      expect(check!.options.length, 3);
      expect(check.correctIndex, inInclusiveRange(0, 2));
    }
  });

  test('Los casos prácticos contienen decisiones y explicación', () {
    expect(ylrScenarios.length, 6);
    for (final scenario in ylrScenarios) {
      expect(scenario.steps.length, greaterThanOrEqualTo(2));
      for (final step in scenario.steps) {
        expect(step.answers.length, 3);
        expect(step.explanation, isNotEmpty);
      }
    }
  });

  test('El nombre predeterminado no exige información personal', () {
    final state = YlrState();
    expect(state.displayName, 'usuario.predeterminado');
    state.nickname = 'Estudiante TENS';
    expect(state.displayName, 'Estudiante TENS');
    state.dispose();
  });
}
