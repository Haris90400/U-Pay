import 'package:flutter/material.dart';
import 'package:u_pay_app/components/input_field.dart';
import 'package:u_pay_app/components/rounded_button.dart';
import 'package:u_pay_app/components/password_field.dart';
import 'package:u_pay_app/components/upi_widget.dart';
import 'package:u_pay_app/screens/home_page.dart';
import 'package:u_pay_app/screens/otp_screen.dart';
import 'package:u_pay_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart';
import 'package:u_pay_app/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  //Defing all the data in the text field
  late String Name;
  late String userPhoneNumber;
  late String Email;
  late String Username;
  late String newPassword;
  late String confirmPassword;
  late double balance = 5000;
  late double sentAmount = 0;
  late double recieveAmount = 0;
  late String error_message = '';

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var verificationId = '';
  final phoneController = TextEditingController();
  late String verifyPhoneNumberValue = phoneController.text;

  Future<void> authenticatePhoneNumber(String phone) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          // await Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OtpScreen(
          //               userPhoneNumber: userPhoneNumber,
          //               // Username: Username,
          //               verificationId: verificationId,
          //             )));
        },
        verificationFailed: (e) {
          setState(() {
            if (e.code == 'invalid-phone-number') {
              error_message = 'Enter a valid phone number and try again.';
            } else {
              error_message = '';
            }
          });
        },
        codeSent: (verificationId, resendToken) async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        userPhoneNumber: userPhoneNumber,
                        Username: Username,
                        Email: Email,
                        Name: Name,
                        confirmPassword: confirmPassword,
                        balance: balance,
                        sentAmount: sentAmount,
                        recieveAmount: recieveAmount,
                        verificationId: verificationId,
                      )));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId = verificationId;
        });
  }

  //Defining a function to check that all inputs are given in TextField
  Future<void> checkInputField() async {
    if (Name.trim().isNotEmpty &&
        userPhoneNumber.trim().isNotEmpty &&
        Email.trim().isNotEmpty &&
        Username.trim().isNotEmpty &&
        newPassword.trim().isNotEmpty &&
        confirmPassword.trim().isNotEmpty) {
      verifyPassword();
      // await Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => OtpScreen(
      //               userPhoneNumber: userPhoneNumber,
      //               Username: Username,
      //             )));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration page Says:"),
            content: Text("Please fill all the fields and try again"),
            actions: <Widget>[
              GestureDetector(
                child: Text("Close"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  //Checks the new password and confirm new password matches or not
  Future<void> verifyPassword() async {
    if (newPassword != confirmPassword) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Both the passwords do not match"),
            actions: <Widget>[
              GestureDetector(
                child: Text("Close"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff24B3A8),
              Color(0xff24B3A8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()));
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.arrow_back,
                            size: 40.0,
                          ),
                          backgroundColor: Colors.white,
                          radius: 25.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 80.0),
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'images/upayy.png',
                          height: 100.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    CircleAvatar(
                      child: Icon(
                        Icons.app_registration,
                        size: 35.0,
                        color: Color(0xff24B3A8),
                      ),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 0.0),
                        child: Column(
                          children: [
                            InputField(
                              hintText: 'Enter your name',
                              onChanged: (value) {
                                Name = value;
                              },
                              fieldIcon: Icon(Icons.person),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (error_message.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 0.0, 0.0, 8.0),
                                    child: Text(
                                      error_message,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                TextField(
                                  controller: phoneController,
                                  decoration: kInputFieldDecoration.copyWith(
                                    hintText: 'Enter Mobile Number',
                                    prefixIcon: Icon(Icons.phone_android),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      userPhoneNumber = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            InputField(
                              hintText: 'Enter Email',
                              onChanged: (value) {
                                Email = value;
                              },
                              fieldIcon: Icon(Icons.email_sharp),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            InputField(
                              hintText: 'Enter username for U-Pay Id',
                              onChanged: (value) {
                                Username = value + "@upay";
                              },
                              fieldIcon: Icon(Icons.account_balance_wallet),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            PasswordField(
                              controller: passwordController1,
                              prefixIconData: Icons.visibility,
                              Name: 'Enter new password',
                              prefixIconColor: Colors.grey,
                              onChanged: (value) {
                                newPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            PasswordField(
                              controller: passwordController2,
                              prefixIconData: Icons.visibility,
                              Name: 'Confirm new password',
                              prefixIconColor: Colors.grey,
                              onChanged: (value) {
                                confirmPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedButton(
                                    Colour: Color(0xff24B3A8),
                                    Name: 'Submit',
                                    onPressed: () {
                                      // _firestore.collection('Users').add({
                                      //   'Balance': balance,
                                      //   'Email': Email,
                                      //   'Name': Name,
                                      //   'Password': confirmPassword,
                                      //   'Phone': userPhoneNumber,
                                      //   'Username': Username
                                      // });
                                      authenticatePhoneNumber(
                                          verifyPhoneNumberValue.trim());
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
