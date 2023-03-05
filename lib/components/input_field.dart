import 'package:flutter/material.dart';
import 'package:u_pay_app/constants.dart';

class InputField extends StatelessWidget {
  final String hintText;

  final ValueChanged<String> onChanged;
  final Icon fieldIcon;

  InputField({
    required this.hintText,
    required this.onChanged,
    required this.fieldIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        onChanged: onChanged,
        decoration: kInputFieldDecoration.copyWith(
          hintText: hintText,
          prefixIcon: fieldIcon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
      ),
    );
  }
}
