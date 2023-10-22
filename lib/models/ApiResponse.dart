// class ApiResponse {
//   // _data will hold any response converted into 
//   // its own object. For example user.
//   late Object _data; 
//   // _apiError will hold the error object
//   late Object _apiError;

//  // late String _status;

//   Object get Data => _data;
//   set Data(Object data) => _data = data;

//   // String get Status => _status;
//   // set Status(String status) => _status = status;


//   Object get ApiError => _apiError as Object;
//   set ApiError(Object error) => _apiError = error;
// }

class ApiResponse {
  late Object _data;
  late int _statusCode; // Add this field to store the status code
  late Object _apiError;

  Object get Data => _data;
  set Data(Object data) => _data = data;

  int get StatusCode => _statusCode; // Getter for status code
  set StatusCode(int statusCode) => _statusCode = statusCode; // Setter for status code

  Object get ApiError => _apiError;
  set ApiError(Object error) => _apiError = error;
}





