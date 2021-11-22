import 'package:cafua/modules/cadastro/cadastro_page.dart';
import 'package:cafua/modules/login/login_page.dart';
import 'package:cafua/modules/splash/splash_page.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cafua',
        theme: ThemeData(
            primarySwatch: Colors.orange, primaryColor: AppColors.primary),
        initialRoute: "/splash",
        routes: {
          "/splash": (context) => SplashPage(),
          "/login": (context) => LoginPage(),
          "/cadastro": (context) => CadastroPage(),
        });
  }
}
