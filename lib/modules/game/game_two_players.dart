import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';

class GameTwoPlayers extends StatefulWidget {
  const GameTwoPlayers({Key? key}) : super(key: key);

  @override
  _GameTwoPlayersState createState() => _GameTwoPlayersState();
}

class _GameTwoPlayersState extends State<GameTwoPlayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
      ),
    );
  }
}
