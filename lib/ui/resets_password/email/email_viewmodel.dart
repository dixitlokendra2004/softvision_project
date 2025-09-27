
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/users.dart';
import '../../../services/services.dart';
import '../../../utils/sp_helper.dart';
import '../../dashboard/dashboard.dart';
import '../otp_verifucation/otp_verification.dart';

class EmailPageViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();

    final formKey = GlobalKey<FormState>(); // Initialize formKey here

  bool showProgressbar = false;

  // Future<void> submitData(BuildContext context) async {
  //   showProgressbar = true;
  //   refreshUI();
  //   String email = emailController.text;
  //
  //
  //   try {
  //     int result = await Services.getInfo(email);
  //     showProgressbar = false;
  //     refreshUI();
  //     String dialogText = "Something went wrong, Please try again !!!";
  //     if(result == -1) {
  //       dialogText = "Unable to login. Please check your email and password.";
  //     }
  //     if(result == 0) {
  //       dialogText = "Unable to login. Please contact your administrator to activate your account.";
  //     }
  //     if(result == 1) {
  //       SharedPreferencesHelper.getEmail();
  //       int otpForVerification = getOtp();
  //       String smsToSend = getSms(email,otpForVerification);
  //       Get.to(() => OtpVerification(smsToSend, otpForVerification,"user"));
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Error'),
  //             content: Text(dialogText),
  //             actions: <Widget>[
  //               InkWell(
  //                 onTap: () {
  //                   Get.back();
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     // Handle error
  //     print('Please contact Administrator to get your account activated: $e');
  //   }
  //   showProgressbar = false;
  //   refreshUI();
  // }

  int getOtp() {
    Random random = Random();
    return random.nextInt(7999) + 1000;
  }

   getSms(String email, int otpForVerification) {
    fetchData(email,otpForVerification);

  }

  refreshUI() {
    notifyListeners();
  }

  init() {}
  List<Users> users = [];

  void fetchData(String queryString,int otpForVerification ) async {
    users = await Services.getUsers(queryString);
    showProgressbar = true;
    refreshUI();
    String dialogText = "Something went wrong, Please try again !!!";
   print(users.length);
    if(users.length > 0) {
      Users u = users[0];
      String otpChangePassword = "https://dudusms.in/smsapi/send_sms?authkey=Tv66DYP4Pi4K9MrJODOVii&mobiles="+u.mobileNumber+"&message=Greetings from SOFTVISION /GSB! Your OTP to change your credentials is "+otpForVerification.toString()+". Do not share the OTP with anyone.&sender=SOFTVN&route=4&templetid=1707171396217403171";
      Get.to(() => ResetOtpVerification(otpChangePassword, otpForVerification,queryString));
    } else {
      Fluttertoast.showToast(
          msg: "Please check Email you have entered",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emailController.text = "";
    }
    showProgressbar = false;
    refreshUI();
  }
}
