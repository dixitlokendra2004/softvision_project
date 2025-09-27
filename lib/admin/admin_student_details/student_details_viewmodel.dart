import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/student_model.dart';
import '../../services/services.dart';


class AdminStudentDetailsViewModel extends ChangeNotifier {
  TextEditingController adminCommentController = TextEditingController();

  Students? data;
  bool showProgressbar = false;
  String queryString = "";
  bool status = false;
  bool feesStatus = false;
  bool documentStatus = false;
  List<bool> _selections = [false, false, false];
  int selectedIndex = 2;

  setDocmentStatus(value) {
    documentStatus = value!;
    notifyListeners();
  }

  setFeesStatus(value) {
      feesStatus = value!;
      notifyListeners();
  }

  refreshUI() {
    notifyListeners();
  }
  init() {}

  Future<int> updateStudentStatus(String id, bool value) async{
    showProgressbar = true;
    refreshUI();
    int status = 0;
    status = await Services.updateStudentStatus(id,value);
    showProgressbar = false;
    refreshUI();
    return status;
  }

  Future<int> updateStudentInfo() async{
    String admitted = "Not Admitted";
    String adminComments =  adminCommentController.text;
    if(selectedIndex == 0) {
      admitted= "Softvision";
    }
    if(selectedIndex == 1) {
      admitted= "GSB";
    }

    showProgressbar = true;
    refreshUI();
    int status = 0;
    status = await Services.updateStudentInfo(data!.id,documentStatus,feesStatus,admitted,adminComments);
    showProgressbar = false;
    if(status == 1) {
      Fluttertoast.showToast(
          msg: "Successfully Updated Student Info",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Failed to Updated Student Info",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    refreshUI();
    return status;
  }


  fetchData(String id) async {
    showProgressbar = true;
    refreshUI();
    List<Students> students = await Services.getStudentsById(id);
    data = students.elementAt(0);
    documentStatus = data!.documents == "1" ? true : false;
    feesStatus = data!.fees_above_50 == "1" ? true : false;
    if(data!.admitted_to == "Softvision") {
      selectedIndex= 0;
      _selections[0] = true;
    } else if(data!.admitted_to == "GSB") {
      selectedIndex= 1;
      _selections[1] = true;
    } else {
      selectedIndex= 2;
      _selections[1] = true;
    }
    adminCommentController.text = data!.admin_comments;
    status = true;
    showProgressbar = false;
    refreshUI();

  }
}
