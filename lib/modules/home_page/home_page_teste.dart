import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/appbar/appbar_widget.dart';
import 'package:cafua/widgets/drawer/is_drawer_widget.dart';
import 'package:cafua/widgets/registrationbutton/button.dart';
import 'package:flutter/material.dart';

class HomePageTeste extends StatefulWidget {
  const HomePageTeste({Key? key}) : super(key: key);

  @override
  _HomePageTesteState createState() => _HomePageTesteState();
}

class _HomePageTesteState extends State<HomePageTeste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyles.buttonBoldBackground,
        ),
      ),
      drawer: IsDrawer(),
      body: Container(
        color: AppColors.background,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(width: 0, height: 15),
            Container(
                width: 150,
                height: 150,
                child: Image.asset(
                  AppImages.logoFull,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: Button(
                  onTap: () {
                    Navigator.pushNamed(context, "/jogaronline");
                  },
                  label: 'Jogar on-line'),
            ),
            SizedBox(width: 0, height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 25),
              child: Button(onTap: () {
                Navigator.pushReplacementNamed(context, "/mesaconfig");
              }, label: 'Criar uma mesa'),
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
          child: Center(child: Text('Anúncio ADMob', style: TextStyles.titleBoldBackground,)),
        ),
      ),
    );
  }
}
