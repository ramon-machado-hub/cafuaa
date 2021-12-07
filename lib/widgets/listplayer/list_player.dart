import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            //color: AppColors.input.withOpacity(0.3),
            height: size.height * 0.5,
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
                            style: TextStyles.captionBackground,
                          ),
                          Text(widget.labelGame,
                            style: TextStyles.titleBoldBackground,
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
                        CardPlayer(
                            width: size.width / 3.5,
                            label: "2 Jogadores",
                            logoPerson: AppImages.twoPlayer),
                        SizedBox(
                          width: (size.width-((size.width / 3)*2)+32)/4,
                        ),
                        CardPlayer(
                            width: size.width / 3.5,
                            label: "4 Jogadores",
                            logoPerson: AppImages.fourPlayer)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          ),
        ],
      ),
    );
  }
}
