import 'package:app_eat/utils/styles.dart';
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
        textStyle: textSplashScreen,
        imageSrc: "assets/images/logo.png",
        backgroundColor: Colors.black,
      ),/*Home(),*/
      routes: getApplicationRoutes(),
    );
  }
}
