import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softvision_project/utils/sp_helper.dart';

import '../../services/services.dart';

class ProfilePageViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController instituteNameController = TextEditingController();

  var formKey;
  ProfilePageViewModel() {
    formKey = GlobalKey<FormState>(); // Initialize formKey here
  }
  Uint8List? image;
  String base64String = "";

  bool showProgressbar = false;

  selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    String base64String = base64Encode(img as List<int>);
    print(base64String);
    image = img;
    notifyListeners();
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      Uint8List bytes = await file.readAsBytes();
      // print(bytes);
      return bytes;
    } else {
      return null;
      print("No Image Selected");
    }
  }

  Future<void> submitData(BuildContext context) async {
    showProgressbar = true;
    refreshUI();
    String email = emailController.text;
    String password = passwordController.text;
    String reEnterPassword = addressController.text;
    String instituteName = instituteNameController.text;
    String name = nameController.text;
    String number = numberController.text;
    if (image != null) {
      base64String = base64Encode(image!);
    }
    print("base64String $base64String");
    //await Clipboard.setData(ClipboardData(text: "your text"));

    try {
      Map<String, String> requestBody = {
        'email': await SharedPreferencesHelper.getEmail(),
        // "password": password,
        "address": reEnterPassword,
        "name": name,
        "mobile_number": number,
        //"profile_pic": "base64String",
      };

      int result = await Services.profileUpdate(requestBody);
      showProgressbar = false;
      refreshUI();
      String dialogText = "Something went wrong, Please try again !!!";
      if (result == -1) {
        dialogText = "Unable to update your profile info. Please tyr again.";
      }
      if (result == 0) {
        dialogText = "Unable to update your profile info. Please tyr again";
      }
      if (result == 1) {
        await SharedPreferencesHelper.saveUserInfo(name, reEnterPassword,number, instituteName);
        SharedPreferencesHelper.userName = name;
        dialogText = "Your profile info is updated successfully";
        Fluttertoast.showToast(
            msg: dialogText,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.back();
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
  }

  void printBase64String(String base64String) {
    final int chunkSize = 1000;
    for (int i = 0; i < base64String.length; i += chunkSize) {
      if (i + chunkSize > base64String.length) {
        print(base64String.substring(i));
      } else {
        print(base64String.substring(i, i + chunkSize));
      }
    }
  }

  refreshUI() {
    notifyListeners();
  }

  init() {}
}
