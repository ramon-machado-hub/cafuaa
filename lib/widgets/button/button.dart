import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const Button({Key? key, required this.onTap, required this.label}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      color: AppColors.buttonGame,
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyles.titleGameButton,
      ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
    );
  }
}