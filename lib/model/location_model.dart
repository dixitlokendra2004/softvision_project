// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';
import '../utils/util.dart';

List<LocationModel> locationModelFromJson(String str) => List<LocationModel>.from(json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  String cityName;
  int cityCode;
  String stateName;
  int stateCode;
  String countryName;
  int countryCode;

  LocationModel({
    this.cityName = defaultString,
    this.cityCode = defaultNumber,
    this.stateName = defaultString,
    this.stateCode = defaultNumber,
    this.countryName = defaultString,
    this.countryCode = defaultNumber,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    cityName: json["CITY_NAME"] ?? defaultString,
    cityCode: json["CITY_CODE"] ?? defaultNumber,
    stateName: json["STATE_NAME"] ?? defaultString,
    stateCode: json["STATE_CODE"] ?? defaultNumber,
    countryName: json["COUNTRY_NAME"] ?? defaultString,
    countryCode: json["COUNTRY_CODE"] ?? defaultNumber,
  );

  Map<String, dynamic> toJson() => {
    "CITY_NAME": cityName,
    "CITY_CODE": cityCode,
    "STATE_NAME": stateName,
    "STATE_CODE": stateCode,
    "COUNTRY_NAME": countryName,
    "COUNTRY_CODE": countryCode,
  };
}
