import 'package:cafua/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppbarJogoWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.primary,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,5),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                    image: Image.network('https://i.imgur.com/RaXDTdX.png').image
                ),
                //border: Border.all(color: Colors.blueAccent, width: 2.5),
              ),

            ),
          ),
        ],
      ),
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
            ),
          ),


        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
