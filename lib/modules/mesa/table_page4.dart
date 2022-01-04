import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class TablePage4 extends StatefulWidget {

  const TablePage4({Key? key,}) : super(key: key);

  @override
  _TablePage4State createState() => _TablePage4State();
}

class _TablePage4State extends State<TablePage4> {
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
