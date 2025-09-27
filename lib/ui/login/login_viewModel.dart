import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:softvision_project/utils/sp_helper.dart';

import '../../admin/dashboard_admin/dashboard_admin.dart';
import '../../services/services.dart';
import '../dashboard/dashboard.dart';


class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   var formKey = GlobalKey<FormState>();

  bool isObscureText = true;

  bool showProgressbar = false;

  refreshUI() {
    notifyListeners();
  }

   getObscure() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  LoginViewModel() {
  }

  Future<void> submitData(BuildContext context) async {
    showProgressbar = true;
    refreshUI();
    String email = emailController.text;
    String password = passwordController.text;

    try {
      int result = await Services.login(email,password);
      showProgressbar = false;
      refreshUI();
      String dialogText = "Something went wrong, Please try again !!!";
      if(result == -1) {
        dialogText = "Unable to login. Please check your email and password.";
      }
      if(result == 0) {
        dialogText = "Unable to login. Please contact your administrator to activate your account.";
      }
      if(result == 1) {
        // await SharedPreferencesHelper.saveLoginInfo(email, password);
        // if(SharedPreferencesHelper.adminLoginInfo(email,password)) {
        //   Get.off(() => RegisterNewLeadAdmin());
        // }
        // else {
        //   Get.off(() => const RegisterNewLeadPage());
        // }
        SharedPreferencesHelper.saveLoginInfo(email, password);
        if(email.trim() == "admin@gmail.com") {
          Get.off(() => DashboardAdmin());
        } else {
          Get.off(() => Dashboard());
        }

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
      }
    } catch (e) {
      // Handle error
      print('Please contact Administrator to get your account activated: $e');
    }
    showProgressbar = false;
    refreshUI();
  }

  init() {}
}
