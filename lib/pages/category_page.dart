// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lms_parent_app/fade_animation.dart';
import 'package:lms_parent_app/pages/add_users_page.dart';
import 'package:lms_parent_app/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryPage extends StatefulWidget {
  String id;
  CategoryPage({super.key, required this.id});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userDetails = '';

  @override
  void initState() {
    super.initState();
    userDetail();
  }

  void userDetail() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    if (userPrefs.getString('userInfo') == null) {
      await userPrefs.setString('userInfo', widget.id);
    }
    userDetails = userPrefs.getString('userInfo')!;
    print("hello $userDetails");
  }

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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        right: MediaQuery.of(context).size.width * 0.09,
                        top: 220,
                        height: 180,
                        child: TextButton(
                          child: const Text("Add User"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNewUser()));
                          },
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.purple.shade700,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue.withOpacity(0.4),
                                BlendMode.dstATop),
                            image:
                                const AssetImage('assets/images/bg_image.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: const Offset(3, 2),
                                blurRadius: 7)
                          ]),
                      child: ListTile(
                        title: const Text(
                          "Abacus",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        id: widget.id,
                                      )));
                        },
                        trailing: const SizedBox(
                            height: double.infinity,
                            child: Icon(
                              Icons.arrow_right,
                              size: 30,
                            )),
                        subtitle: const Text(
                            "What is an Abacus? An abacus is a calculation tool used by sliding counters along rods or grooves, used to perform mathematical functions."),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade700,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue.withOpacity(0.4),
                                BlendMode.dstATop),
                            image:
                                const AssetImage('assets/images/bg_image.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: const Offset(3, 2),
                                blurRadius: 7)
                          ]),
                      child: const ListTile(
                        title: Text(
                          "Vedic Mathematics",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: SizedBox(
                            height: double.infinity,
                            child: Icon(
                              Icons.arrow_right,
                              size: 30,
                            )),
                        subtitle: Text(
                            "Vedic maths is a system of mathematics that was discovered by an Indian mathematician, Jagadguru Shri Bharathi Krishna Tirthaji during A.D. 1911 and 1918."),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue.withOpacity(0.4),
                                BlendMode.dstATop),
                            image:
                                const AssetImage('assets/images/bg_image.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: const Offset(3, 2),
                                blurRadius: 7)
                          ]),
                      child: const ListTile(
                        title: Text(
                          "Learn English",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: SizedBox(
                            height: double.infinity,
                            child: Icon(
                              Icons.arrow_right,
                              size: 30,
                            )),
                        subtitle: Text(
                            "Learn English online and improve your skills through our high-quality courses and resources – all designed for adult language learners"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
