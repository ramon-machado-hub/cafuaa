import 'dart:convert';

import 'package:cafua/models/card_model.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/widgets/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListCardsPlayer extends StatefulWidget {
  final int contCards;
  final double height;
  final double width;
  const ListCardsPlayer({Key? key,required this.height,required this.width,required this.contCards}) : super(key: key);

  @override
  _ListCardsPlayerState createState() => _ListCardsPlayerState();
}

class _ListCardsPlayerState extends State<ListCardsPlayer> {

  @override
  Widget build(BuildContext context) {
    double widthFactor = 1;
    if (widget.contCards>10) {
       widthFactor = ( (  ((widget.width / 10)*9) / (widget.contCards-1) ) /(widget.width / 10));
      // widthFactor = widget.width/(((widget.width / 10)*9)/(widget.contCards-1));
        print(widget.contCards);
        print(widget.width);
        print(widthFactor.toString());
    }
    final size = MediaQuery.of(context).size;
    bool selected = false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return  FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<CardModel>;
            return Container(
              height: widget.height,
              padding: const EdgeInsets.all(0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.contCards,/* == null ? 0 : items.length,*/
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.topCenter,
                      widthFactor: index == 0 ? 1 : widthFactor,
                      child: Cards(
                          selected: false,
                          color: (items[index].color == "red")
                              ? AppColors.red
                              : AppColors.black,
                          width: widget.width,
                          height: widget.height,
                          naipe: items[index].naipe.toString(),
                          number: items[index].characters.toString()),
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });

  }

  Future<List<CardModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('jsonfile/cards_json.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CardModel.fromJson(e)).toList();
  }
}