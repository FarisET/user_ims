import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'incident_types.dart';

class IncidentProviderClass extends ChangeNotifier {
  List<IncidentType>? incidentPost;
  bool loading = false;
  String? selectedIncident;


  getIncidentPostData() async {
    // loading = true;
    incidentPost = (await fetchIncidentTypes());
    // loading = false;
    notifyListeners();
  }
      setIncidentType(selectedVal){
      selectedIncident = selectedVal;
      notifyListeners();
    }
    //IPs
    //stormfiber: 192.168.18.74
    //mobile data: 192.168.71.223

    Future<List<IncidentType>> fetchIncidentTypes() async {
    loading = true;
    notifyListeners();
    print('Fetching incident types...');    Uri url = Uri.parse('http://192.168.71.223:3000/getIncidentTypes');
    final response = await http.get(url);
            Fluttertoast.showToast(
            msg: '${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
          );

    if(response.statusCode==200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> parseListJson = jsonResponse['incidentTypes'];
    List<IncidentType> prevReportList = List<IncidentType>.from(
      parseListJson.map<IncidentType>((dynamic i) => IncidentType.fromJson(i))).toList();
      loading = false;
      notifyListeners();
      print('Loading completed');   
      return prevReportList;
    
    }
   loading = false;
    notifyListeners();
    print('Failed to load incident types');
    throw Exception('Failed to load Incident Types');
    }



  
}