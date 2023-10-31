// ignore_for_file: non_constant_identifier_names

class Role {
  final String role_name;
  final String role_id;

  Role( this.role_id, this.role_name); 
  factory Role.fromMap(Map<String, dynamic> json) {
    return Role(
        json['role_name'], json['role_id']);
  }
  factory Role.fromJson(Map<String, dynamic> json) {
 //       json['user_id'], json['user_pass'],);
  if (json != null) {
    return Role(
      json['role_name'],
      json['role_id'],
      
    );
  } else {
    // Handle the case where the JSON data is null or invalid.
    return Role("","");
  }
  }

  Map<String, dynamic> toJson() => {
        'role_name': role_name,
        'role_id': role_id,
      };
}