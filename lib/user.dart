class User {
  String? id;
  String nome;
  String sobrenome;
  String genero;
  int idade;
  String email;

  User({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.genero,
    required this.idade,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        nome: json['nome'],
        sobrenome: json['sobrenome'],
        genero: json['genero'],
        idade: json['idade'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'sobrenome': sobrenome,
        'genero': genero,
        'idade': idade,
        'email': email,
      };
}
