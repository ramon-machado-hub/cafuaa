import 'package:cafua/controller/validator.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/input_text/input_text_widget.dart';
import 'package:cafua/widgets/registrationbutton/button.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  late String nome, data_nascimento, email, senha1, senha2;

  @override
  Widget build(BuildContext context) {
    final dataInputTextController =
    MaskedTextController(mask: "00/00/0000");
    final _form = GlobalKey<FormState>();
    final controller = Validator();
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
                 InputTextWidget(
                   keyboardType: TextInputType.name,
                   label: "Nome",
                   icon: Icons.description_outlined,
                   validator: controller.validateName,
                   //controller: moneyInputTextController,
                   /* função sem arrow function
                   controller: moneyInputTextController,
                   validator: (_) => controller.funcao(moneyInputTextController.numberValue.toString()),*/
                 ),
                 InputTextWidget(
                   keyboardType: TextInputType.name,
                   label: "Sobrenome",
                   icon: Icons.description_outlined,
                   validator: controller.validateName,
                 ),
                 InputTextWidget(
                   keyboardType: TextInputType.datetime,
                   label: "Data de Nascimento",
                   controller: dataInputTextController,
                   icon: Icons.date_range,
                   validator: controller.validateDate,
                   onChanged: (value){
                      data_nascimento = value.toString();
                   },
                 ),
                 InputTextWidget(
                   keyboardType: TextInputType.emailAddress,
                   label: "Email",
                   icon: Icons.alternate_email_outlined,
                   validator: controller.validateEmail,
                   onChanged: (value){
                     email = value.toString();
                   },
                 ),
                 InputTextWidget(
                   keyboardType: TextInputType.visiblePassword,
                   label: "Senha",
                   icon: Icons.vpn_key_outlined,
                   validator: controller.validatePassword,
                   onChanged: (value){
                     senha1 = value.toString();
                   },
                 ),
                 InputTextWidget(
                   keyboardType: TextInputType.name,
                   label: "Confirmação de senha",
                   icon: Icons.vpn_key_outlined,
                   validator: controller.validatePassword,
                   onChanged: (value){
                     senha2 = value.toString();
                   },
                 ),
                 Button(
                     label: 'Cadastrar',
                     onTap: (){
                        final isValid = _form.currentState!.validate();
                        print('valido '+isValid.toString());
                       // if (isValid){
                       /*InputTextWidget(
                        keyboardType: TextInputType.name,
                        label: "Email",
                         icon: Icons.alternate_email_outlined,
                         validator: controller.validateName,
                       ),*/
                     },
                 ),
               ],
             ),
          ),
        ),
      ),
    );
  }
}
