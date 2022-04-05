import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cafua/models/card_model3.dart';
import 'package:cafua/modules/game/game_two_controller.dart';
import 'package:cafua/modules/game/validator_game.dart';
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
    with TickerProviderStateMixin {

  //final ValueNotifier<int> _counterBunch = ValueNotifier<int>(104);
  late AnimationController _controllerBarTime;
  late AnimationController _controllerBarTime2;
  late Animation<double> _animationBarTime;
  late Animation<double> _animationBarTime2;
  late AnimationController _controllerPulseAnimation;
  late Animation<double> _pulseAnimationBunch;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyCardBack = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyTrash = GlobalKey<AnimatedListState>();
  late GameTwoController _gameTwoController;
  final ValidatorGame _validator = ValidatorGame();

  @override
  void initState() {
    super.initState();
    _controllerBarTime = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    );

    _animationBarTime = Tween(begin: 0.0, end: 1.0)
        .animate(_controllerBarTime)
      ..addListener(() {setState(() {
        // print(_animationBarTime.value..toString());
      });
      });

    _animationBarTime.addStatusListener((status) {
      if (status == AnimationStatus.completed){
        _controllerBarTime.stop();
      } else if (status == AnimationStatus.dismissed) {
        _controllerBarTime.forward();
      }
    });

    _controllerBarTime2 = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    );

    _animationBarTime2 = Tween(begin: 0.0, end: 1.0)
        .animate(_controllerBarTime2)
      ..addListener(() {setState(() {
        // print(_animationBarTime.value..toString());
      });
      });

    _animationBarTime2.addStatusListener((status) {
      if (status == AnimationStatus.completed){
        _controllerBarTime2.stop();
      } else if (status == AnimationStatus.dismissed) {
        _controllerBarTime2.forward();
      }
    });

    _controllerPulseAnimation = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimationBunch = Tween<double>(begin: 0.5, end: 1.0).animate(
        _controllerPulseAnimation);

    _pulseAnimationBunch.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerPulseAnimation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllerPulseAnimation.forward();
      }
    });

    //iniciando os controladores como falso
    //ao dar as cartas, os controladores tomam suas devidas posições.
    _gameTwoController = GameTwoController(
      showAnimationSnoop: false,
      showAnimationTrash:  false,
      discard:  false,
      isMyTurn:  false,
      snoopCard: false,
      takeTrash: false
    );
  }

  @override
  void dispose() {
    _controllerBarTime.dispose();
    _controllerPulseAnimation.dispose();
    super.dispose();


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
    for (int i = 0; i < 11; i++) {
        addSnoopedCardsOne();
        insertSnoopedCard(cardsTwo);
        insertSnoopedCard(deathOne);
        insertSnoopedCard(deathTwo);

      //é gerado uma animação para as cartas do player one
      await Future.delayed(const Duration(milliseconds: 150), () {
        listKey.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 150));
      });
      await Future.delayed(const Duration(milliseconds: 250), () {
        // setState(() {
          listKeyCardBack.currentState
              ?.insertItem(i, duration: const Duration(milliseconds: 150));
        // });
      });

      if (i==10) {
        insertSnoopedCard(trash);
        await Future.delayed(const Duration(milliseconds: 250), () {
          listKeyTrash.currentState
              ?.insertItem(0, duration: const Duration(milliseconds: 250));
        });
      }
      setState(() { });
    }

    //animar a cada ordenamento
    await Future.delayed(const Duration(milliseconds: 1000), ()
    {
      cardsOne.sort((a, b) => a.numerator.compareTo(b.numerator));
    });
    //iniciar partida
    _gameTwoController.startGame();
    _controllerPulseAnimation.forward();
    _controllerBarTime.forward(from: 0);
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
      if (card.numerator <= cards[i].numerator) {
        return i;
      }
    }
    return cards.length;
  }

  //mensagem de avisos
  void showSnackBar(String message) {
    _gameTwoController.snack = SnackBar(
      backgroundColor: AppColors.primary,
      content: Text(
        message,
        style: TextStyles.subTitleGameCard,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(_gameTwoController.snack);    
  }

  //metodo jogada adversário
  Future<void> opponentMove() async{
    _controllerBarTime2.forward(from: 0);
   await Future.delayed(const Duration(milliseconds: 3000), () {
      insertSnoopedCard(cardsTwo);
      listKeyCardBack.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 1020));
    });
    _controllerBarTime2.forward(from: 0);
   await Future.delayed(const Duration(milliseconds: 3000), () {
      listKeyCardBack.currentState?.removeItem(
          0,
              (context, animation) => slidCardBack(context, 0, animation,),
          duration: const Duration(milliseconds: 1020));
      trash.add(cardsTwo[0]);
      listKeyTrash.currentState
          ?.insertItem(trash.length-1, duration: const Duration(milliseconds: 320));
      cardsTwo.removeAt(0);
    });
    _controllerBarTime2.value = 0;
    _controllerBarTime2.stop();
    _gameTwoController.opponentMove();
    _controllerBarTime.forward(from: 0);
  }


  //método que insere a primeira carta do fuço a mão passada como parametro
  void insertSnoopedCard(List<CardModel3> cards) {
    if (bunch.isNotEmpty) {
      cards.insert(getIndex(cards, bunch[0]), bunch[0]);
      bunch.removeAt(0);
    }
  }

  //método que adiciona cartas do lixo na mão passada como parametro.
  Future<void> insertTrashCards (List<CardModel3> cards) async {
    if (trash.isNotEmpty){
      // cards.addAll(trash);
      int index = 0;
      int cont = trash.length;
      print("trash.length "+trash.length.toString());
      for (int i =0; i< cont; i++){
        // insert(getIndex(cards, bunch[0]), bunch[0]);
        // await Future.delayed(const Duration(milliseconds: 1000), () {
        index = getIndex(cards, trash[0]);
        cards.insert(index, trash[0]);

        print("removeu trash[$i] = " + trash[0].characters);
        // trash.removeAt(0);
        listKey.currentState
            ?.insertItem(index, duration: const Duration(milliseconds: 3000));

        listKeyTrash.currentState?.removeItem(
            0,
            (context, animation) => slideTrash(context, 0, animation),
            // (i==(cont-1)) ? const SizedBox(height: 50, width: 50,) :
            duration: const Duration(milliseconds: 320));
        print("removeu trash[$i] = " + trash[0].characters);
        trash.removeAt(0);
        // });
      }

      // trash.clear();
      print(trash.length);
    }
  }

  //método discarta uma carta selecionada player one
  void discartCard(CardModel3 card){
    print("descartou");
    int index = cardsOne.lastIndexOf(card);
    listKey.currentState?.removeItem(
        index,
            (context, animation) => slideIt(context, index, animation,),
        duration: const Duration(milliseconds: 320));
    cardsOne.remove(card);
    card.selected = false;
    trash.add(card);
    listKeyTrash.currentState
        ?.insertItem(trash.length-1, duration: const Duration(milliseconds: 320));
    selectedCards.clear();
  }

  //adiciona cartas desordenadas a cards one (animação cartas entrada do jogo)
  void addSnoopedCardsOne() {
    if (bunch.isNotEmpty) {
      cardsOne.add(bunch[0]);
      bunch.removeAt(0);
    }
  }

  void selectCard(int index){
    if (cardsOne[index].selected){
      print("desselecionou");
      selectedCards.remove(cardsOne[index]);
      cardsOne[index].selected=false;
    } else {
      print("selecionou");
      selectedCards.add(cardsOne[index]);
      cardsOne[index].selected = true;
    }
    print(selectedCards.length.toString());
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
            // print(items.length);

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

                    //jogos adversários
                    //height 32%
                    Positioned(
                      top: size.height * 0.155,
                      left: size.width * 0.05 / 2,
                      child: GestureDetector(
                        onTap: () {
                          showSnackBar("Ops! Aqui ficam os jogos do seu adversário.");
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
                              //container pontos adversários
                              Positioned(
                                  top: 0, right: 0,
                                  child: showPoints("Eles: 0", size.width*0.25, size.height*0.045, false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Lixo
                    // height 10%
                    Positioned(
                      top: size.height * 0.477,
                      left: size.width * 0.14,
                      child: GestureDetector(
                        onTap: () {
                          print("lixo");
                          if (_gameTwoController.isMyTurn){

                            if(_gameTwoController.takeTrash){

                              insertTrashCards(cardsOne);
                              _controllerBarTime.forward(from: 0);
                              _gameTwoController.takeTrashCards();
                              setState(() {

                              });
                            } else {
                              if (_gameTwoController.discard){
                                if(selectedCards.length!=1){
                                  showSnackBar("Selecionar ao menos uma carta");
                                } else {
                                  discartCard(selectedCards[0]);
                                  _controllerBarTime.value = 0;
                                  _controllerBarTime.stop();
                                  _gameTwoController.discartCard();
                                  opponentMove();
                                }
                              } else {
                                showSnackBar("Aguarde sua vez");
                              }
                            }
                          }
                        },
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
                          child:
                          (trash.isNotEmpty) ?
                            AnimatedList(
                              key: listKeyTrash,
                              scrollDirection: Axis.horizontal,
                              initialItemCount: (trash.length),
                              itemBuilder: (context, index, animation) {
                                // print("entrou "+animation.value.toString()+ "index ="+index.toString());
                                return slideTrash(context, index, animation);
                            }) :

                              const Text("Aguardando carta."),

                        ),
                      ),
                    ),

                    //jogos do player
                    //height 32%
                    Positioned(
                      top: size.height * 0.58,
                      left: size.width * 0.05 / 2,
                      child: GestureDetector(
                        onTap: () {
                          if (_gameTwoController.discard){
                            if (_validator.isValid(selectedCards)){
                              showSnackBar("Jogo válido");
                              //inserir jogo
                            } else {
                              showSnackBar("Jogo Inválido");
                            }
                          } else {
                            if (_gameTwoController.takeTrash){
                              showSnackBar("FUÇAR ou PEGAR LIXO");
                            } else {
                              showSnackBar("Aguarde sua vez.");
                            }
                          }


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
                                  bottom: 0,
                                  right: 0,
                                  child: showPoints("Nós: 30", size.width*0.25, size.height*0.045, true)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //animação fuçar
                    Positioned(
                      bottom: size.height * 0.55,
                      left: size.width*0.08,
                      child: ScaleTransition(
                        scale: _pulseAnimationBunch,
                        child: Opacity(
                          opacity: _gameTwoController.snoopCard ? 1 : 0,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(AppImages.triangle),
                          ),
                        ),
                      ),
                    ),

                    //animação pegar lixo / discarte
                    Positioned(
                      bottom: size.height * 0.55,
                      left: size.width*0.13,
                      child: ScaleTransition(
                        scale: _pulseAnimationBunch,
                        child: Opacity(
                          opacity: ((_gameTwoController.takeTrash)||(_gameTwoController.discard)) ? 1 : 0,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(AppImages.triangle),
                          ),
                        ),
                      ),
                    ),

                    //FUÇO
                    // height 10%
                    Positioned(
                      top: size.height * 0.477,
                      left: size.width * 0.03,
                      child: GestureDetector(
                        onTap: () {
                          if ((_gameTwoController.isMyTurn)&(_gameTwoController.snoopCard)){
                            setState(() {
                              int index = getIndex(cardsOne, bunch[0]);
                              addSnoopedCardsOne();
                              _gameTwoController.snoopedCard();
                              _controllerBarTime.forward(from: 0);
                              listKey.currentState
                                  ?.insertItem(index, duration: const Duration(milliseconds: 3000));

                            });
                          } else {
                            if (_gameTwoController.isMyTurn){
                              showSnackBar("Você ja fuçou");
                            } else {
                              showSnackBar("Aguarde sua vez");
                            }
                          }
                        },
                        child: CardBack(
                          height: size.height * 0.1,
                          width: size.width * 0.1,
                        ),
                      ),
                    ),

                    //quantidade de cartas no fuço
                    Positioned(
                      top: size.height * 0.477,
                      right: size.width * 0.87,
                      child: GestureDetector(
                        onTap: (){
                          print(bunch.length);
                        },
                        child: contCards(bunch.length.toString(), size.width*0.06, size.width*0.06)
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
                                  // print(cardsTwo.length);
                                 return slidCardBack(context, index, animation,);
                                }),
                          )),
                    ),

                    //barra do tempo adversário
                    Positioned(
                        top: size.height*0.137,
                        right: size.width*0.03,
                        child: barTimeAnimated(_controllerBarTime2, _animationBarTime2, size),
                        // child: barTime(size, _gameTwoController.isMyTurn)
                    ),

                    //barra de tempo player
                    Positioned(
                        top: size.height*0.904,
                        right: size.width*0.03,
                        child: barTimeAnimated(_controllerBarTime, _animationBarTime, size),
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

                    //qtd cartas mão adversário
                    AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        bottom: _gameTwoController.isMyTurn
                            ? size.height * 0.812 + size.width * 0.125
                            : size.height * 0.812,
                        left: size.width*0.065,
                        height: size.width*0.05,
                        width: size.width*0.05,
                        child: contCards(
                            cardsTwo.length.toString(),
                            size.width*0.02,
                            size.width*0.02
                        ),
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

                    //qtd cartas mão do player
                    AnimatedPositioned(
                      duration: const Duration(seconds: 1),
                      top: _gameTwoController.isMyTurn
                          ? size.height * 0.80
                          : size.height * 0.812 + size.width * 0.125,
                      left: size.width*0.065,
                      height: size.width*0.05,
                      width: size.width*0.05,
                      child: contCards(
                          cardsOne.length.toString(),
                          size.width*0.02,
                          size.width*0.02
                      ),
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
                              initialItemCount: (cardsOne.length-1),
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

  //barra do tempo players
  Widget barTimeAnimated (AnimationController controller, Animation animation, Size size){
    return Container(
      width: size.width * 0.72,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.buttonGame,
              width: 0.5,
            ),
          )
      ),
      child: LinearProgressIndicator(
        key: ValueKey<double>(controller.value),
        minHeight: 6,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        value:  animation.value,
      ),
    );
  }

  //pontuação jogadores playerone (jogador logado) e adversario.
  Widget showPoints(String value, double width, double height,
      bool playerOne ){
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.only(
              bottomLeft: playerOne ? Radius.circular(0) : Radius.circular(5),
              topLeft: playerOne ? Radius.circular(5): Radius.circular(0),
              bottomRight:  playerOne ? Radius.circular(5) : Radius.circular(0),
              topRight: playerOne ? Radius.circular(0) : Radius.circular(5),
            ),
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

  //contador de cartas
  Widget contCards(String cont, double height, double width){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.cafua.withOpacity(0.65),
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.shape,
              width: 0.1,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(cont, style: TextStyles.titlePoints,),
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
  Widget slidCardBack(BuildContext context, int index, animation,) {
    double size = MediaQuery.of(context).size.width;
    return SlideTransition(
      child: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: getWidfactor(size*0.7, cardsTwo.length, size*0.1),
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
  Widget slideIt(BuildContext context, int index,animation, ) {
    double width = MediaQuery.of(context).size.width;
    return SlideTransition(
      child: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: (index==0) ?  1 : getWidfactor(width, cardsOne.length, width*0.1),
        child: GestureDetector(
          onTap: (){
            setState(() {
              selectCard(index);
            });
          },
          child: CardWidget(
              card: cardsOne[index],
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1),
        ),
      ),
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
    );
  }

  //lista cartas lixo
  Widget slideTrash(BuildContext context, int index, animation) {
    double size = MediaQuery.of(context).size.width;
    return SlideTransition(
      child: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: (index==0) ?  1 : getWidfactor(size*0.656, trash.length, size*0.1),
        child: CardWidget(
            card: trash[index],
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1),
      ),
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
    );
  }
}
