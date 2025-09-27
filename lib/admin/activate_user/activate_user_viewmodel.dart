import 'package:flutter/cupertino.dart';
import 'package:softvision_project/model/users.dart';
import 'package:softvision_project/services/services.dart';

class ActivateUserViewModel extends ChangeNotifier {

  List<Users> users = [];
  bool showProgressbar = false;
  String queryString = "";

  refreshUI() {
    notifyListeners();
  }

  init() {}

  void fetchData() async {
    showProgressbar = true;
    refreshUI();
    users = await Services.getAllUsers(queryString);
    showProgressbar = false;
    refreshUI();
  }

  Future<int> updateUserStatus(String email, bool value) async{
    showProgressbar = true;
    refreshUI();
    int status = 0;
    status = await Services.updateUserStatus(email,value);
    showProgressbar = false;
    refreshUI();
    return status;
  }

}