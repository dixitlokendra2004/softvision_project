import 'package:flutter/cupertino.dart';

import '../../model/all_associates_model.dart';
import '../../services/services.dart';
import '../../utils/sp_helper.dart';

class AssociatePageViewModel extends ChangeNotifier {

  late List<AllAssociates> data = [];

  var showProgressbar = false;

  String queryString = "";


  fetchData() async {
    showProgressbar = true;
    refreshUI();
    data = await Services.getAssociates(queryString);
    print(data);
    print(data.length);
    showProgressbar = false;
    refreshUI();
  }

  refreshUI() {
    notifyListeners();
  }

  init() {}
}