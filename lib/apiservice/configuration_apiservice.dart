import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_parent_app/model/configuration_model.dart';

Future<dynamic> configurationInput(
    String id,
    sameDevice,
    screenDuration,
    gameDuration,
    learningDaysFrom,
    learningDaysTo,
    learningFromTime,
    learningToTime,
    nonAcademicDurationFrom,
    nonAcademicDurationTo) async {
  var url = Uri.parse('http://3.6.165.160/api-get-parent-inputs');
  var map = <String, dynamic>{};
  map['login_unique'] = id;
  map['same_device'] = sameDevice;
  map['screen_duration'] = screenDuration;
  map['game_duration'] = gameDuration;
  map['learning_days_from'] = learningDaysFrom;
  map['learning_days_to'] = learningDaysTo;
  map['learning_from_time'] = learningFromTime;
  map['learning_to_time'] = learningToTime;
  map['non_academic_duration_from'] = nonAcademicDurationFrom;
  map['non_academic_duration_to'] = nonAcademicDurationTo;

  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } on Error catch (err) {
    print('loginAuth -> error occured: $err.');
    return null;
  }
}

Future<ConfigurationModel?> configDetails(String loginId) async {
  var url = Uri.parse('http://3.6.165.160/api-list-parent-inputs');
  var map = <String, dynamic>{};
  map['login_unique'] = loginId;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ConfigurationModel.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } on Error catch (err) {
    print('loginAuth -> error occured: $err.');
    return null;
  }
}
