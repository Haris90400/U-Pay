import 'package:flutter/material.dart';

class CheckBalance extends StatelessWidget {
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
                      Text(
                        "₹5000",
                        style: TextStyle(fontSize: 18),
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
