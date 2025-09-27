import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/app_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../model/student_model.dart';
import '../model/users.dart';

const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
const UNAUTHORISED = 401;

const int defaultNumber = -1;
const double defaultDouble = -1.0;
const String defaultString = "NA";
bool isWeb = kIsWeb;

EdgeInsetsGeometry getMargin({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? horizontal,
  double? vertical,
}) {
  if (horizontal != null && horizontal != 0) {
    left = right = horizontal;
  }
  if (vertical != null && vertical != 0) {
    top = bottom = vertical;
  }
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: left ?? 0,
    top: top ?? 0,
    right: right ?? 0,
    bottom: bottom ?? 0,
  );
}

EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? horizontal,
  double? vertical,
}) {
  if (horizontal != null && horizontal != 0) {
    left = right = horizontal;
  }
  if (vertical != null && vertical != 0) {
    top = bottom = vertical;
  }
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: left ?? 0,
    top: top ?? 0,
    right: right ?? 0,
    bottom: bottom ?? 0,
  );
}

class Util {
  static var mockupHeight = 812;
  static var mockupWidth = 375;
  static var deviceHeight;
  static var deviceWidth;

  static List<BoxShadow> get defaultShadow => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 8,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ];

  static getSnackBar(String text, {var icon, color, int delayMilli = 0, int duration = 3}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Row(
            children: [
              if (icon != null)
                Container(
                    margin: EdgeInsets.only(right: 20.Sw),
                    child: Icon(icon, color: Colors.white, size: 25.Sh)),
              Expanded(
                  child: Util.text(text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.Sp,
                          fontFamily: 'BarlowMedium'))),
            ],
          ),
          margin: EdgeInsets.fromLTRB(20.Sw, 0, 20.Sw, 20.Sh),
          padding: EdgeInsets.symmetric(vertical: 20.Sh, horizontal: 20.Sw),
          borderRadius: 13.r,
          backgroundColor: color ?? Color.fromRGBO(238, 82, 95, 1),
          duration: Duration(seconds: duration),
        ),
      );
    }
  }

  static text(String title,
      {TextAlign textAlign = TextAlign.center,
      var alignment,
      style = const TextStyle(),
      margin = EdgeInsets.zero,
      double height = 0.0,
      double width = 0.0,
      overflow = TextOverflow.ellipsis,
      maxLines = 0}) {
    return Container(
      width: (width == 0.0) ? null : width,
      margin: margin,
      alignment:
          (alignment != null) ? alignment : alignmentByTextAlign(textAlign),
      child: Text(
        title,
        textAlign: textAlign,
        style: style,
        textScaleFactor: 1.0,
        overflow: overflow,
        maxLines: (maxLines == 0) ? 100 : maxLines,
      ),
    );
  }

  static richText(String text1, String text2,
      {TextAlign textAlign = TextAlign.center,
      style1 = const TextStyle(),
      style2 = const TextStyle(),
      margin = EdgeInsets.zero,
      double height = 0.0,
      overflow = TextOverflow.ellipsis,
      maxLines}) {
    return Container(
      margin: margin,
      alignment: alignmentByTextAlign(textAlign),
      child: RichText(
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: text1, style: style1),
            TextSpan(text: text2, style: style2),
          ],
        ),
      ),
    );
  }


  static alignmentByTextAlign(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.justify:
        return Alignment.bottomCenter;
      case TextAlign.start:
        return Alignment.centerLeft;
      case TextAlign.end:
        return Alignment.centerRight;
    }
  }

  static parseDateTime(dynamic dateTimeIst, {bool changeToIst = true}) {
    if (dateTimeIst == null) return AppStrings.NA;
    if ((DateTime.tryParse(dateTimeIst) ?? AppStrings.NA) is DateTime) {
      if (changeToIst) {
        var d = DateTime.parse(dateTimeIst);
        return d;
      } else {
        return DateTime.parse(dateTimeIst);
      }
    } else {
      return AppStrings.NA;
    }
  }

  static double getHeight(var height) {
    var percent = ((height / mockupHeight) * 100);
    return ((deviceHeight * percent) / 100);
  }

  static double getWidth(var width) {
    var percent = ((width / mockupWidth) * 100);
    return ((deviceWidth * percent) / 100);
  }

  static double getSp(var sp) {
    var percent = (((sp - 0.25) / mockupHeight) * 100);
    return ((deviceHeight * percent) / 100);
  }

  static double getRadius(var radius) {
    return double.parse(radius.toString());
  }

  static printString(var v) {
    print(v);
  }

  static printLog(var v) {
    log(v.toString());
  }
  static String capitalizeEveryWord(String text) {
    List<String> words = text.split(' ');
    List<String> capitalizedWords = [];
    for (String word in words) {
      if (word.isNotEmpty) {
        capitalizedWords.add(word.substring(0, 1).toUpperCase() + word.substring(1));
      }
    }
    return capitalizedWords.join(' ');
  }

  static Future<void> generateAndShareStudentList(List<Students> students) async {
    // Create Excel file
    Excel excel = Excel.createExcel();

    Sheet sheetObject = excel['Students'];
    sheetObject.appendRow([
      'ID', 'Student Name', 'Email', 'Number', 'WhatsApp No',
      'Father Name', 'Father Number', 'School Name', 'City',
      'Email ID Student', 'District', 'Comments', 'Counselling Done By',
      'Date Of Counselling', 'User Email', 'College', 'Gender',
      'Board', 'Stream', 'Course Of Interest', 'Payment Status',
      'Name', 'Institute', 'Entry date'
    ]);

    // Populate data
    for (var student in students) {
      sheetObject.appendRow([
        student.id, student.studentName, student.email, student.number, student.watssapNo,
        student.fatherName, student.fatherNumber, student.schoolName, student.city,
        student.emailIdStudent, student.district, student.comments, student.counsellingDoneBy,
        student.dateOfCounselling, student.userEmail, student.collage, student.gender,
        student.board, student.stream, student.courseOfInterest, student.paymentStatus,
        student.name, student.institute,student.entrydate,
      ]);
    }
    // Save Excel file to temporary directory
    Directory directory = await getTemporaryDirectory();
    String filePath = '${directory.path}/data.xlsx';
    List<int>? excelBytes = excel.encode();
    await File(filePath).writeAsBytes(excelBytes!);


    // Share Excel file
    Share.shareFiles([filePath]);
  }


  static Future<void> generateAndShareUserList(List<Users> users) async {
    // Create Excel file
    Excel excel = Excel.createExcel();

    Sheet sheetObject = excel['Business Associates'];
    sheetObject.appendRow([
      'ID', 'Email', 'Active',
      'Name', 'Address', 'Mobile Number', 'Institute'
    ]);

    // Populate data
    for (var user in users) {
      sheetObject.appendRow([
        user.id, user.email,  user.active,
        user.name, user.address, user.mobileNumber, user.institute,
      ]);
    }
    // Save Excel file to temporary directory
    Directory directory = await getTemporaryDirectory();
    String filePath = '${directory.path}/data.xlsx';
    List<int>? excelBytes = excel.encode();
    await File(filePath).writeAsBytes(excelBytes!);


    // Share Excel file
    Share.shareFiles([filePath]);
  }

}
