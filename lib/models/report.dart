class Reports {
  final int? id;
  final String? description;
  final String? dateTime;
 // final Stream location;
  final String? subLocationName;
//  final String incidentType;
  final String? subLocationID;
  final String? incidentSubtypeDescription;
  final String? incidentCriticalityLevel;
  final String? incidentCriticalityID;
  final Map<String, dynamic> image; // You may need to adjust this property's type 
  final String? status;

  Reports({
    required this.id,
    required this.description,
    required this.dateTime,
 //   required this.location,
  required this.subLocationID,
    required this.subLocationName,
  //  required this.incidentType,
    required this.incidentSubtypeDescription,
    required this.incidentCriticalityLevel,
    required this.incidentCriticalityID,
    required this.image,
    required this.status
  });

  factory Reports.fromJson(Map<String, dynamic> json) {
    return Reports(
      id: json['user_report_id'],
      description: json['report_description'],
      dateTime: json['date_time'],
   //   location: json['location_name'],
      subLocationName: json['sub_location_name'] as String?,
      subLocationID: json['sub_location_id'] as String?,
 //   incidentType: json['incident_type_description'],
      incidentSubtypeDescription: json['incident_subtype_description'],
      incidentCriticalityLevel: json['incident_criticality_level'] as String?,
      incidentCriticalityID: json['incident_criticality_id'] as String?,
      image: json['image'], 
      status: json['status'],// You may need to adjust this based on the actual data type
    );
  }
}
