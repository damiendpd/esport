class Question {
  final int idEvent;
  final int idQuestion;
  final String libelleQuestion;

  Question({
    required this.idEvent,
    required this.idQuestion,
    required this.libelleQuestion,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEvent': idEvent,
      'idQuestion': idQuestion,
      'libelleQuestion': libelleQuestion,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      idEvent: map['idEvent'],
      idQuestion: map['idQuestion'],
      libelleQuestion: map['libelleQuestion'],
    );
  }
}
