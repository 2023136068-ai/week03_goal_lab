import 'package:flutter_test/flutter_test.dart';
import 'package:week03_goal_lab/main.dart';

void main() {
  group('StudyGoal', () {
    test('toggle changes completion state', () {
      final goal = StudyGoal('Dart 객체지향');

      expect(goal.isCompleted, isFalse);

      goal.toggle();

      expect(goal.isCompleted, isTrue);
    });

    test('trimmed title is kept when valid', () {
      final goal = StudyGoal('  Dart 객체지향  ');

      expect(goal.title, 'Dart 객체지향');
    });
  });
}
