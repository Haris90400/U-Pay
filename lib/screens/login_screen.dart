import 'package:flutter/material.dart';
import 'package:u_pay_app/components/rounded_button.dart';
import 'package:u_pay_app/components/input_field.dart';
import 'package:u_pay_app/components/password_field.dart';
import 'package:u_pay_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late String _errorMessage = '';
  late bool _isLoading = false;

  void logIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      late String password = passwordController.text;
      late String email = emailController.text;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = 'No user found for that email.';
          _isLoading = false;
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _errorMessage = 'Wrong password provided for that user.';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff24B3A8),
                  Color(0xff24B3A8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'images/upayy.png',
                            height: 120.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                          child: Icon(
                            Icons.login,
                            size: 35.0,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          radius: 30.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 0.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  TextField(
                                    controller: emailController,
                                    decoration: kInputFieldDecoration.copyWith(
                                      hintText: 'Enter your email',
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  PasswordField(
                                    controller: passwordController,
                                    prefixIconData: Icons.visibility,
                                    Name: 'Enter your password',
                                    prefixIconColor: Colors.grey,
                                    onChanged: (value) {
                                      print(value);
                                    },
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    _errorMessage,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: 200.0,
                                  ),
                                  RoundedButton(
                                      Colour: Color(0xff24B3A8),
                                      Name: 'Log In',
                                      onPressed: () {
                                        logIn();
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => Home()));
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) // Show the CircularProgressIndicator if loading
            Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
