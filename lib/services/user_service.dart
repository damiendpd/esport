import 'package:mongo_dart/mongo_dart.dart';
import '../models/user.dart';
import '../services/database_service.dart';

class UserService {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addUser(User user) async {
    final collection = await _databaseService.getCollection('Utilisateurs');
    await collection.insert(user.toMap());
  }

  Future<User?> getUser(int idUtilisateurs) async {
    final collection = await _databaseService.getCollection('Utilisateurs');
    var result = await collection.findOne({'idUtilisateurs': idUtilisateurs});
    if (result != null) {
      return User.fromMap(result);
    }
    return null;
  }
}
