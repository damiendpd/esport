import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/question.dart';
import '../../lib/services/question_service.dart';

void main() {
  test('Should add and retrieve questions for an event', () async {
    final questionService = QuestionService();
    
    final question = Question(
      idEvent: 1,
      idQuestion: 1,
      libelleQuestion: 'Quelle est votre question préférée?',
    );
    
    await questionService.addQuestion(question);
    
    final questions = await questionService.getQuestionsForEvent(1);
    
    expect(questions.length, 1);
    expect(questions[0].libelleQuestion, 'Quelle est votre question préférée?');
  });

  test('Should return empty list when no questions are added', () async {
    final questionService = QuestionService();
    final questions = await questionService.getQuestionsForEvent(1);
    expect(questions, isEmpty);
  });

  test('Should handle error when adding question with invalid data', () async {
    final questionService = QuestionService();

    final invalidQuestion = Question(
      idEvent: -1, // Invalid id
      idQuestion: -1, // Invalid id
      libelleQuestion: '',
    );

    try {
      await questionService.addQuestion(invalidQuestion);
      fail('Expected an exception to be thrown');
    } catch (e) {
      expect(e, isA<ArgumentError>()); // Assurez-vous que l'exception est bien celle attendue
    }
  });

  test('Should handle concurrent additions correctly', () async {
    final questionService = QuestionService();
    
    await Future.wait([
      questionService.addQuestion(Question(idEvent: 1, idQuestion: 1, libelleQuestion: 'Concurrent 1')),
      questionService.addQuestion(Question(idEvent: 1, idQuestion: 2, libelleQuestion: 'Concurrent 2')),
    ]);

    final questions = await questionService.getQuestionsForEvent(1);
    expect(questions.length, 2);
    expect(questions.map((q) => q.libelleQuestion).toSet(), containsAll(['Concurrent 1', 'Concurrent 2']));
  });

  test('Should update an existing question correctly', () async {
    final questionService = QuestionService();

    final question = Question(
      idEvent: 1,
      idQuestion: 1,
      libelleQuestion: 'Old question',
    );

    await questionService.addQuestion(question);

    final updatedQuestion = Question(
      idEvent: 1,
      idQuestion: 1,
      libelleQuestion: 'Updated question',
    );

    await questionService.updateQuestion(updatedQuestion);
    
    final questions = await questionService.getQuestionsForEvent(1);
    expect(questions[0].libelleQuestion, 'Updated question');
  });

  test('Should delete a question correctly', () async {
    final questionService = QuestionService();

    final question = Question(
      idEvent: 1,
      idQuestion: 1,
      libelleQuestion: 'To be deleted',
    );

    await questionService.addQuestion(question);
    await questionService.deleteQuestion(1);

    final questions = await questionService.getQuestionsForEvent(1);
    expect(questions, isEmpty);
  });
}
