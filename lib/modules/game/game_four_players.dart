import 'dart:convert';
import 'dart:math';

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

class GameFourPlayers extends StatefulWidget {
  const GameFourPlayers({Key? key}) : super(key: key);

  @override
  _GameFourPlayersState createState() => _GameFourPlayersState();
}

class _GameFourPlayersState extends State<GameFourPlayers> {
  bool isSelected = false;
  bool isMyTurn = true;
  bool discard = false;
  String message = "mensagem";
  double opacity = 0;
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
        numerator: cards[list[i]].numerator,
        selected: false,
        color: cards[list[i]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i]].naipe.toString(),
        number: cards[list[i]].characters.toString(),
      ));
      cardsTwo.add(Cards2(
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

  //mensagem de avisos
  void editSnackBar(String message){
    snack = SnackBar(
      backgroundColor: AppColors.primary,
      content: Text(message, style: TextStyles.subTitleGameCard, textAlign: TextAlign.center,),
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.fromLTRB(
          20, 20, 20, 40),
      behavior: SnackBarBehavior.floating,
    );
  }

  //ordenar cartas player one
  void orderCards() {
    cardsOne.sort((a, b) => a.numerator.compareTo(b.numerator));
  }

  void SelectedCard(Cards2 card) {
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
  }

  //fuçar
  void snoop(int player) {
    selectedCards.add(bunch[bunch.length - 1]);
    print("fuçou = selected = " + selectedCards.length.toString());
    print(bunch[bunch.length - 1].selected);
    bunch[bunch.length - 1].selected = true;
    cardsOne.add(Cards2(
        numerator: bunch[bunch.length - 1].numerator,
        color: bunch[bunch.length - 1].color,
        width: bunch[bunch.length - 1].width,
        height: bunch[bunch.length - 1].height,
        naipe: bunch[bunch.length - 1].naipe,
        number: bunch[bunch.length - 1].number,
        selected: bunch[bunch.length - 1].selected));
    bunch.remove(bunch[bunch.length - 1]);
    orderCards();
  }

  //pegar lixo
  void TakeTrash() {
    cardsOne.addAll(trash);
    trash.clear();
    orderCards();
  }

  //jogada adversário
  void jogadaAdversario()  {
      cardsTwo.add(bunch.last);
      bunch.removeLast();
      cardsTwo.sort((a, b) => a.numerator.compareTo(b.numerator));
      trash.add(cardsTwo.first);
      cardsTwo.removeAt(0);
      setState(() {
        isMyTurn = true;
      });
  }

  //carregando cartas do json
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
            if (cardsOne.length > 10) {
              widthFactor =
                  ((((width / 10) * 9) / (cardsOne.length - 1)) / (width / 10));
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
                          onTap: (){
                            editSnackBar("Ops! Aqui fica os jogos do adversário.");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snack);
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
                        bottom: isMyTurn ? size.height * 0.785 :  size.height * 0.785-size.width * 0.125,
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

                      //imagem jogador 2 adversário
                     /* Positioned(
                        bottom: size.height * 0.785,
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
                      ),*/

                      //fuço
                      Positioned(
                        bottom: size.height * 0.395,
                        left: size.width * 0.05 / 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if ((isMyTurn) ) {
                                if (discard==false){
                                  //entra quando é a minha vez eesta bloqueado para descarte (false)
                                  snoop(1);//fuçou
                                  discard = true;//descarte está liberado
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
                            });
                          },
                          child: CardBack(
                            width: size.width * 0.15,
                            height: size.height * 0.13,
                          ),
                        ),
                      ),
                      /*
                      animated
                      Positioned(
                        left: size.width*0.05,
                        bottom:  size.height*0.54,
                        child: AnimatedOpacity(
                          child: Image.asset(AppImages.heart),
                          duration: const Duration(seconds: 10),
                          opacity: opacity,
                        ),
                      ),*/

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
                                  if (selectedCards.length==1){
                                    //remover pelo indice
                                    for (int i =0; i<cardsOne.length; i++){
                                        if (cardsOne[i].numerator ==
                                            selectedCards[0].numerator) {
                                          setState(() {
                                            cardsOne.removeAt(i);
                                          });
                                        }
                                    }
                                    selectedCards[selectedCards.length-1].selected=false;
                                    if (trash.isEmpty) {
                                      trash.addAll(selectedCards);
                                    } else {
                                      trash.add(selectedCards[0]);
                                    }
                                    selectedCards.clear();
                                    setState(() {
                                      isMyTurn = false;
                                    });
                                    discard = false;
                                    setState(() async {
                                      await Future.delayed(const Duration(seconds: 2));
                                      jogadaAdversario();
                                    });
                                    setState(() {
                                      isMyTurn = true;
                                    });
                                  }else{
                                    //Aviso "Selecionar uma carta para discarte"
                                    editSnackBar("Selecione uma carta para descarte.");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snack);
                                    print("saiu no aviso");
                                  }
                                } else {
                                  print("pegou lixo ----------------------");
                                  TakeTrash();
                                  discard = true;
                                  setState(() {

                                  });
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: trash.length,
                                    itemBuilder: (context, index) {
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      widthFactor: 1,
                                      child: Cards2(
                                        selected: trash[index].selected,
                                        color: trash[index].color,
                                        width: size.height * 0.075,
                                        height: size.height * 0.14,
                                        naipe: trash[index].naipe.toString(),
                                        number: trash[index].number.toString(),
                                        numerator: trash[index].numerator,
                                      ),
                                    );
                                  })
                                : const Center(
                                    child:
                                        Text("DESCARTE UMA CARTA AQUI")),
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

                      //container jogos do player logado 20%
                      Positioned(
                        bottom: size.height * 0.15,
                        left: size.width * 0.05 / 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              print("discarte ismyturn = "+isMyTurn.toString());
                              print("discarte discard = "+discard.toString());
                              if (isMyTurn) {
                                if (discard){
                                  //arriar cartas selecionadas
                                  if (selectedCards.length<3){
                                    //snack "SELECIONE AO MENOS 3 CARTAS
                                    editSnackBar("Selecione ao menos 3 cartas para descer um jogo.");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snack);
                                  } else {
                                    //adicionando cartas selecionadas array de Games.
                                    gamesOne.add(selectedCards);
                                    for (int i =0; i<selectedCards.length; i++) {
                                      cardsOne.removeWhere((item) => item.numerator == selectedCards[i].numerator);
                                    }
                                    print("gamesOne[0].length"+gamesOne[0].length.toString());
                                    print("gamesOne[0][1].numerator."+gamesOne[0][1].numerator.toString());
                                    /*
                                      for (int i =0; i<cardsOne.length; i++){
                                        for (int j =0; j<selectedCards.length; j++) {
                                          if (cardsOne[i].numerator ==
                                              selectedCards[j].numerator) {

                                            games.add(GameCardsModel(cards: selectedCards));
                                            print("remove at "+i.toString());
                                            //print("cards.lenthg at "+games[]);
                                            cardsOne.removeAt(i);
                                          }
                                        }
                                      }*/
                                      selectedCards.clear();
                                      //games.addAll(selectedCards);
                                  }

                                } else{
                                  //aviso "VC DEVE FUÇAR OU PEGAR O LIXO."
                                  editSnackBar("Pegar carta do monte ou Pegar lixo.");
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
                                ?
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.height * 0.30,
                                        height: size.height * 0.119,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.fromBorderSide(
                                              BorderSide(
                                                color: AppColors.cafua,
                                                width: 1,
                                              ),
                                            )),
                                        child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: trash.length,
                                            itemBuilder: (context, index) {
                                              return Align(
                                                alignment: Alignment.bottomCenter,
                                                widthFactor: 0.5,
                                                child: Cards2(
                                                  selected: gamesOne[0][index].selected,
                                                  color: gamesOne[0][index].color,
                                                  width: size.height * 0.075,
                                                  height: size.height * 0.14,
                                                  naipe: gamesOne[0][index].naipe.toString(),
                                                  number: gamesOne[0][index].number.toString(),
                                                  numerator: gamesOne[0][index].numerator,
                                                ),
                                              );
                                            })

                                        /*
                                        ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemCount: gamesOne[0].length,
                                                itemBuilder: (context, index) {
                                                  print("tesssssssssssste"+gamesOne[0].length.toString());
                                                  return Align(
                                                    alignment: Alignment.bottomCenter,
                                                    widthFactor: 1,
                                                    child: Cards2(
                                                      selected: gamesOne[0][index].selected,
                                                      color: (gamesOne[0][index].color == "red")
                                                          ? AppColors.red
                                                          : AppColors.black,
                                                      width: size.height * 0.075,
                                                      height: size.height * 0.14,
                                                      naipe: gamesOne[0][index].naipe.toString(),
                                                      number: gamesOne[0][index].number.toString(),
                                                      numerator: gamesOne[0][index].numerator,
                                                    ),);
                                                }),*/
                                      ),
                                    ],
                                  )
                                /*ListView.builder(
                                  itemCount: games.length,
                                  itemBuilder: (context, index) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  widthFactor: 1,
                                  child: Cards2(
                                    selected: trash[index].selected,
                                    color: (trash[index].color == "red")
                                        ? AppColors.red
                                        : AppColors.black,
                                    width: size.height * 0.075,
                                    height: size.height * 0.14,
                                    naipe: trash[index].naipe.toString(),
                                    number: trash[index].number.toString(),
                                    numerator: trash[index].numerator,
                                  ),
                                );
                              })*/
                                : const Center(
                                    child: Text("INSIRA SEUS JOGOS AQUI")),

                          ),
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
                              child: Text(
                            'Nós: 0',
                            style: TextStyles.subTitleGameCard,
                          )),
                        ),
                      ),

                      //imagem jogador logado
                      AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        top: isMyTurn ? size.height * 0.71 : size.height * 0.81 ,
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
                                    widthFactor: index == 0 ? 1 : widthFactor,
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
                                            /*print("index = "+index.toString()+" validacao in cardsOne[index].selected = "+cardsOne[index].selected.toString());
                                            print("tamanho selectedCards = "+selectedCards.length.toString());
                                            print("selectedCard isEmpity"+selectedCards.isEmpty.toString());
                                            print("item removido "+selectedCards[0].selected.toString());
                                            print("item selecionado "+cardsOne[index].selected.toString());
                                            print("item removido "+selectedCards[0].numerator.toString());
                                            print("item selecionado "+cardsOne[index].numerator.toString());
                                            print("contem "+selectedCards.contains(cardsOne[index]).toString());

                                             */
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

                      //qtd cartas player logado
                      AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          bottom: isMyTurn ? size.height * 0.23 : size.height * 0.13,
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
                                )
                            ),
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

                      //qtd cartas adversário
                      AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          top: isMyTurn? size.height * 0.15: size.height*0.23,
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
                                )
                            ),
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
        } //aqui
        );
  }


}
