import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/widgets/appbar/appbar_widget.dart';
import 'package:cafua/widgets/registrationbutton/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: Container(
        color: AppColors.background,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(width: 0,height: 15),
            Container(
                width: 150,
                height: 150,
                child: Image.asset(
                  AppImages.logoFull,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(25,25,25,25),
              child: Button(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "/mesaconfig");
                  },
                  label: 'Jogar on-line'
              ),
            ),
            SizedBox(width: 0,height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25,25,25,25),
              child: Button(
                  onTap: (){}, label: 'Criar uma mesa'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
