import 'package:flutter/cupertino.dart';

import '../../model/image_model.dart';
import '../../services/services.dart';
import '../../utils/sp_helper.dart';


class DashboardViewModel extends ChangeNotifier {

  List<AllImages> imgList = [];
  bool showProgressbar = false;
  String userName="";

  refreshUI() {
    notifyListeners();
  }

  init() {
   getUserName();
  }

   getUserName() async {
    userName = await SharedPreferencesHelper.getName() ?? "";
    refreshUI() ;
  }

  Future<void> fetchData() async {
    showProgressbar = true;
    refreshUI();
    imgList = await Services.getAllImages();
    showProgressbar = false;
    refreshUI();
  }

}