import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  final double width;
  final double height;
  final String naipe;
  final String number;
  final Color color;
  final bool selected;

  const Cards({
    Key? key,
    required this.color,
    required this.width,
    required this.height,
    required this.naipe,
    required this.number,
    required this.selected,
  }) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {

  var _selected = false;

  void _handleTap() {
    setState(() {
      _selected = !_selected;
    });
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: _selected ? AppColors.buttonGame : AppColors.shape,
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
                    fit: BoxFit.contain,child: Text(widget.number, style: TextStyle(color: widget.color),)))),

            //naipe superior
            Positioned(
              top: widget.height*0.18,
              left: 2,
              child: SizedBox(
                height: widget.height*0.125,
                child: Image.asset(widget.naipe),
              ),
            ),

            //naipe central
            Center(child: Padding(
              padding: EdgeInsets.all(widget.width*0.15),
              child: SizedBox(
                  height: widget.height*0.4,
                  child: Image.asset(widget.naipe)),
            )),

            //naipe inferior
            Positioned(
              top: widget.height*0.66,
              right: 3,
              child: SizedBox(
                height: widget.height*0.125,
                child: Center(child: Image.asset(widget.naipe)),
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
                      child: Text(widget.number))),
            ),
          ],
        ),
      ),
    );
  }
}
