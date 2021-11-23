import 'package:cafua/modules/login/login_page.dart';
import 'package:cafua/themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 5,
            navigateAfterSeconds: LoginPage(),
            loaderColor: Colors.transparent,
          ),
          Container(
            child: Stack(
              children: [
                Center(child: Image.asset(AppImages.union)),
                Center(child: Image.asset(AppImages.logoFull)),
              ],
            ),
          ),
        ],
      );
  }
}