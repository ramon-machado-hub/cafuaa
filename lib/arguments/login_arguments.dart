import 'package:flutter/cupertino.dart';

class LoginArguments {
  final IconData iconLogin;
  // final TextInputType type;
  final String labelLogin;
  final String labelPassword;
  final String labelTypeLogin;
  LoginArguments(this.iconLogin, this.labelLogin,
      this.labelPassword, this.labelTypeLogin);
}