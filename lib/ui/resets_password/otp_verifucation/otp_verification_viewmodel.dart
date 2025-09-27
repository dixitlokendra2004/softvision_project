import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;
import 'package:softvision_project/ui/login/login.dart';
import 'package:softvision_project/ui/success/success.dart';

import '../../../services/services.dart';
import '../email/email.dart';


class ResetOtpVerificationViewModel extends ChangeNotifier {

  late var formKey;
  bool hasError = false;
  String currentText = "";
  String enteredOtp = "";
  late String smsToSend;
  late int otpForVerification;
  Map<String, String> requestBody = {};

  bool showProgressbar = false;

  String email = "";

  ResetOtpVerificationViewModel() {
    formKey = GlobalKey<FormState>(); // Initialize formKey here
  }

  getCurrentText(value) {
    currentText = value;
  }

  refreshUI() {
    notifyListeners();
  }

  Future<bool> sendOtpToDevice() async {
    try {
      final response = await http.get(Uri.parse(smsToSend));
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
