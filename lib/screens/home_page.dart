import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/about.dart';
import 'package:u_pay_app/screens/add_account.dart';
import 'package:u_pay_app/screens/pay_bank.dart';
import 'package:u_pay_app/screens/pay_contacts.dart';
import 'package:u_pay_app/screens/pay_upi.dart';
import 'package:u_pay_app/screens/registration_screen.dart';
import 'package:u_pay_app/screens/transaction_history.dart';

import '../components/input_field.dart';
import '../components/password_field.dart';
import '../components/rounded_button.dart';
import 'my_profile.dart';

class HomePage extends StatelessWidget {
  late final Function onPressed;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Upay"),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile()));
              },
              icon: Icon(
                Icons.account_circle,
                size: 46,
                color: Color(0xff24B3A8),
              ),
            ),
          ),
        ],
      ),
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
                padding: EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/upayy.png',
                        height: 100.0,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 00.0),
                        child: Text(
                          "Fast and safe transactions",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Accounts",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 35.0,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddAccount()));
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            child: Icon(
                                              Icons.add_circle_outline_sharp,
                                              size: 45.0,
                                            ),
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            radius: 25.0,
                                          ),
                                          Text(
                                            "Add Account",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen()));
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              child: Icon(
                                                Icons.account_circle_outlined,
                                                size: 45.0,
                                              ),
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              radius: 25.0,
                                            ),
                                            Text(
                                              'Manage Account',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ]),
                              SizedBox(
                                height: 15.0,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             PayUpi()));
                                            },
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(
                                                    Icons
                                                        .account_balance_wallet_outlined,
                                                    size: 40.0,
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.black,
                                                  radius: 25.0,
                                                ),
                                                Text(
                                                  'Pay to Upi',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PayBank()));
                                            },
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(
                                                    Icons.account_balance,
                                                    size: 40.0,
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.black,
                                                  radius: 25.0,
                                                ),
                                                Text(
                                                  "Bank transfer",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             PayContact(uid: ,)));
                                            },
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(
                                                    Icons.account_box_outlined,
                                                    size: 40.0,
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.black,
                                                  radius: 25.0,
                                                ),
                                                Text(
                                                  'Pay contacts',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            )),
                                      ]),
                                ],
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             transctionHistory()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            child: Icon(
                                              Icons.access_time,
                                              size: 30,
                                            ),
                                            backgroundColor: Color(0xff24B3A8),
                                            foregroundColor: Colors.white,
                                          ),
                                          Text(
                                            "Show transaction history",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          CircleAvatar(
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 30,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.black,
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterScreen()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            child: Icon(
                                              Icons.account_balance_sharp,
                                              size: 30,
                                            ),
                                            backgroundColor: Color(0xff24B3A8),
                                            foregroundColor: Colors.white,
                                          ),
                                          Text(
                                            "Check Balance                  ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          CircleAvatar(
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 30,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.black,
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AboutPage()));
                                      },
                                      child: Text(
                                        "About U-Pay",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff24B3A8)),
                                      ))
                                ],
                              )
                            ],
                          ),
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
