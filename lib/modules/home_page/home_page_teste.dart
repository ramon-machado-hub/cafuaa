import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/appbar/appbar_widget.dart';
import 'package:cafua/widgets/drawer/is_drawer_widget.dart';
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
          title: Text('Home', style: TextStyles.buttonBoldBackground,),
        ),
        drawer: IsDrawer(),
    );
  }
}
