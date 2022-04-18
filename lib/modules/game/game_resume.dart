import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class GameResume extends StatefulWidget {
  const GameResume({Key? key}) : super(key: key);

  @override
  State<GameResume> createState() => _GameResumeState();
}

class _GameResumeState extends State<GameResume> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          gradient: RadialGradient(
        radius: 1.05,
        colors: [
          AppColors.primaryGradient,
          AppColors.primary,
        ],
      )),
      child: Column(
        children: [
          //resumo
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, size.height * 0.08, 0, size.height * 0.02),
            child: Text(
              "RESUMO DO JOGO",
              style: TextStyles.titleAppbar,
            ),
          ),
          //linha com as imagens dos players
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: size.height * 0.1,
                      width: size.height * 0.1,
                      child: imagePlayer('https://i.imgur.com/RaXDTdX.png')),
                  SizedBox(
                      width: size.height * 0.15,
                      child: Center(
                          child: Text(
                        "X",
                        style: TextStyles.titleAppbar,
                      ))),
                  SizedBox(
                      height: size.height * 0.1,
                      width: size.height * 0.1,
                      child: imagePlayer(
                          'https://thumbs.dreamstime.com/b/car%C3%A1ter-bonde-do-avatar-do-rob-85443716.jpg')),
                ]),
          ),

          //faixa vencedor
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, size.height * 0.03, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.red,
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: AppColors.background,
                      width: 2,
                    ),
                  )),
              height: size.height * 0.08,
              width: size.width,
              // color: AppColors.buttonGame,
              child: Center(
                  child: Text("VOCÊ PERDEU!!!",
                      style: TextStyles.titleLoginPage,
                      textAlign: TextAlign.center)),
            ),
          ),

          //tabela pontuação
          Container(
            width: size.width*0.75+4,
            height: size.height*0.40+4,

            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(0),
              ),
              color: AppColors.shape,
              border: Border.fromBorderSide(
                BorderSide(
                  color: AppColors.background,
                  width: 2,
                ),
              )),

            child: Column(
              children: [
                SizedBox(
                  height: size.height*0.05,
                  child: rowTable("200", "Canastras limpas", "200", size)
                ),
                 Divider(
                   height: 0,
                   color: AppColors.cafua,
                   thickness: 1,),
                SizedBox(
                    height: size.height*0.05,
                    child: rowTable("0", "Canastras sujas", "100", size)
                ),
                Divider(
                  height: 0,
                  color: AppColors.cafua,
                  thickness: 1,),
                SizedBox(
                    height: size.height*0.05,
                    child: rowTable("0", "Canastras de 500", "0", size)
                ),
                Divider(
                  height: 0,
                  color: AppColors.cafua,
                  thickness: 1,),
                SizedBox(
                    height: size.height*0.05,
                    child: rowTable("0", "Canastras Reais", "0", size)
                ),
                Divider(
                  height: 0,
                  color: AppColors.cafua,
                  thickness: 1,),
                SizedBox(
                    height: size.height*0.05,
                    child: rowTable("315", "Mesa", "370", size)
                ),
                Divider(
                  height: 0,
                  color: AppColors.cafua,
                  thickness: 1,),
                SizedBox(
                    height: size.height*0.05,
                    child: rowTable("100", "Batida", "0", size)
                ),
                Divider(
                  height: 0,
                  color: AppColors.cafua,
                  thickness: 1,),
                SizedBox(
                    height: size.height*0.05,
                    child: rowTable("- 100", "Cartas na mão", "- 5", size)
                ),
                Divider(
                  height: 0,
                  color: AppColors.cafua,
                  thickness: 1,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backPoints,
                    borderRadius: const BorderRadius.only(
                      bottomLeft:Radius.circular(5),
                      topLeft:  Radius.circular(0),
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(0),
                    )
                  ),
                  height: size.height*0.05,
                  width: size.width*0.75,
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.2,
                        child: const FittedBox(
                            fit: BoxFit.contain,
                            child:  Center(child: Text("515"))),
                      ),
                      SizedBox(
                        width: size.width*0.35,
                        child: Center(child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text("TOTAL", 
                              style: TextStyles.titleBoldBackground, ))),
                      ),
                      SizedBox(
                        width: size.width*0.2,
                        child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Center(child: Text("515"))),
                      )

                    ],
                  )
                ),

                // SizedBox(
                //     height: size.height*0.05,
                //     child: rowTable("- 100", "TOTAL", "- 5", size)
                // ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

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

  Widget rowTable(String points1, String label, String points2, Size size) {
    return Row(
      children: [
        Container(
          color: AppColors.blue,
          height: size.height*0.05,
          width: size.width*0.20,
          child: Center(child: FittedBox(
              fit: BoxFit.contain,
              child: Text(points1, style: TextStyles.titleBoldHeading,))),
        ),
        Container(
          color: AppColors.shape,
          height: size.height*0.05,
          width: size.width*0.35,
          child: Center(child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: EdgeInsets.fromLTRB(size.width*0.01,0,size.width*0.01,0),
                child: Text(label, style: TextStyles.titleBoldHeading,),
              ))),
        ),
        Container(
          color: AppColors.blue,
          height: size.height*0.05,
          width: size.width*0.20,
          child: Center(child: FittedBox(
              fit: BoxFit.contain,
              child: Text(points2, style: TextStyles.titleBoldHeading,))),
        ),
      ],
    );
  }
}
