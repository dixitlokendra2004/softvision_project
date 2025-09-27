import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../model/student_model.dart';
import 'package:http/http.dart' as http;
import '../../services/services.dart';
import '../../utils/sp_helper.dart';

class DataDisplayViewModel extends ChangeNotifier {
  late List<Students> data = [];

  var showProgressbar = false;

  String queryString = "";
  //late Future<List<Students>> data;

   fetchData() async {
    // Make API call
     showProgressbar = true;
     refreshUI();
     String? email = await SharedPreferencesHelper.getEmail() ?? "";
     print(email);
     data = await Services.getRegisterStudents(email,queryString);
     print(data);
     showProgressbar = false;
    refreshUI();
  }

  refreshUI() {
    notifyListeners();
  }

  init() {}
}
