import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:user_ims/models/ApiResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/ApiError.dart';
import '../models/user.dart';

class UserServices {
  Future<ApiResponse> login(String id, String password) async {
    ApiResponse _apiResponse = ApiResponse();
    Uri url = Uri.parse('http://192.168.18.74:3000/login');
    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String,String>{
            "user_id": id,
            "user_pass": password,
          }
        ),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');


       switch (response.statusCode) {
        case 200:
          final jsonBody = json.decode(response.body);
          if (jsonBody.containsKey('user_id') && jsonBody.containsKey('user_pass')) {
            _apiResponse.Data = User.fromJson(jsonBody);
          } else {
            _apiResponse.ApiError = ApiError(error: 'Invalid response format');
          }          
          // Fluttertoast.showToast(
          // msg: "Login Successful",
          // toastLength: Toast.LENGTH_SHORT,);
          print('Login Successful');
          break;
        case 401:
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    
    return _apiResponse;
    }
  }


// Future<bool> pingServer(String serverUrl) async {
//   try {
//     final response = await http.get(Uri.parse(serverUrl));

//     if (response.statusCode == 200) {
//       // Server is reachable (status code 200 indicates success)
//       return true;
//     } else {
//       // Server returned a non-success status code
//       return false;
//     }
//   } catch (e) {
//     // Error occurred, server is unreachable
//     return false;
//   }
// }

// void main() async {
//   final serverUrl = 'http://your-node-server-url'; // Replace with your server URL
//   final isServerReachable = await pingServer(serverUrl);

//   if (isServerReachable) {
//     print('Server is reachable.');
//   } else {
//     print('Server is not reachable.');
//   }
// }
