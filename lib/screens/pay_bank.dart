import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/payment.dart';

import '../components/input_field.dart';
import '../components/rounded_button.dart';

class PayBank extends StatelessWidget {
  late String AcNo;
  late String Branch;
  late String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff24B3A8),
        title: Text("Enter recipient details"),
      ),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                child: InputField(
                  hintText: 'Account number',
                  onChanged: (value) {
                    AcNo = value;
                  },
                  fieldIcon: Icon(Icons.account_circle),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                child: InputField(
                  hintText: 'Re-enter Account number',
                  onChanged: (value) {
                    AcNo = value;
                  },
                  fieldIcon: Icon(Icons.account_balance),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                child: InputField(
                  hintText: 'Branch',
                  onChanged: (value) {
                    Branch = value;
                  },
                  fieldIcon: Icon(Icons.account_balance_sharp),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                child: InputField(
                  hintText: 'Recipient name',
                  onChanged: (value) {
                    name = value;
                  },
                  fieldIcon: Icon(Icons.account_balance_sharp),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 50.0),
          child: RoundedButton(
              Colour: Color(0xff24B3A8), Name: 'Continue', onPressed: () {})),
    );
  }
}
