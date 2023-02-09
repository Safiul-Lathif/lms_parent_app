// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lms_parent_app/fade_animation.dart';
import 'package:lms_parent_app/login/login_apiservice.dart';
import 'package:lms_parent_app/pages/category_page.dart';
import 'package:lms_parent_app/pages/otp_page.dart';
import 'package:pinput/pinput.dart';

class RegisteredUserPage extends StatefulWidget {
  String mobileNumber;
  RegisteredUserPage({super.key, required this.mobileNumber});

  @override
  State<RegisteredUserPage> createState() => _RegisteredUserPageState();
}

class _RegisteredUserPageState extends State<RegisteredUserPage> {
  String createPass = '';
  String reenterPass = '';
  bool isVisible = true;
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
        child: SingleChildScrollView(
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

                    // )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: const [
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Please sign in to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: "Number",
                      initialValue: widget.mobileNumber,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        hintText: "Enter Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.mobileNumber = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          reenterPass = value;
                        });
                      },
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                        filled: true,
                        hintText: "Your Password",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.pinkAccent,
                            title: Text('Show Password'),
                            value: !isVisible,
                            onChanged: (bool? value) {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.5,
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
                            await loginWithPassword(
                                    widget.mobileNumber, reenterPass)
                                .then((value) {
                              print(value);
                              if (value['categories'] != null) {
                                _snackBar('Login successfully  !');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryPage(
                                              id: value['login_unique'],
                                            )));
                              } else {
                                _snackBar(
                                    'Your number and password does not match !');
                              }
                            });
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot your password ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                    mobileNumber: widget.mobileNumber,
                                  ),
                                ));
                          },
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  _snackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
