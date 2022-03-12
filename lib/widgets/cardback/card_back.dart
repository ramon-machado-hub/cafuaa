import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:flutter/material.dart';

class CardBack extends StatefulWidget {
  final  double height;
  final  double width;


  const CardBack({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  State<CardBack> createState() => _CardBackState();
}

class _CardBackState extends State<CardBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(3),
              border: Border.fromBorderSide(
                BorderSide(
                  color: AppColors.background,
                  width: 1,
                ),
              )),

        child: ClipRRect(
            borderRadius: BorderRadius.circular(
                3),

            child: Image.asset(AppImages.cardBack, fit: BoxFit.fill))

      );

  }
}
