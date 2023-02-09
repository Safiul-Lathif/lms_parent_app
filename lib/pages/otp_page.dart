// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lms_parent_app/fade_animation.dart';
import 'package:lms_parent_app/login/login_apiservice.dart';
import 'package:lms_parent_app/pages/create_password.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  String mobileNumber;
  OTPScreen({super.key, required this.mobileNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String OTP = '';
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  final focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  final submittedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.blue.shade50,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.4), BlendMode.dstATop),
              image: const AssetImage('assets/images/bg_image.png'),
              fit: BoxFit.cover,
            )),
        child: Column(
          children: <Widget>[
            Container(
              height: 330,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Login/000.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: MediaQuery.of(context).size.width * 0.09,
                      width: 80,
                      height: 350,
                      child: FadeAnimation(
                        2.2,
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Login/mathematics-symbol.png'))),
                        ),
                      )),
                  Positioned(
                      left: MediaQuery.of(context).size.width * 0.439,
                      width: 60,
                      height: 220,
                      child: FadeAnimation(
                        2.3,
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Login/eng.png'))),
                        ),
                      )),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.09,
                      top: 40,
                      width: 65,
                      height: 180,
                      child: FadeAnimation(
                        2.5,
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/Login/abacus.png'))),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Verification",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Enter the verification code send to yor number +91-${widget.mobileNumber}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == '1234' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                    onChanged: (value) {
                      OTP = value;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.pink.shade400)),
                        onPressed: () async {
                          await verifyOTP(widget.mobileNumber, OTP)
                              .then((value) {
                            print(value);
                            if (value['login_unique'] != null) {
                              _snackBar('OTP Verified successfully ');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatePassword(
                                      mobileNumber: widget.mobileNumber,
                                    ),
                                  ));
                            } else {
                              _snackBar('Invalid OTP');
                            }
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  _snackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 600),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
