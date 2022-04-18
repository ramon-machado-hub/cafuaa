import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cafua/models/card_model2.dart';
import 'package:cafua/models/game_cards_model.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/card/card.dart';
import 'package:cafua/widgets/card/card2.dart';
import 'package:cafua/widgets/cardback/card_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/animation/animation_controller.dart';

class GameFourPlayers extends StatefulWidget {
  const GameFourPlayers({Key? key}) : super(key: key);

  @override
  _GameFourPlayersState createState() => _GameFourPlayersState();
}

class _GameFourPlayersState extends State<GameFourPlayers> with TickerProviderStateMixin {
  int _increment = 0;

  void zeroIncrement(){
    _increment =0;
  }
  bool _isSniffing = false;
  bool _isPlayng = false;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  void animate() {
    _animationController.forward();
    setState(() {
      _isPlayng = ! _isPlayng;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
        _animationController);
    animate();
    _pulseAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _animationController.reverse();
      else if (status == AnimationStatus.dismissed)
        _animationController.forward();
    });
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
  }

  int indexCardSnooped =0;
  bool snooped = false;
  bool isSelected = false;
  bool isMyTurn = true;
  bool discard = false;
  String message = "mensagem";
  double opacity = 0;
  int points1 = 0;
  int points2 = 0;
  late SnackBar snack;
  List<GameCardsModel> games = [];
  List<List<Cards2>> gamesOne = [];
  List<Cards2> selectedCards = [];
  List<Cards2> cardsOne = [];
  List<Cards2> cardsTwo = [];
  List<Cards2> deathOne = [];
  List<Cards2> deathTwo = [];
  List<Cards2> trash = [];
  List<Cards2> bunch = [];

  //barallho
  List<CardModel2> cheap = [];
  double widthFactor = 1;
  double widthFactor2 = 1;

  /*
    primeiro é gerado um vetor randomico que enfatiza as cartas embaralhadas
    em seguida dar as cartas player one, player two, morto1 e morto2
    em seguida dar as cartas do fusso;
    em seguida dar as cartas do lixo;
   */
  void darAsCartas(List<CardModel2> cards, Size size) {
    var random = Random();
    List<int> list2 = [];
    //criado uma lista de indices randomicos referentes aos indices das cartas do baralho
    var list = List.generate(108, (index) {
      int verificador = random.nextInt(108);
      while (list2.contains(verificador)) {
        verificador = random.nextInt(108);
      }
      list2.add(verificador);
      return verificador;
    });

    //dar as cartas
    for (int i = 0; i < 44; i++) {
      cardsOne.add(Cards2(
        orderValue: cards[list[i]].orderValue,
        points: cards[list[i]].pontosCard,
        numerator: cards[list[i]].numerator,
        selected: false,
        color: cards[list[i]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i]].naipe.toString(),
        number: cards[list[i]].characters.toString(),
      ));
      cardsTwo.add(Cards2(
        orderValue: cards[list[i + 1]].orderValue,
        points: cards[list[i + 1]].pontosCard,
        numerator: cards[list[i + 1]].numerator,
        selected: false,
        color:
        cards[list[i + 1]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i + 1]].naipe.toString(),
        number: cards[list[i + 1]].characters.toString(),
      ));
      deathOne.add(Cards2(
        orderValue: cards[list[i + 2]].orderValue,
        points: cards[list[i + 2]].pontosCard,
        numerator: cards[list[i + 2]].numerator,
        selected: false,
        color:
        cards[list[i + 2]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i + 2]].naipe.toString(),
        number: cards[list[i + 2]].characters.toString(),
      ));
      deathTwo.add(Cards2(
        orderValue: cards[list[i + 3]].orderValue,
        points: cards[list[i + 3]].pontosCard,
        numerator: cards[list[i + 3]].numerator,
        selected: false,
        color:
        cards[list[i + 3]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i + 3]].naipe.toString(),
        number: cards[list[i + 3]].characters.toString(),
      ));
      i = i + 3;
    }
    //carta do lixo
    trash.add(Cards2(
      orderValue: cards[list[44]].orderValue,
      points: cards[list[44]].pontosCard,
      numerator: cards[list[44]].numerator,
      selected: false,
      color: cards[list[44]].color == "red" ? AppColors.red : AppColors.black,
      height: size.height * 0.12,
      width: size.width,
      naipe: cards[list[44]].naipe.toString(),
      number: cards[list[44]].characters.toString(),
    ));

    //cartas do morto
    for (int i = 45; i < 108; i++) {
      bunch.add(Cards2(
        orderValue: cards[list[i]].orderValue,
        points: cards[list[i]].pontosCard,
        numerator: cards[list[i]].numerator,
        selected: false,
        color: cards[list[i]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i]].naipe.toString(),
        number: cards[list[i]].characters.toString(),
      ));
    }
    //ordena cartas do player
    orderCards();
  }


  //retorna se é possível exibir animação em cima da carta do fuço
  bool showAimationSnoopMyTurn(){
    if ((isMyTurn==true)&&(discard==false ))
      return true;
    else
      return false;
  }

  //mensagem de avisos
  void editSnackBar(String message) {
    snack = SnackBar(
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
  }

  //ordenar cartas player one
  void orderCards() {
    cardsOne.sort((a, b) => a.numerator.compareTo(b.numerator));
  }

  //retorna pontos do jogo a ser arriado (selectedCards)
  int getPointsGame(List<Cards2> cards){
    int sum =0;
    for (int i =0;  i<cards.length;i++)
      sum+=cards[i].points;
    return sum;
  }

  //adicionando cartas gamesOne
  void addCardsGamesOne() {
    gamesOne.add(List<Cards2>.generate(
        selectedCards.length, (index) => selectedCards[index]));
    for (int i = 0; i < selectedCards.length; i++) {
      cardsOne
          .removeWhere((item) => item.numerator == selectedCards[i].numerator);
    }
    for (int i = 0; i < selectedCards.length; i++) {
      points1 += selectedCards[i].points;
    }

    selectedCards.clear();
  }

  void orderSelectedCards() {
    selectedCards.sort((a, b) => a.orderValue.compareTo(b.orderValue));
  }

  void SelectedCard(Cards2 card) {
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
  }

  //informa qual indice a carta foi inserida na mão do player one
  void setIndexCardsOneSnoop(Cards2 card){
    indexCardSnooped = cardsOne.length;
    for (int i=0; i<cardsOne.length; i++){
      if (card.numerator< cardsOne[i].numerator){
        print("entrou================="+i.toString());
        print(card.numerator);
        print(card.number);
        indexCardSnooped = i;
        i=cardsOne.length;
      }
    }
  }

  //fuçar
  void snoop(int player) {
    Timer(const Duration(milliseconds: 1400), () {
      setState(() {
        selectedCards.add(bunch[bunch.length - 1]);
        bunch[bunch.length - 1].selected = true;
        cardsOne.add(Cards2(
            orderValue: bunch[bunch.length - 1].orderValue,
            points: bunch[bunch.length - 1].points,
            numerator: bunch[bunch.length - 1].numerator,
            color: bunch[bunch.length - 1].color,
            width: bunch[bunch.length - 1].width,
            height: bunch[bunch.length - 1].height,
            naipe: bunch[bunch.length - 1].naipe,
            number: bunch[bunch.length - 1].number,
            selected: bunch[bunch.length - 1].selected));
        cardsOne.sort((a, b) => a.numerator.compareTo(b.numerator));
        bunch.remove(bunch[bunch.length - 1]);
      });
    });

  }

  //pegar lixo
  void TakeTrash() {
    cardsOne.addAll(trash);
    trash.clear();
    orderCards();
  }

  //jogada adversário
  void jogadaAdversario() {

    Timer(const Duration(seconds: 3), () {
      setState(() {
        cardsTwo.add(bunch.last);
        bunch.removeLast();
        cardsTwo.sort((a, b) => a.numerator.compareTo(b.numerator));
        trash.add(cardsTwo.first);
        cardsTwo.removeAt(0);
        isMyTurn = true;
      });
    });
  }

  //checa se existe um melé no jogo a ser inserido
  bool have2(List<Cards2> cards) {
    bool contain = cards.any((element) => element.number == "2");
    return contain;
  }

  //checa se existe um melé no jogo a ser inserido
  bool haveJoker(List<Cards2> cards) {
    bool contain = cards.any((element) => element.number == "JOKER");
    return contain;
  }

  bool haveA(List<Cards2> cards) {
    bool contain = cards.any((element) => element.number == "A");
    return contain;
  }

  int count2() {
    int count = 0;
    for (int i = 0; i < selectedCards.length; i++) {
      if (selectedCards[i].number == "2") count++;
    }
    return count;
  }

  int countJoker() {
    int count = 0;
    for (int i = 0; i < selectedCards.length; i++) {
      if (selectedCards[i].number == "JOKER") count++;
    }
    return count;
  }

  String naipeGame(List<Cards2> game) {
    if (haveA(game)) {
      for (int i = 0; i < game.length; i++) {
        if (game[i].number == "A") {
          return game[i].naipe;
        }
      }
    } else if (haveJoker(game)) {
      if (game[0].number == "JOKER") {
        return game[1].naipe;
      } else {
        return game[0].naipe;
      }
    } else if (have2(game)) {
      if (game[0].number == "2") {
        return game[1].naipe;
      } else {
        return game[0].naipe;
      }
    }
    return game[0].naipe;
  }

  bool validatorGame() {
    bool conditional = true;
    bool used2 = false;
    bool usedJoker = false;
    Cards2 aux;
    if (selectedCards.length < 3) {
      editSnackBar("Selecione ao menos 3 cartas para descer um jogo.");
      return false;
    }
    orderSelectedCards();
    print("order = 0 " +
        selectedCards.first.number +
        " value order = " +
        selectedCards.first.orderValue.toString());
    print("order = 1 " +
        selectedCards[1].number +
        " value order = " +
        selectedCards[1].orderValue.toString());
    print("order = 2 " +
        selectedCards.last.number +
        " value order = " +
        selectedCards.last.orderValue.toString());
    print("have2 " + have2(selectedCards).toString());
    print("haveA " + haveA(selectedCards).toString());
    print("haveJoker " + haveJoker(selectedCards).toString());
    print((have2(selectedCards) | haveJoker(selectedCards)).toString());
    if (haveA(selectedCards)) {
      if (have2(selectedCards)) {
        //A + 2
        if (selectedCards[2].number == "3") {
          print("entrou SE = 3 " + selectedCards[2].number);
          /*
                se o 3° numero é 3 e existe um mele e um az a sequencia devera
                ser: A 2 3 ... (ordenada)
                 */
          for (int i = 1; i < selectedCards.length; i++) {
            print("CARDS " + i.toString() + " - " + selectedCards[i].number);
            if (selectedCards[i].orderValue !=
                (selectedCards[i - 1].orderValue + 1)) {
              editSnackBar("Sequencia inválida.");
              return false;
            }
          }
        } else {
          print("não é 3 ultimo elemento = " + selectedCards.last.number);
          /*
                se o 3° elemento não é 3  checar jogos Q 2 A = 2 K A
                checa se o ultimo elemento é K ou Q caso contrario return false
                 */

          if (selectedCards.last.number == "K") {
            print("entrou k");
            /*
                    se o ultimo elemento é o "K"  empurrar o "A" para ultima posição
                    e checar se a lista possui buracos ex. [10 J 2 K A].
                    se não a lista ja estará ordenada.
                   */

            //empurra o Az para a primeira posição
            selectedCards.add(selectedCards.first);
            selectedCards.removeAt(0);

            print("K 0 " + selectedCards.first.number);
            print("K 1 " + selectedCards[1].number);
            print("K 2 " + selectedCards[2].number);
            print("K 3 " + selectedCards.last.number);
            //checa o vetor de traz pra frente a partir do penultimo elemento
            if (selectedCards.length > 3) {
              for (int i = selectedCards.length - 2; i > 1; i--) {
                if (selectedCards[i].orderValue !=
                    (selectedCards[i - 1].orderValue + 1)) {
                  if (used2 == true) {
                    editSnackBar("Sequencia inválida.");
                    return false;
                  } else {
                    aux = selectedCards[0];
                    for (int j = 0; j < i - 1; j++) {
                      selectedCards[j] = selectedCards[j + 1];
                    }
                    selectedCards[i - 1] = aux;
                    used2 = true;
                  }
                  print(i);
                  print("teste " + selectedCards[i].orderValue.toString());
                  print("teste " + selectedCards[i - 1].orderValue.toString());
                }
              }
            }
          } else {
            /*
                    checar o [Q 2 A] já que não possui o "K"
                   */
            if (selectedCards.last.number == "Q") {
              selectedCards.add(selectedCards[1]);
              selectedCards.add(selectedCards[0]);
              selectedCards.removeRange(0, 2);
            } else {
              editSnackBar("Sequencia inválida.");
              return false;
            }
          }
        }
      } else {
        /*
                  jogo com A sem 2 => EX. Q K A
                  empurra o A para ultima posição e checa do segundo indice em
                  diante decrescente se o antecessor é igual a atual -1
               */
        print("--------------**************" +
            selectedCards.last.orderValue.toString());
        if (selectedCards.last.orderValue != 13) {
          editSnackBar("Sequencia inválida.");
          return false;
        }
        //checar se a sequencia é decrescente
        for (int i = selectedCards.length - 1; i > 1; i--) {
          if (selectedCards[i].orderValue !=
              (selectedCards[i - 1].orderValue + 1)) {
            editSnackBar("Sequencia inválida.");
            return false;
          }
        }
        selectedCards.add(selectedCards[0]);
        selectedCards.removeAt(0);
      }
    } else {
      if (have2(selectedCards)) {
        /*
            jogo sem A com melé 2
         */
        for (int i = 1; i <= selectedCards.length - 2; i++) {
          if (selectedCards[i].orderValue !=
              (selectedCards[i + 1].orderValue - 1)) {
            if (used2 == true) {
              editSnackBar("Sequencia inválida.");
              return false;
            } else {
              print("entrou321321321");
              if (selectedCards[i].orderValue !=
                  (selectedCards[i + 1].orderValue - 2)) {
                editSnackBar("Sequencia inválida.");
                return false;
              }
              selectedCards.insert(i + 1, selectedCards[0]);
              selectedCards.removeAt(0);
            }
          }
        }
      }
    }

    return conditional;
  }

  double getWidfactorTrash(double width, int contCards) {
    //getWidfactorTrash(size.width * 0.775, trash.length),
    double result = 1;
    if (contCards > 6)
      result = ((((width / 6) * 5) / (trash.length - 1)) / (width / 6));

    //((((width * 0.7 / 6) * 5) / (cardsTwo.length - 1)) / (width * 0.7 / 6));
    return result;
  }

  double getWidfactorGame(double width, int contCards, double widthCard) {
    return 1 - ((widthCard - (width / contCards)) / widthCard);
  }

  double getWidfactorCardsOne(double width, int contCards, double widthCard) {
   if (contCards<=10){
     return 1;
   } else {
    return  ((((width / 10) * 9) / (cardsOne.length - 1)) / (width / 10));
   }
  }

  double getLeftAnimatedSnoop(double width, int contCards, double widthCard){
    double wid = getWidfactorCardsOne(width, contCards, widthCard);
    print("entrou getLeft");
    if (contCards>10){
      return (width / contCards)*(indexCardSnooped+1);
    } else {
      return widthCard - wid + (indexCardSnooped - 1) * (widthCard - wid);
    }
  }

  //carregando icartas do json
  Future<List<CardModel2>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel2.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width * 0.1;
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<CardModel2>;
            if (cardsOne.isEmpty) {
              darAsCartas(items, size);
            }
            if (cardsTwo.length > 6) {
              widthFactor2 =
              ((((width * 0.7 / 6) * 5) / (cardsTwo.length - 1)) /
                  (width * 0.7 / 6));
            }
            return SafeArea(
              child: Scaffold(
                body: Container(
                  color: AppColors.grey,
                  child: Stack(
                    children: [
                      //container jogos dos adversários
                      Positioned(
                        bottom: size.height * 0.54,
                        left: size.width * 0.05 / 2,
                        child: GestureDetector(
                          onTap: () {
                            editSnackBar(
                                "Ops! Aqui fica os jogos do adversário.");
                            ScaffoldMessenger.of(context).showSnackBar(snack);
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
                                  child: Cards(
                                    selected: false,
                                    width: size.width / 10,
                                    height: size.height / 10,
                                    color: AppColors.cafua,
                                    number: '3',
                                    naipe: AppImages.spade,
                                  ),
                                ),
                                const Positioned(
                                    bottom: 0, right: 3, child: Text("ELES")),
                              ],
                            ),
                          ),
                        ),
                      ),


                      //imagem player adversário
                      AnimatedPositioned(
                        duration: Duration(seconds: 1),
                        bottom: isMyTurn
                            ? size.height * 0.785
                            : size.height * 0.785 - size.width * 0.125,
                        left: size.width * 0.05,
                        height: size.width * 0.25,
                        width: size.width * 0.25,
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

                      //container do lixo 14%
                      Positioned(
                        bottom: size.height * 0.395,
                        left: size.width * 0.2,
                        child: GestureDetector(
                          onTap: () {
                            print("isMyturn == " + isMyTurn.toString());
                            print("discard == " + discard.toString());
                            if (isMyTurn) {
                              if (discard) {
                                //descartou uma carta selecionada
                                if (selectedCards.length == 1) {
                                  //remover pelo indice
                                  for (int i = 0; i < cardsOne.length; i++) {
                                    if ((cardsOne[i].numerator ==
                                        selectedCards[0].numerator) &&
                                        (cardsOne[i].selected == true)) {
                                      //removeu carta descartada da mão do playerOne
                                      setState(() {
                                        cardsOne.removeAt(i);
                                      });
                                    }
                                  }

                                  selectedCards[selectedCards.length - 1]
                                      .selected = false;
                                  setState(() {
                                    snooped = false;
                                  });

                                  //adiciona carta ao lixo
                                  Timer(const Duration(seconds: 2), () {
                                      isMyTurn = false;
                                      discard = false;
                                    if (trash.isEmpty) {
                                      trash.addAll(selectedCards);
                                    } else {
                                      trash.add(selectedCards[0]);
                                    }
                                    selectedCards.clear();
                                  });

                                  Timer(const Duration(seconds: 2), () {
                                    setState(() {
                                      jogadaAdversario();
                                    });
                                  });
                                } else {
                                  //Aviso "Selecionar uma carta para discarte"
                                  editSnackBar(
                                      "Selecione uma carta para descarte.");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                  print("saiu no aviso");
                                }
                              } else {
                                print("pegou lixo ----------------------");
                                TakeTrash();
                                discard = true;
                                setState(() {});
                              }
                              print("isMyturn == " + isMyTurn.toString());
                              print("discard == " + discard.toString());
                            } else {
                              print("NÃO É A SUA VEZ");
                            }
                          },
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
                            child: trash.isNotEmpty
                                ? ListView.builder(
                                physics:
                                const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: trash.length,
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    //color: cards[list[i]].color == "red" ? AppColors.red : AppColors.black,
                                    widthFactor: index == 0
                                        ? 1
                                        : getWidfactorTrash(
                                        size.width * 0.775,
                                        trash.length),
                                    child: Cards2(
                                      orderValue: trash[index].orderValue,
                                      points: trash[index].points,
                                      selected: trash[index].selected,
                                      color: trash[index].color,
                                      width: size.height * 0.075,
                                      height: size.height * 0.14,
                                      naipe: trash[index].naipe.toString(),
                                      number:
                                      trash[index].number.toString(),
                                      numerator: trash[index].numerator,
                                    ),
                                  );
                                })
                                : const Center(
                                child: Text("DESCARTE UMA CARTA AQUI")),
                          ),
                        ),
                      ),



                      //container jogos do player logado 20%
                      Positioned(
                        bottom: size.height * 0.15,
                        left: size.width * 0.05 / 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              print(
                                  "discarte ismyturn = " + isMyTurn.toString());
                              print("discarte discard = " + discard.toString());
                              if (isMyTurn) {
                                if (discard) {
                                  //arriar cartas selecionadas
                                  if (validatorGame() == false) {
                                    //snack "SELECIONE AO MENOS 3 CARTAS
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snack);
                                  } else {
                                    _increment = 0;

                                    setState(() {
                                      _increment = getPointsGame(selectedCards);
                                    });
                                    print(_increment.toString()+"aaaaaaaaaaaa");
                                    addCardsGamesOne();

                                  }
                                } else {
                                  //aviso "VC DEVE FUÇAR OU PEGAR O LIXO."
                                  editSnackBar(
                                      "Pegar carta do monte ou Pegar lixo.");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                }
                              } else {
                                //aviso  "AINDA não é sua vez;
                                editSnackBar("Aguarde sua vez.");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                              }
                            });
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
                            child: gamesOne.isNotEmpty
                                ? Wrap(
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                for (int i = 0; i < gamesOne.length; i++)
                                  Container(
                                      width: size.width * 0.28,
                                      height: size.height * 0.119,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border: Border.fromBorderSide(
                                            BorderSide(
                                              color: AppColors.cafua,
                                              width: 1,
                                            ),
                                          )),
                                      child: ListView.builder(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          scrollDirection:
                                          Axis.horizontal,
                                          itemCount: gamesOne[i].length,
                                          itemBuilder: (context, index) {
                                            return Align(
                                              alignment:
                                              Alignment.bottomLeft,
                                              widthFactor:
                                              getWidfactorGame(
                                                  size.width * 0.28,
                                                  gamesOne[i].length,
                                                  size.height *
                                                      0.075),
                                              child: Cards2(
                                                orderValue: gamesOne[i]
                                                [index]
                                                    .orderValue,
                                                points: gamesOne[i][index]
                                                    .points,
                                                selected: false,
                                                color: gamesOne[i][index]
                                                    .color,
                                                width:
                                                size.height * 0.075,
                                                height:
                                                size.height * 0.14,
                                                naipe: gamesOne[i][index]
                                                    .naipe
                                                    .toString(),
                                                number: gamesOne[i][index]
                                                    .number
                                                    .toString(),
                                                numerator: gamesOne[i]
                                                [index]
                                                    .numerator,
                                              ),
                                            );
                                          })),
                              ],
                            )
                                : const Center(
                                child: Text("INSIRA SEUS JOGOS AQUI")),
                          ),
                        ),
                      ),



                      //imagem jogador playerOne
                      AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        top: isMyTurn ? size.height * 0.71 : size.height * 0.81,
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
                            child: Image.network(
                                'https://i.imgur.com/RaXDTdX.png')),
                      ),

                      //qtd cartas player logado
                      AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          bottom: isMyTurn
                              ? size.height * 0.23
                              : size.height * 0.13,
                          left: size.width * 0.15,
                          child: Container(
                            width: size.width * 0.05,
                            height: size.width * 0.05,
                            decoration: BoxDecoration(
                                color: AppColors.cafua.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: AppColors.shape,
                                    width: 1.5,
                                  ),
                                )),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Text(
                                    cardsOne.length.toString(),
                                    style: TextStyles.subTitleGameCard,
                                  ),
                                )),
                          )),

                      //animação fuçando carta monte
                      AnimatedPositioned(
                        curve: Curves.easeInOutCirc,
                        duration: const Duration(seconds: 2),
                        top: (snooped) ? size.height : size.height * 0.418,
                        left: (snooped) ? getLeftAnimatedSnoop(size.width, cardsOne.length, width) : size.width * 0.05 / 2 ,
                        width: size.width * 0.15,
                        height: size.height * 0.13,
                        child: AnimatedOpacity(
                          opacity: (isMyTurn)? 1 : 1,
                          duration: Duration(seconds: 2),
                          child: CardBack(
                            width: size.width * 0.15,
                            height: size.height * 0.13,
                          ),
                        ),
                      ),

                      //fuço
                      Positioned(
                        bottom: size.height * 0.395,
                        left: size.width * 0.05 / 2,
                        child: GestureDetector(
                          onTap: () {
                              if ((isMyTurn)) {
                                if (discard == false) {
                                  //entra quando é a minha vez eesta bloqueado para descarte (false)
                                  setState(() {
                                    discard = true;
                                    snooped = true;
                                    snoop(1);//fuçou//descarte está liberado
                                    setIndexCardsOneSnoop(bunch[bunch.length - 1]);
                                  });
                                } else {
                                  //speak contendo aviso "Você já fuçou"
                                  print("speak contendo aviso Você já fuçou");
                                  editSnackBar("Você já fuçou.");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                }
                              } else {
                                //speak contendo aviso "Aguarde sua vez;
                                editSnackBar("Aguarde sua vez.");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                              }
                          },
                          child: CardBack(
                            width: size.width * 0.15,
                            height: size.height * 0.13,
                          ),
                        ),
                      ),

                      //Container com a quantidade de cartas fuço
                      Positioned(
                          bottom: size.height * 0.395,
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
                                  child: Text(
                                    bunch.length.toString(),
                                    style: TextStyles.subTitleGameCard,
                                  ),
                                )),
                          )),

                      //animação pontuação novo jogo
                      if (points1!=0)
                        Positioned(
                          bottom: size.height * 0.15,
                          left: (size.width / 2) - (size.width * 0.25) / 2,
                          child: AnimatedTextKit(
                            key: ValueKey<String>(_increment.toString()),
                            repeatForever: false,
                            totalRepeatCount: 2,
                            animatedTexts: [
                              ScaleAnimatedText('+ $_increment', textStyle: TextStyles.titleGameButton)
                            ],
                          ),
                        ),


                      //pontuação player 0.105 bottom
                      Positioned(
                        bottom: size.height * 0.105,
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
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  ScaleAnimatedText('Nós: $points1',)
                                ],
                              )
                            /*
                            Text(
                            'Nós: $points1',
                            style: TextStyles.subTitleGameCard,
                          )*/
                          ),
                        ),
                      ),



                      //animação fuçar indicador
                      ((isMyTurn)&&(discard==false)) ?
                      Positioned(
                        bottom: size.height * 0.55,
                        left: size.width*0.08,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(AppImages.triangle),
                          ),
                        ),
                      ) :
                      Positioned(
                        bottom: size.height * 0.55,
                        left: size.width*0.08,
                        child: Container(
                          height: 20,
                          width: 20,),
                      ),

                      //animação pegar lixo e discarte
                      (isMyTurn) ?
                      Positioned(
                        bottom: size.height * 0.55,
                        left: size.width*0.22,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(AppImages.triangle),
                          ),
                        ),
                      ) :
                      Positioned(
                        bottom: size.height * 0.55,
                        left: size.width*0.22,
                        child: Container(
                          height: 20,
                          width: 20,),
                      ),

                      //pontuação adversário
                      Positioned(
                        top: size.height * 0.13,
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
                              child: Text(
                                'Eles: 0',
                                style: TextStyles.subTitleGameCard,
                              )),
                        ),
                      ),

                      //listview cartas playerone ordenadas
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: SizedBox(
                            height: size.height * 0.12,
                            width: size.width,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: cardsOne.length,
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    widthFactor: index == 0 ? 1 : getWidfactorCardsOne(size.width, cardsOne.length, width),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          int indiceRemove = 100;
                                          print("carta selected = " +
                                              cardsOne[index]
                                                  .selected
                                                  .toString());
                                          if (cardsOne[index].selected ==
                                              true) {
                                            //encontra indice a ser removido
                                            for (int i = 0;
                                            i < selectedCards.length;
                                            i++) {
                                              if (selectedCards[i].numerator ==
                                                  cardsOne[index].numerator) {
                                                print("encontrou");
                                                indiceRemove = i;
                                                break;
                                              }
                                            }
                                            print("selected cardsOne");
                                            print("numerator " +
                                                selectedCards[0]
                                                    .numerator
                                                    .toString());
                                            print("naipe " +
                                                selectedCards[0]
                                                    .naipe
                                                    .toString());
                                            print("selected " +
                                                selectedCards[0]
                                                    .selected
                                                    .toString());
                                            print("number " +
                                                selectedCards[0]
                                                    .number
                                                    .toString());
                                            print("order " +
                                                selectedCards[0]
                                                    .orderValue
                                                    .toString());
                                            print("SelectedCards");
                                            print("numerator " +
                                                cardsOne[index]
                                                    .numerator
                                                    .toString());
                                            print("naipe " +
                                                cardsOne[index]
                                                    .naipe
                                                    .toString());
                                            print("selected " +
                                                cardsOne[index]
                                                    .selected
                                                    .toString());
                                            print("number " +
                                                cardsOne[index]
                                                    .number
                                                    .toString());
                                            //print("contem "+selectedCards.contains(cardsOne[index]).toString());
                                            selectedCards
                                                .removeAt(indiceRemove);
                                            cardsOne[index].selected = false;
                                            print(
                                                "validacao out selectedCards = " +
                                                    selectedCards.length
                                                        .toString());
                                          } else {
                                            selectedCards.add(cardsOne[index]);
                                            cardsOne[index].selected = true;
                                          }
                                          print("selectedCards === " +
                                              selectedCards.length.toString());
                                        });
                                      },
                                      child: Cards2(
                                        orderValue: cardsOne[index].orderValue,
                                        points: cardsOne[index].points,
                                        selected: cardsOne[index].selected,
                                        color: (cardsOne[index].color == "red")
                                            ? AppColors.red
                                            : AppColors.black,
                                        width: width,
                                        height: size.height * 0.1,
                                        naipe: cardsOne[index].naipe.toString(),
                                        number:
                                        cardsOne[index].number.toString(),
                                        numerator: cardsOne[index].numerator,
                                      ),
                                    ),
                                  );
                                }),
                          )),

                      //listview com o fundo das cartas do adversário
                      Positioned(
                        bottom: size.height * 0.825,
                        left: size.width * 0.31,
                        child: SizedBox(
                          height: size.height * 0.12,
                          width: size.width,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: cardsOne.length,
                              itemBuilder: (context, index) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  widthFactor: index == 0 ? 1 : widthFactor2,
                                  child: CardBack(
                                    height: size.height * 0.12,
                                    width: width,
                                  ),
                                );
                              }),
                        ),
                      ),



                      //qtd cartas adversário
                      AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          top: isMyTurn
                              ? size.height * 0.15
                              : size.height * 0.23,
                          left: size.width * 0.23,
                          child: Container(
                            width: size.width * 0.05,
                            height: size.width * 0.05,
                            decoration: BoxDecoration(
                                color: AppColors.cafua.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: AppColors.shape,
                                    width: 1.5,
                                  ),
                                )),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Text(
                                    cardsTwo.length.toString(),
                                    style: TextStyles.subTitleGameCard,
                                  ),
                                )),
                          )),

                      //anuncio admob
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
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}