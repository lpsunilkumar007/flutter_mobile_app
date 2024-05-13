import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile_app/values/app_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  var url = Uri.https(AppApi.baseUrl, AppApi.user);

  UserModel? userProfile;

  Future<UserModel> getData() async {
    UserModel userModel = UserModel(
        Age: '',
        Email: 'Email',
        FirstName: 'FirstName',
        LastName: 'LastName',
        Role: 'Role',
        UserName: 'UserName',
        statuscode: 100);
    final storage = await SharedPreferences.getInstance();
    var accessToken = await storage.getString('access_token');
    bool authenticated = false;
    if (accessToken != null) {
      authenticated = !JwtDecoder.isExpired(accessToken!);
    }
    if (authenticated) {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var parsedData = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        try {
          userModel = UserModel(
              Age: parsedData["data"]["age"].toString(),
              Email: parsedData["data"]["email"],
              FirstName: parsedData["data"]["firstName"],
              LastName: parsedData["data"]["lastName"],
              Role: parsedData["data"]["role"],
              UserName: parsedData["data"]["username"],
              statuscode: 200);
          userProfile = userModel;
        } catch (e) {}
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        userModel = UserModel(
            Age: '',
            Email: 'Email',
            FirstName: 'FirstName',
            LastName: 'LastName',
            Role: 'Role',
            UserName: 'UserName',
            statuscode: response.statusCode);
      }
    } else {
      userModel = UserModel(
          Age: '',
          Email: 'Email',
          FirstName: 'FirstName',
          LastName: 'LastName',
          Role: 'Role',
          UserName: 'UserName',
          statuscode: 100);
    }
    return userModel;
  }
}

class UserModel {
  String UserName;
  String FirstName;
  String LastName;
  String Email;
  String Role;
  String Age;
  int statuscode;
  UserModel(
      {required this.Age,
      required this.Email,
      required this.FirstName,
      required this.LastName,
      required this.Role,
      required this.UserName,
      required this.statuscode});
}
