import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class UserServices {
  final BuildContext context;  // Include the BuildContext in the constructor

  UserServices(this.context);  // Constructor for UserServices

  Future<bool> login(String id, String password) async {
    Uri url = Uri.parse('http://${IP_URL}:3000/user/login');
    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String, String>{
            "user_id": id,
            "user_pass": password,
          },
        ),
      );
      final status = json.decode(response.body)['status'];
      final user_name = json.decode(response.body)['user_name'];  
      final role = json.decode(response.body)['role'];  

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
       // return true;
          // User user = User.fromJson(jsonBody);
          // print(user);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("user_name", user_name);
          await prefs.setString("role", role);

          print('user name: $user_name');
          return true;
        
      } else if (response.statusCode == 401) {
    //    print(status);
            Fluttertoast.showToast(
            msg: status,
            toastLength: Toast.LENGTH_SHORT,
          );

        // Handle the case where user is not found or password is invalid
          return false;
      }
    } catch (e) {
        Fluttertoast.showToast(
            msg: '$e',
            toastLength: Toast.LENGTH_SHORT,
          );
      // Handle network or unexpected errors
      return false; 
    }
    return false;
  }

  Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
}

}

