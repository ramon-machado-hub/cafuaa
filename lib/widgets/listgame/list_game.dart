import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/gamecard/card_teste.dart';
import 'package:cafua/widgets/gamecard/game_card.dart';
import 'package:cafua/widgets/labelbutton/label_button.dart';
import 'package:flutter/material.dart';

class ListGame extends StatelessWidget {
  const ListGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: AppColors.input.withOpacity(0.3),
            height: 260,
            width: size.width-30,
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(18,9,9,9),
                        child: GameCard(width: 65, heigth: 130,label: "Buraco FECHADO", logoCard: AppImages.trinca,),
                      ),

                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: GameCard(width: 65, heigth: 130,label: "Buraco ABERTO", logoCard: AppImages.jogoCartas,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: GameCard(width: 65, heigth: 130,label: "Buraco STBL", logoCard: AppImages.jogoCartas,),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.fromLTRB(16,8,8,8),
                        child: Container(
                          height: 130,
                          width: (size.width - 60) / 4,
                          color: Colors.white,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: (size.width - 60) / 4,
                          color: Colors.white,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: (size.width - 60) / 4,
                          color: Colors.white,
                        ),
                      ),*/
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 35,
                    //width: size.width - 40,
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                        child: Text(
                      "Regras do jogo",
                      style: TextStyles.titleBoldBackground,
                    )),
                  ),
                  const SizedBox(
                    height: 8
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                    Expanded(
                      flex: 1,
                        child: Text(
                          "Trinca",
                          style: TextStyles.titleIconButton,
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 45,
                        child: VerticalDivider(color: Colors.black),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Lixo fechado",
                          style: TextStyles.titleIconButton,
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 45,
                      child: VerticalDivider(color: Colors.black),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Bate com canastra limpa",
                          style: TextStyles.titleIconButton,
                          textAlign: TextAlign.center,
                        )),
                  ]),

                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {},
            child: Text('JOGAR',style: TextStyles.titleBoldBackground,),
            style: ElevatedButton.styleFrom(
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
