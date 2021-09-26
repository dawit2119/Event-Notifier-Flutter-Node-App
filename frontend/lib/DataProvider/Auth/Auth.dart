import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frontend/Models/User.dart';
import 'package:frontend/Models/LoginModel.dart';

import '../../Utilities/Constants.dart';

//Genymotion emulator address 192.168.60.1

class ClientAuthDataProvider {
// RegisterUser DataProvider

  static Future<User> register(User user) async {
    User getCurrentUser = User("", "");
    try {
      final httpresponse = await http.post(
        Uri.parse('$API_URL/RegisterUser'),
        body: user.tojson(),
      );
      if (httpresponse.statusCode == 201) {
        var incommingvalue = jsonDecode(httpresponse.body);
        getCurrentUser = User(
          incommingvalue['emailAddress'],
          incommingvalue['password'],
          userName: incommingvalue['userName'],
          fullName: incommingvalue['fullName'],
          confirmPassword: incommingvalue['confirmPassword'],
        );
      }

    } catch (e) {
      print(e.toString());
    }

    return getCurrentUser;
  }

  //update
  static Future<String> update(User user) async {
    String message = "";
    try {
      final httpresponse = await http.put(
        Uri.parse('$API_URL/UpdateProfile'),
        body: user.tojson(),
      );
      if (httpresponse.statusCode == 201) {
        message = httpresponse.body;
        
      }
    } catch (e) {
      print(e.toString());
    }

    return message;
  }

// Login DataProvider

  static Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    var finalvalue;
    try {
      final httpresponse = await http.post(Uri.parse('$API_URL/LoginUser'),
          body: loginModel.tojson());
      if (httpresponse.statusCode == 200) {
        finalvalue = jsonDecode(httpresponse.body);
      } else if (httpresponse.statusCode == 400) {
        finalvalue = jsonDecode(httpresponse.body);
      }
    } catch (e) {
      print(e.toString());
    }

    return finalvalue;
  }

// DeleteUser DataProvider

  static Future<String> deleteaccount(User user, String accesstoken) async {
    var result = "";

    try {
      final httpresponse = await http.delete(
        Uri.parse('$API_URL/DeleteProfile'),
        body: {
          "emailAddress": user.tojson()['emailAddress'],
        },
        headers: {"Authorization": "${accesstoken}"},
      );
      if (httpresponse.statusCode == 200) {
        result = jsonDecode(httpresponse.body).toString();
      } else if (httpresponse.statusCode == 400) {
        result = jsonDecode(httpresponse.body).toString();
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
