// ignore_for_file: non_constant_identifier_names

import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:lms_parent_app/apiservice/configuration_apiservice.dart';
import 'package:lms_parent_app/model/configuration_model.dart';

class ConfigurationsPage extends StatefulWidget {
  String id;
  ConfigurationsPage({super.key, required this.id});

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  bool isOkay = true;
  bool isStudent = false;
  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek(
      "Tue",
    ),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thr",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];

  bool is_submitted = false;
  // bool val
  bool isEdit = true;

  String learningDaysFrom = 'Select Day';
  String learningDaysTo = 'Select Day';
  bool isVisible = false;
  String sameDevice = '';
  int screenDuration = 0;
  String learningFromTime = '';
  String learningToTime = '';
  String nonAcademicDurationFrom = '';
  String nonAcademicDurationTo = '';
  int gameDuration = 0;

  ConfigurationModel? configurationData;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await configDetails(widget.id).then((value) {
      setState(() {
        configurationData = value;
        sameDevice = configurationData!.sameDevice;
        learningDaysFrom = configurationData!.learningDaysFrom;
        learningDaysTo = configurationData!.learningDaysTo;
        gameDuration = int.parse(configurationData!.gameDuration);
        screenDuration = int.parse(configurationData!.screenDuration);
        if (sameDevice == "no") {
          setState(() {
            is_submitted == false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'page1',
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  animationDuration: const Duration(seconds: 4),
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
              onPressed: () {
                setState(() {
                  isOkay = !isOkay;
                });
              },
              child: const Text(
                " Abacus Configuration",
                style: TextStyle(fontSize: 16),
              )),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: configurationData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
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
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Does your child use same device?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CupertinoSwitch(
                        activeColor: Colors.purple,
                        value: isEdit ? is_submitted : isStudent,
                        onChanged: (value) {
                          is_submitted = !is_submitted;
                          setState(() {
                            if (is_submitted == true) {
                              sameDevice = 'Yes';
                            } else {
                              sameDevice = 'no';
                            }
                            HapticFeedback.vibrate();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/danger.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "Our notifications will be segregated based on your input",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Screen Duration setting (in a day)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showMaterialNumberPicker(
                                backgroundColor: const Color(0xffcccccc),
                                headerColor: Colors.purple,
                                context: context,
                                title: 'Pick Time in hrs',
                                maxShortSide: 500,
                                maxLongSide: 500,
                                maxNumber: 24,
                                minNumber: 1,
                                selectedNumber: 6,
                                onChanged: (value) => {
                                      setState(() {
                                        screenDuration = value;
                                      })
                                    });
                          },
                          style: ButtonStyle(
                              animationDuration: const Duration(seconds: 4),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffcccccc))),
                          child: Text(
                            " $screenDuration Hrs",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/danger.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "If you have a recommended duration , we will inform you if the screen duration exceeds the recommendation",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Available period for learning abacus",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 330,
                          height: 70,
                          child: SelectWeekDays(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            days: _days,
                            border: false,
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                // 10% of the width, so there are ten blinds.
                                colors: [
                                  Color(0xFFE55CE4),
                                  Color(0xFFBB75FB)
                                ], // whitish to gray
                                tileMode: TileMode
                                    .repeated, // repeats the gradient over the canvas
                              ),
                            ),
                            onSelect: (values) {
                              setState(() {
                                isVisible = false;
                                learningDaysFrom = values[0];
                                learningDaysTo = values[1];
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Days",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(child: Text(learningDaysFrom))),
                      ),
                      const Text(
                        "to",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(child: Text(learningDaysTo))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 90,
                        height: 40,
                        child: FormBuilderTextField(
                          textAlign: TextAlign.center,
                          initialValue:
                              isEdit ? configurationData!.learningFromTime : '',
                          name: "",
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              learningFromTime = value.toString();
                            });
                          },
                        ),
                      ),
                      const Text(
                        "to",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 90,
                        height: 40,
                        child: FormBuilderTextField(
                          textAlign: TextAlign.center,
                          initialValue:
                              isEdit ? configurationData!.learningToTime : '',
                          name: "",
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              learningToTime = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/danger.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "We will remind you during the set duration for learning Abacus",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Non-academic period range",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: FormBuilderDropdown(
                            name: 'Month',
                            menuMaxHeight: 300.0,
                            dropdownColor:
                                const Color.fromARGB(255, 231, 230, 230),
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: isEdit
                                  ? configurationData!.nonAcademicDurationFrom
                                  : "April",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                nonAcademicDurationFrom = value.toString();
                              });
                            },
                            items: month.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                alignment: AlignmentDirectional.center,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      item,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const Expanded(
                            flex: 1, child: Center(child: Text("to"))),
                        Expanded(
                          flex: 2,
                          child: FormBuilderDropdown(
                            menuMaxHeight: 300.0,
                            name: 'Month',
                            dropdownColor:
                                const Color.fromARGB(255, 231, 230, 230),
                            isExpanded: true,
                            decoration: InputDecoration(
                              hintText: isEdit
                                  ? configurationData!.nonAcademicDurationTo
                                  : "June",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                nonAcademicDurationTo = value.toString();
                              });
                            },
                            items: month.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      item,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/danger.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "This is the durations that can be used for fast track learning ",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Game duration setting (in a day)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showMaterialNumberPicker(
                                backgroundColor: const Color(0xffcccccc),
                                headerColor: Colors.purple,
                                context: context,
                                title: 'Pick Time in hrs',
                                maxShortSide: 500,
                                maxLongSide: 500,
                                maxNumber: 24,
                                minNumber: 1,
                                selectedNumber: 6,
                                onChanged: (value) => {
                                      setState(() {
                                        gameDuration = value;
                                      })
                                    });
                          },
                          style: ButtonStyle(
                              animationDuration: const Duration(seconds: 4),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffcccccc))),
                          child: Text(
                            " $gameDuration Hrs",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/danger.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "We will restrict usages of games to fall within the set duration ",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          animationDuration: const Duration(seconds: 4),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: () async {
                        if (widget.id.isEmpty ||
                            sameDevice.isEmpty ||
                            screenDuration.toString().isEmpty ||
                            gameDuration.toString().isEmpty ||
                            learningDaysFrom.isEmpty ||
                            learningDaysTo.isEmpty ||
                            learningFromTime.isEmpty ||
                            learningToTime.isEmpty ||
                            nonAcademicDurationFrom.isEmpty ||
                            nonAcademicDurationTo.isEmpty) {
                          _snackBar('Please fill All the value ');
                        } else {
                          await configurationInput(
                              widget.id,
                              sameDevice,
                              screenDuration.toString(),
                              gameDuration.toString(),
                              learningDaysFrom,
                              learningDaysTo,
                              learningFromTime,
                              learningToTime,
                              nonAcademicDurationFrom,
                              nonAcademicDurationTo);
                          _snackBar('Data Updated Successfully');
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              )),
            ),
    );
  }

  _snackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
