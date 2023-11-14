import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:user_ims/models/action_team.dart';

import '../../constants.dart';

class ActionTeamProviderClass extends ChangeNotifier {
  List<ActionTeam>? actionTeamPost;
  bool loading = false;
  String? selectedActionTeam;

  Future<void> getActionTeamPostData(String selectedDepartment) async {
    loading = true;
    actionTeamPost = await fetchActionTeams(selectedDepartment);
    loading = false;
    notifyListeners();
  }

  void setActionTeam(selectedVal){
    selectedActionTeam = selectedVal;
    notifyListeners();
  }
   
    Future<List<ActionTeam>> fetchActionTeams(String selectedDepartment) async {
    loading = true;
    notifyListeners();
    print('Fetching incident sub types...ID: $selectedDepartment');   
     Uri url = Uri.parse('http://${IP_URL}:3000/admin/dashboard/fetchActionTeams?department_id=$selectedDepartment');
     final response = await http.get(
      url,
      // body: {'incident_type_id': selectedIncidentType},
      );
            Fluttertoast.showToast(
            msg: '${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
          );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<ActionTeam> actionTeamList = jsonResponse
        .map((dynamic item) => ActionTeam.fromJson(item as Map<String, dynamic>))
        .toList();
      loading = false;
      notifyListeners();
      print('action teams Loaded');  
    return actionTeamList;
  } 
  loading = false;
  notifyListeners();
  print('Failed to load action teams');
    throw Exception('Failed to load action teams');
    }



  
}