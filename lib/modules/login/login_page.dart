import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/googlebutton/google_button.dart';
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
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      AppImages.logoFull,
                    )),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: Text(
                    "Divirta-se e convide seus amigos!",
                    textAlign: TextAlign.center,
                    style: TextStyles.titleRegular,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,20,30,0),
                  child: Button(
                      label: 'Novo cadastro',
                      onTap: (){
                        Navigator.pushReplacementNamed(context, "/cadastro");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,20,30,0),
                  child: GoogleButton(onTap: (){}),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30,20,30,0),
                  child: Button(
                      label: 'Entrar como convidado',
                      onTap: (){
                        Navigator.pushReplacementNamed(context, "/home");
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
