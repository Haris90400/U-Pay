import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/payment.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:u_pay_app/constants.dart';

class PayUpi extends StatefulWidget {
  const PayUpi({Key? key}) : super(key: key);

  @override
  State<PayUpi> createState() => _PayUpiState();
}

class _PayUpiState extends State<PayUpi> {
  late String searchText = '';
  TextEditingController searchController = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff24B3A8),
        title: Text("Pay Using UPI ID"),
      ),
      body: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Search bar for searching users by name or UPI ID
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                child: TextField(
                  controller: searchController,
                  decoration: kInputFieldDecoration.copyWith(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Display the list of users that match the search criteria
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: searchText.isEmpty
                      ? firestore.collection('Users').snapshots()
                      : firestore
                          .collection('Users')
                          .orderBy('Username')
                          .startAt([searchText]).endAt(
                              [searchText + '\uf8ff']).snapshots(),
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
                        child: Text('No search results found'),
                      );
                    }
                    return ListView.builder(
                      // Display a list of search results
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 0.0),
                          child: GestureDetector(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Text(
                                  data?['Name']
                                          ?.substring(0, 1)
                                          ?.toUpperCase() ??
                                      '',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              title: Text(data?['Name'] ?? ''),
                              subtitle: Row(
                                children: [
                                  Image.asset(
                                    'images/bhim.ico',
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                  Text(data?['Username'] ?? ''),
                                ],
                              ),
                              onTap: () {
                                // Navigate to the Payment screen when a user is selected
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Payment(
                                        username: data?['Name'],
                                        UpayId: data?['Username'],
                                        firstNameString: data?['Name']
                                                ?.substring(0, 1)
                                                ?.toUpperCase() ??
                                            ''),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
