import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckBalance extends StatefulWidget {
  final String userName;
  final String userPhone;
  final String userUserName;
  final String uid;

  CheckBalance(
      {required this.userName,
      required this.userPhone,
      required this.userUserName,
      required this.uid});

  @override
  _CheckBalanceState createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  double? userBalance;
  bool _isBalanceFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff000000),
        title: Text("Check Balance"),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
                      widget.userName,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.userPhone,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.userUserName,
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
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Balance",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (_isBalanceFetched)
                        Text(
                          "₹$userBalance",
                          style: TextStyle(fontSize: 18),
                        ),
                      if (!_isBalanceFetched)
                        ElevatedButton(
                          onPressed: () async {
                            final snapshot = await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.uid)
                                .get();
                            if (snapshot.exists) {
                              setState(() {
                                userBalance = snapshot.data()!['Balance'];
                                _isBalanceFetched = true;
                              });
                            }
                          },
                          child: Text("Check Balance"),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
