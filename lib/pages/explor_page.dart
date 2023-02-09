// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lms_parent_app/apiservice/category_apiservice.dart';
import 'package:lms_parent_app/model/category_model.dart';
import 'package:lms_parent_app/model/student_progress.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatefulWidget {
  String id;
  ExplorePage({super.key, required this.id});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Category> category = [];
  List<LevelList> level = [];
  List<StudentProgress> listOfStudents = [];
  String categoryId = '';
  String levelName = '';
  String levelId = '';

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await categoryModel(widget.id).then((value) {
      setState(() {
        category = value!;
      });
    });
  }

  void levelList() async {
    await LevelModel(widget.id, categoryId).then((value) {
      setState(() {
        level = value!;
      });
    });
  }

  void getStudentList() async {
    await getStudent(widget.id, categoryId, levelId).then((value) {
      setState(() {
        listOfStudents = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 35),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue.shade50,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.4), BlendMode.dstATop),
              image: const AssetImage('assets/images/bg_image.png'),
              fit: BoxFit.cover,
            )),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: const Offset(3, 2),
                        blurRadius: 7)
                  ],
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.blue.withOpacity(0.4), BlendMode.dstATop),
                    image: const AssetImage('assets/images/bg_image.png'),
                    fit: BoxFit.cover,
                  )),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                              width: 100,
                              child: Text(
                                "Course:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          Text("Elementary course")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                              width: 100,
                              child: Text(
                                "Category:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          SizedBox(
                            width: 130,
                            height: 50,
                            child: FormBuilderDropdown(
                              name: '',
                              isExpanded: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select level'),
                              dropdownColor:
                                  const Color.fromARGB(255, 231, 230, 230),
                              onChanged: (value) {
                                setState(() {
                                  categoryId = value.toString();
                                  if (levelId != '') {
                                    level == [];
                                  }
                                  levelList();
                                });
                              },
                              items: category.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.categoryId,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item.categoryName,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                              width: 100,
                              child: Text(
                                "Level:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          SizedBox(
                            width: 130,
                            height: 50,
                            child: FormBuilderDropdown(
                              name: '',
                              isExpanded: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select level'),
                              dropdownColor:
                                  const Color.fromARGB(255, 231, 230, 230),
                              onChanged: (value) {
                                setState(() {
                                  levelId = value.toString();
                                  getStudentList();
                                });
                              },
                              items: level.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.levelId,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item.levelName,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset(
                    'assets/images/elementary-school.png',
                    height: 60,
                    width: 60,
                  )
                ],
              ),
            ),
            listOfStudents.isEmpty
                ? Center(
                    child: Container(
                      child: Lottie.network(
                        'https://assets7.lottiefiles.com/private_files/lf30_lkquf6qz.json',
                        height: 500.0,
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                    ),
                  )
                : categoryId == '' || levelId == ''
                    ? Center(
                        child: Container(
                          child: Lottie.network(
                            'https://assets7.lottiefiles.com/private_files/lf30_lkquf6qz.json',
                            height: 500.0,
                            repeat: true,
                            reverse: true,
                            animate: true,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: ListWheelScrollView(
                          itemExtent: 250,
                          physics: const FixedExtentScrollPhysics(),
                          children: [
                            for (int i = 0; i < listOfStudents.length; i++)
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.5),
                                                  offset: const Offset(3, 2),
                                                  blurRadius: 7)
                                            ],
                                            image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  Colors.blue.withOpacity(0.4),
                                                  BlendMode.dstATop),
                                              image: const AssetImage(
                                                  'assets/images/bg_image.png'),
                                              fit: BoxFit.cover,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${listOfStudents[i].unitId} :",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 250,
                                                    child: Text(
                                                      listOfStudents[i]
                                                          .unitName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: const [
                                                  Text(
                                                    "Course Benefits: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    width: 320,
                                                    child: Text(
                                                      listOfStudents[i]
                                                          .unitBenefits,
                                                      maxLines: 3,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: const [
                                                  Text(
                                                    "Parent Tip:",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 320,
                                                child: Text(
                                                  listOfStudents[i].parentTip ==
                                                          ''
                                                      ? 'Empty'
                                                      : listOfStudents[i]
                                                          .parentTip,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Total Question :",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(listOfStudents[i]
                                                          .questionsCount)
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Duration Taken :",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(listOfStudents[i]
                                                                  .time ==
                                                              null
                                                          ? '0'
                                                          : listOfStudents[i]
                                                              .time)
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Correct answers :",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(listOfStudents[i]
                                                          .correctAnswer
                                                          .toString())
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Wrong Answers :",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(listOfStudents[i]
                                                          .wrongAnswer
                                                          .toString())
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  listOfStudents[i].status == 'in_progress'
                                      ? Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/5696/5696031.png",
                                            height: 40,
                                            width: 40,
                                          ))
                                      : listOfStudents[i].status !=
                                              'not_yet_started'
                                          ? Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Image.network(
                                                "https://cdn-icons-png.flaticon.com/512/190/190411.png",
                                                height: 40,
                                                width: 40,
                                              ))
                                          : Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Image.network(
                                                "https://cdn-icons-png.flaticon.com/512/753/753345.png",
                                                height: 40,
                                                width: 40,
                                              ))
                                ],
                              ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
