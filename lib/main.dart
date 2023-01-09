import 'package:flutter/material.dart';
import 'package:starwears/Screens/SplashScreen.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/IntroScreen.dart';
import 'Screens/SignUpScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'starwears',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
