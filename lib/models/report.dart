
class Reports {
  final String title;
  final String incidentType;
  final int id;
  final String description;
  final String location;
  final String date;
  final String risklevel;
  final bool status;

  const Reports({
    required this.title, 
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
        title: json['title'],
       incidentType: json['incidentType'], 
       id: json['id'],
       description: json['description'], 
       location: json['location'], 
       date: json['date'], 
       risklevel: json['risklevel'],
        status: json['status']
        );
        
    }

    


    // factory Reports.fromJson(Map<String, dynamic> json) {
    // title = json['title'];
    


}