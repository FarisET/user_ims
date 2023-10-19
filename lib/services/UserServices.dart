import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:user_ims/models/ApiResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/ApiError.dart';
import '../models/user.dart';

class UserServices {
  Future<ApiResponse> login(String id, String password) async {
    ApiResponse _apiResponse = new ApiResponse();
    Uri url = Uri.parse('http://localhost:3000/login');
    try {
      final http.Response response = await http.post(
        url,
        body: jsonEncode(
          <String,String>{
            'user_id': id,
            'user_pass': password,
          }
        ),
      );

       switch (response.statusCode) {
        case 200:
          _apiResponse.Data = User.fromJson(json.decode(response.body));
          Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,);
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


Future<bool> pingServer(String serverUrl) async {
  try {
    final response = await http.get(Uri.parse(serverUrl));

    if (response.statusCode == 200) {
      // Server is reachable (status code 200 indicates success)
      return true;
    } else {
      // Server returned a non-success status code
      return false;
    }
  } catch (e) {
    // Error occurred, server is unreachable
    return false;
  }
}

void main() async {
  final serverUrl = 'http://your-node-server-url'; // Replace with your server URL
  final isServerReachable = await pingServer(serverUrl);

  if (isServerReachable) {
    print('Server is reachable.');
  } else {
    print('Server is not reachable.');
  }
}
