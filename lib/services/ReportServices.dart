import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/incident_sub_type.dart';
import '../models/incident_types.dart';
import '../models/report.dart';

class ReportServices {
  final BuildContext context;  // Include the BuildContext in the constructor

  ReportServices(this.context);  
  // Constructor for ReportServices

  Future<List<Reports>> fetchReports() async {
    Uri url = Uri.parse('http://192.168.71.223:3000/getUserReports');
    final response = await http.get(url);
          //   Fluttertoast.showToast(
          //   msg: '${response.statusCode}',
          //   toastLength: Toast.LENGTH_SHORT,
          // );

    if(response.statusCode==200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> parseListJson = jsonResponse['reports'];
    List<Reports> prevReportList = List<Reports>.from(
      parseListJson.map<Reports>((dynamic i) => Reports.fromJson(i))).toList();
      return prevReportList;
    
    } 
   throw Exception('Failed to load Reports');
    }



    //TODO: post selected incident type id to return incident sub type

  Future<bool> postReport(String image,int id, String location, String incidentType, String description, DateTime date, String risklevel, bool status) async {
    Uri url = Uri.parse('http://192.168.71.223:3000/makeUserReport');
    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String,dynamic>{
          "image":image.toString(),
          "id":id,
          "incidentType":incidentType,
           "location":location,
           "description":description,
           "date": date.toLocal().toIso8601String().split(".")[0], // Serialize DateTime to string   
           "status":status, //how to update, initial false, will be changed by admin.
           "risklevel":risklevel
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