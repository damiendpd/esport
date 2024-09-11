import 'package:mongo_dart/mongo_dart.dart';
import '../models/event.dart';
import '../services/database_service.dart';

class EventService {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addEvent(Event event) async {
    final collection = await _databaseService.getCollection('Evenements');
    await collection.insert(event.toMap());
  }

  Future<Event?> getEvent(int idEvent) async {
    final collection = await _databaseService.getCollection('Evenements');
    var result = await collection.findOne({'idEvent': idEvent});
    if (result != null) {
      return Event.fromMap(result);
    }
    return null;
  }

  Future<List<Event>> getAllEvents() async {
    final collection = await _databaseService.getCollection('Evenements');
    var results = await collection.find().toList();
    return results.map((event) => Event.fromMap(event)).toList();
  }

  Future<void> updateEvent(Event event) async {
    final collection = await _databaseService.getCollection('Evenements');
    await collection.updateOne(
      where.eq('idEvent', event.idEvent),
      modify.set('libelleEvent', event.libelleEvent),
    );
  }

  Future<void> deleteEvent(int idEvent) async {
    final collection = await _databaseService.getCollection('Evenements');
    await collection.deleteOne(where.eq('idEvent', idEvent));
  }
}
