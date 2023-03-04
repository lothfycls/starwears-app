import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:starwears/Screens/IntroScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
  _onWidgetDidBuild(()=>
 Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => introScreen(),
        ),
      );
    }));
   
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        )));
  }
}
