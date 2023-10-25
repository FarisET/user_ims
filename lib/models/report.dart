
import 'dart:io';

class Reports {
 final String? image;
  final String incidentType;
  final int id;
  final String description;
  final String location;
  final String date;
  final String risklevel;
  final bool status;

  const Reports({
    required this.image, 
    required this.incidentType,
    required this.id,
    required this.description,
    required this.location,
    required this.date,
    required this.risklevel,
    required this.status,
    });
    
    factory Reports.fromJson(Map<String, dynamic> json) {
      return Reports(
       image: json['image'],    
       location: json['location'],    
       incidentType: json['incidentType'], 
       //TODO: add incident sub type
       id: json['id'], //Autogenerate 8 digit  serialized id
       description: json['description'], 
       date: json['date'], 
       risklevel: json['risklevel'],
       status: json['status']
        //image
        //Name
        );
        
    }

    


    // factory Reports.fromJson(Map<String, dynamic> json) {
    // title = json['title'];
    


}