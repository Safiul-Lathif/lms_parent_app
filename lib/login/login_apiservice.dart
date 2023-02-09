import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_model.dart';

Future<dynamic> sendOTP(String number) async {
  var url = Uri.parse('http://3.6.165.160/api-sendOTP');
  var map = <String, dynamic>{};
  map['mobile_number'] = number;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
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

Future<dynamic> verifyOTP(String number, String otp) async {
  var url = Uri.parse('http://3.6.165.160/api-verify-OTP');
  var map = <String, dynamic>{};
  map['mobile_number'] = number;
  map['otp'] = otp;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
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

Future<dynamic> setPassword(String number, String password) async {
  var url = Uri.parse('http://3.6.165.160/api-store-password');
  var map = <String, dynamic>{};
  map['mobile_number'] = number;
  map['password'] = password;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
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

Future<dynamic> loginWithPassword(String number, String password) async {
  var url = Uri.parse('http://3.6.165.160/api-parent-login');
  var map = <String, dynamic>{};
  map['mobile_number'] = number;
  map['password'] = password;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
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

// Future<dynamic> mainScreenApi(String userId) async {
//   var url = Uri.parse('http://3.6.165.160/api-get-parent-main-screen');
//   var map = <String, dynamic>{};
//   map['login_unique'] = userId;
//   try {
//     final response = await http.post(url, body: map);
//     if (response.statusCode == 200) {
//       List jsonResponse = jsonDecode(response.body);
//       return jsonResponse.map((json) => Login.fromJson(json)).toList();
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//       return null;
//     }
//   } on Error catch (err) {
//     print('loginAuth -> error occured: $err.');
//     return null;
//   }
// }
Future<LoginDetails?> mainScreenApi(String number) async {
  var url = Uri.parse('http://3.6.165.160/api-get-parent-main-screen');
  var map = <String, dynamic>{};
  map['login_unique'] = number;
  try {
    final response = await http.post(url, body: map);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return LoginDetails.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } on Error catch (err) {
    print('loginAuth -> error occured: $err.');
    return null;
  }
}

// Future<dynamic> fetchAlbum() async {
//   final response = await http.get(Uri.parse(
//       'https://xl0i8xtzg9.execute-api.ap-northeast-1.amazonaws.com/contacts'));

//   if (response.statusCode == 200) {
//     final jsonResponse = jsonDecode(response.body);
//     return jsonResponse;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
