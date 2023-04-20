import 'package:flutter/material.dart';
import 'package:u_pay_app/components/rounded_button.dart';

import '../constants.dart';

class StudentPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff24B3A8),
        title: Text("Student Point"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Column(

    children: [

       TextField(
      decoration: kInputFieldDecoration.copyWith(
      hintText: 'Enter Marks',)
      ),
       Padding(padding: EdgeInsets.fromLTRB(0, 480, 0, 0),
       child: RoundedButton(Colour: Color(0xff24B3A8), Name: "Submit", onPressed: ()  async {
    StudentPoint();
    }),),
    ],),

          ),
        ),
      ),);

  }
}
