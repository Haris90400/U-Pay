import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:u_pay_app/components/upi_widget.dart';
import 'home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class otpWidget extends StatefulWidget {
  final String uid;
  final String userPhoneNumber;
  final String Name;
  final String Email;
  final String Username;
  final double balance;
  final double sentAmount;
  final double recieveAmount;
  otpWidget(
      {required this.userPhoneNumber,
      required this.Username,
      required this.Email,
      required this.Name,
      required this.balance,
      required this.recieveAmount,
      required this.sentAmount,
      required this.uid});
  @override
  State<otpWidget> createState() => _otpWidgetState();
}

class _otpWidgetState extends State<otpWidget> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  bool _obscureText = true;

  Future<void> updateDeviceToken(String uid) async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // Get the device token for the current device
    String? deviceToken = await _firebaseMessaging.getToken();

    // Update the user's document in the database with the new device token
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .update({'device_token': deviceToken});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Set Your 6 digit U-pay pin',
          ),
          backgroundColor: Color(0xff24B3A8),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Enter 6 digit U-PAY Pin',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 40.0,
                        height: 35.0,
                        decoration: BoxDecoration(),
                        child: TextField(
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                          obscureText: _obscureText,
                          focusNode: focusNodes[index],
                          controller: controllers[index],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            counterText: '',
                          ),
                          //textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          onChanged: (value) {
                            if (value.length == 1) {
                              focusNodes[index].unfocus();
                              if (index != 5) {
                                FocusScope.of(context).requestFocus(
                                  focusNodes[index + 1],
                                );
                              }
                            }
                          },
                        ),
                      );
                    })),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff24B3A8)),
                  child: Text('Submit'),
                  onPressed: () async {
                    String pin = '';
                    controllers.forEach((element) => pin += element.text);
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.uid)
                        .update({'upiPin': pin});
                    updateDeviceToken(widget.uid);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  userName: widget.Name,
                                  userBalance: widget.balance,
                                  userPhone: widget.userPhoneNumber,
                                  userUserName: widget.Username,
                                  uid: widget.uid,
                                )));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
