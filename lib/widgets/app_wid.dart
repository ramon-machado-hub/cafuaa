import 'package:cafua/modules/cadastro/cadastro_page.dart';
import 'package:cafua/modules/home_page/home_page_teste.dart';
import 'package:cafua/modules/jogar_online/jogar_online.dart';
import 'package:cafua/modules/jogar_online/jogar_online_player.dart';
import 'package:cafua/modules/login/login_page.dart';
import 'package:cafua/modules/mesa/table_page.dart';
import 'package:cafua/modules/playwithfriends/play_with_friends.dart';
import 'package:cafua/modules/splash/splash_page.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWidget extends StatelessWidget {


  AppWidget({Key? key}) : super(key: key){
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
        initialRoute: "/splash",
        routes: {
          "/home": (context) => const HomePageTeste(),
          "/splash": (context) => const  SplashPage(),
          "/login": (context) => const LoginPage(),
          "/cadastro": (context) => CadastroPage(),
          "/mesa": (context) => TablePage(labelGame: ModalRoute.of(context)!.settings.arguments.toString(),imageGame: ModalRoute.of(context)!.settings.arguments.toString(),),
          "/jogaronline": (context) => const JogarOnline(),
          "/jogaronlineplayer": (context) => JogarOnlinePlayer(label: ModalRoute.of(context)!.settings.arguments.toString(),),
          "/jogarcomamigos": (context) => const PlayWithFriends(),
        });
  }
}
