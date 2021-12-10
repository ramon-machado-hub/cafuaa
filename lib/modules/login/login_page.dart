import 'package:cafua/modules/entrar/login_with.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/button/button.dart';
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
                      top: 25, left: 50, right: 50, bottom: 20),
                  child: Text(
                    "Divirta-se e convide seus amigos!",
                    textAlign: TextAlign.center,
                    style: TextStyles.titleLoginPage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ButtonTheme(

                    minWidth: 200.0,
                    height: 70.0,
                    child: Button(
                      label: 'ENTRAR',
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const LoginWith(),
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 70.0,
                  child: Button(
                      label: 'CRIAR CONTA',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/cadastro");
                      }),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
