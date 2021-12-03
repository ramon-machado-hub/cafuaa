import 'package:cafua/modules/entrar/login_with.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/registrationbutton/button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      AppImages.logoFull,
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 50, right: 50, bottom: 10),
                  child: Text(
                    "Divirta-se e convide seus amigos!",
                    textAlign: TextAlign.center,
                    style: TextStyles.titleRegular,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                  child: Button(
                      label: 'Criar uma conta',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/cadastro");
                      }),
                ),


                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                  child: Button(
                    label: 'Entrar',
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => const LoginWith(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
