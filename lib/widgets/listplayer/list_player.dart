import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/button/button.dart';
import 'package:cafua/widgets/cardplayer/card_player.dart';
import 'package:flutter/material.dart';

class ListPlayer extends StatefulWidget {
  final String labelGame;
  final String imageGame;

  const ListPlayer({Key? key, required this.labelGame, required this.imageGame})
      : super(key: key);

  @override
  _ListPlayerState createState() => _ListPlayerState();
}

class _ListPlayerState extends State<ListPlayer> {
  var selectTwoPlayer = true;
  var selectFourPlayer = false;
  var colorCard = AppColors.buttonGame;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            //color: AppColors.input.withOpacity(0.3),
            height: size.height * 0.45,
            width: size.width - 30,
            decoration: BoxDecoration(
                color: AppColors.heading,
                borderRadius: BorderRadius.circular(10),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: AppColors.shape,
                    width: 3,
                  ),
                )),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: size.width / 4,
                            height: size.width / 4,
                            child: Image.asset(widget.imageGame)),
                        //child: Container(width: widget.width-20, height: widget.heigth/3 ,child: Image.asset(widget.logoCard)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DESAFIO",
                            style: TextStyles.titleListGame,
                          ),
                          Text(widget.labelGame,
                            style: TextStyles.titleLoginPage,
                          )
                        ],
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectTwoPlayer = true;
                            selectFourPlayer = false;
                            setState(() {});
                          },
                          child: CardPlayer(
                              color: selectTwoPlayer
                              ? colorCard
                              : AppColors.primary,
                              width: size.width / 3.3,
                              label: "2 Jogadores",
                              logoPerson: AppImages.twoPlayer),
                        ),
                        SizedBox(
                          width: (size.width-((size.width / 3)*2)+32)/4,
                        ),
                        GestureDetector(
                          onTap: (){
                            selectTwoPlayer=false;
                            selectFourPlayer=true;
                            selectFourPlayer=true;
                            setState(() {});
                          },
                          child: CardPlayer(
                              color: selectFourPlayer
                                  ? colorCard
                                  : AppColors.primary,
                              width: size.width / 3.3,
                              label: "4 Jogadores",
                              logoPerson: AppImages.fourPlayer),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ButtonTheme(
            minWidth: 200.0,
            height: 70.0,
            child: Button(
              label: 'JOGAR AGORA',
              onTap: (){
                Navigator.pushReplacementNamed(context, "/mesa");
              },
            ),
          ),
          /*
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/jogaronlineplayer");
            },
            child: Text('JOGAR AGORA',style: TextStyles.titleBoldBackground,),
            style: ElevatedButton.styleFrom(
              primary: AppColors.buttonGame,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
