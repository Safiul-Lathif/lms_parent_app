import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.blue.withOpacity(0.4), BlendMode.dstATop),
                  image: const AssetImage('assets/images/bg_image.png'),
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.purple,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.purple.withOpacity(0.3), BlendMode.dstATop),
                  image: const AssetImage('assets/images/bg_image.png'),
                  fit: BoxFit.cover,
                )),
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: FormBuilderTextField(
                    name: "",
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: FormBuilderTextField(
                    name: "",
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
