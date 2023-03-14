import 'package:flutter/material.dart';
import 'package:u_pay_app/components/upi_widget.dart';
import 'package:u_pay_app/screens/payment.dart';

import '../components/input_field.dart';
import '../components/rounded_button.dart';

class Amount extends StatelessWidget {
  late String? UPIorPhone;
  late String amount;
  late String? username;
  late String? headerfirstname;
  final String uid;
  late double transferAmount;
  TextEditingController transferAmountController = TextEditingController();

  Amount(
      {required this.UPIorPhone,
      required this.username,
      required this.headerfirstname,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff24B3A8),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: CircleAvatar(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 33,
                    child: Text(
                      headerfirstname!,
                      style: TextStyle(fontSize: 35.0, color: Colors.white),
                    ),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff24B3A8),
                  radius: 40,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  'Paying ' + username!,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: Text(
                  UPIorPhone!,
                  style: TextStyle(fontSize: 23),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(130.0, 10.0, 110.0, 0.0),
                child: TextField(
                  controller: transferAmountController,
                  style: TextStyle(fontSize: 50),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      size: 50,
                      color: Colors.black,
                    ),
                    hintText: '0',
                    hintStyle: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: RoundedButton(
            Colour: Color(0xff24B3A8),
            Name: 'Pay',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => otpWidget(
                          uid: uid,
                          phoneOrUpay: UPIorPhone!,
                          transferAmount:
                              double.parse(transferAmountController.text),
                          recieverName: username!)));
            }),
      ),
    );
  }
}
