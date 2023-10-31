import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'incident_sub_type.dart';

class SubIncidentProviderClass extends ChangeNotifier {
  List<IncidentSubType>? subIncidentPost;
  bool loading = false;
  String? selectedSubIncident;
  List<IncidentSubType>? filteredIncidentSubTypes;

  getSubIncidentPostData() async {
    // loading = true;
    subIncidentPost = (await fetchIncidentSubTypes());
    // loading = false;
    notifyListeners();
  }

   void updateFilteredIncidentSubtypes(String selectedIncidentType) {
    filteredIncidentSubTypes = subIncidentPost
        ?.where((subtype) => subtype.Incident_Type_ID == selectedIncidentType)
        .toList();
    selectedSubIncident = null; // Reset selectedSubIncident when filtering
    notifyListeners();
  }

  void setSubIncidentType(selectedVal){
    selectedSubIncident = selectedVal;
    notifyListeners();
  }
    //IPs
    //stormfiber: 192.168.18.74
    //mobile data: 192.168.71.223

    Future<List<IncidentSubType>> fetchIncidentSubTypes() async {
    loading = true;
    notifyListeners();
    print('Fetching incident sub types...');    Uri url = Uri.parse('http://192.168.71.223:3000/getIncidentSubTypes');
    final response = await http.get(url);
            Fluttertoast.showToast(
            msg: '${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
          );

    if(response.statusCode==200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> parseListJson = jsonResponse['incidentSubTypes'];
    List<IncidentSubType> prevReportList = List<IncidentSubType>.from(
      parseListJson.map<IncidentSubType>((dynamic i) => IncidentSubType.fromJson(i))).toList();
      loading = false;
      notifyListeners();
      print('incident sub types Loaded');   
      return prevReportList;
    
    }
   loading = false;
    notifyListeners();
    print('Failed to load incident types');
    throw Exception('Failed to load Incident Sub Types');
    }



  
}