import 'package:cafua/models/user_model.dart';

class CadastroPageController {
  UserModel model = UserModel();

  void onChange({
    String? nome,
    String? sobrenome,
    String? data_nascimento,
    String? senha,
    String? email,
    String? photoUrl,
  }) {
    model = model.copyWith(
        nome: nome,
        sobrenome: sobrenome,
        dataNascimento: data_nascimento,
        email: email,
        photoURL: photoUrl,
        senha: senha,
    );
  }
}
