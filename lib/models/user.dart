class User {
  final int idUtilisateurs;
  final String email;

  User({
    required this.idUtilisateurs,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUtilisateurs': idUtilisateurs,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      idUtilisateurs: map['idUtilisateurs'],
      email: map['email'],
    );
  }
}
