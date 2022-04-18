import 'package:cafua/app_wid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // print("ENTROU");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // try {
  //
  //   // print("ENTROU");
  // } catch (e) {
  //   print("ERRO FIREBASE ");
  //   print(e.toString());
  //   print("ERRO FIREBASE ");
  // }
  runApp(AppWidget());
}

