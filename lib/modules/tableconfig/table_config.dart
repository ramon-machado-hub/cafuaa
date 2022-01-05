import 'package:cafua/arguments/table_two_arguments.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/button/button.dart';
import 'package:cafua/widgets/listgametable/list_game_table.dart';
import 'package:flutter/material.dart';

class TableConfig extends StatefulWidget {
  const TableConfig({Key? key}) : super(key: key);

  @override
  State<TableConfig> createState() => _TableConfigState();
}

class _TableConfigState extends State<TableConfig> {
  var colorCard = AppColors.buttonGame;
  var colorCardBackground = AppColors.primary;
  bool selectTwoPlayer = true;
  bool selectFourPlayer = false;
  int players = 2;
  bool checkBox1 = true;
  bool checkBox2 = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.background),
        backgroundColor: AppColors.primary,
        title: Text(
          'OPÇÕES DE JOGO',
          style: TextStyles.titleAppbar,
        ),
      ),
      body: Column(
          children: [
        //opçoes de jogo
        Center(child: const ListGameTable()),

        //divider
        Divider(
          height: 0,
          color: AppColors.shape,
          thickness: 2,
          endIndent: 20,
          indent: 20,
        ),

        //checkbox1 partida 3000 pontos
        Padding(
          padding: const EdgeInsets.fromLTRB(12,16,0,8),
          child: Container(
            height: 18,
            child: Row(
              children: [
                Checkbox(
                    value: checkBox1,
                    checkColor: AppColors.secondary,
                    activeColor: AppColors.shape,
                    onChanged: (newValue) {
                      setState(() {
                        checkBox2 = checkBox1;
                        checkBox1 = newValue!;

                      });
                    }),
                Text("Partida UNICA", style: TextStyles.titleCheckbox1,)
              ],
            ),
          ),
        ),

        //checkbox2 partida 3000 pontos
        Padding(
          padding: const EdgeInsets.fromLTRB(12,8,0,16),
          child: Container(
            height: 18,
            child: Row(
              children: [
                Checkbox(
                    value: checkBox2,
                    checkColor: AppColors.secondary,
                    activeColor: AppColors.shape,
                    onChanged: (newValue) {
                      setState(() {
                        checkBox1 = checkBox2;
                        checkBox2 = newValue!;
                        ;
                      });
                    }),
                Text("3000 PONTOS", style: TextStyles.titleCheckbox1,)
              ],
            ),
          ),
        ),

        //divider
        Divider(
          height: 0,
          color: AppColors.shape,
          thickness: 2,
          endIndent: 20,
          indent: 20,
        ),

        //players
        Padding(
          padding: const EdgeInsets.fromLTRB(0,12,0,4),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 15.0,
            children: [
              //two player
              GestureDetector(
                onTap: () {
                  players = 2;
                  selectTwoPlayer = true;
                  selectFourPlayer = false;
                  setState(() {});
                },
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.heading,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: selectTwoPlayer
                                ? colorCard
                                : colorCardBackground,
                            width: 3,
                          ),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(AppImages.twoPlayer),
                    )
                ),
              ),
              //four player
              GestureDetector(
                onTap: () {
                  players = 4;
                  selectTwoPlayer = false;
                  selectFourPlayer = true;
                  setState(() {});
                },
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.heading,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: selectFourPlayer
                                ? colorCard
                                : colorCardBackground,
                            width: 3,
                          ),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(AppImages.fourPlayer),
                    )
                ),
              ),
            ],
          ),
        ),

        //botão jogar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ButtonTheme(
              minWidth: 200.0,
              height: 60.0,
              child: Button(
                  colorButton: AppColors.buttonGame,
                  label: 'JOGAR',
                  onTap: () {
                    Navigator.pushNamed(context, "/tablepage2", arguments: TableTwoArguments("BURACO ABERTO", "PARTIDA ÚNICA"));
                    //Navigator.pushNamed(context, "/jogaronlineplayer", arguments: regras[index]);
                  }),
            ),
          ),
        ),
      ]),

      //anúncio
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: 50,
          height: 60,
          color: Colors.black,
          child: Center(
              child: Text(
            'Anúncio ADMob',
            style: TextStyles.titleBoldBackground,
          )),
        ),
      ),
    );
  }
}
