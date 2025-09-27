// To parse this JSON data, do
//
//     final allAssociates = allAssociatesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllAssociates> allAssociatesFromJson(String str) => List<AllAssociates>.from(json.decode(str).map((x) => AllAssociates.fromJson(x)));

String allAssociatesToJson(List<AllAssociates> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAssociates {
  final int id;
  final String email;
  late final int active;
  final String name;
  final String address;
  final String mobileNumber;
  final String institute;

  AllAssociates({
    required this.id,
    required this.email,
    required this.active,
    required this.name,
    required this.address,
    required this.mobileNumber,
    required this.institute,
  });

  AllAssociates copyWith({
    int? id,
    String? email,
    int? active,
    String? name,
    String? address,
    String? mobileNumber,
    String? institute,
  }) =>
      AllAssociates(
        id: id ?? this.id,
        email: email ?? this.email,
        active: active ?? this.active,
        name: name ?? this.name,
        address: address ?? this.address,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        institute: institute ?? this.institute,
      );

  factory AllAssociates.fromJson(Map<String, dynamic> json) => AllAssociates(
    id: json["id"],
    email: json["email"],
    active: json["active"],
    name: json["name"],
    address: json["address"],
    mobileNumber: json["mobile_number"],
    institute: json["institute"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "active": active,
    "name": name,
    "address": address,
    "mobile_number": mobileNumber,
    "institute": institute,
  };
}

