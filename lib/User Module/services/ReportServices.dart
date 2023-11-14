// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_ims/Action%20Team%20Module/pages/action_report_2.dart';
import 'package:user_ims/models/action_report.dart';
import 'package:user_ims/models/assign_task.dart';
import 'package:user_ims/models/count_resolved.dart';
import '../../constants.dart';
import '../../models/report.dart';

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
  Uri url = Uri.parse('http://$IP_URL:3000/userReport/dashboard/$current_user_id/reports');
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

Future<List<AssignTask>> fetchAssignedReports() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 
  current_user_id =  prefs.getString('user_id'); 
  print('USER-ID: ${current_user_id}');
  Uri url = Uri.parse('http://$IP_URL:3000/actionTeam/dashboard/$current_user_id/fetchAssignedTasks');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<AssignTask> reportList = jsonResponse
        .map((dynamic item) => AssignTask.fromJson(item as Map<String, dynamic>))
        .toList();
    return reportList;
  }

  throw Exception('Failed to load Reports');
}   

Future<List<Reports>> fetchAllReports() async {
  Uri url = Uri.parse('http://$IP_URL:3000/admin/dashboard/fetchAllUserReports');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<Reports> allReportList = jsonResponse
        .map((dynamic item) => Reports.fromJson(item as Map<String, dynamic>))
        .toList();
    return allReportList;
  }

  throw Exception('Failed to load all Reports');
}    




Future<void> postapprovedActionReport(int? user_report_id, int? action_report_id ) async {
  Uri url = Uri.parse('http://$IP_URL:3000/admin/dashboard/approvedActionReport');

  await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      <String, dynamic>{
        "user_report_id": user_report_id,
        "action_report_id": action_report_id,

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
          return true;
        
      } else if (response.statusCode == 500) {
            Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
          );

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

  Future<List<ActionReport>> fetchAllActionReports() async {
  Uri url = Uri.parse('http://$IP_URL:3000/admin/dashboard/fetchAllActionReports');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<ActionReport> allReportList = jsonResponse
        .map((dynamic item) => ActionReport.fromJson(item as Map<String, dynamic>))
        .toList();
    return allReportList;
  }

  throw Exception('Failed to load all Reports');
}    


    Future<bool> postAssignedReport(int user_report_id, String user_id, String action_team_id, String incident_criticality_id) async {
    Uri url = Uri.parse('http://${IP_URL}:3000/admin/dashboard/InsertAssignTask');
    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String,dynamic>{
          "user_report_id":user_report_id,
           "user_id":user_id,
           "action_team_id":action_team_id,
           "incident_criticality_id":incident_criticality_id
         //  "reported_by": reported_by
      },
    ),
      );
      final msg = json.decode(response.body)['status'];

      if (response.statusCode == 200) {

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

    Future<bool> postActionReport(    
    String? report_description,
    String? question_one,
    String? question_two,
    String? question_three,
    String? question_four,
    String? question_five,
    String? resolution_description,
    String? reported_by,
    String? surrounding_image,
    String? proof_image,
    int? user_report_id
    ) async 
    
    {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    current_user_id = prefs.getString("user_id");
    print('current_user_id:$current_user_id');
    Uri url = Uri.parse('http://${IP_URL}:3000/actionTeam/dashboard/$current_user_id/MakeActionReport');
    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String,dynamic>{
          "report_description": report_description,
          "question_one": question_one,
          "question_two": question_two,
          "question_three": question_three,
          "question_four": question_four,
          "question_five": question_five,
          "resolution_description": resolution_description,
          "reported_by":reported_by,
          "surrounding_image":surrounding_image,
          "proof_image":proof_image,
          "user_report_id":user_report_id
      },
    ),
      );
      final msg = json.decode(response.body)['status'];

      if (response.statusCode == 200) {
          return true;
        
      } else if (response.statusCode == 500) {
            Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
          );

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

  // Analytics----------------

 

// Future<CountResolved> fetchIncidentsResolved() async {
//   final response = await http.get(Uri.parse('http://$IP_URL:3000/analytics/fetchIncidentsResolved'));

//   if (response.statusCode == 200) {
//     // Parse the response and return the String value
//     return json.decode(response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // throw an exception.
//     throw Exception('Failed to load data');
//   }
// }

//   Future<List<ActionReport>> fetchIncidentReported() async {
//   Uri url = Uri.parse('http://$IP_URL:3000/analytics/fetchIncidentsReported');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
//     List<ActionReport> allReportList = jsonResponse
//         .map((dynamic item) => ActionReport.fromJson(item as Map<String, dynamic>))
//         .toList();
//     return allReportList;
//   }

//   throw Exception('Failed to load all Reports');
// }    

//Image handling
Future<String?> uploadImage(File imageFile) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse('http://${IP_URL}:3000/api/image/upload'));

    // Attach the image file to the request
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    // Send the request
    var response = await request.send();

    // Process the response
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      
      // Assuming Cloudinary returns the image URL in the response
      final imageUrl = await response.stream.bytesToString();

      print('Image URL: $imageUrl');

      // Return the image URL
      return imageUrl;
    } else {
      print('Failed to upload image');
      return null;
    }
  } catch (error) {
    print('Error uploading image: $error');
    return null;
  }
}






}