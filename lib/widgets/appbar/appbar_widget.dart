import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Olá teste1',
          style: TextStyles.titleHome,
        ),
        Text(
          'Pontuação: 1000 pts ',
          style: TextStyles.buttonBoldBackground,
        ),
      ]),
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipOval(
          child: Image.asset('assets/images/profile.jpg'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
