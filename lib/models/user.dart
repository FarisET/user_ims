// ignore_for_file: non_constant_identifier_names

class User {
  final String user_id;
  final String user_pass;

  User(this.user_id, this.user_pass); 
  factory User.fromMap(Map<String, dynamic> json) {
    return User(
        json['user_id'], json['user_pass']);
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['user_id'], json['user_pass'],);
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'user_pass': user_pass,
      };
}