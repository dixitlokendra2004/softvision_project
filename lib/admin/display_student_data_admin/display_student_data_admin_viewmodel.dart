import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/student_model.dart';
import '../../services/services.dart';
import '../../utils/sp_helper.dart';

class DisplayStudentDataShowAdminViewModel extends ChangeNotifier {

  late List<Students> data = [];
  bool showProgressbar = false;
  String queryString = "";

  fetchData() async {
    showProgressbar = true;
    refreshUI();
    data = await Services.getAllStudents(queryString);
    print(data);
    print(data.length);
    showProgressbar = false;
    refreshUI();

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


  // Function to display the date picker
  DateTime? _selectedDate;
  String? _formattedDate;
  final dateController = TextEditingController();

  DateTime? get selectedDate => _selectedDate;
  String? get formattedDate => _formattedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      _selectedDate = pickedDate;
      _formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = _formattedDate!;
      showProgressbar = true;
      refreshUI();
      data = await Services.getAllStudentsByDate(_formattedDate!);
      showProgressbar = false;
      refreshUI();
      print(_formattedDate); // This will print the date in yyyy-MM-dd format
    }
  }


}