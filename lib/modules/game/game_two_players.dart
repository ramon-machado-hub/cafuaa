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
    with TickerProviderStateMixin {

  //final ValueNotifier<int> _counterBunch = ValueNotifier<int>(104);
  late AnimationController _controllerBarTime;
  late Animation<double> _animationBarTime;
  late AnimationController _controllerPulseAnimation;
  late Animation<double> _pulseAnimationBunch;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyCardBack = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyTrash = GlobalKey<AnimatedListState>();
  late GameTwoController _gameTwoController;

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

    _controllerPulseAnimation = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimationBunch = Tween<double>(begin: 0.5, end: 1.0).animate(
        _controllerPulseAnimation);
    // _controllerPulseAnimation.forward();

    _animationBarTime.addStatusListener((status) {
      if (status == AnimationStatus.completed){
        _controllerBarTime.stop();
      } else if (status == AnimationStatus.dismissed) {
        _controllerBarTime.forward();
      }
    });

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
    int index = 0;
    for (int i = 0; i < 11; i++) {
        addSnoopedCardsOne();
        insertSnoopedCard(cardsTwo);
        insertSnoopedCard(deathOne);
        insertSnoopedCard(deathTwo);
      if (i==10){ insertSnoopedCard(trash); }

      //é gerado uma animação para cara listkey
      await Future.delayed(const Duration(milliseconds: 360), () {

        listKey.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 320));
        setState(() {
          listKeyCardBack.currentState
              ?.insertItem(i, duration: const Duration(milliseconds: 320));
        });

        if (i==10) {
          listKeyTrash.currentState
              ?.insertItem(0, duration: const Duration(milliseconds: 320));

        }
      });
    }

    //animar a cada ordenamento
    await Future.delayed(const Duration(milliseconds: 1000), ()
    {
      cardsOne.sort((a, b) => a.numerator.compareTo(b.numerator));
    });
    _gameTwoController.startGame();
    _controllerPulseAnimation.forward();
    _controllerBarTime.forward(from: 0);
    //iniciar partida

    // _gameTwoController.setDiscard();
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

  //retorna indice da carta que será removida
  int getIndexRemovedCardsOne(CardModel3 card){
    return 1;
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
  
  //método que insere a primeira carta do fuço a mão passada como parametro
  void insertSnoopedCard(List<CardModel3> cards) {
    if (bunch.isNotEmpty) {
      cards.insert(getIndex(cards, bunch[0]), bunch[0]);
      bunch.removeAt(0);
    }
  }

  //método que adiciona cartas do lixo na mão passada como parametro.
  void insertTrashCards(List<CardModel3> cards){
    if (trash.isNotEmpty){
      cards.addAll(trash);
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

  }

  //adiciona cartas desordenadas a cards one (animação cartas entrada do jogo)
  void addSnoopedCardsOne() {
    if (bunch.isNotEmpty) {
      // print("inseriu " +
      //     bunch[0].numerator.toString() +
      //     " no indice " +
      //     getIndex(cardsOne, bunch[0]).toString());
      // cardsOne.insert(getIndex(cardsOne, bunch[0]), bunch[0]);
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
                              _controllerBarTime.forward(from: 0);
                              insertTrashCards(cardsOne);
                              _gameTwoController.takeTrashCards();
                              setState(() {

                              });
                            } else {
                                if(selectedCards.length!=1){
                                  showSnackBar("Selecionar ao menos uma carta");
                                } else {
                                  discartCard(selectedCards[0]);
                                  _controllerBarTime.value = 0;
                                  _controllerBarTime.stop();
                                  _gameTwoController.discardCard();
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
                          child: SizedBox(
                            height: size.height * 0.1,
                            width: size.width,
                            child: Center(
                              child: AnimatedList(
                                  key: listKeyTrash,
                                  scrollDirection: Axis.horizontal,
                                  initialItemCount: (trash.length),
                                  itemBuilder: (context, index, animation) {
                                    // print("entrou "+animation.value.toString());
                                    return slideTrash(context, index, animation);
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //jogos do player
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

                    //monte do fuço
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
                              // _gameTwoController.snoopCard=false;
                              // _gameTwoController.takeTrash=false;
                              // _gameTwoController.discard=true;
                              _controllerBarTime.forward(from: 0);
                              listKey.currentState
                                  ?.insertItem(index, duration: const Duration(milliseconds: 3000));
                              // Future.delayed(const Duration(milliseconds: 200), () {
                              // });
                              // _gameTwoController.setDiscard();
                            });
                          } else {
                            if (_gameTwoController.isMyTurn){
                              showSnackBar("Você ja fuçou sua vez");
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
                                  return slidCardBack(context, index, animation,
                                    (size.width * 0.70), (size.width*0.1), cardsTwo.length,);
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
                        top: size.height*0.904,
                        right: size.width*0.03,
                        child: GestureDetector(
                          onTap: (){
                            print("startou");
                            _controllerBarTime.forward(from: 0);
                          },
                            child: Container(
                              width: size.width * 0.72,
                              // color: AppColors.buttonGame,
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
                                key: ValueKey<double>(_controllerBarTime.value),
                                minHeight: 6,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                value:  _animationBarTime.value,
                              ),
                            ),
                        ),
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

  //barra do tempo2
  Widget barTime2(Size size){
    return Container(
      width: size.width*0.42,
      color: AppColors.buttonGame,
      child: LinearProgressIndicator(
        key: ValueKey<double>(_controllerBarTime.value),
        minHeight: 6,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        value:  _animationBarTime.value,
      ),
    );
  }

  //barra do tempo
  Widget barTime(Size size, bool show){
    return AnimatedContainer(
      duration: const Duration(seconds: 8),
      curve: Curves.linear,
      height: size.height * 0.01,
      width: show? size.width * 0.72: 0.01,
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
      child: AnimatedContainer(
        color: AppColors.primary,
        duration: Duration(seconds: 8),
        width: _gameTwoController.isMyTurn ?
          size.width*0.72 : 0,
        height: size.height*0.01,
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
  Widget slidCardBack(BuildContext context, int index, animation, double width, double widthCard, int contCards) {
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
  Widget slideIt(BuildContext context, int index,animation, ) {
    double width = MediaQuery.of(context).size.width;
    return SlideTransition(
      child: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: getWidfactor(width, cardsOne.length, width*0.1),
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
    return SlideTransition(
      child: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
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
