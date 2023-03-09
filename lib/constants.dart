import 'package:flutter/material.dart';

const kInputFieldDecoration = InputDecoration(
  hintText: "Enter a value",
  hintStyle: TextStyle(color: Colors.grey),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
