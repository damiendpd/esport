import 'package:mongo_dart/mongo_dart.dart';
import '../models/answer.dart';
import '../services/database_service.dart';

class AnswerService {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addAnswer(Answer answer) async {
    final collection = await _databaseService.getCollection('Reponses');
    await collection.insert(answer.toMap());
  }

  Future<List<Answer>> getAnswersForQuestion(int idQuestion) async {
    final collection = await _databaseService.getCollection('Reponses');
    var results = await collection.find({'idQuestion': idQuestion}).toList();
    return results.map((answer) => Answer.fromMap(answer)).toList();
  }

  Future<void> updateAnswer(Answer answer) async {
    final collection = await _databaseService.getCollection('Reponses');
    await collection.updateOne(
      where.eq('idReponse', answer.idReponse),
      modify.set('descriptionReponse', answer.descriptionReponse),
    );
  }

  Future<void> deleteAnswer(int idReponse) async {
    final collection = await _databaseService.getCollection('Reponses');
    await collection.deleteOne(where.eq('idReponse', idReponse));
  }
}
