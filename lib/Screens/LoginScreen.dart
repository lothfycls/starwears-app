import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:starwears/Screens/SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading:  IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {Navigator.of(context).pop();},
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logo
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 5,),
            Text(
              "STARWEARS",
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(height: 24),
            // Text
            Text(
              'Welcome back',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 24),
            // Sign in with Google button
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.red,
              onPressed: () {
                // Perform some action
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 15,
                      child: Image.asset('assets/images/google.png')),
                  SizedBox(width: 8.0),
                  Text(
                    "sign in with google",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Sign in with Facebook button
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.blue,
              onPressed: () {
                // Perform some action
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.facebook),
                  SizedBox(width: 8.0),
                  Text(
                    "sign in  with facebook",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Divider
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    width: 16.0,
                  ),
                  Text("or "),
                  Container(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Login with email and password
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Theme(
                data: Theme.of(context).copyWith(
                  // hintStyle: TextStyle(color: Colors.grey),
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "email",
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Theme(
                data: Theme.of(context).copyWith(
                  // hintStyle: TextStyle(color: Colors.grey),
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "password",
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
           
            FlatButton(
              child: Text(
                'Forgot password?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                // Code to handle password reset goes here
              },
            ),

            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 100),
              color: Colors.black,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                // Perform some action
              },
              child: Text(
                "Login",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            // Divider
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                )),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? '),
                FlatButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
                    // handle button press
                  },
                ),
              ],
            ),
            // Sign up option
            // Text('Don\'t have an account? '),
            // FlatButton(
            //   child: Text('Sign up'),
            //   onPressed: () {
            //     // Code to handle sign up goes here
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
