import 'package:flutter/material.dart';
import 'package:u_pay_app/screens/home_page.dart';

class OtpScreen extends StatefulWidget {
  final String userPhoneNumber;
  final String Username;

  OtpScreen({required this.userPhoneNumber, required this.Username});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter OTP send to ${widget.userPhoneNumber}',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'OTP',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>HomePage()));
                // perform action to verify OTP
                // for example:
                String enteredOtp = _otpController.text;
                // if OTP is verified, navigate to next page
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    ));
  }
}
