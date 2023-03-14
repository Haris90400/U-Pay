import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/payment_confirmation.dart';

class otpWidget extends StatefulWidget {
  final double transferAmount;
  final String phoneOrUpay;
  final String uid;
  final String recieverName;
  otpWidget(
      {required this.transferAmount,
      required this.phoneOrUpay,
      required this.uid,
      required this.recieverName});
  @override
  State<otpWidget> createState() => _otpWidgetState();
}

class _otpWidgetState extends State<otpWidget> {
  bool _isLoading = false;
  //Function to get the logged in user U-PAY Pin
  Future<String> getUpayPin(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    final DocumentSnapshot userDoc = await users.doc(uid).get();
    final String upiPin = userDoc.get('upiPin');
    return upiPin;
  }

  //Function to get the logged in user Balance
  Future<double> getBalance(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    final DocumentSnapshot userDoc = await users.doc(uid).get();
    final double currentBalance = userDoc.get('Balance');
    return currentBalance;
  }

  //Function to get Balance of reciever using username
  Future<double?> getBalanceByUsername(String username) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    final QuerySnapshot snapshot =
        await users.where('Username', isEqualTo: username).get();
    if (snapshot.size > 0) {
      final DocumentSnapshot userDoc = snapshot.docs[0];
      final double balance = userDoc['Balance'];
      return balance;
    } else {
      return null;
    }
  }

  //Function to get Balance of reciever using phone
  Future<double?> getBalanceByPhone(String phone) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    final QuerySnapshot snapshot =
        await users.where('Phone', isEqualTo: phone).get();
    if (snapshot.size > 0) {
      final DocumentSnapshot userDoc = snapshot.docs[0];
      final double balance = userDoc['Balance'];
      return balance;
    } else {
      return null;
    }
  }
  //Function To update Users Balance

  Future<void> updateBalance() async {
    double currentBalance = await getBalance(widget.uid);
    double? recieverBalance = 0.0;

    //To check if the selected payment mode is phone or username
    if (widget.phoneOrUpay.contains('+91')) {
      recieverBalance = await getBalanceByPhone(widget.phoneOrUpay);
      print(recieverBalance);
    } else {
      recieverBalance = await getBalanceByUsername(widget.phoneOrUpay);
      print(recieverBalance);
    }

    double transferAmount = widget.transferAmount;

    if (currentBalance < transferAmount) {
      // Show error message and return if user has insufficient balance
      return;
    }
    //Deduct the money from the logged in user
    currentBalance -= transferAmount;

    // If the receiver's balance is not null, add transfer amount to their balance
    if (recieverBalance != null) {
      recieverBalance += transferAmount;

      // Update receiver's balance in Firestore
      if (widget.phoneOrUpay.contains('+91')) {
        await FirebaseFirestore.instance
            .collection('Users')
            .where('Phone', isEqualTo: widget.phoneOrUpay)
            .get()
            .then((snapshot) {
          snapshot.docs.first.reference.update({'Balance': recieverBalance});
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Users')
            .where('Username', isEqualTo: widget.phoneOrUpay)
            .get()
            .then((snapshot) {
          snapshot.docs.first.reference.update({'Balance': recieverBalance});
        });
      }
    }

    // Update current user's balance in Firestore
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.uid)
        .update({'Balance': currentBalance});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PaymentConformationScreen()));
  }

  //Function to update the transaction history whenever the user does a payment
  Future<void> updateTransactionHistory() async {
    final String senderUID = widget.uid;

    //Retrieving reciever UID
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    final QuerySnapshot usernameQuerySnapshot = await usersCollection
        .where('Username', isEqualTo: widget.phoneOrUpay)
        .get();
    final DocumentSnapshot? userDocumentSnapshot =
        usernameQuerySnapshot.docs.first;
    final String? recieverUID = userDocumentSnapshot?.id;
    // print(recieverUID);
    final _firestore = FirebaseFirestore.instance;

    //Code for retrieving sender Name
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(widget.uid);
    final DocumentSnapshot? NameDocumentSnapshot = await userDocRef.get();
    final String Sendername =
        (NameDocumentSnapshot?.data() as dynamic)!['Name'];

    //Code for updating transaction History Colloection
    //For Sender
    await _firestore.collection('Transactions').add({
      'uid':
          widget.uid, //seeting the sender uid to uniquely identify transaction
      'Amount': widget.transferAmount,
      'Type': 'Paid To',
      'Name': widget.recieverName,
      'timestamp': FieldValue.serverTimestamp()
    });
    //For Reciever
    await _firestore.collection('Transactions').add({
      'uid':
          recieverUID, //setting the reciever uid to uniquely identify transactions for that user
      'Amount': widget.transferAmount,
      'Type': 'Recieved From',
      'Name': Sendername
    });
  }

  late String error_message = '';
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    String enteredUpayPin =
        controllers.map((controller) => controller.text).join();

    //Function to verify upayPin
    Future<bool> verifyUpayPin() async {
      String upayPin = await getUpayPin(widget.uid);
      // print(upayPin);
      print(enteredUpayPin);
      if (enteredUpayPin == upayPin) {
        setState(() {
          error_message = '';
        });
        return true;
      } else {
        setState(() {
          error_message = 'Please enter correct U-Pay Pin';
        });
        return false;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verify Your U-PAY Pin',
          ),
          backgroundColor: Color(0xff24B3A8),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Enter 6 digit U-PAY Pin',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    error_message,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 40.0,
                            height: 35.0,
                            decoration: BoxDecoration(),
                            child: TextField(
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                              obscureText: _obscureText,
                              focusNode: focusNodes[index],
                              controller: controllers[index],
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                                counterText: '',
                              ),
                              //textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  focusNodes[index].unfocus();
                                  if (index != 5) {
                                    FocusScope.of(context).requestFocus(
                                      focusNodes[index + 1],
                                    );
                                  }
                                }
                              },
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff24B3A8)),
                      child: Text('Submit'),
                      onPressed: () async {
                        String pin = '';
                        controllers.forEach((element) => pin += element.text);
                        bool isVerified = await verifyUpayPin();
                        if (isVerified) {
                          _isLoading = true;
                          updateBalance();
                          updateTransactionHistory();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            if (_isLoading) // Show the CircularProgressIndicator if loading
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
