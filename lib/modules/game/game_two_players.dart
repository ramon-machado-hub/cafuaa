import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cafua/models/card_model3.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/card/card3.dart';
import 'package:cafua/widgets/cardback/card_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_colors.dart';

class GameTwoPlayers extends StatefulWidget {
  const GameTwoPlayers({Key? key}) : super(key: key);

  @override
  _GameTwoPlayersState createState() => _GameTwoPlayersState();
}

class _GameTwoPlayersState extends State<GameTwoPlayers>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();


  @override
  void initState() {
    super.initState();
     _controller = AnimationController(
       duration: const Duration(milliseconds: 1000),
       vsync: this,
     );
     _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    //  _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
    //   TweenSequenceItem<double>(
    //     tween: Tween<double>(begin: 30, end: 50),
    //     weight: 50,
    //   ),
    //   TweenSequenceItem<double>(
    //     tween: Tween<double>(begin: 50, end: 30),
    //     weight: 50,
    //   ),
    // ]).animate(_animation);

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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

  int getIndex(List<CardModel3> cards, CardModel3 card) {
    for (int i = 0; i < cards.length; i++) {
      if (card.numerator < cards[i].numerator) {
        return i;
      }
    }
    return cards.length;
  }

  //método que insere a primeira carta do fuço a mão passada como parametro
  void insertSnoopedCard(List<CardModel3> cards) {
    if (bunch.isNotEmpty) {
      print("inseriu "+bunch[0].characters+ " de "+bunch[0].naipe);
      cards.insert(getIndex(cards, bunch[0]), bunch[0]);
      bunch.removeAt(0);
    }
  }

  void addSnoopedCardsOne() {
    if (bunch.isNotEmpty) {
      print("inseriu "+bunch[0].numerator.toString()+" no indice "+getIndex(cardsOne, bunch[0]).toString());
      cardsOne.add(bunch[0]);
      bunch.removeAt(0);
    }
  }

  Future<List<CardModel3>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel3.fromJson(e)).toList();
  }

  Future<void> darAsCartas(List<CardModel3> cards) async{
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
      //adiciona cartas randomicas ao monte
      bunch.add(cards[verificador]);
      return verificador;
    });

    // dar as cartas embaralhadas sequencialmente:
    // player 1, player 2, morto 1, morto 2,
    int index=0;
    for (int i = 0; i <11; i++) {
      addSnoopedCardsOne();
      insertSnoopedCard(cardsTwo);
      insertSnoopedCard(deathOne);
      insertSnoopedCard(deathTwo);
      await Future.delayed(const Duration(milliseconds: 350), () {
        listKey.currentState?.insertItem(
            i, duration: const Duration(milliseconds: 320));
      });
    }
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        cardsOne.sort((a, b) => a.numerator.compareTo(b.numerator));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            print("erro ao carregar o json");
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<CardModel3>;
            print(items.length);

            if ((cardsOne.isEmpty) && (cardsTwo.isEmpty)){
                darAsCartas(items);
            }
              return SafeArea(
                  child: Scaffold(
                    body: Container(
                      height: 1000,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            radius: 1.05,
                            colors: [
                              AppColors.primaryGradient,
                              AppColors.primary,
                            ],
                          )),
                      child: Stack(
                        children: [
                          //anuncio admob
                          //height 10%
                          Positioned(
                            top: 0,
                            child: Container(
                              color: AppColors.cafua,
                              height: size.height * 0.1,
                              width: size.width,
                              child: Center(
                                  child: Text(
                                    'ANUNCIO ADMOB',
                                    style: TextStyles.titleBoldBackground,
                                  )),
                            ),
                          ),

                          //container jogos adversários
                          //height 32%
                          Positioned(
                            top: size.height * 0.14,
                            left: size.width * 0.05 / 2,
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                height: size.height * 0.32,
                                width: size.width * 0.95,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: AppColors.background,
                                        width: 1.5,
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
                                        card: cardsTwo[0],
                                      ),
                                    ),
                                    const Positioned(
                                        bottom: 0, right: 3, child: Text("ELES")),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //container do lixo
                          // height 10%
                          Positioned(
                            top: size.height * 0.463,
                            left: size.width * 0.2,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: size.height * 0.10,
                                width: size.width * 0.775,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: AppColors.background,
                                        width: 1.5,
                                      ),
                                    )),
                                child: Stack(
                                  children: const [
                                    Positioned(
                                        bottom: 0, right: 3, child: Text("Lixo")),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //container jogos do player
                          //height 32%
                          Positioned(
                            top: size.height * 0.566,
                            left: size.width * 0.05 / 2,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: size.height * 0.32,
                                width: size.width * 0.95,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: AppColors.background,
                                        width: 1.5,
                                      ),
                                    )),
                              ),
                            ),
                          ),

                          //monte do fuço
                          // height 10%
                          Positioned(
                            top: size.height * 0.463,
                            left: size.width * 0.05,
                            child: GestureDetector(
                              onTap: () {},
                              child: CardBack(
                                height: size.height * 0.1,
                                width: size.width * 0.1,
                              ),
                            ),
                          ),

                          //cartas da mão do jogador
                          //height 8%
                          AnimatedList(
                              key: listKey,
                              scrollDirection: Axis.horizontal,
                              initialItemCount: (cardsOne.length-1),
                              itemBuilder: (context, index, animation) {
                                // print("entrou "+animation.value.toString());
                                return slideIt(context, index, animation);
                              }
                           ),
                          /*Positioned(
                      top: size.height * 0.92,
                      left: 0,
                      child: SizedBox(
                        height: size.height * 0.12,
                        width: size.width,
                        child: ListView.builder(
                            key: ValueKey<List<CardModel3>>(cardsOne),
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cardsOne.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                widthFactor: 1,
                                child: CardWidget(
                                    card: cardsOne[index],
                                    height: size.height * 0.1,
                                    width: size.width * 0.1),
                              );
                            }),
                      ),
                    ),*/
                          /* ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: cardsOne.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            widthFactor: 1,
                            child: CardWidget(card: cardsOne[index],
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                            )
                           );

                      }*/


                        ],
                      ),
                    ),
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        });
  }
  Widget slideIt(BuildContext context, int index, animation) {
    return SlideTransition(
      child: Align(
          alignment: Alignment.bottomCenter,
          widthFactor: 1,
          child: CardWidget(
          card: cardsOne[index],
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.1),
      ),
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),

    );
  }

}

