import 'package:cafua/themes/app_images.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class IsDrawer extends StatefulWidget {
  //final UserModel user;

  const IsDrawer({Key? key}) : super(key: key);

  @override
  _IsDrawerState createState() => _IsDrawerState();
}

class _IsDrawerState extends State<IsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(

                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                    'https://i.imgur.com/RaXDTdX.png'
                ),
              ),
              accountEmail: Text('rodrigo23@gmail.com'),
              accountName: Text('Olá, Rodrigo Menezes'),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 0, top: 0, bottom: 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: ClipOval(
                        child: Image.asset('assets/images/profile.jpg'),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Amigos',
                      style: TextStyles.buttonBoldPrimary)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 0, top: 0, bottom: 0),

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: ClipOval(
                        child: Image.asset('assets/images/profile.jpg'),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Estatística',
                        style: TextStyles.buttonBoldPrimary
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 0, top: 0, bottom: 0),

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: ClipOval(
                        child: Image.asset('assets/images/profile.jpg'),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Perfil',
                        style: TextStyles.buttonBoldPrimary
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 0, top: 0, bottom: 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: ClipOval(
                        child: Image.asset('assets/images/profile.jpg'),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Sair',
                          style: TextStyles.buttonBoldPrimary)
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
