import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class transactionnHistory extends StatefulWidget {
  final String uid;

  transactionnHistory({required this.uid});

  @override
  State<transactionnHistory> createState() => _transactionnHistoryState();
}

class _transactionnHistoryState extends State<transactionnHistory> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff24B3A8),
          title: Text('Your previous transactions'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Transactions')
              .where('uid', isEqualTo: widget.uid)
              .orderBy('timestamp', descending: false)
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
                if (transactionType.contains('Received')) {
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
                    child: Text(
                        'No Transactions Found. Do your first transaction and get assured rewards'),
                  );
                }
              },
            );
          },
        ));
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
