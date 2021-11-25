import 'package:cafua/widgets/appbar/appbar_widget_jogo.dart';
import 'package:flutter/material.dart';

class MesaConfigPage extends StatefulWidget {
  const MesaConfigPage({Key? key}) : super(key: key);

  @override
  _MesaConfigPageState createState() => _MesaConfigPageState();
}

class _MesaConfigPageState extends State<MesaConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarJogoWidget(),


    );
  }
}
