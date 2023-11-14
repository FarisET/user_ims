import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/incident_sub_type.dart';

class SubIncidentProviderClass extends ChangeNotifier {
  List<IncidentSubType>? subIncidentPost;
  bool loading = false;
  String? selectedSubIncident;
  List<IncidentSubType>? filteredIncidentSubTypes;

  Future<void> getSubIncidentPostData(String selectedIncidentType) async {
    loading = true;
    // Pass the selected incident type to the fetchIncidentSubTypes method
    subIncidentPost = await fetchIncidentSubTypes(selectedIncidentType);
    loading = false;
    notifyListeners();
  }

  //  void updateFilteredIncidentSubtypes(String selectedIncidentType) {
  //   filteredIncidentSubTypes = subIncidentPost
  //       ?.where((subtype) => subtype.Incident_Type_ID == selectedIncidentType)
  //       .toList();
  //   selectedSubIncident = null; // Reset selectedSubIncident when filtering
  //   notifyListeners();
  // }

  void setSubIncidentType(selectedVal){
    selectedSubIncident = selectedVal;
    notifyListeners();
  }
   
    Future<List<IncidentSubType>> fetchIncidentSubTypes(String selectedIncidentType) async {
    loading = true;
    notifyListeners();
     Uri url = Uri.parse('http://${IP_URL}:3000/userReport/dashboard/fetchincidentsubType?incident_type_id=$selectedIncidentType');
     final response = await http.get(
      url,
      // body: {'incident_type_id': selectedIncidentType},
      );
          //   Fluttertoast.showToast(
          //   msg: '${response.statusCode}',
          //   toastLength: Toast.LENGTH_SHORT,
          // );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<IncidentSubType> subIncidentList = jsonResponse
        .map((dynamic item) => IncidentSubType.fromJson(item as Map<String, dynamic>))
        .toList();
      loading = false;
      notifyListeners();
    return subIncidentList;
  } 
  loading = false;
  notifyListeners();
    throw Exception('Failed to load Incident Sub Types');
    }



  
}