import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';


class AppBoxDecoration {


  static getSideBarDecoration() {
    return BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5, // Spread radius
          blurRadius: 7, // Blur radius
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static getActivateDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5, // Spread radius
          blurRadius: 7, // Blur radius
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}