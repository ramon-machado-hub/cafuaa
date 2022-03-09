import 'package:cafua/models/card_model3.dart';
import 'package:cafua/widgets/card/card2.dart';
import 'package:flutter/cupertino.dart';

class MyHands extends StatefulWidget {
  //final VoidCallback onTap;
  List<CardModel3> cards;
  MyHands({Key? key, required this.cards,}) : super(key: key);

  @override
  _MyHandsState createState() => _MyHandsState();
}

class _MyHandsState extends State<MyHands> {
  // AnimationController _animationController;
  // Animation<double> _positionedLeft;
  // Animation<double> _positionedTop;
  // Animation<Color> _colorAnimation;

  List<Cards2> listCards = [];
  List<Widget> _Tiles = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
