import 'dart:async';

import 'package:flutter/material.dart';

import 'home.dart';

class PaymentConformationScreen extends StatefulWidget {
  @override
  _PaymentConformationScreenState createState() =>
      _PaymentConformationScreenState();
}

class _PaymentConformationScreenState extends State<PaymentConformationScreen>
    with SingleTickerProviderStateMixin {
  // Define the animation controller for the check icon
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () => Navigator.pop(context));
  }

  // Initialize the animation controller

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image(
          image: AssetImage('images/tick0.gif'),
          fit: BoxFit.cover,
        ), //
      ),
    );
  }
}
