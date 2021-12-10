import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:cafua/widgets/googlebutton/google_button.dart';
import 'package:cafua/widgets/iconbutton/icon_button_widget.dart';
import 'package:flutter/material.dart';

class LoginWith extends StatelessWidget {
  const LoginWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Faça seu login")),
      backgroundColor: AppColors.input,
      content: SingleChildScrollView(
          child: ListBody(children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.shape,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: AppColors.stroke,
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GoogleButton(onTap: () {
                  Navigator.pushReplacementNamed(context, "/home");
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: IconButtonWidget(
                  text_styles: TextStyles.titleIconButton,
                  colorButton:  AppColors.shape,
                  label: 'Entrar com facebook',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  imageButton: AppImages.logoFace,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: IconButtonWidget(
                  text_styles: TextStyles.titleIconButton,
                  colorButton: AppColors.shape,
                  label: 'Entrar com Cafua',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  imageButton: AppImages.logoBlack,
                ),
              ),
            ])),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text('cancelar'),
              ),
            ],
    );
  }
}
