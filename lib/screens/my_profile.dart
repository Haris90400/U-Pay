import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:u_pay_app/components/rounded_button.dart';
import 'package:u_pay_app/screens/registration_screen.dart';
import 'package:u_pay_app/screens/login_screen.dart';
import 'package:u_pay_app/components/rounded_button.dart';
import 'package:u_pay_app/screens/welcome_screen.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xff24B3A8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pritesh Patil",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "+91 8689987277",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "pritesh@upay",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                    size: 90,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff24B3A8),
                  radius: 50,
                ),
              ],
            ),
            SizedBox(
              height: 450,
            ),
            RoundedButton(
                Colour: Colors.black,
                Name: 'Sign Out',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                })
          ],
        ),
      ),
    );
  }
}
