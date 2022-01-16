import 'dart:convert';

import 'package:cafua/data/cards_data.dart';
import 'package:cafua/models/card_model.dart';
import 'package:cafua/models/user_model.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/card/card.dart';
import 'package:cafua/widgets/cardback/card_back.dart';
import 'package:cafua/widgets/listcardsplayer/list_cards_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class GameTwoPlayers extends StatefulWidget {
  const GameTwoPlayers({Key? key}) : super(key: key);

  @override
  _GameTwoPlayersState createState() => _GameTwoPlayersState();
}

class _GameTwoPlayersState extends State<GameTwoPlayers> {
  int contCardLixo = 59;
  int contCardsPlayerOne = 11;
  int contCardsPlayertwo = 11;

  late List<Cards> items;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      //mesa
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            //container jogos dos adversários
            Positioned(
              bottom: size.height * 0.59,
              left: size.width * 0.05 / 2,
              child: Container(
                height: size.height * 0.24,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    color: AppColors.stroke,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.cafua,
                        width: 1,
                      ),
                    )),

                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Cards(
                        selected: false,
                        width: size.width / 10,
                        height: size.height / 10,
                        color: AppColors.cafua,
                        number: '3',
                        naipe: AppImages.spade,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //imagem jogador 2 adversário
            Positioned(
              top: size.height * 0.1,
              left: 35,
              height: 80,
              width: 80,
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.heading,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: AppColors.blue,
                          width: 3,
                        ),
                      )),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.stroke,
                      //size: 36.0,
                    ),
                  )),
            ),


            //fusso do lixo
            Positioned(
              bottom: size.height * 0.445,
              left: size.width * 0.05 / 2,
              child: GestureDetector(
                onTap: () {
                  contCardLixo--;
                  setState(() {});
                },
                child: CardBack(
                  width: size.width * 0.15,
                  height: size.height * 0.13,
                ),
              ),
            ),

            //quantidade cartas fusso
            Positioned(
                bottom: size.height * 0.445,
                left: size.width * 0.05 / 2,
                child: Container(
                  width: size.width * 0.07,
                  height: size.width * 0.07,
                  decoration: BoxDecoration(
                    color: AppColors.cafua.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: Text(contCardLixo.toString(),
                          style: TextStyles.subTitleGameCard,),
                      )),
                )),

            //pontuação player
            Positioned(
              bottom: size.height * 0.155,
              left: (size.width / 2) - (size.width * 0.25) / 2,
              child: Container(
                width: size.width * 0.25,
                height: size.height * 0.04,
                decoration: BoxDecoration(
                    color: AppColors.shape.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.shape,
                        width: 2,
                      ),
                    )),
                child: Center(
                    child: Text('Nós: 0', style: TextStyles.subTitleGameCard,)),
              ),
            ),


            //pontuação adversário
            Positioned(
              top: size.height * 0.12,
              left: (size.width / 2) - (size.width * 0.25) / 2,
              child: Container(
                width: size.width * 0.25,
                height: size.height * 0.04,
                decoration: BoxDecoration(
                    color: AppColors.shape.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.shape,
                        width: 2,
                      ),
                    )),
                child: Center(child: Text(
                  'Eles: 0', style: TextStyles.subTitleGameCard,)),
              ),
            ),

            //container do lixo 14%
            Positioned(
              bottom: size.height * 0.445,
              left: size.width * 0.2,
              child: Container(
                height: size.height * 0.14,
                width: size.width * 0.775,
                decoration: BoxDecoration(
                    color: AppColors.stroke,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.cafua,
                        width: 1,
                      ),
                    )),

                child: Stack(
                  children: [
                    Positioned(
                      top: (size.height * 0.01) / 3,
                      left: 2,
                      child: Cards(
                        selected: false,
                        width: size.width * 0.13,
                        height: size.height * 0.13,
                        naipe: AppImages.heart,
                        number: '3',
                        color: AppColors.red,
                      ),
                    ),

                    //label lixo
                    const Positioned(
                        bottom: 3,
                        right: 15,
                        child: Text('LIXO'))
                  ],
                ),
              ),
            ),

            //container cartas do jogador 24%
            Positioned(
              bottom: size.height * 0.2,
              left: size.width * 0.05 / 2,
              child: Container(
                height: size.height * 0.24,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    color: AppColors.stroke,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.cafua,
                        width: 1,
                      ),
                    )),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Cards(
                        selected: false,
                        width: size.width / 10,
                        height: size.height / 10,
                        color: AppColors.red,
                        number: '4',
                        naipe: AppImages.heart,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //imagem jogador logado
            Positioned(
              //quando for a vez do adversário alterar o bottom para
              top: size.height * 0.820,
              left: 35,
              height: 80,
              width: 80,
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.heading,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: AppColors.red,
                          width: 3,
                        ),
                      )),
                  child: Image.network('https://i.imgur.com/RaXDTdX.png')),
            ),

            //cartas jogador 15% heigth
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: size.height * 0.12,
                width: size.width,
                child:  ListCardsPlayer(

                  contCards: contCardsPlayerOne,
                  height: size.height * 0.12 ,
                  width: size.width * 0.1,
                ),

                /*ListView.builder(
                    scrollDirection: Axis.horizontal,

                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contCardsPlayertwo,/* == null ? 0 : items.length,*/
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topCenter,
                        widthFactor: index == 0 ? 1 : widthFactor,
                        child: Cards(
                            selected: false,
                            color: (items[index].color == "red")
                                ? AppColors.red
                                : AppColors.black,
                            width: size.width,
                            height: size.height * 0.12,
                            naipe: items[index].naipe.toString(),
                            number: items[index].characters.toString()),
                      );
                    }),*/

              ),
            ),
            /*Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.15,
                width: size.width,
                color: AppColors.stroke.withOpacity(0.4),
                child: Row(
                  children: [
                    Cards(
                      selected: false,
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.joker,
                      number: 'JOKER',
                      color: AppColors.red,
                    ),
                    Cards(
                      selected: false,
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.diamond,
                      number: '7',
                      color: AppColors.red,
                    ),
                    Cards(
                      selected: false,
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.diamond,
                      number: '8',
                      color: AppColors.red,
                    ),
                    Cards(
                      selected: false,
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.club,
                      number: '10',
                      color: AppColors.cafua,
                    ),
                  ],
                ),
              ),
            ),*/

            //anuncio admob
            Positioned(
              top: 0,
              child: Container(
                color: AppColors.cafua,
                height: size.height * 0.1,
                width: size.width,
                child: Center(child: Text(
                  'ANUNCIO ADMOB', style: TextStyles.titleBoldBackground,)),
              ),
            ),
          ],
        ),
      ),
      //cartas do jogador 15%

    );
  }

  Future<List<CardModel>>ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel.fromJson(e)).toList();
  }
}
