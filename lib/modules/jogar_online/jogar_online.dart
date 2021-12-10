import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/listgame/list_game.dart';
import 'package:flutter/material.dart';

class JogarOnline extends StatelessWidget {
  const JogarOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.background),
        backgroundColor: AppColors.primary,
        title: Text(
          'Jogar Online',
          style: TextStyles.titleAppbar,
        ),
      ),
      body:

      const Padding(

        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),

        child: ListGame(),
      ),

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
