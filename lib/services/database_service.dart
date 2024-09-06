import 'package:mongo_dart/mongo_dart.dart';

class DatabaseService {
  Db? _db;

  Future<void> connect() async {
    _db = await Db.create('mongodb://localhost:27017/Esport');
    await _db!.open();
  }

  Future<DbCollection> getCollection(String collectionName) async {
    if (_db == null) {
      await connect();
    }
    return _db!.collection(collectionName);
  }

  Future<void> close() async {
    await _db?.close();
  }
}
