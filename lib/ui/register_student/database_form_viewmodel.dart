import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:softvision_project/utils/sp_helper.dart';

import '../../apis/api_status.dart';
import '../../model/location_model.dart';
import '../../services/services.dart';
import '../display_student_data/data_display.dart';
import '../otp_verification_user/otp_verification.dart';

class RegisterStudentViewModel extends ChangeNotifier {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController whatsAppNumberController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherNumberController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailIDOfStudentController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController counsellingDoneByController = TextEditingController();
  TextEditingController dateOfCounsellingController = TextEditingController();


  String selectedCollageStat = "Select";
  String selectedGenderStat = "Select";
  String selectedBoardStat = "Select";
  String selectedStreamStat = "Select";
  String selectedCourseInterestedStat = "Select";
  String selectedSecondaryDataSourceStat = "NONE";
  LocationModel? selectedLocation;
  String selectedDistrictStat = "Select";

  var formKey;
  RegisterStudentViewModel() {
    formKey = GlobalKey<FormState>();
    // Initialize formKey here
  }

  void clearTextControllers() {
    studentNameController.clear();
    emailController.clear();
    numberController.clear();
    whatsAppNumberController.clear();
    fatherNameController.clear();
    fatherNumberController.clear();
    schoolNameController.clear();
    cityController.clear();
    emailIDOfStudentController.clear();
    districtController.clear();
    commentsController.clear();
    counsellingDoneByController.clear();
    dateOfCounsellingController.clear();
  }

  List<String> lists = [];

  List<String> districts = [
    "Select",
    "Agar Malwa",
    "Alirajpur",
    "Anuppur",
    "Ashoknagar",
    "Balaghat",
    "Barwani",
    "Betul",
    "Bhind",
    "Bhopal",
    "Burhanpur",
    "Chhatarpur",
    "Chhindwara",
    "Damoh",
    "Datia",
    "Dewas",
    "Dhar",
    "Dindori",
    "Guna",
    "Gwalior",
    "Harda",
    "Hoshangabad",
    "Indore",
    "Jabalpur",
    "Jhabua",
    "Katni",
    "Khandwa",
    "Khargone",
    "Mandla",
    "Mandsaur",
    "Morena",
    "Narsinghpur",
    "Neemuch",
    "Panna",
    "Raisen",
    "Rajgarh",
    "Ratlam",
    "Rewa",
    "Sagar",
    "Satna",
    "Sehore",
    "Seoni",
    "Shahdol",
    "Shajapur",
    "Sheopur",
    "Shivpuri",
    "Sidhi",
    "Singrauli",
    "Tikamgarh",
    "Ujjain",
    "Umaria",
    "Vidisha"
  ];

  bool showProgressbar = false;

  refreshUI() {
    notifyListeners();
  }

  Future<List<LocationModel>> getCityByName(String cityName) async {
    var response = await Services.searchLocationByCity(cityName);
    if (response is Success) {
      List<LocationModel> locations =
          (response.response as List<LocationModel>);
      return locations;
    } else {
      return [];
    }
  }

  void selectLocation(LocationModel locationModel) {
    selectedLocation = locationModel;
    districtController.text = locationModel.cityName;
  }

  void deselectLocation() {
    selectedLocation = null;
  }

  Future<void> submitData(BuildContext context) async {
    showProgressbar = true;
    refreshUI();
    String studentName = studentNameController.text;
    String email = emailIDOfStudentController.text;
    //String number = numberController.text;
    String watssapNo = whatsAppNumberController.text;
    String fatherName = fatherNameController.text;
    String fatherNo = fatherNumberController.text;
    String schoolName = schoolNameController.text;
    String city = cityController.text;
    String emailIdStudent = emailIDOfStudentController.text;
    String district = selectedDistrictStat;
    String comments = commentsController.text;
    //String counsellingDoneBy = counsellingDoneByController.text;
    //String dateOfCounselling = dateOfCounsellingController.text;
    String userEmail = await SharedPreferencesHelper.getEmail();
    String collage = selectedCollageStat;
    String gender = selectedGenderStat;
    String board = selectedBoardStat;
    String stream = selectedStreamStat;
    String courseOfInterest = selectedCourseInterestedStat;

    try {
      Map<String, String> requestBody = {
        'studentName': studentName,
        'email': email,
        "number": watssapNo,
        "watssapNo": watssapNo,
        "fatherName": fatherName,
        "fatherNumber": fatherNo,
        "schoolName": schoolName,
        "city": city,
        "emailIdStudent": emailIdStudent,
        "district": district,
        "comments": comments,
        "counsellingDoneBy": "",//counsellingDoneBy,
        "dateOfCounselling": "",//dateOfCounselling,
        "userEmail": userEmail,
        "collage": collage,
        "gender": gender,
        "board": board,
        "stream": stream,
        "courseOfInterest": courseOfInterest,
      };
      clearTextControllers();
      int otpForVerification = getOtp();
      String smsToSend = getSms(watssapNo,otpForVerification);
      Get.to(() => OtpVerificationUser(smsToSend, otpForVerification,requestBody,"student"));
       selectedCollageStat = "Select";
       selectedGenderStat = "Select";
       selectedBoardStat = "Select";
       selectedStreamStat = "Select";
       selectedCourseInterestedStat = "Select";
       selectedDistrictStat = "Select";
    } catch (e) {
      // Handle error
      print('Please contact Administrator to get your account activated: $e');
    }
    showProgressbar = false;
    refreshUI();
  }

  int getOtp() {
    Random random = Random();
    return random.nextInt(7999) + 1000;
  }

  String getSms(String mobileNumber, int otpForVerification) {
    //String otpStudentRegistration = "https://dudusms.in/smsapi/send_sms?authkey=Tv66DYP4Pi4K9MrJODOVii&mobiles="+ mobileNumber +"&message="+ otpForVerification.toString() +" is OTP to complete admission counselling with our counselor. DO NOT disclose this OTP to anyone on call. SOFTVISION /GSB&sender=SOFTVN&route=4&templetid=1707171396211263156";
    String otpStudentRegistration = "https://dudusms.in/smsapi/send_sms?authkey=Tv66DYP4Pi4K9MrJODOVii&mobiles="+ mobileNumber +"&message=Dear Student, "+ otpForVerification.toString() +" is OTP to complete admission counselling with our counselor. DO NOT disclose this OTP to anyone on call. VEEVAA&sender=TXESMS&route=4&templetid=1707171586346044438";
    return otpStudentRegistration;
  }

}
