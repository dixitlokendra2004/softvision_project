// To parse this JSON data, do
//
//     final students = studentsFromJson(jsonString);

import 'dart:convert';

List<Students> studentsFromJson(String str) => List<Students>.from(json.decode(str).map((x) => Students.fromJson(x)));

String studentsToJson(List<Students> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Students {
  var id;
  String studentName;
  String email;
  String number;
  String watssapNo;
  String fatherName;
  String fatherNumber;
  String schoolName;
  String city;
  String emailIdStudent;
  String district;
  String comments;
  String counsellingDoneBy;
  String dateOfCounselling;
  String userEmail;
  String collage;
  String gender;
  String board;
  String stream;
  String courseOfInterest;
  var paymentStatus;
  String name;
  String institute;
  String admitted_to;
  var fees_above_50;
  var documents;
  String admin_comments;
  String entrydate;


  Students({
    required this.id,
    required this.studentName,
    required this.email,
    required this.number,
    required this.watssapNo,
    required this.fatherName,
    required this.fatherNumber,
    required this.schoolName,
    required this.city,
    required this.emailIdStudent,
    required this.district,
    required this.comments,
    required this.counsellingDoneBy,
    required this.dateOfCounselling,
    required this.userEmail,
    required this.collage,
    required this.gender,
    required this.board,
    required this.stream,
    required this.courseOfInterest,
    required this.paymentStatus,
    required this.name,
    required this.institute,
    required this.admitted_to,
    required this.fees_above_50,
    required this.documents,
    required this.admin_comments,
    required this.entrydate
  });

  factory Students.fromJson(Map<String, dynamic> json) => Students(
    id: json["id"] ?? "",
    studentName:json["studentName"]??"",
    email: json["email"]??"",
    number: json["number"]??"",
    watssapNo: json["watssapNo"]??"",
    fatherName: json["fatherName"]??"",
    fatherNumber: json["fatherNumber"]??"",
    schoolName: json["schoolName"]??"",
    city: json["city"]??"",
    emailIdStudent: json["emailIdStudent"]??"",
    district: json["district"]??"",
    comments: json["comments"]??"",
    counsellingDoneBy: json["counsellingDoneBy"]??"",
    dateOfCounselling: json["dateOfCounselling"]??"",
    userEmail: json["userEmail"]??"",
    collage : json["collage"] ?? "",
    gender: json["gender"] ?? "",
    board: json["board"] ?? "",
    stream: json["stream"] ?? "",
    courseOfInterest: json["courseOfInterest"] ?? "",
    paymentStatus: json["paymentStatus"].toString() ?? "",
    name: json["name"].toString() ?? "",
    institute: json["institute"].toString() ?? "",
    admitted_to: json["admitted_to"].toString() ?? "",
    fees_above_50: json["fees_above_50"].toString() ?? "",
    documents: json["documents"].toString() ?? "",
    admin_comments: json["admin_comments"].toString() ?? "",
    entrydate: json["entrydate"].toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentName": studentName,
    "email": email,
    "number": number,
    "watssapNo": watssapNo,
    "fatherName": fatherName,
    "fatherNumber": fatherNumber,
    "schoolName": schoolName,
    "city": city,
    "emailIdStudent": emailIdStudent,
    "district": district,
    "comments": comments,
    "counsellingDoneBy": counsellingDoneBy,
    "dateOfCounselling": dateOfCounselling,
    "userEmail": userEmail,
    "collage" : collage,
    "gender": gender,
    "board": board,
    "stream": stream,
    "courseOfInterest": courseOfInterest,
    "paymentStatus" : paymentStatus,
    "name" : name,
    "institute" : institute,
    "admitted_to": admitted_to,
    "fees_above_50": fees_above_50,
    "documents": documents,
    "admin_comments": admin_comments,
    "entrydate": entrydate,
  };
}
