import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:user_ims/models/report.dart';
import 'package:http/http.dart' as http;


Future<List<Reports>> fetchReports() async {
  try{
    // Load the JSON file from the assets directory
    final String jsonString = await rootBundle.loadString('assets/json/incident/report.json');  
    //if (response.statusCode==200) {
    List<dynamic> parseListJson = jsonDecode(jsonString);
    List<Reports> reportItems = List<Reports>.from(
      parseListJson.map<Reports>((dynamic i) => Reports.fromJson(i))
    );
    return reportItems;

  } catch(e) {
    throw Exception('Error:${e}');
  }

}