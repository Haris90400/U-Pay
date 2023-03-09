import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtpScreen extends StatefulWidget {
  final String userPhoneNumber;
  final String Name;
  final String Email;
  final String Username;
  final String confirmPassword;
  final double balance;
  final double sentAmount;
  final double recieveAmount;

  final String verificationId;

  OtpScreen(
      {required this.userPhoneNumber,
      required this.Username,
      required this.verificationId,
      required this.Email,
      required this.Name,
      required this.balance,
      required this.confirmPassword,
      required this.recieveAmount,
      required this.sentAmount});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  late String otp = _otpController.text;
  final _auth = FirebaseAuth.instance;

  Future<bool> verifyOtp(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  final _firestore = FirebaseFirestore.instance;
  void createUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: widget.Email, password: widget.confirmPassword);
    } catch (e) {
      print('Error creating user: $e');
      // Show an error message
    }
  }

  void saveUser() async {
    await _firestore.collection('Users').add({
      'Balance': widget.balance,
      'Email': widget.Email,
      'Name': widget.Name,
      'Password': widget.confirmPassword,
      'Phone': widget.userPhoneNumber,
      'Username': widget.Username,
      'sentAmount': widget.sentAmount,
      'recieveAmount': widget.recieveAmount
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/otp_image.png'),
            Text(
              'Enter OTP send to ${widget.userPhoneNumber}',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'OTP',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String enteredOtp = _otpController.text;
                bool isVerified = await verifyOtp(enteredOtp);
                print(isVerified);

                if (isVerified) {
                  createUser();
                  saveUser();

                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                } else {
                  // Show an error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Invalid OTP"),
                        content: Text("Please enter a valid OTP."),
                        actions: <Widget>[
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                }

                // perform action to verify OTP
                // for example:

                // if OTP is verified, navigate to next page
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    ));
  }
}
