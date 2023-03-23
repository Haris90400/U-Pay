import 'package:flutter/material.dart';
import 'package:u_pay_app/components/input_field.dart';
import 'package:u_pay_app/components/rounded_button.dart';
import 'package:u_pay_app/components/password_field.dart';
import 'package:u_pay_app/screens/home_page.dart';
import 'package:u_pay_app/screens/otp_screen.dart';
import 'package:u_pay_app/screens/welcome_screen.dart';

import 'home.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  //Defing all the data in the text field
  late String Name;
  late String userPhoneNumber;
  late String Email;
  late String Username;
  late String newPassword;
  late String confirmPassword;

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
            title: Text("Page Says:"),
            content: Text("Please fill all the fields and try again"),
            actions: <Widget>[
              GestureDetector(
                child: Text("Close"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAccount()));
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
                padding: EdgeInsets.only(top: 20.0),
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
                                   builder: (context) => Home(userName: '', userBalance: 0, userPhone: "", userUserName: '', uid: '',)));
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.arrow_back,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          backgroundColor: Color(0xff24B3A8),
                          radius: 25.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 55.0),
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'images/logo1.png',
                          height: 170.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Account',
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
                            InputField(
                              hintText: 'Enter Phone Number',
                              onChanged: (value) {
                                userPhoneNumber = value;
                              },
                              fieldIcon: Icon(Icons.phone),
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
                                    onPressed: () async {
                                      await checkInputField();
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
