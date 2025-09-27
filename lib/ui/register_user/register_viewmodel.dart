import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softvision_project/utils/util.dart';

import '../../services/services.dart';
import '../login/login.dart';
import '../otp_verification_user/otp_verification.dart';

class ResiterUserViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController instituteNameController = TextEditingController();

  var formKey;
  ResiterUserViewModel() {
    formKey = GlobalKey<FormState>(); // Initialize formKey here
  }

  Uint8List? image;
  String base64String = "";
  bool showProgressbar = false;
  bool isObscureText = true;

  String otpChangePassword = "https://dudusms.in/smsapi/send_sms?authkey=Tv66DYP4Pi4K9MrJODOVii&mobiles=Mobile No&message=Greetings from SOFTVISION /GSB! Your OTP to change your credentials is {#var#}. Do not share the OTP with anyone.&sender=SOFTVN&route=4&templetid=1707171396217403171";
  String otpCounselling = "https://dudusms.in/smsapi/send_sms?authkey=ap6C0Y9pPyXUnlH9j9A59z&mobiles=Mobile No&message={#var#} is OTP to complete admission counselling with our counselor. DO NOT disclose this OTP to anyone on call. SOFTVISION /GSB&sender=GSBCLG&route=4&templetid=1707171396211263156";

  getObscure() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

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
    String email = emailController.text;
    String password = passwordController.text;
    String reEnterPassword = againPasswordController.text;
    String name = nameController.text;
    String number = numberController.text;
    String institute = instituteNameController.text;
    if (image != null) {
      base64String = base64Encode(image!);
    }
    print("base64String $base64String");
    //await Clipboard.setData(ClipboardData(text: "your text"));

    try {
      Map<String, String> requestBody = {
        'email': email,
        "password": password,
        "address": reEnterPassword,
        "name": name,
        "number": number,
        "profile_pic": "base64String",
        "institute" : institute
      };
      int otpForVerification = getOtp();
      String smsToSend = getSms(number,otpForVerification);
      Get.to(() => OtpVerificationUser(smsToSend, otpForVerification,requestBody,"user"));
      nameController.text = "";
      passwordController.text = "";
      againPasswordController.text = "";
      emailController.text = "";
      numberController.text = "";
      instituteNameController.text = "";
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

  // File? pickedImage;
  //
  // pickImages(ImageSource imageType) async {
  //   try {
  //     final photo = await ImagePicker().pickImage(source: imageType);
  //     if (photo == null) return;
  //     final tempImage = File(photo.path);
  //     pickedImage = tempImage;
  //     Get.back();
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  refreshUI() {
    notifyListeners();
  }

  RegisterUserViewModel() {
    showProgressbar = false; // Initialize your variable here
  }

  int getOtp() {
    Random random = Random();
    return random.nextInt(7999) + 1000;
  }

  String getSms(String mobileNumber, int otpForVerification) {
    String registerUser = "https://dudusms.in/smsapi/send_sms?authkey=Tv66DYP4Pi4K9MrJODOVii&mobiles="+mobileNumber+"&message=Greetings from SOFTVISION /GSB! Your onetime OTP to join our councelling team is "+otpForVerification.toString()+". Do not share the OTP with anyone.&sender=SOFTVN&route=4&templetid=1707171420777765990";
    //String otpRestPassword = "https://dudusms.in/smsapi/send_sms?authkey=ap6C0Y9pPyXUnlH9j9A59z&mobiles="+mobileNumber+"&message=Greetings from SOFTVISION /GSB! Your OTP to change your credentials is "+otpForVerification.toString()+". Do not share the OTP with anyone.&sender=GSBCLG&route=4&templetid=1707171396217403171";
    return registerUser;
  }
}
