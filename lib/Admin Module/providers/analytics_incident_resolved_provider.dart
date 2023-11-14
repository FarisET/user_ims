import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../constants.dart';

class CountIncidentsResolvedProvider extends ChangeNotifier {
  String? _totalIncidentsResolved;
  bool loading = false;

  String? get totalIncidentsResolved => _totalIncidentsResolved;

  getCountResolvedPostData() async {
    loading = true;
    _totalIncidentsResolved = await fetchIncidentsResolved();
    loading = false;
    notifyListeners();
  }

  Future<String> fetchIncidentsResolved() async {
    loading = true;
    final response = await http.get(Uri.parse('http://$IP_URL:3000/analytics/fetchIncidentsResolved'));
    if (response.statusCode == 200) {
      loading = false;
      notifyListeners();
      // Parse the response and return the String value
      return json.decode(response.body).toString(); // Assuming response.body is a String
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      loading = false;
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }
}
