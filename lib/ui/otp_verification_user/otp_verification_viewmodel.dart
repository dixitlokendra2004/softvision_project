import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;
import 'package:softvision_project/ui/login/login.dart';
import 'package:softvision_project/ui/success/success.dart';

import '../../services/services.dart';
import '../../utils/util.dart';
import '../dashboard/dashboard.dart';
import '../register_student/database_form.dart';
import '../register_user/register_user.dart';

class OtpVerificationUserViewModel extends ChangeNotifier {

  late var formKey;
  bool hasError = false;
  String currentText = "";
  String enteredOtp = "";
  late String smsToSend;
  late int otpForVerification;
  Map<String, String> requestBody = {};

  bool showProgressbar = false;

  String type = "";

  OtpVerificationUserViewModel() {
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

  Future<void> submitData(BuildContext context) async {
    if (type == "user") {
      submitUserRegistrationData(context);
    } else {
      submitStudentRegistrationData(context);
    }
  }

  Future<void> submitUserRegistrationData(BuildContext context) async {
    showProgressbar = true;
    refreshUI();
    try {
      int result = await Services.registerUser(requestBody);
      showProgressbar = false;
      refreshUI();
      String dialogText = "Something went wrong, Please try again !!!";
      if (result == -1) {
        dialogText = "Unable to Resgister User. Please try again.";
      }
      if (result == -2) {
        dialogText =
        "Email already exists. Please choose different email id and try again.";
      }
      if (result == 0) {
        dialogText = "Unable to Resgister User. Please try again.";
      }
      if (result == 1) {
        Get.offAll(() => const Success());
      } else {
        Fluttertoast.showToast(
            msg: dialogText,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.to(() => RegisterUser());
      }
    } catch (e) {
      // Handle error
      print('Please contact Administrator to get your account activated: $e');
    }
    showProgressbar = false;
    refreshUI();
  }

  Future<void> submitStudentRegistrationData(BuildContext context) async {
    showProgressbar = true;
    refreshUI();
    try {
      int result = await Services.registerStudent(requestBody);
      String dialogText = "Registration completed successfully";
      if (result == -1) {
        dialogText = "Unable to Register. Please try again.";
      }
      if (result == 0) {
        dialogText =
        "Unable to Register. Please try again.";
      }
      if (result == 1) {
        Fluttertoast.showToast(
            msg: dialogText,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.offAll(() => Dashboard());
      } else {
        Fluttertoast.showToast(
            msg: dialogText,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.offAll(() => RegisterStudent());
      }
      showProgressbar = false;
      refreshUI();
    } catch (e) {
      // Handle error
      print('Please contact Administrator to get your account activated: $e');
    }
    showProgressbar = false;
    refreshUI();
  }
}
