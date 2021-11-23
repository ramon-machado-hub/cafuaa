import 'package:flutter/material.dart';

class AuthController{

  Future<void> currentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, "/login");
  }

}