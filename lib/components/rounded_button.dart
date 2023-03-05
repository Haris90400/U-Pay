import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color Colour;
  final String Name;
  final Function onPressed;

  RoundedButton(
      {required this.Colour, required this.Name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colour,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(Name, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
