import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:user_ims/models/location.dart';

import '../constants.dart';
import '../models/incident_types.dart';

class LocationProviderClass extends ChangeNotifier {
  List<Location>? LocationPost;
  bool loading = false;
  String? selectedLocation;


  getLocationPostData() async {
    // loading = true;
    LocationPost = (await fetchLocations());
    // loading = false;
    notifyListeners();
  }
      setLocation(selectedVal){
      selectedLocation = selectedVal;
      notifyListeners();
    }
    //IPs
    //stormfiber: 192.168.18.74
    //mobile data: 192.168.71.223

    Future<List<Location>> fetchLocations() async {
    loading = true;
    notifyListeners();
    print('Fetching location types...');   
    Uri url = Uri.parse('http://${IP_URL}:3000/userReport/dashboard/fetchlocations');
    final response = await http.get(url);
            Fluttertoast.showToast(
            msg: 'locations status:${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
          );


  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
    List<Location> incidentList = jsonResponse
        .map((dynamic item) => Location.fromJson(item as Map<String, dynamic>))
        .toList();
      loading = false;
      notifyListeners();
      print('Location Loaded');  
    return incidentList;
  }
   loading = false;
    notifyListeners();
    print('Failed to load Location ');
    throw Exception('Failed to load Location');
    }



  
}