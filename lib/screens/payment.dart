import 'package:flutter/material.dart';
import 'package:u_pay_app/components/upi_widget.dart';
import 'package:u_pay_app/screens/amount.dart';

import '../components/input_field.dart';
import '../components/rounded_button.dart';

class Payment extends StatelessWidget {
  late String number;
  late String msg;
  final String? username;
  final String? UpayId;

  Payment({required this.username, required this.UpayId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff24B3A8),
        title: Container(
            child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
              child: Icon(
                Icons.account_circle,
                size: 40,
              ),
            ),
            Text(
              username!,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          sendMessageBubble(
            reciever: 'Haris',
            Amount: '50',
          ),
          sendMessageBubble(reciever: 'Haris', Amount: '50'),
          recieverMessageBubble(sender: 'Haris', Amount: '69'),
          recieverMessageBubble(sender: 'Haris', Amount: '69'),
          sendMessageBubble(reciever: 'Haris', Amount: '10'),
          recieverMessageBubble(sender: 'Haris', Amount: '500'),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: RoundedButton(
            Colour: Color(0xff24B3A8),
            Name: 'Amount',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Amount(username: username, UPIorPhone: UpayId)));
            }),
      ),
    );
  }
}

class sendMessageBubble extends StatelessWidget {
  final String reciever;
  final String Amount;

  sendMessageBubble({required this.reciever, required this.Amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Paid To'),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)),
            elevation: 5.0,
            color: Color(0xff24B3A8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    reciever,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Text(
                    '₹$Amount',
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class recieverMessageBubble extends StatelessWidget {
  final String sender;
  final String Amount;

  recieverMessageBubble({required this.sender, required this.Amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recieved From'),
          Material(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    '₹$Amount',
                    style: TextStyle(color: Colors.black, fontSize: 40.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
