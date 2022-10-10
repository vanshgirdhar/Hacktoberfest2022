// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getmygps/login.dart';


class Palette {
  static const MaterialColor kToDark = MaterialColor(
      0xff6C63FF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      <int, Color>{
        50: Color(0xff6C63FF), //10%
        100: Color(0xff6C63FF), //20%
        200: Color(0xff6C63FF), //30%
        300: Color(0xff6C63FF), //40%
        400: Color(0xff6C63FF), //50%
        500: Color(0xff6C63FF), //60%
        600: Color(0xff6C63FF), //70%
        700: Color(0xff6C63FF), //80%
        800: Color(0xff6C63FF), //90%
        900: Color(0xff6C63FF) //100%
      });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.deepPurple[300],
            primarySwatch: Palette.kToDark),
        home: LoginPage());
  }
}
 