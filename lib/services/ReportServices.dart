import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/incident_sub_type.dart';
import '../models/incident_types.dart';
import '../models/report.dart';

class ReportServices {
  final BuildContext context;  // Include the BuildContext in the constructor

  ReportServices(this.context);  
  // Constructor for ReportServices
  String? current_user_id;

 // void getUsername() async {
    
      
 // }

Future<List<Reports>> fetchReports() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  current_user_id = prefs.getString("user_id");
  print('current user in sp: $current_user_id');
  Uri url = Uri.parse('http://${IP_URL}:3000/userReport/dashboard/$current_user_id/reports');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<Reports> reportList = jsonResponse
        .map((dynamic item) => Reports.fromJson(item as Map<String, dynamic>))
        .toList();
    return reportList;
  }

  throw Exception('Failed to load Reports');
}    

Future<void> postSelectedIncidentType(String selectedIncidentType) async {
  // Specify the complete URL including the endpoint path
  Uri url = Uri.parse('http://${IP_URL}:3000/userReport/dashboard/fetchincidentsubType');

  final http.Response response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      <String, dynamic>{
        "incident_type_id": selectedIncidentType,
      },
    ),
  );

}



    //TODO: post selected incident type id to return incident sub type
  
  Future<bool> postReport(String image, String sublocation, String incidentSubType, String description, DateTime date, String risklevel) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    current_user_id = prefs.getString("user_id");
    print('current_user_id:$current_user_id');
    Uri url = Uri.parse('http://${IP_URL}:3000/userReport/dashboard/$current_user_id/MakeReport');
    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String,dynamic>{
          "image":image,
        //  "id":id,
          "incident_subtype_id":sublocation,
           "sub_location_id":incidentSubType,
           "report_description":description,
           "date_time": date.toLocal().toIso8601String().split(".")[0], // Serialize DateTime to string   
         //  "status":status, //how to update, initial false, will be changed by admin.
           "incident_criticality_id":risklevel
         //  "reported_by": reported_by
      },
    ),
      );
      final msg = json.decode(response.body)['status'];

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
       // return true;
          // User user = User.fromJson(jsonBody);
          // print(user);
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString("user_id", user.user_id);
          // print(prefs);
          return true;
        
      } else if (response.statusCode == 500) {
    //    print(status);
            Fluttertoast.showToast(
            msg: msg,
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

}