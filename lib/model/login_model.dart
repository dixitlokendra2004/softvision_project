// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';
import '../utils/util.dart';

List<loginModel> loginModelFromJson(String str) => List<loginModel>.from(json.decode(str).map((x) => loginModel.fromJson(x)));

String loginModelToJson(List<loginModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class loginModel {
  String email;
  String password;


  loginModel({
    this.email = defaultString,
    this.password = defaultString,
  });

  factory loginModel.fromJson(Map<String, dynamic> json) => loginModel(
    email: json["EMAIL"] ?? defaultString,
    password: json["PASSWORD"] ?? defaultString,
  );

  Map<String, dynamic> toJson() => {
    "EMAIL": email,
    "PASSWORD": password,
  };
}
