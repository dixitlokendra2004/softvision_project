import 'package:flutter/cupertino.dart';


class LandingViewModel extends ChangeNotifier {
  TextEditingController enterController = TextEditingController();

  late TextEditingController textController;




  List<String> lists = [];

  refreshUI() {
    notifyListeners();
  }

  init() {}

}