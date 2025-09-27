// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String id;
  String email;
  String password;
  String active;
  String profilePic;
  String name;
  String address;
  String mobileNumber;
  String institute;

  Users({
    required this.id,
    required this.email,
    required this.password,
    required this.active,
    required this.profilePic,
    required this.name,
    required this.address,
    required this.mobileNumber,
    required this.institute,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    active: json["active"],
    profilePic: json["profile_pic"],
    name: json["name"],
    address: json["address"],
    mobileNumber: json["mobile_number"],
    institute: json["institute"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "active": active,
    "profile_pic": profilePic,
    "name": name,
    "address": address,
    "mobile_number": mobileNumber,
    "institute": institute,
  };
}
