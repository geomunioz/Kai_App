import 'package:app_eat/pages/registerAccount.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'package:app_eat/utils/routes.dart';

import 'package:app_eat/pages/index.dart';

import 'data/Register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Register.regist();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenView(
        navigateRoute: Home(),
        duration: 3000,
        imageSize: 300,
        text: "Kai",
        textType: TextType.NormalText,
        textStyle: TextStyle(
          fontSize: 30.0,
          color: green50,
          fontWeight: FontWeight.bold,
        ),
        imageSrc: "assets/images/logo.png",
        backgroundColor: Colors.black,
      ),/*Home(),*/
      routes: getApplicationRoutes(),
    );
  }
}
