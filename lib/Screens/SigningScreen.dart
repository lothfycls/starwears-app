import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/connected_account/AccountScreen.dart';
import 'package:starwears/Screens/LoginScreen.dart';
import 'package:starwears/Screens/SignUpScreen.dart';

import '../bloc/authentication_bloc.dart';
import '../main.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({Key? key}) : super(key: key);

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthSuccess) {
        return AccountScreen();
     
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 40,
            centerTitle: true,
            title: Text(
              'Account',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(right: 15),
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 22,
                ),
                onPressed: () {
                  // Perform some action when the button is pressed
                },
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              children: [
                // Logo
                Image.asset('assets/images/logo.png'),
                SizedBox(
                  height: 5,
                ),

                Text(
                  "STARWEARS",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 24),
                // Text
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  child: const Text(
                    'Login or sign up to bid, manage your portfolio or personalise your account',
                    // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  child: FlatButton(
                    // padding: EdgeInsets.symmetric(horizontal: 120),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      outerNavigator.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => SignUpScreen()),
                  (route) => false
                      );
                    },
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  child: FlatButton(
                    // padding: EdgeInsets.symmetric(horizontal: 120),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                       outerNavigator.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false
                      );
                      
                    },
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                /*  SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  child: FlatButton(
                    // padding: EdgeInsets.symmetric(horizontal: 120),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => AccountScreen()),
                      );
                    },
                    child: Text(
                      "Profile",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        );
      }
    });
  }
}
