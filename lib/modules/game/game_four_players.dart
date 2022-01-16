import 'dart:convert';
import 'dart:math';

import 'package:cafua/data/cards_data.dart';
import 'package:cafua/models/card_model.dart';
import 'package:cafua/models/card_model2.dart';
import 'package:cafua/models/user_model.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/card/card.dart';
import 'package:cafua/widgets/card/card2.dart';
import 'package:cafua/widgets/cardback/card_back.dart';
import 'package:cafua/widgets/listcardsplayer/list_cards_player.dart';
import 'package:cafua/widgets/listcardsplayer/list_cards_player2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameFourPlayers extends StatefulWidget {
  const GameFourPlayers({Key? key}) : super(key: key);

  @override
  _GameFourPlayersState createState() => _GameFourPlayersState();
}

class _GameFourPlayersState extends State<GameFourPlayers> {
  bool isSelected = false;
  List<Cards> selectedCards = [];
  List<Cards2> cardsOne = [];
  List<Cards> cardsTwo = [];
  List<Cards> trash = [];
  List<Cards> bunch = [];
  List<CardModel2> cheap = [];
  double widthFactor = 1;


  void embaralhar(List<CardModel> cards, Size size) {
    var random = Random();
    List<int> list2 = [];
    var list = List.generate(108, (index) {
      int verificador = random.nextInt(108);
      while (list2.contains(verificador)){
        verificador = random.nextInt(108);
      }
        list2.add(verificador);
        return verificador;
    });
    print(list.toString());
    print(list2.toString());
  }

  //dar as cartas player one
  void darAsCartas(List<CardModel2> cards, Size size) {
    //embaralhar(cards, size);
    var random = Random();
    List<int> list2 = [];
    var list = List.generate(108, (index) {
      int verificador = random.nextInt(108);
      while (list2.contains(verificador)){
        verificador = random.nextInt(108);
      }
      list2.add(verificador);
      return verificador;
    });
    for (int i = 0; i < 12; i++) {
      cardsOne.add(Cards2(
        numerator: cards[list[i]].numerator,
        selected: false,
        color: cards[list[i]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[list[i]].naipe.toString(),
        number: cards[list[i]].characters.toString(),
      ));
    }
    //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    print(cardsOne.toString());
    cardsOne.sort((a,b)=> a.numerator.compareTo(b.numerator));
    print(cardsOne.toString());

    /*var random = Random();
    var l = List.generate(24, (_) => random.nextInt(100));
    print(l.toString());
    //cheap = ReadJsonData() as List<CardModel>;
    //Dar as 11 cartas aleatorias para cardsOne... gerada pela lista randomica "l"
    for (int i = 0; i < 12; i++) {
      cardsOne.add(Cards(
        selected: false,
        color: cards[l[i]].color == "red" ? AppColors.red : AppColors.black,
        height: size.height * 0.12,
        width: size.width,
        naipe: cards[l[i]].naipe.toString(),
        number: cards[l[i]].characters.toString(),
      ));
    }*/
  }

  void selectedCard(Cards card) {
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
  }

  Future<List<CardModel2>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel2.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width*0.1;
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<CardModel2>;
            darAsCartas(items, size);
            if (cardsOne.length>10) {
              print("ENTROU"+widthFactor.toString());
              widthFactor = ( (  ((width / 10)*9) / (cardsOne.length-1) ) /(width / 10));
              // widthFactor = ( (  ((widget.width / 10)*9) / (widget.contCards-1) ) /(widget.width / 10));
              print("SAIU"+widthFactor.toString());
            }
            print("cards one: "+cardsOne.length.toString());
            return SafeArea(
              child: Scaffold(
                body: Container(
                  color: AppColors.grey,
                  child: Stack(
                    children: [
                      //listCardsPlayer bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: SizedBox(
                          height: size.height * 0.12,
                          width: size.width,
                          //criar listview com cartas do jogador
                          child: ListCardsPlayer2(
                            onPressed: () {},
                            contCards: cardsOne.length,
                            height: size.height * 0.12,
                            width: size.width * 0.1,
                          ),
                        ),
                      ),

                      //listview cartas aleatorias top
                      Positioned(
                          top: 0,
                          left: 0,
                          child: SizedBox(
                            height: size.height * 0.12,
                            width: size.width,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: cardsOne.length,
                                itemBuilder: (context, index) {
                                  print("cards"+cardsOne.length.toString()+" widthFactor"+widthFactor.toString());
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    widthFactor: index == 0 ? 1 : widthFactor,
                                    child: Cards(
                                        selected: false,
                                        color: (cardsOne[index].color == "red")
                                            ? AppColors.red
                                            : AppColors.black,
                                        width: width ,
                                        height: size.height * 0.1,
                                        naipe: cardsOne[index].naipe.toString(),
                                        number:
                                            cardsOne[index].number.toString()),
                                  );
                                }),
                          ))
                      /* Positioned(
                  top:80,
                  left: 0,
                  child: SizedBox(
                    height: size.height * 0.145,
                    width: size.width * 0.95,
                    child: ListCardsPlayer(
                      contCards: 10,
                      height: size.height * 0.12 ,
                      width: size.width * 0.1,
                    ),
                  ),
                ),*/
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
/*  final size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<CardModel>;
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  height: size.height * 0.13,
                  padding: EdgeInsets.all(0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items == null ? 0 : items.length,
                      itemBuilder: (context, index) {
                        return Cards(
                            color: (items[index].color == "red")
                                ? AppColors.red
                                : AppColors.black,
                            width: size.width * 0.10,
                            height: size.height * 0.13,
                            naipe: items[index].naipe.toString(),
                            number: items[index].characters.toString());
                      }),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<CardModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel.fromJson(e)).toList();
  }
}
*/
