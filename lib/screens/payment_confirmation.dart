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
      ) // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // Circular avatar with white background
          //     Container(
          //       height: 120,
          //       width: 120,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.cyan.shade700,
          //       ),
          //       // Animated check icon inside the circular avatar
          //       child: AnimatedBuilder(
          //         animation: _controller,
          //         builder: (context, child) {
          //           return Opacity(
          //             opacity: _opacityAnimation.value,
          //             child: Transform.scale(
          //               scale: _scaleAnimation.value,
          //               child: child,
          //             ),
          //           );
          //         },
          //         child: Icon(
          //           Icons.check,
          //           color: Colors.white,
          //           size: 50,
          //         ),
          //       ),
          //     ),
          //     // Text to show the payment confirmation
          //     SizedBox(height: 20),
          //     Text(
          //       "Payment Confirmed",
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.cyan.shade700,
          //       ),
          //     ),
          //     SizedBox(height: 10),
          //     Text(
          //       "Your transaction is successful",
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.grey.shade600,
          //       ),
          //     ),
          //   ],
          ),
    );
  }
}
