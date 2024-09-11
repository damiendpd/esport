class Answer {
  final int idReponse;
  final int idQuestion;
  final String descriptionReponse;

  Answer({
    required this.idReponse,
    required this.idQuestion,
    required this.descriptionReponse,
  });

  Map<String, dynamic> toMap() {
    return {
      'idReponse': idReponse,
      'idQuestion': idQuestion,
      'descriptionReponse': descriptionReponse,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      idReponse: map['idReponse'],
      idQuestion: map['idQuestion'],
      descriptionReponse: map['descriptionReponse'],
    );
  }
}
