import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/answer.dart';
import '../../lib/services/answer_service.dart';

void main() {
  test('Should add and retrieve answers for a question', () async {
    final answerService = AnswerService();
    
    final answer = Answer(
      idReponse: 1,
      idQuestion: 1,
      descriptionReponse: '1er match',
    );
    
    await answerService.addAnswer(answer);
    
    final answers = await answerService.getAnswersForQuestion(1);
    
    expect(answers.length, 1);
    expect(answers[0].descriptionReponse, '1er match');
  });

  test('Should return empty list when no answers are added', () async {
    final answerService = AnswerService();
    final answers = await answerService.getAnswersForQuestion(1);
    expect(answers, isEmpty);
  });

  test('Should handle error when adding answer with invalid data', () async {
    final answerService = AnswerService();

    final invalidAnswer = Answer(
      idReponse: -1, // Invalid id
      idQuestion: -1, // Invalid id
      descriptionReponse: '',
    );

    try {
      await answerService.addAnswer(invalidAnswer);
      fail('Expected an exception to be thrown');
    } catch (e) {
      expect(e, isA<ArgumentError>()); // Assurez-vous que l'exception est bien celle attendue
    }
  });

  test('Should handle concurrent additions correctly', () async {
    final answerService = AnswerService();
    
    await Future.wait([
      answerService.addAnswer(Answer(idReponse: 1, idQuestion: 1, descriptionReponse: 'Concurrent 1')),
      answerService.addAnswer(Answer(idReponse: 2, idQuestion: 1, descriptionReponse: 'Concurrent 2')),
    ]);

    final answers = await answerService.getAnswersForQuestion(1);
    expect(answers.length, 2);
    expect(answers.map((a) => a.descriptionReponse).toSet(), containsAll(['Concurrent 1', 'Concurrent 2']));
  });

  test('Should update an existing answer correctly', () async {
    final answerService = AnswerService();

    final answer = Answer(
      idReponse: 1,
      idQuestion: 1,
      descriptionReponse: 'Old description',
    );

    await answerService.addAnswer(answer);

    final updatedAnswer = Answer(
      idReponse: 1,
      idQuestion: 1,
      descriptionReponse: 'New description',
    );

    await answerService.updateAnswer(updatedAnswer);
    
    final answers = await answerService.getAnswersForQuestion(1);
    expect(answers[0].descriptionReponse, 'New description');
  });

  test('Should delete an answer correctly', () async {
    final answerService = AnswerService();

    final answer = Answer(
      idReponse: 1,
      idQuestion: 1,
      descriptionReponse: 'To be deleted',
    );

    await answerService.addAnswer(answer);
    await answerService.deleteAnswer(1);

    final answers = await answerService.getAnswersForQuestion(1);
    expect(answers, isEmpty);
  });
}
