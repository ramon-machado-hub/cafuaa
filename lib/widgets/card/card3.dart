import 'package:cafua/models/card_model3.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final CardModel3 card;
  final double height;
  final double width;

  CardWidget({
    Key? key,
    required this.card,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with SingleTickerProviderStateMixin{

  // late AnimationController _controller;
  // late Animation <double> _animation;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(milliseconds: 1000),
    //   vsync: this,
    // );
    //
    // _controller.forward();
    // _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.card.selected ? AppColors.buttonGame : AppColors.shape,
          borderRadius: BorderRadius.circular(3),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.cafua,
              width: 1,
            ),
          )),
      child: Stack(
        children: [
          //número superior
          Positioned(
              top: 0,
              left: 3,
              child: SizedBox(height: widget.height*0.2,child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    widget.card.characters,
                    style: TextStyle(color: (widget.card.color=="red") ? AppColors.red : AppColors.black,),)))),

          //naipe superior
          Positioned(
            top: widget.height*0.18,
            left: 2,
            child: SizedBox(
              height: widget.height*0.125,
              child: Image.asset(widget.card.naipe),
            ),
          ),

          //naipe central
          Center(child: Padding(
            padding: EdgeInsets.all(widget.width*0.15),
            child: SizedBox(
                height: widget.height*0.4,
                child: Image.asset(widget.card.naipe)),
          )),

          //naipe inferior
          Positioned(
            top: widget.height*0.66,
            right: 3,
            child: SizedBox(
              height: widget.height*0.125,
              child: Center(child: Image.asset(widget.card.naipe)),
            ),
          ),

          //numero inferior
          Positioned(
            bottom: 1,
            right: 3,
            child: SizedBox(
                height: widget.height*0.2,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(widget.card.characters))),
          ),
        ],
      ),
    );
  }
}