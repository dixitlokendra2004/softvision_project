// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.error,
    required this.path,
  });

  String timestamp;
  var status;
  String message;
  String error;
  String path;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        timestamp: json["timestamp"] ?? "",
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        error: json["error"] ?? "",
        path: json["path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "status": status,
        "message": message,
        "error": error,
        "path": path,
      };
}
