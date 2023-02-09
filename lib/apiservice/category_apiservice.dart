import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_parent_app/model/category_model.dart';
import 'package:lms_parent_app/model/student_progress.dart';

Future<List<Category>?> categoryModel(String userId) async {
  var url = Uri.parse('http://3.6.165.160/api-category-dropdown-list');
  var map = <String, dynamic>{};
  map['login_unique'] = userId;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Category.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } on Error catch (err) {
    print('loginAuth -> error occured: $err.');
    return null;
  }
}

Future<List<LevelList>?> LevelModel(String userId, String catId) async {
  var url = Uri.parse('http://3.6.165.160/api-level-dropdown-list');
  var map = <String, dynamic>{};
  map['login_unique'] = userId;
  map['category_id'] = catId;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => LevelList.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } on Error catch (err) {
    print('level error -> error : $err.');
    return null;
  }
}

Future<List<StudentProgress>?> getStudent(
    String userId, String catId, String levId) async {
  var url = Uri.parse('http://3.6.165.160/api-student-progress');
  var map = <String, dynamic>{};
  map['login_unique'] = userId;
  map['category_id'] = catId;
  map['level_id'] = levId;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((json) => StudentProgress.fromJson(json))
          .toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } on Error catch (err) {
    print('student error -> error : $err.');
    return null;
  }
}
