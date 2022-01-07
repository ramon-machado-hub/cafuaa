import 'package:cafua/arguments/table_two_arguments.dart';
import 'package:cafua/modules/cadastro/cadastro_page.dart';
import 'package:cafua/modules/game/game_two_players.dart';
import 'package:cafua/modules/home_page/home_page_teste.dart';
import 'package:cafua/modules/jogar_online/jogar_online.dart';
import 'package:cafua/modules/jogar_online/jogar_online_player.dart';
import 'package:cafua/modules/login/login_page.dart';
import 'package:cafua/modules/mesa/table_page2.dart';
import 'package:cafua/modules/mesa/table_page4.dart';
import 'package:cafua/modules/tableconfig/table_config.dart';
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

      //debugShowCheckedModeBanner: false,
        title: 'Cafua',
        theme: ThemeData(
            primarySwatch: Colors.orange, primaryColor: AppColors.primary),
        initialRoute: "/splash",
        routes: {
          "/home": (context) => const HomePageTeste(),
          "/splash": (context) => const  SplashPage(),
          "/login": (context) => const LoginPage(),
          "/cadastro": (context) => CadastroPage(),
          "/game2": (context) => const GameTwoPlayers(),
          "/tablepage2": (context) => TablePage2(arguments: ModalRoute.of(context)!.settings.arguments as TableTwoArguments,),
          "/tablepage4": (context) => const TablePage4(),
          "/jogaronline": (context) => const JogarOnline(),
          "/jogaronlineplayer": (context) => JogarOnlinePlayer(label: ModalRoute.of(context)!.settings.arguments.toString(),),
          "/jogarcomamigos": (context) => const TableConfig(),
        });
  }
}
