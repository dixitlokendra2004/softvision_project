import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:softvision_project/size_ext.dart';

import '../core/constant/app_colors.dart';


class AppTextStyle {

  static TextStyle getTextStyle25FontWeight700 = const TextStyle(
    color: Color(0xff000000),
    fontSize: 25,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );

  static TextStyle getTextStyle14FontWeight600 = const TextStyle(
    color: Color(0xff000000),
    fontSize: 14,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );

  static TextStyle getTextStyle18FontWeight400 = const TextStyle(
    color: Color(0xff000000),
    fontSize: 18,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  static TextStyle getTextStyle12FontWeight500 = const TextStyle(
    color: Color(0xff000000),
    fontSize: 12,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  static TextStyle getTextStyle22FontWeight500 = const TextStyle(
      fontSize: 22,
      color: Color(0xffffffff),
      fontWeight: FontWeight.w500
  );

  static TextStyle getTextStyle15FontWeight500 = const TextStyle(
      fontSize: 15,
      color: Colors.blue,
      fontWeight: FontWeight.w500
  );

  static TextStyle getTextStyle20FontWeight500 = const TextStyle(
      fontSize: 16,
      color: Colors.blue,
      fontWeight: FontWeight.w500
  );

  static TextStyle getTextStyleBlue12FontWeight500 = const TextStyle(
      fontSize: 12,
      color: Colors.blue,
      fontWeight: FontWeight.w500
  );

  static TextStyle getTextStyle16FontWeight500 = const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w500
  );
  static TextStyle getTextStyle18FontWeight500 = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w500
  );

  static TextStyle getTextStyle14FontWeight500 = const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500
  );

  static TextStyle getTextStyle16FontWeight600 = const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w600
  );

  static TextStyle getTextStyle16FontWeightBold = const TextStyle(
    color: Colors.black45,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static TextStyle getTextStyle12FontWeight400 = const TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle getTextStyle15FontWeightBold = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );

  static TextStyle getTextStyle15FontWeight = const TextStyle(
    color: Colors.black54,
    fontSize: 15,
  );

  static TextStyle getTextStyle22FontWeightBold = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22
  );

  static TextStyle getTextStyle18FontWeightBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle getTextStyle14FontWeightBold = const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static getHeadingStyle() {
    return TextStyle(
      color: AppColors.gray800,
      fontSize: 15.Sp,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
    );
  }

}