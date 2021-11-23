class UserModel {
  final String? nome;
  final String? sobrenome;
  final String? email;
  final String? dataNascimento;
  final String? senha;
  final String? photoURL;

  UserModel(
      {this.nome,
      this.sobrenome,
      this.email,
      this.dataNascimento,
      this.senha,
      this.photoURL});

  UserModel copyWith({
    String? nome,
    String? sobrenome,
    String? email,
    String? dataNascimento,
    String? senha,
    String? photoURL,
  }) {
    return UserModel(
      nome: nome ?? this.nome,
      sobrenome: sobrenome ?? this.sobrenome,
      email: email ?? this.email,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      senha: senha ?? this.senha,
      photoURL: photoURL ?? this.photoURL,
    );
  }
}
