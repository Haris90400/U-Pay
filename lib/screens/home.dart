import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/about.dart';
import 'package:u_pay_app/screens/add_account.dart';
import 'package:u_pay_app/screens/check_balance.dart';
import 'package:u_pay_app/screens/images.dart';
import 'package:u_pay_app/screens/pay_bank.dart';
import 'package:u_pay_app/screens/pay_contacts.dart';
import 'package:u_pay_app/screens/pay_upi.dart';
import 'package:u_pay_app/screens/registration_screen.dart';
import 'package:u_pay_app/screens/transaction_history.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/input_field.dart';
import '../components/password_field.dart';
import '../components/rounded_button.dart';
import 'my_profile.dart';

class Home extends StatefulWidget {
  final String userName;
  final double userBalance;
  final String userPhone;
  final String userUserName;

  Home(
      {required this.userName,
      required this.userBalance,
      required this.userPhone,
      required this.userUserName});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff008080),
        title: Text('Welcome' + " " + '${widget.userName}'),
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
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xfff5f5f5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Container(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 180,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    reverse: false,
                    aspectRatio: 5.0,
                  ),
                  itemCount: imageList.length,
                  itemBuilder: (BuildContext context, int i, int id) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(imageList[i],
                              width: 500, fit: BoxFit.cover),
                        ),
                      ),
                      onTap: () {
                        var url = imageList[i];
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Column(
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Color(0xff008080),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Accounts",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 50.0,
                                                ),
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Color(0xff008080),
                                                radius: 25.0,
                                              ),
                                              Text(
                                                "Add Account",
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(
                                                    Icons
                                                        .account_circle_outlined,
                                                    size: 50.0,
                                                  ),
                                                  backgroundColor:
                                                      Color(0xff008080),
                                                  foregroundColor: Colors.white,
                                                  radius: 25.0,
                                                ),
                                                Text(
                                                  'Manage Account',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PayUpi()));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(
                                                    Icons.account_box,
                                                    size: 50.0,
                                                  ),
                                                  backgroundColor:
                                                      Color(0xff008080),
                                                  foregroundColor: Colors.white,
                                                  radius: 25.0,
                                                ),
                                                Text(
                                                  'Student Points',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),
                                      ]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Color(0xff008080),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      "Payment",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PayUpi()));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
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
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PayContact()));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),
                                      ]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  transctionHistory()));
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
                                          backgroundColor: Color(0xff008080),
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
                                                  CheckBalance(
                                                    userName: widget.userName,
                                                    userBalance:
                                                        widget.userBalance,
                                                    userPhone: widget.userPhone,
                                                    userUserName:
                                                        widget.userUserName,
                                                  )));
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
                                          backgroundColor: Color(0xff008080),
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
                                  height: 20,
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
                                          color: Color(0xff008080)),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
