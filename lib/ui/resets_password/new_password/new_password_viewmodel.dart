import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:softvision_project/model/users.dart';

import '../../../services/services.dart';
import '../../../utils/sp_helper.dart';
import '../../dashboard/dashboard.dart';
import '../../login/login.dart';

class NewPasswordViewModel extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>(); // Initialize formKey here
  bool isObscureText = true;

  getObscure() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  bool showProgressbar = false;

  refreshUI() {
    notifyListeners();
  }

  init() {}

  Future<void> submitData(BuildContext context, String email) async {
    showProgressbar = true;
    refreshUI();
    String password = passwordController.text;

    try {
      int result = await Services.getChangePassword(email, password);
      showProgressbar = false;
      refreshUI();
      String dialogText = "Something went wrong, Please try again !!!";
      if (result == -1) {
        dialogText = "Unable to Update your password. Please try again.";
      }
      if (result == 0) {
        dialogText = "Unable to Update your password. Please try again.";
      }
      if (result == 1) {
        Fluttertoast.showToast(
            msg: "Your password is Updated",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        passwordController.text = "";
        showProgressbar = false;
        Get.offAll(() => const LoginPage());
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(dialogText),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        showProgressbar = false;
        refreshUI();
      }
    } catch (e) {
      showProgressbar = false;
      refreshUI();
      print('Please contact Administrator to get your account activated: $e');
    }
  }
}
