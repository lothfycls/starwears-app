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
    _onWidgetDidBuild(() => Future.delayed(Duration(seconds: 5), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => introScreen(),
            ),
          );
        }));
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(
              height: 10,
            ),
            Text('STARWEARS'),
          ],
        ),
      ),
    ));
  }
}
