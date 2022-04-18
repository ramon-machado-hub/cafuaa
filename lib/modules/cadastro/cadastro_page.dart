import 'package:cafua/controller/cadastro_page_controller.dart';
import 'package:cafua/controller/validator.dart';
import 'package:cafua/modules/cadastro/authentication_service.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/button/button.dart';
import 'package:cafua/widgets/input_text/input_text_widget.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final dataInputTextController =
    MaskedTextController(mask: "00/00/0000");
    final _form = GlobalKey<FormState>();
    final controller = Validator();
    final controllador = CadastroPageController();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Center(
            child: Text(
              'Cadastro         ',
              style: TextStyles.titleRegular,
            )),
        leading: BackButton(
          color: AppColors.background,
          onPressed: (){
            Navigator.pushReplacementNamed(context, "/login");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 18, bottom: 18),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // inputText("Nome", TextInputType.name, controller, Icons.description_outlined, false),
                InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.input,
                  iconColor: AppColors.primary,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  label: "Nome",
                  icon: Icons.description_outlined,
                  validator: controller.validateName,
                  controller: TextEditingController(),
                  onChanged: (value) {
                    controllador.onChange(nome: value);
                  },
                ),
                // inputText("Data de Nascimento", TextInputType.datetime, controller, Icons.date_range, false),
                InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.input,
                  iconColor: AppColors.primary,
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  label: "Data de Nascimento",
                  controller: dataInputTextController,
                  icon: Icons.date_range,
                  validator: controller.validateDate,
                  onChanged: (value) {
                    controllador.onChange(data_nascimento: value);
                  },
                ),
                // inputText("Email", TextInputType.emailAddress, controller,  Icons.alternate_email_outlined, false),
                InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.input,
                  iconColor: AppColors.primary,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  label: "Email",
                  icon: Icons.alternate_email_outlined,
                  validator: controller.validateEmail,
                  onChanged: (value) {
                    controllador.onChange(email: value);
                  },
                ),
                // inputText("Senha", TextInputType.visiblePassword, controller, Icons.vpn_key_outlined, true),
                InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.input,
                  iconColor: AppColors.primary,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  label: "Senha",
                  icon: Icons.vpn_key_outlined,
                  validator: controller.validatePassword,
                  onChanged: (value) {
                    controllador.onChange(senha: value);
                  },
                ),
                // inputText("Confirmação de senha", TextInputType.visiblePassword, controller, Icons.vpn_key_outlined, true),
                InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.input,
                  iconColor: AppColors.primary,
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  label: "Confirmação de senha",
                  icon: Icons.vpn_key_outlined,
                  validator: controller.validatePassword,
                ),

                Button(
                  colorButton: AppColors.buttonGame,
                  label: 'Cadastrar',
                  onTap: (){
                    if (_form.currentState!.validate()){
                      _form.currentState!.save();
                      AuthenticationService().signUp(
                          email: controllador.model.email!,
                          password: controllador.model.senha!).then((result) {
                          if (result == null){
                            Navigator.pushReplacementNamed(context, "/home");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                result,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ));
                          }
                      });
                    } else {
                      print('Invalido ');
                    }

                    print(controllador.model.nome);
                    print(controllador.model.dataNascimento);
                    print(controllador.model.email);
                    print(controllador.model.senha);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget inputText (String label, TextInputType type, Validator controller, IconData icon, bool obscureText) {
    return InputTextWidget(
      backgroundColor: AppColors.shape,
      borderColor: AppColors.input,
      iconColor: AppColors.primary,
      obscureText: obscureText,
      keyboardType: type,
      label: label,
      icon: icon,
      validator: controller.validatePassword,
    );
  }
}