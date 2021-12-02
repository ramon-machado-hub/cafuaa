import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {

  final VoidCallback onTap;
  final String imageButton;
  final String label;
  final Color colorButton;
  const IconButtonWidget({Key? key, required this.onTap, required this.imageButton, required this.label, required this.colorButton}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46,
        //color: colorButton,
        decoration: BoxDecoration(
            color: colorButton,
            borderRadius: BorderRadius.circular(5),
            border: Border.fromBorderSide(
              BorderSide(
                color: AppColors.stroke,
              ),
            )),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(imageButton),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    /*Container(
                      height: 38,
                      width: 1,
                      color: AppColors.stroke,
                    )*/
                  ],
                )),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyles.titleIconButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}