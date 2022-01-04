import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameCardTable extends StatefulWidget {
  final double width;
  final double heigth;
  final String label;
  final String logoCard;
  final Color colorCard;
  const GameCardTable({Key? key,required this.width,required this.heigth,required this.label,required this.logoCard,required this.colorCard}) : super(key: key);

  @override
  State<GameCardTable> createState() => _GameCardTableState();
}

class _GameCardTableState extends State<GameCardTable> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width,
        height: widget.heigth,
        decoration: BoxDecoration(
            color: AppColors.heading,
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                color: widget.colorCard,
                width: 3,
              ),
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: widget.width-20, height: widget.heigth/3 ,child: Image.asset(widget.logoCard)),
            ),
            Text(widget.label, textAlign: TextAlign.center, style: TextStyles.subTitleGameCard, ),
          ],
        ),
      ),
    );
  }
}
