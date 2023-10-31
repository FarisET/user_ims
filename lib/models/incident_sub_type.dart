// ignore_for_file: non_constant_identifier_names

class IncidentSubType {
  final String Incident_SubType_ID;
  final String Incident_SubType_Description;
  final String Incident_Type_ID;

  const IncidentSubType({
    required this.Incident_SubType_ID, 
    required this.Incident_SubType_Description,
    required this.Incident_Type_ID, 
    });
    
    factory IncidentSubType.fromJson(Map<String, dynamic> json) {
      return IncidentSubType(
       Incident_SubType_ID: json['Incident_SubType_ID'],
       Incident_SubType_Description: json['Incident_SubType_Description'],
       Incident_Type_ID: json['Incident_Type_ID'],
 
     );
        
    }
}
