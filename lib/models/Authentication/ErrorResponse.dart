import 'dart:convert';

ErrorResponse errorRespFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorRespToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  String? message;
  Errors? errors;

  ErrorResponse({this.message, this.errors});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? deviceName;

  Errors({this.deviceName});

  Errors.fromJson(Map<String, dynamic> json) {
    deviceName = json['device_name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_name'] = this.deviceName;
    return data;
  }
}
