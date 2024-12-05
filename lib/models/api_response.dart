class ApiResponse {
  bool error;
  String message;
  Object? data;


  ApiResponse({required this.error, required this.message});

  ApiResponse.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        message = json['message'],
        data = json['data'];
}
