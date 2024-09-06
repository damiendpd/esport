class Event {
  final int idEvent;
  final String libelleEvent;

  Event({
    required this.idEvent,
    required this.libelleEvent,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEvent': idEvent,
      'libelleEvent': libelleEvent,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      idEvent: map['idEvent'],
      libelleEvent: map['libelleEvent'],
    );
  }
}
