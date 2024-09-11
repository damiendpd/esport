import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/event.dart';
import '../../lib/services/event_service.dart';

void main() {
  test('Should add and retrieve an event', () async {
    final eventService = EventService();
    
    final event = Event(
      idEvent: 1,
      libelleEvent: 'Tournoi Smash Bros',
    );
    
    await eventService.addEvent(event);
    
    final retrievedEvent = await eventService.getEvent(1);
    
    expect(retrievedEvent?.libelleEvent, 'Tournoi Smash Bros');
  });
}
