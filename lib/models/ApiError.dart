// class ApiError {
//   late String _error;

//   ApiError({required String error}) {
//     this._error = error;
//   }

//   String get error => _error;
//   set error(String error) => _error = error;

//   ApiError.fromJson(Map<String, dynamic> json) {
//     //_error = json['status'] as String ?? 'Unknown Error'; // Provide a default value.
//     _error = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this._error;
//     return data;
//   }
// }

class ApiError {
  String? error; // Use a nullable string to handle null values

  ApiError({this.error = ''});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      error: json['error'] ?? '', // Provide a default value for null
    );
  }
}
