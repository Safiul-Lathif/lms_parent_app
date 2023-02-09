// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lms_parent_app/fade_animation.dart';
import 'package:lms_parent_app/login/login_apiservice.dart';
import 'package:lms_parent_app/pages/category_page.dart';
import 'package:pinput/pinput.dart';

class CreatePassword extends StatefulWidget {
  String mobileNumber;
  CreatePassword({super.key, required this.mobileNumber});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  String createPass = '';
  String reenterPass = '';
  bool createPassword = true;
  bool reenterPassword = true;
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

                  // )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Create password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          createPass = value;
                        });
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: createPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                createPassword = !createPassword;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: createPassword
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            )),
                        filled: true,
                        hintText: "Create your Password",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          reenterPass = value;
                        });
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: reenterPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                reenterPassword = !reenterPassword;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: reenterPassword
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            )),
                        filled: true,
                        hintText: "Conform Your Password",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
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
                          await setPassword(widget.mobileNumber, createPass)
                              .then((value) {
                            print(value);
                            if (value['categories'] != null) {
                              if (reenterPass.isEmpty || createPass.isEmpty) {
                                _snackBar('please Enter the Password   !');
                              } else {
                                if (createPass != reenterPass) {
                                  _snackBar(
                                      'Password Field doesnt same enter correct password  !');
                                } else {
                                  _snackBar('Login successfully  !');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoryPage(
                                                id: value['login_unique'],
                                              )));
                                }
                              }
                            } else {
                              _snackBar('Please fill the password Field');
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
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
