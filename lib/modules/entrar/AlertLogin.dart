import 'package:flutter/material.dart';

class AlertLogin extends StatelessWidget {
  const AlertLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showAlertDialog1(context);
  }
}


showAlertDialog1(BuildContext context)
{
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Promoção Imperdivel"),
    content: Text("Não perca a promoção."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}