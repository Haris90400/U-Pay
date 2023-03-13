import 'package:flutter/material.dart';

class transctionHistory extends StatelessWidget {
  const transctionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff24B3A8),
          title: Text('Your previous transactions'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          children: [],
        ));
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
