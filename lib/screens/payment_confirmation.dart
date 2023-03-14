import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    // Create a tween animation for scaling the icon
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, 0.5, curve: Curves.easeIn),
    ));

    // Create a tween animation for changing the opacity of the icon
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1, curve: Curves.easeOut),
    ));

    // Start the animation and make it repeat
    _controller.repeat();
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image(
        image: NetworkImage(
            'https://media.tenor.com/bm8Q6yAlsPsAAAAi/verified.gif'),
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
