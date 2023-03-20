import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/amount.dart';
import 'package:u_pay_app/screens/transaction_history.dart';

import '../components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Payment extends StatelessWidget {
  late String number;
  late String msg;
  final String? username;
  final String? UpayIdorPhone;
  final String? firstNameString;
  final String uid;

  Payment(
      {required this.username,
      required this.UpayIdorPhone,
      required this.firstNameString,
      required this.uid});
  late FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Function to get the logged in user transactionId
  Future<String?> getTransactionId(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Transactions');
    final QuerySnapshot snapshot =
        await users.where('uid', isEqualTo: uid).get();
    if (snapshot.size > 0) {
      final DocumentSnapshot userDoc =
          snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;
      final String? transactionId = userDoc['transactionID'];
      return transactionId ?? null;
    } else {
      return null;
    }
  }

  String? transactionId = null;
  void retrievetransactionId() async {
    transactionId = await getTransactionId(uid);
  }

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
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    firstNameString!,
                    style: TextStyle(fontSize: 25.0),
                  ),
                )),
            Text(
              username!,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Transactions')
            .where('transactionID', isEqualTo: transactionId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // If data is not available, show a loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            // If there are no search results, display a message
            return Center(
              child: Text(
                'No Transactions Found. Do your first transaction and get assured rewards',
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final String transactionType = data?['Type'];
              if (transactionType.contains('Recieved')) {
                return recieverMessageBubble(
                  sender: data?['Name'] ?? '',
                  Amount: data?['Amount'] ?? '',
                );
              } else if (transactionType.contains('Paid')) {
                return sendMessageBubble(
                  reciever: data?['Name'] ?? '',
                  Amount: data?['Amount'] ?? '',
                );
              } else {
                return Center(
                  child: Text(''),
                );
              }
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: RoundedButton(
            Colour: Color(0xff24B3A8),
            Name: 'Amount',
            onPressed: () {
              print(transactionId);
              print(username);
              print(uid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Amount(
                            username: username,
                            UPIorPhone: UpayIdorPhone,
                            headerfirstname: firstNameString,
                            uid: uid,
                          )));
            }),
      ),
    );
  }
}

class sendMessageBubble extends StatelessWidget {
  final String reciever;
  final double Amount;

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
  final double Amount;

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
