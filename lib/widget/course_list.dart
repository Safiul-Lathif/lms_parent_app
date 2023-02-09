// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:lms_parent_app/apiservice/category_apiservice.dart';
import 'package:lms_parent_app/model/student_progress.dart';

class CourseList extends StatefulWidget {
  String id, categoryId, levelId;
  CourseList(
      {super.key,
      required this.id,
      required this.categoryId,
      required this.levelId});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  List<StudentProgress> listOfStudents = [];

  @override
  void initState() {
    super.initState();
    getStudentList();
  }

  void getStudentList() async {
    await getStudent(widget.id, widget.categoryId, widget.levelId)
        .then((value) {
      setState(() {
        // listOfStudents = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: MediaQuery.of(context).size.height * 0.76,
      child: widget.categoryId == '' || widget.levelId == ''
          ? Container()
          : ListWheelScrollView(
              itemExtent: 250,
              physics: const FixedExtentScrollPhysics(),
              children: [
                for (int i = 0; i < listOfStudents.length; i++)
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
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
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        listOfStudents[i].unitId,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        listOfStudents[i].unitName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text(
                                        "Course Benefits: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 320,
                                        child: Text(
                                          listOfStudents[i].unitBenefits,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text(
                                        "Parent Tip:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 320,
                                    child: Text(
                                      listOfStudents[i].parentTip,
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Total Question :",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(listOfStudents[i].questionsCount)
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(listOfStudents[i].time)
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Correct answers :",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
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
                                                fontWeight: FontWeight.bold),
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
                          : listOfStudents[i].status != 'not_yet_started'
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
    );
  }

  _snackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 600),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
