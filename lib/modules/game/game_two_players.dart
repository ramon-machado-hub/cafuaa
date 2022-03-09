import 'dart:convert';
import 'dart:math';

import 'package:cafua/models/card_model3.dart';
import 'package:cafua/widgets/card/card3.dart';
import 'package:cafua/widgets/myhands/my_hands.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_colors.dart';


class GameTwoPlayers extends StatefulWidget {
  const GameTwoPlayers({Key? key}) : super(key: key);

  @override
  _GameTwoPlayersState createState() => _GameTwoPlayersState();
}

class _GameTwoPlayersState extends State<GameTwoPlayers> {
  // AnimationController _animationController;
  // Animation<double> _Animation;
  // Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    // _animationController = AnimationController(
    //   duration: Duration(milliseconds: 200),
    //   vsync: this,
    // );
  }

  @override
  void dispose(){
    super.dispose();
    //_animationController.dispose();
  }
  //cartas do jogo
  List<List<CardModel3>> gamesOne = [];
  List<List<CardModel3>> gamesTwo = [];
  List<CardModel3> selectedCards = [];
  List<CardModel3> cardsOne = [];
  List<CardModel3> cardsTwo = [];
  List<CardModel3> deathOne = [];
  List<CardModel3> deathTwo = [];
  List<CardModel3> trash = [];
  List<CardModel3> bunch = [];



  Future<List<CardModel3>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel3.fromJson(e)).toList();
  }

  void darAsCartas(List<CardModel3> cards) {
    var random = Random();
    List<int> randomList = [];
    //criado uma lista de indices randomicos sem repetições
    // referentes aos indices das cartas do baralho
    var list = List.generate(108, (index) {
      int verificador = random.nextInt(108);
      while (randomList.contains(verificador)) {
        verificador = random.nextInt(108);
      }
      randomList.add(verificador);
      return verificador;
    });

    // dar as cartas embaralhadas sequencialmente:
    // player 1, player 2, morto 1, morto 2,
    for (int i = 0; i < 11; i++) {
      cardsOne.add(cards[i]);
      cardsTwo.add(cards[i+1]);
      deathOne.add(cards[i+2]);
      deathTwo.add(cards[i+3]);
      i+4;
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            print("erro ao carregar o json");
            return Center(child: Text("${data.error}"));
          }
          else
           if (data.hasData)   {
            var items = data.data as List<CardModel3>;
            print(items.length);
            darAsCartas(items);
            return SafeArea(
                child: Scaffold(
                  body: Container(
                    child: Stack(
                      children: [

                        //container jogos adversários
                        Positioned(
                          bottom: size.height * 0.54,
                          left: size.width * 0.05 / 2,
                          child: GestureDetector(
                            onTap: () {
                              // editSnackBar(
                              //     "Ops! Aqui fica os jogos do adversário.");
                              // ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
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
                                    child: CardWidget(
                                      width: size.width * 0.1,
                                      height: size.height * .1,
                                      selected: false,
                                      card: items[0],
                                    ),
                                  ),
                                  const Positioned(
                                      bottom: 0, right: 3, child: Text("ELES")),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //cartas da mão do jogador
                        MyHands(cards: cardsOne,)
                      ],
                    ),
                  ),
                )
            );
          } else {
             return const Center(
               child: CircularProgressIndicator(),
             );
          }
        }


    );
    }


      /*
      Scaffold(
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

            //container jogos do player one 24%
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

    );*/
  }






