import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/appbar/appbar_widget_jogo.dart';
import 'package:cafua/widgets/listgame/list_game.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  final String labelGame;
  final String imageGame;
  const TablePage({Key? key,required this.labelGame, required this.imageGame}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.background),
        backgroundColor: AppColors.primary,
        title: Text(
          'SALA DE ESPERA',
          style: TextStyles.titleAppbar,
        ),
      ),
      body: Expanded(
        child: Container(
          color: AppColors.input,
        ),
      )

      ,

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: 50,
          height: 60,
          color: Colors.black,
          child: Center(
              child: Text(
                'Anúncio ADMob',
                style: TextStyles.titleBoldBackground,
              )),
        ),
      ),
    );
  }
}
