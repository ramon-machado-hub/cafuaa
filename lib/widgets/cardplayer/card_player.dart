import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CardPlayer extends StatefulWidget {
  final double width;
  final String label;
  final String logoPerson;

  const CardPlayer(
      {Key? key,
      required this.width,
      required this.label,
      required this.logoPerson})
      : super(key: key);

  @override
  _CardPlayerState createState() => _CardPlayerState();
}

class _CardPlayerState extends State<CardPlayer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width,
        height: widget.width * 1.2,
        decoration: BoxDecoration(
            color: AppColors.heading,
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                color: AppColors.background,
                width: 3,
              ),
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Image.asset(widget.logoPerson)),
              //child: Container(width: widget.width-20, height: widget.heigth/3 ,child: Image.asset(widget.logoCard)),
            ),
            Text(
              widget.label,
              style: TextStyles.titleIconButton,
            )
          ],
        ),
      ),
    );
  }
}
