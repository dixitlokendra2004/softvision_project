import 'dart:io';

import 'package:softvision_project/core/constant/app_strings.dart';
import 'package:softvision_project/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

extension Extensions on dynamic {
  double get Sw => Util.getWidth(this);

  double get Sh => Util.getHeight(this);

  double get Sp => Util.getSp(this);

  double get r => Util.getRadius(this);

  // String get translate => toString().tr();// for localization

  String get formatDate {
    if (this is DateTime) {
      return DateFormat('yyyy-MM-dd').format(this);
    } else {
      return AppStrings.NA;
    }
  }

  String get formatTime {
    if (this is TimeOfDay) {
      String period = this.period == DayPeriod.am ? "AM" : "PM";
      int hourOfPeriod = this.hourOfPeriod;
      if(period == "PM") hourOfPeriod= hourOfPeriod+12;
      String formattedTime = "${hourOfPeriod.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}:00";
      return formattedTime;
    } else {
      return AppStrings.NA;
    }
  }

  String get fileName => (this is File)
      ? basename(this.path)
      : (this is String)
      ? this.split('/').last
      : AppStrings.NA;

  String get fileNameWithoutNA => (this is File)
      ? basename(this.path)
      : (this is String)
      ? (this.contains('/'))
      ? this.split('/').last
      : ""
      : "";

  String get getFileExtension {
    String fileName = toString();
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex < fileName.length - 1 && dotIndex > 0) {
      return fileName.substring(dotIndex + 1);
    } else {
      return '';
    }
  }
}
