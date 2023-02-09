import 'package:flutter/material.dart';
import 'package:lms_parent_app/fade_animation.dart';
import 'package:lms_parent_app/login/login_apiservice.dart';
import 'package:lms_parent_app/pages/otp_page.dart';
import 'package:lms_parent_app/pages/registered_user_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String mobileNumber = '';
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
                  Positioned(
                      child: FadeAnimation(
                    2.6,
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Enter your mobile number and login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              mobileNumber = value;
                            });
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            isDense: true,
                            filled: true,
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisteredUserPage(
                                    mobileNumber: mobileNumber,
                                  ),
                                ));
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey.shade700),
                          )),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.39,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.pink.shade400),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ))),
                            onPressed: () async {
                              await sendOTP(mobileNumber).then((value) {
                                if (mobileNumber.length == 10) {
                                  if (value['status'] == true) {
                                    _snackBar('OTP Send successfully');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OTPScreen(
                                            mobileNumber: mobileNumber,
                                          ),
                                        ));
                                  }
                                } else {
                                  _snackBar(
                                      'Please enter the valid mobile number');
                                }
                              });
                            },
                            child: Row(
                              children: const [
                                Text(
                                  "Sent OTP",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 180,
                  ),
                  Text(
                    "Powered by KYC360 pro",
                    style: TextStyle(color: Colors.blueGrey.shade700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  _snackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
