import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIconData;
  final String Name;
  final Color prefixIconColor;
  final ValueChanged<String> onChanged;

  PasswordField({
    required this.controller,
    required this.prefixIconData,
    required this.Name,
    required this.prefixIconColor,
    required this.onChanged,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;
  late Color _prefixIconColor;

  void togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
      _prefixIconColor =
          _hidePassword ? widget.prefixIconColor : Colors.blueAccent;
    });
  }

  @override
  void initState() {
    _prefixIconColor = widget.prefixIconColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: _hidePassword,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        hintText: widget.Name,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: IconButton(
          icon: Icon(
            widget.prefixIconData,
            color: _prefixIconColor,
          ),
          onPressed: togglePasswordVisibility,
        ),
      ),
    );
  }
}
