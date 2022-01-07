import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/card/card.dart';
import 'package:cafua/widgets/cardback/card_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameTwoPlayers extends StatefulWidget {
  const GameTwoPlayers({Key? key}) : super(key: key);

  @override
  _GameTwoPlayersState createState() => _GameTwoPlayersState();
}

class _GameTwoPlayersState extends State<GameTwoPlayers> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      //mesa
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [



            //container cartas adversários
            Positioned(
              bottom: size.height * 0.59,
              left: size.width*0.05/2,
              child: Container(
                height: size.height * 0.24,
                width: size.width*0.95,
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
                      child: CardBack(
                        width: size.width*0.23,
                        height: size.height * 0.2-2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //imagem jogador 2 adversário
            Positioned(
              top: size.height*0.1,
              left: 35,
              height: 80,
              width: 80,
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
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.network(
                        'https://avatarfiles.alphacoders.com/105/105223.jpg'),
                  )),
            ),



            //container do lixo 14%
            Positioned(
              bottom: size.height * 0.445,
              left: size.width*0.05/2,
              child: Container(
                height: size.height * 0.14,
                width: size.width*0.95,
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
                      child: CardBack(
                        width: size.width*0.15,
                        height: size.height * 0.13,
                      ),
                    ),
                    Positioned(
                      top: (size.height*0.01)/3,
                      left: size.width*0.16,
                      child:  Cards(
                        width: size.width * 0.13,
                        height:  size.height * 0.13,
                        naipe: AppImages.heart,
                        number: '3',
                        color: AppColors.red,
                      ),
                    ),

                    Positioned(
                        bottom: 3,
                        right: 15,
                        child: Text('LIXO'))],
                ),
              ),
            ),

            //container cartas do jogador 24%
            Positioned(
              bottom: size.height * 0.2,
              left: size.width*0.05/2,
              child: Container(
                height: size.height * 0.24,
                width: size.width*0.95,
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
                      child: CardBack(
                        width: size.width*0.23,
                        height: size.height * 0.2-2,
                      ),
                    ),
                    ],
                ),
              ),
            ),

            //imagem jogador logado
            Positioned(
              //quando for a vez do adversário alterar o bottom para
              top: size.height * 0.820,
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
                  child: Image.network('https://i.imgur.com/RaXDTdX.png')),
            ),

            //cartas jogador 15%
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.15,
                width: size.width,
                color: AppColors.stroke.withOpacity(0.4),
                child: Row(
                  children: [
                    Cards(
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.heart,
                      number: '3',
                      color: AppColors.red,
                    ),
                    Cards(
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.diamond,
                      number: '7',
                      color: AppColors.red,
                    ),
                    Cards(
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.diamond,
                      number: '8',
                      color: AppColors.red,
                    ),
                    Cards(
                      width: size.width * 0.15,
                      height: size.height * 0.15,
                      naipe: AppImages.club,
                      number: '10',
                      color: AppColors.cafua,
                    ),
                  ],
                ),
              ),
            ),

            //anuncio admob
            Positioned(
              top: 0,
              child: Container(
                color: AppColors.cafua,
                height: size.height * 0.1,
                width: size.width,
                child: Center(child: Text('ANUNCIO ADMOB',style: TextStyles.titleBoldBackground,)),
              ),
            ),
          ],
        ),
      ),
      //cartas do jogador 15%

    );
  }
}
