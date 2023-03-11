import 'package:flutter/material.dart';
import 'dart:async';
import 'package:u_pay_app/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds:4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),

        child: Center(


          child: Container(

            height: 250,
            alignment: Alignment.center,

            child:Hero(
              tag: 'logo',
              child: Image.asset('images/logo1.png')
            ),

          ),
        ),
      ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          padding: EdgeInsets.fromLTRB(145.0, 0.0, 50.0, 60.0),
         child: Text(
           'U-Pay',
           style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold  ),
          ),

        ),
      );

  }
}
