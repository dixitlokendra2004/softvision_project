import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/image_model.dart';
import '../services/services.dart';

class UploadImageViewModel extends ChangeNotifier {

   List<AllImages> imgList = [];
  bool uploading = false;
  int currentIndex = 0; // Variable to store index of the selected image
  bool showProgressbar = false;
  bool idStatus = false;


  refreshUI() {
    notifyListeners();
  }

  init() {}

  Future<void> fetchData() async {
    showProgressbar = true;
    refreshUI();
    imgList = await Services.getAllImages();
    showProgressbar = false;
    refreshUI();
  }

   Future<int> updateImageInfo(String id) async{
     showProgressbar = true;
     refreshUI();
     int status = 0;
     status = await Services.updateImageStatus(id);
     if(status == 1) {
       Fluttertoast.showToast(
           msg: "Successfully Deleted Image",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.black,
           textColor: Colors.white,
           fontSize: 16.0
       );
       fetchData();
     } else {
       Fluttertoast.showToast(
           msg: "Please try again.",
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
}
