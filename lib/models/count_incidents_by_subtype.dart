// ignore_for_file: non_constant_identifier_names

class CountByIncidentSubTypes {
  final String? incident_type_description;
  final int? incident_count;

  const CountByIncidentSubTypes({
    required this.incident_type_description, 
    required this.incident_count,
    });
    
    factory CountByIncidentSubTypes.fromJson(Map<String, dynamic> json) {
      return CountByIncidentSubTypes(
       incident_type_description: json['incident_type_description'] ?? '',
       incident_count: json['incident_count'] ?? 0,
 
     );
        
    }
}
