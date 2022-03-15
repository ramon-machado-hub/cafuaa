import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cafua/models/card_model3.dart';
import 'package:cafua/modules/game/game_two_controller.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/card/card3.dart';
import 'package:cafua/widgets/cardback/card_back.dart';
import 'package:flutter/cupertino.dart';
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
  final GlobalKey<AnimatedListState> listKeyCardBack = GlobalKey<AnimatedListState>();
  late GameTwoController _gameTwoController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _gameTwoController = GameTwoController(
      discard: false,
      isMyTurn: false,
      showAnimationDiscard: false,
      showAnimationSnoop: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<List<CardModel3>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel3.fromJson(e)).toList();
  }

  Future<void> darAsCartas(List<CardModel3> cards) async {
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
    int index = 0;
    for (int i = 0; i < 11; i++) {
      addSnoopedCardsOne();
      insertSnoopedCard(cardsTwo);
      insertSnoopedCard(deathOne);
      insertSnoopedCard(deathTwo);
      await Future.delayed(const Duration(milliseconds: 350), () {
        listKey.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 320));
        listKeyCardBack.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 320));
      });
    }
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        cardsOne.sort((a, b)  {
          listKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 1500));
          return a.numerator.compareTo(b.numerator);

        });
      });
    });
  }

  //retorna o widfactor da lista de cartas
  //de acordo com o tamanho e a quantidade de cartas
  double getWidfactor(double width, int contCards, double widthCard) {
    if (width<(contCards*widthCard)){
      return 1 - ((widthCard - (width / contCards)) / widthCard);
    } else{
      return 1;
    }


  }

  //retorna o indice que a carta será inserida em um novo jogo
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
      // print("inseriu " + bunch[0].characters + " de " + bunch[0].naipe);
      cards.insert(getIndex(cards, bunch[0]), bunch[0]);
      bunch.removeAt(0);
    }
  }

  //adiciona cartas desordenadas a cards one (animação cartas entrada do jogo)
  void addSnoopedCardsOne() {
    if (bunch.isNotEmpty) {
      print("inseriu " +
          bunch[0].numerator.toString() +
          " no indice " +
          getIndex(cardsOne, bunch[0]).toString());
      cardsOne.add(bunch[0]);
      bunch.removeAt(0);
    }
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

            if ((cardsOne.isEmpty) && (cardsTwo.isEmpty)) {
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

                    //container jogos adversários
                    //height 32%
                    Positioned(
                      top: size.height * 0.155,
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

                              //container pontos adversários
                              Positioned(
                                  bottom: 0, right: 0,
                                  child: showPoints("Eles: 0", size.width*0.25, size.height*0.045)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //container do lixo
                    // height 10%
                    Positioned(
                      top: size.height * 0.477,
                      left: size.width * 0.14,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: size.height * 0.1,
                          width: size.width * 0.656,
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
                      top: size.height * 0.58,
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
                          child: Stack(
                            children: [
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: showPoints("Nós: 30", size.width*0.25, size.height*0.045)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //monte do fuço
                    // height 10%
                    Positioned(
                      top: size.height * 0.477,
                      left: size.width * 0.03,
                      child: GestureDetector(
                        onTap: () {},
                        child: CardBack(
                          height: size.height * 0.1,
                          width: size.width * 0.1,
                        ),
                      ),
                    ),

                    // morto under
                    Positioned(
                        top: size.height * 0.495,
                        right: size.width * 0.03,
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: CardBack(
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                            ),
                          ),
                        )),


                    //morto top
                    Positioned(
                        top: size.height * 0.477,
                        right: size.width * 0.06,
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: CardBack(
                            height: size.height * 0.1,
                            width: size.width * 0.1,
                          ),
                        )),

                    //cartas da mão do adversário
                    //height 8%
                    Positioned(
                      top: size.height * 0.03,
                      left: size.width * 0.26,
                      child: SizedBox(
                          height: size.height * 0.1,
                          width: size.width * 0.72,
                          child: Center(
                            child: AnimatedList(
                                key: listKeyCardBack,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                initialItemCount: cardsTwo.length-1,
                                itemBuilder: (context, index, animation) {
                                  print(cardsTwo.length);
                                  return slidCardBack(context, index, animation,
                                    (size.width * 0.70), (size.width*0.1), cardsTwo.length,);
                                  //   Align(
                                  //   alignment: Alignment.bottomCenter,
                                  //   widthFactor: 1,
                                  //   child: CardBack(
                                  //     height: size.height * 0.10,
                                  //     width: size.width * 0.1,
                                  //   ),
                                  // );
                                }),
                          )),
                    ),

                    //barra do tempo adversário
                    Positioned(
                        top: size.height*0.137,
                        right: size.width*0.03,
                        child: barTime(size, true)
                        // child: barTime(size, _gameTwoController.isMyTurn)
                    ),

                    //barra de tempo player
                    Positioned(
                        top: size.height*0.905,
                        right: size.width*0.03,
                        child: barTime(size,false),
                    ),

                    //imagem player adversário
                    AnimatedPositioned(
                      duration: const Duration(seconds: 1),
                      bottom: _gameTwoController.isMyTurn
                          ? size.height * 0.812 + size.width * 0.125
                          : size.height * 0.812,
                      left: size.width * 0.05,
                      height: size.width * 0.18,
                      width: size.width * 0.18,
                      child: imagePlayer(
                          'https://thumbs.dreamstime.com/b/car%C3%A1ter-bonde-do-avatar-do-rob-85443716.jpg'),
                    ),

                    //imagem player
                    AnimatedPositioned(
                      duration: Duration(seconds: 1),
                      top: _gameTwoController.isMyTurn
                          ? size.height * 0.80
                          : size.height * 0.812 + size.width * 0.125,
                      left: size.width * 0.05,
                      height: size.width * 0.18,
                      width: size.width * 0.18,
                      child: imagePlayer('https://i.imgur.com/RaXDTdX.png'),
                    ),

                    //cartas da mão do jogador
                    //height 8%
                    Positioned(
                      top: size.height * 0.92,
                      left: 0,
                      child: SizedBox(
                        height: size.height * 0.1,
                        width: size.width,
                        child: Center(
                          child: AnimatedList(
                              key: listKey,
                              scrollDirection: Axis.horizontal,
                              initialItemCount: (cardsOne.length - 1),
                              itemBuilder: (context, index, animation) {
                                // print("entrou "+animation.value.toString());
                                return slideIt(context, index, animation);
                              }),
                        ),
                      ),
                    ),

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

  // Widget Death(double width, double height){
  //   return CardBack(height: height, width: width);
  // }

  Widget barTime(Size size, bool show){
    return Container(
      height: size.height * 0.01,
      width: size.width * 0.72,
      decoration: BoxDecoration(
          color: show ?
          AppColors.buttonGame : AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.cafua,
              width: 0.3,
            ),
          )),
    );
  }

  Widget showPoints(String value, double width, double height){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          topLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topRight: Radius.circular(0),
        ),
        // BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.shape,
              width: 1,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Opacity(
            opacity: 0.9,
            child: Text(value, style: TextStyles.titlePoints,)),
        ),
      ),
    );
  }

  //imagem dos jogadores
  Widget imagePlayer(String imagePlayer) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.heading,
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                color: AppColors.blue,
                width: 3,
              ),
            )),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imagePlayer)));
  }

  //lista cartas adversário
  Widget slidCardBack(BuildContext context, int index, animation, double width, double widthCard, int contCards) {
    print("Index = "+index.toString()+" contCards = "+gamesTwo.length.toString());
    return SlideTransition(
      child: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: getWidfactor(width, contCards, widthCard),
        child: CardBack(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
      ),
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
    );
  }

  //lista de cartas do player
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

//
//
// RotatedBox(
// quarterTurns: 1,
// child: new Text("Lorem ipsum")
// )