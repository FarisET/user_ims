class IncidentType {
  final String label;
  final String value;

  const IncidentType({
    required this.label, 
    required this.value,
    });
    
    factory IncidentType.fromJson(Map<String, dynamic> json) {
      return IncidentType(
       label: json['label'],
       value: json['value']
        );
        
    }
}

    
