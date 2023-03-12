import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'set_pin.dart';

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
  bool is_Loading = false;

  Future<bool> verifyOtp(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  final _firestore = FirebaseFirestore.instance;
  void createUser() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: widget.Email,
        password: widget.confirmPassword,
      );

      // Use the user's UID as the document ID in Firestore
      final String uid = userCredential.user!.uid;

      // Save user information to Firestore with the same UID
      await _firestore.collection('Users').doc(uid).set({
        'Balance': widget.balance,
        'Email': widget.Email,
        'Name': widget.Name,
        'Password': widget.confirmPassword,
        'Phone': widget.userPhoneNumber,
        'Username': widget.Username,
        'sentAmount': widget.sentAmount,
        'recieveAmount': widget.recieveAmount,
      });

      final userDoc = await _firestore.collection('Users').doc(uid).get();
      final String userName = userDoc['Name'];
      final double userBalance = userDoc['Balance'];
      final String userPhone = userDoc['Phone'];
      final String userUserName = userDoc['Username'];
      final String userEmail = userDoc['Email'];
      final double sentAmount = userDoc['sentAmount'];
      final double recieveAmount = userDoc['recieveAmount'];
      print('User uid:$uid');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Home(
      //               userName: userName,
      //               userBalance: userBalance,
      //               userPhone: userPhone,
      //               userUserName: userUserName,
      //             )));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => otpWidget(
                  userPhoneNumber: userPhone,
                  Name: userName,
                  balance: userBalance,
                  Username: userUserName,
                  Email: userEmail,
                  uid: uid,
                  sentAmount: sentAmount,
                  recieveAmount: recieveAmount,
                )),
      );
    } catch (e) {
      print('Error creating user: $e');
      // Show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/otpimage.png'),
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
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          )),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        is_Loading = true;
                      });
                      String enteredOtp = _otpController.text;
                      bool isVerified = await verifyOtp(enteredOtp);
                      print(isVerified);

                      if (isVerified) {
                        createUser();
                        setState(() {
                          is_Loading = true;
                        });
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
                        setState(() {
                          is_Loading = false;
                        });
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
          ),
          if (is_Loading) // Show the CircularProgressIndicator if loading
            Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
