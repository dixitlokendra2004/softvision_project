import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/services.dart';
import '../dashboard/dashboard.dart';


class EnterEmailViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();

  late var formKey;

  bool isObscureText = true;

  bool showProgressbar = false;

  refreshUI() {
    notifyListeners();
  }

   getObscure() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  EnterEmailViewModel() {
    formKey = GlobalKey<FormState>(); // Initialize formKey here
  }

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
  //         Get.off(() => Dashboard());
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

  init() {}
}
