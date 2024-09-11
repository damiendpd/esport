import 'package:mongo_dart/mongo_dart.dart';
import '../models/question.dart';
import '../services/database_service.dart';

class QuestionService {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addQuestion(Question question) async {
    final collection = await _databaseService.getCollection('Questions');
    await collection.insert(question.toMap());
  }

  Future<List<Question>> getQuestionsForEvent(int idEvent) async {
    final collection = await _databaseService.getCollection('Questions');
    var results = await collection.find({'idEvent': idEvent}).toList();
    return results.map((question) => Question.fromMap(question)).toList();
  }

  Future<void> updateQuestion(Question question) async {
    final collection = await _databaseService.getCollection('Questions');
    await collection.updateOne(
      where.eq('idQuestion', question.idQuestion),
      modify.set('libelleQuestion', question.libelleQuestion),
    );
  }

  Future<void> deleteQuestion(int idQuestion) async {
    final collection = await _databaseService.getCollection('Questions');
    await collection.deleteOne(where.eq('idQuestion', idQuestion));
  }
}
