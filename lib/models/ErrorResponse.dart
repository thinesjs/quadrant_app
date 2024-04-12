import 'dart:convert';

ErrorResponse errorRespFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorRespToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.error,
  });

  String error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}