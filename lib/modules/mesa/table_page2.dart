import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class TablePage2 extends StatefulWidget {

  const TablePage2({Key? key,}) : super(key: key);

  @override
  _TablePage2State createState() => _TablePage2State();
}

class _TablePage2State extends State<TablePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.background),
        backgroundColor: AppColors.primary,
        title: Text(
          'SALA DE ESPERA',
          style: TextStyles.titleAppbar,
        ),
      ),


      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: 50,
          height: 60,
          color: Colors.black,
          child: Center(
              child: Text(
                'Anúncio ADMob',
                style: TextStyles.titleBoldBackground,
              )),
        ),
      ),
    );
  }
}
