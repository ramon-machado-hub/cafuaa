import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/gamecard/game_card.dart';
import 'package:flutter/material.dart';

class ListGame extends StatefulWidget {
  const ListGame({Key? key}) : super(key: key);

  @override
  State<ListGame> createState() => _ListGameState();
}

class _ListGameState extends State<ListGame> {
  final regras = ["ABERTO","FECHADO", "STBL"];
  var regraTrinca = "Sem trinca";
  var regraCanastra = "Bate com canastra LIMPA";
  var regraLixo =  "Lixo ABERTO";
  var index = 0;
  var selectFechado = false;
  var selectAberto = true;
  var selectStbl = false;

  @override
  var colorCard = AppColors.primary;

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 260,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,15,15,0),
                  child: Wrap(
                    direction: Axis.horizontal,

                   spacing: 15.0,
                    children: [
                      GestureDetector(
                          onTap: () {
                            colorCard = AppColors.primary;
                            index = 0;
                            regraTrinca = "Sem trinca";
                            regraCanastra = "Bate com canastra LIMPA";
                            regraLixo =  "Lixo ABERTO";
                            selectFechado=false;
                            selectAberto= true;
                            selectStbl=false;
                            setState(() {});
                          },
                          child: GameCard(
                              width: 65,
                              heigth: 130,
                              label: "Buraco ABERTO",
                              logoCard: AppImages.jogoCartas,
                              colorCard: selectAberto
                                  ? colorCard
                                  : AppColors.background)
                      ),
                      GestureDetector(
                        onTap: () {
                          colorCard = AppColors.primary;
                          index = 1;
                          regraTrinca = "Com trinca";
                          regraCanastra = "Bate com canastra SUJA";;
                          regraLixo =  "Lixo FECHADO";
                          selectFechado = true;
                          selectAberto= false;
                          selectStbl= false;
                          setState(() {});
                        },
                        child: GameCard(
                            width: 65,
                            heigth: 130,
                            label: "Buraco FECHADO",
                            logoCard: AppImages.trinca,
                            colorCard: selectFechado
                                ? colorCard
                                : AppColors.background),
                      ),

                      GestureDetector(
                        onTap: () {
                          colorCard = AppColors.primary;
                          index = 2;
                          regraTrinca = "Sem trinca";
                          regraCanastra = "Bate com canastra LIMPA";
                          regraLixo =  "Lixo Fechado";
                          selectFechado=false;
                          selectAberto= false;
                          selectStbl=true;
                          setState(() {});
                        },
                        child: GameCard(
                            width: 65,
                            heigth: 130,
                            label: "Buraco STBL",
                            logoCard: AppImages.jogoCartas,
                            colorCard: selectStbl
                                ? colorCard
                                : AppColors.background),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 35,
                  width: size.width - 40,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Text(
                      " Regras do jogo: ${regras[index]}",
                      style: TextStyles.titleListGame,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        regraTrinca,
                        style: TextStyles.subTitleGameCard,
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: 45,
                    child: VerticalDivider(color: Colors.black),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        regraLixo,
                        style: TextStyles.subTitleGameCard,
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: 45,
                    child: VerticalDivider(color: Colors.black),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        regraCanastra,
                        style: TextStyles.subTitleGameCard,
                        textAlign: TextAlign.center,
                      )),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(

            onPressed: () {
              Navigator.pushNamed(context, "/jogaronlineplayer");
            },
            child: Text(
              'JOGAR',
              style: TextStyles.titleGameButton1,
            ),

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
