class DsmResponse<T> {
  bool? success;
  T? data;
  Map? error;
  DsmResponse({this.success, this.data});
  DsmResponse.fromJson(dynamic json, T Function(dynamic) parser) {
    success = json['success'];
    if (json['data'] != null) {
      data = parser(json['data']);
    }

    error = json['error'];
  }
}
