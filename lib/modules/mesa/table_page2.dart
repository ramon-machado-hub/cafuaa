import 'package:cafua/arguments/table_two_arguments.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/button/button.dart';
import 'package:flutter/material.dart';

class TablePage2 extends StatefulWidget {
  final TableTwoArguments arguments;
  const TablePage2({
    Key? key, required this.arguments
  }) : super(key: key);

  @override
  _TablePage2State createState() => _TablePage2State();
}

class _TablePage2State extends State<TablePage2> {
  bool playerTwoIsLoged = false;
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
          'SALA DE ESPERA',
          style: TextStyles.titleAppbar,
        ),
      ),
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            //container tipo buraco + logoplayers
            /* Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,0),
              child: Container(
                height: size.height * 0.20,
                width: size.width*0.90,
                decoration: BoxDecoration(
                    color: AppColors.stroke,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.shape,
                        width: 2,
                      ),
                    )),
                child: Column(
                  children: [

                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          //imagem carta+label
                          Expanded(flex: 8, child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Image.asset(AppImages.jogoCartas),
                                const FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text("Buraco STBL")),
                              ],
                            ),
                          )),
                          //divider
                          Expanded(
                            flex: 1,
                            child: VerticalDivider(
                              color: AppColors.shape,
                              thickness: 1,
                            ),
                          ),
                          //logo jogador + label
                          Expanded(
                              flex: 8,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: Image.asset(
                                        AppImages.twoPlayer),
                                  ),
                                 const Expanded(
                                     flex: 4,
                                     child: FittedBox(
                                         fit: BoxFit.fitWidth,
                                         child: Padding(
                                           padding: EdgeInsets.fromLTRB(5,0,5,0),
                                           child: Text("2 JOGADORES"),
                                         ))),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.shape,
                      height: 0,
                      thickness: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                          children: const [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Partida 3.000 pontos",style: TextStyle(fontSize: 18),),
                            )
                          ],
                      ),
                    )
                  ],
                ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,0),
              child: Container(
                height: size.height*0.2,
                width: size.width*0.85,
               // color: AppColors.cafua.withOpacity(0.1),
                decoration: BoxDecoration(
                    color: AppColors.cafua.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.stroke,
                        width: 2,
                      ),
                    )
                  ),
                child: Column(
                  children: [
                    Container(color: AppColors.shape, width: double.infinity, height: size.height*0.2/4,child: Center(child: Text(widget.arguments.tipoJogo))),
                    Container(color: AppColors.stroke, width: double.infinity, height: size.height*0.2/4,child: Center(child: Text(widget.arguments.partida))),
                    //botão editar jogo
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(AppColors.heading),
                            textStyle: MaterialStateProperty.all<TextStyle>(TextStyles.titleIconButtonWhite),
                          ),
                          onPressed: () {},
                          child: const Text('Alterar Jogo'),

                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Row com os jogador1 x jogador2
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 12),
              child: SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //jogador1
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          //imagem jogador1
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: AppColors.heading,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.fromBorderSide(
                                    BorderSide(
                                      color: AppColors.buttonGame,
                                      width: 3,
                                    ),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.network(
                                    'https://i.imgur.com/RaXDTdX.png'),
                              )),
                          //texto jogador 1
                          Text(
                            "Ramon",
                            style: TextStyles.titleIconButtonWhite,
                          )
                        ],
                      ),
                    ),
                    //versos "X"
                    Expanded(
                      flex: 2,
                      child: Center(
                          child: Text(
                        "X",
                        style: TextStyles.titleAppbar,
                      )),
                    ),
                    //jogador2
                    Expanded(
                      flex: 4,

                      child: Column(
                        children: [
                          //imagem jogador2
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: AppColors.heading,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.fromBorderSide(
                                    BorderSide(
                                      color: AppColors.blue,
                                      width: 3,
                                    ),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(AppImages.perfil),
                              )),
                          //texto jogador 1
                          Text(
                            "AGUARDANDO",
                            style: TextStyles.titleIconButtonWhite,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //botão INICIAR PARTIDA
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: Button(
                      label: 'INICIAR PARTIDA',
                      colorButton: playerTwoIsLoged
                          ? AppColors.background
                          : AppColors.heading,
                      onTap: () {
                        Navigator.pushNamed(context, "/game2");
                      }),
                ),
              ),
            ),

            //botão convidar amigos
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: Button(
                      label: 'CONVIDAR AMIGOS',
                      colorButton: AppColors.buttonGame,
                      onTap: () {
                        Navigator.pushNamed(context, "/game2");
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
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
