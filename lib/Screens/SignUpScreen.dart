import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/LoginScreen.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/models/user.dart';
import 'package:starwears/services/shared_preferences_service.dart';

import '../utils/utils.dart';
import 'HomeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  GlobalKey<FormState> formKey = GlobalKey();
  bool _isObscured = true;

// Toggle the visibility of the password
  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _showAgreement() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('User Agreement'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Inter"),
                            children: [
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text:
                                  "To use our services, you must register and create an account with us. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Registration and Account\n"),
                          TextSpan(
                              text:
                                  "You can bid on any product listed on our platform. Bidding starts at the minimum bid amount and increases in increments set by the app. The highest bidder at the end of the auction period wins the product.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Bidding Process\n"),
                          TextSpan(
                              text:
                                  "You can bid on any product listed on our platform. Bidding starts at the minimum bid amount and increases in increments set by the app. The highest bidder at the end of the auction period wins the product.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Payment and Delivery\n"),
                          TextSpan(
                              text:
                                  "If you win an auction, you must complete the payment process within the specified time period. We will provide you with the payment instructions and options. Once payment is confirmed, your product will be delivered to your designated address.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "User Obligations\n"),
                          TextSpan(
                              text:
                                  "You agree to use our services for lawful purposes only and to comply with all applicable laws and regulations. You will not use our app to engage in any fraudulent or illegal activities. You are also responsible for any content you post on our platform and must ensure that it does not infringe on any third-party rights.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Intellectual Property\n"),
                          TextSpan(
                              text:
                                  "All content and materials on our platform, including trademarks, logos, and copyrights, are owned by us or our partners. You are not allowed to use our content or materials for any commercial or non-commercial purposes without our prior written consent.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Limitation of Liability\n"),
                          TextSpan(
                              text:
                                  "We are not liable for any damages or losses arising from your use of our app or from any products you purchase through our platform. We are not responsible for any errors or omissions in the product listings or for any disputes between users.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Privacy and Data Security\n"),
                          TextSpan(
                              text:
                                  "We respect your privacy and are committed to protecting your personal information. We collect and use your information in accordance with our privacy policy, which you can view on our app.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "Changes and Updates\n"),
                          TextSpan(
                              text:
                                  "We reserve the right to modify, update, or terminate our services or user agreement at any time without prior notice. It is your responsibility to check our app regularly for any updates or changes to the user agreement.\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text:
                                  "By using our app, you agree to these terms and conditions. If you do not agree with any of the terms or conditions, please do not use our app.\n"),
                        ])),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Agree'),
                  onPressed: () {
                    // Perform some action when the user agrees.
                    Navigator.of(context).pop();
                    setState(() {
                      _value = true;
                    });
                  },
                ),
                TextButton(
                  child: Text('Disagree'),
                  onPressed: () {
                    // Perform some action when the user disagrees.
                    Navigator.of(context).pop();
                    setState(() {
                      _value = false;
                    });
                  },
                ),
              ],
            ));
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Sign Up Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }

  bool? _value = false;
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Logo
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 5,
              ),

              Text(
                "STARWEARS",
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(height: 24),
              // Text
              Text(
                'Welcome to our bidding wears',
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
                      "continue with google",
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
                      "Continue with facebook",
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
                    controller: emailController,
                    validator: Utils.validateEmail,
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
                        controller: passwordController,
                        obscureText: _isObscured,
                        validator: Utils.validatePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: _toggleObscure,
                            child: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ))),
              const SizedBox(height: 12),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'I agree to the Starwears ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: 'User Agreement and Privacy Policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _showAgreement();
                              // Add your onTap function here
                            },
                          style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                value: _value,
                onChanged: (bool? value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              showError
                  ? const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Cannot proceeed without accepting our terms",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox(),

              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is CreationFailed) {
                    _onWidgetDidBuild(() => _showAlertDialog(state.message));
                  }
                  if (state is AuthSuccess) {
                    SharedPreferencesService shared =
                        SharedPreferencesService();
                    shared.upDateSharedPreferences(
                        state.email, state.id, "", "", "", "", "");
                    _onWidgetDidBuild(() => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false));
                  }
                },
                builder: (context, state) {
                  return FlatButton(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate() && _value!) {
                        setState(() {
                          showError = false;
                        });
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            CreateUser(BidUser(emailController.text.trim(),
                                passwordController.text)));
                      }
                      if (!_value!) {
                        setState(() {
                          showError = true;
                        });
                      }
                    },
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
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
                  Text('Already have an account?'),
                  FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
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
      ),
    );
  }
}
