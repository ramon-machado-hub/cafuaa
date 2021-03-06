import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/listplayer/list_player.dart';
import 'package:flutter/material.dart';

class JogarOnlinePlayer extends StatefulWidget {
  final String label;
  const JogarOnlinePlayer({Key? key, required this.label}) : super(key: key);

  @override
  _JogarOnlinePlayerState createState() => _JogarOnlinePlayerState();
}

class _JogarOnlinePlayerState extends State<JogarOnlinePlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.background),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text(
          'JOGAR ONLINE',
          style: TextStyles.titleAppbar,
        ),
      ),
      body: Padding(

        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),

        child: ListPlayer(imageGame: AppImages.jogoCartas, labelGame: this.widget.label),
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
