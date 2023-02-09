// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lms_parent_app/login/login_apiservice.dart';
import 'package:lms_parent_app/login/login_model.dart';
import 'package:lms_parent_app/login/login_screen.dart';
import 'package:lms_parent_app/pages/configurations.dart';
import 'package:lms_parent_app/pages/explor_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  String id;
  HomePage({super.key, required this.id});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<String> userCategory = ["Management", "Teachers ", "Parents"];
  String userDetails = '';

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ConfigurationsPage(
              id: widget.id,
            ),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(10.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );
          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }

  LoginDetails? loginDetails;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  //Adding UserDetails to sharedPreference

  void initialize() async {
    await mainScreenApi(widget.id).then((value) {
      setState(() {
        loginDetails = value;
      });
    });
  }

  void logout() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      userPrefs.remove('userInfo');
    });
    var info = userPrefs.getString('userInfo');
    print(" helo $info");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  TextEditingController parentNameController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController userCategoryController = TextEditingController();
  TextEditingController courseConfiguredController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abacus"),
        backgroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: loginDetails == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
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
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Parent Name:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 59,
                              child: FormBuilderTextField(
                                controller: TextEditingController(
                                    text: loginDetails?.parentName),
                                name: "",
                                // initialValue: loginDetails.parentName,
                                enabled: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Ward Name:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 59,
                              child: FormBuilderTextField(
                                controller: TextEditingController(
                                    text: loginDetails?.wardName),
                                enabled: false,
                                name: "",
                                decoration: InputDecoration(
                                  // fillColor: Colors.white,
                                  filled: true,

                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "User Category",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 59,
                              child: FormBuilderTextField(
                                name: "",
                                controller: TextEditingController(
                                    text: loginDetails?.userCategory),
                                enabled: false,
                                decoration: InputDecoration(
                                  // fillColor: Colors.white,
                                  filled: true,

                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Course Configured:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: loginDetails?.courseConfigured),
                              enabled: false,
                              minLines: 2,
                              maxLines: 10,
                              decoration: InputDecoration(
                                // fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Progress",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.blue.withOpacity(0.4),
                                    BlendMode.dstATop),
                                image: const AssetImage(
                                    'assets/images/bg_image.png'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    offset: const Offset(3, 2),
                                    blurRadius: 7)
                              ]),
                          child: Column(
                            children: [
                              const Text(
                                "Content Usage",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 10.0,
                                percent: .40,
                                animation: true,
                                linearGradient: LinearGradient(colors: [
                                  Colors.red.shade100,
                                  Colors.red.shade500
                                ]),
                                animationDuration: 1000,
                                center:
                                    Text("${loginDetails?.contentUsage} hours"),
                                // progressColor: Colors.red,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.blue.withOpacity(0.4),
                                    BlendMode.dstATop),
                                image: const AssetImage(
                                    'assets/images/bg_image.png'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    offset: const Offset(3, 2),
                                    blurRadius: 7)
                              ]),
                          child: Column(
                            children: [
                              const Text(
                                "Completion Percent",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 10.0,
                                percent: 0.35,
                                animation: true,
                                animationDuration: 1000,
                                center:
                                    Text(loginDetails!.completionPercentage),
                                linearGradient: LinearGradient(colors: [
                                  Colors.purple.shade100,
                                  Colors.purple.shade500
                                ]),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Hero(
                          tag: 'page1',
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  animationDuration: const Duration(seconds: 4),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.purple)),
                              onPressed: () {
                                Navigator.of(context).push(_createRoute());
                              },
                              child: const Text(
                                "Configuration",
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                animationDuration: const Duration(seconds: 4),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.purple)),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                          id: widget.id,
                                        )),
                              );
                            },
                            child: const Text(
                              "Explore",
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
