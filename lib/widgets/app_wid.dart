import 'package:cafua/modules/cadastro/cadastro_page.dart';
import 'package:cafua/modules/home_page/home_page.dart';
import 'package:cafua/modules/login/login_page.dart';
import 'package:cafua/modules/mesa/mesa_config_page.dart';
import 'package:cafua/modules/splash/splash_page.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWidget extends StatelessWidget {


  AppWidget(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.background));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cafua',
        theme: ThemeData(
            primarySwatch: Colors.orange, primaryColor: AppColors.primary),
        initialRoute: "/login",
        routes: {
          "/home": (context) => HomePage(),
          "/splash": (context) => SplashPage(),
          "/login": (context) => LoginPage(),
          "/cadastro": (context) => CadastroPage(),
          "/mesaconfig": (context) => MesaConfigPage(),
        });
  }
}
