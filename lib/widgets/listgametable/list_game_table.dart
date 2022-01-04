import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/widgets/gamecardtable/game_card_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListGameTable extends StatefulWidget {

  const ListGameTable({Key? key}) : super(key: key);

  @override
  State<ListGameTable> createState() => _ListGameTableState();
}

class _ListGameTableState extends State<ListGameTable> {
  var index = 0;
  var selectAberto = true;
  var selectFechado = false;
  var selectStbl = false;
  var colorCard = AppColors.buttonGame;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15,15,15,0),
                child: Wrap(
                  direction: Axis.horizontal,

                  spacing: 15.0,
                  children: [
                    GestureDetector(
                        onTap: () {
                          colorCard = AppColors.buttonGame;
                          index = 0;
                          selectFechado=false;
                          selectAberto= true;
                          selectStbl=false;
                          setState(() {});
                        },
                        child: GameCardTable(
                            width: 65,
                            heigth: 100,
                            label: "Buraco ABERTO",
                            logoCard: AppImages.jogoCartas,
                            colorCard: selectAberto
                                ? colorCard
                                : AppColors.primary)
                    ),
                    GestureDetector(
                      onTap: () {
                        colorCard = AppColors.buttonGame;
                        index = 1;
                        selectFechado = true;
                        selectAberto= false;
                        selectStbl= false;
                        setState(() {});
                      },
                      child: GameCardTable(
                          width: 65,
                          heigth: 100,
                          label: "Buraco FECHADO",
                          logoCard: AppImages.trinca,
                          colorCard: selectFechado
                              ? colorCard
                              : AppColors.primary),
                    ),

                    GestureDetector(
                      onTap: () {
                        colorCard = AppColors.buttonGame;
                        index = 2;
                        selectFechado=false;
                        selectAberto= false;
                        selectStbl=true;
                        setState(() {});
                      },
                      child: GameCardTable(
                          width: 65,
                          heigth: 100,
                          label: "Buraco STBL",
                          logoCard: AppImages.jogoCartas,
                          colorCard: selectStbl
                              ? colorCard
                              : AppColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
