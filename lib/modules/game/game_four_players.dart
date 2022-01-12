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

class GameFourPlayers extends StatefulWidget {
  const GameFourPlayers({Key? key}) : super(key: key);

  @override
  _GameFourPlayersState createState() => _GameFourPlayersState();
}

class _GameFourPlayersState extends State<GameFourPlayers> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.grey,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left:  0,
                child: SizedBox(
                  height: size.height * 0.145,
                  width: size.width,
                  child: ListCardsPlayer(
                    contCards: 23,
                    height: size.height * 0.12 ,
                    width: size.width * 0.1,
                  ),
                ),
              ),
              Positioned(
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
              ),
            ],
          ),
        ),
      ),
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