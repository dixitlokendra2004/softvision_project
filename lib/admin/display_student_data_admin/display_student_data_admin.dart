import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/model/student_model.dart';
import 'package:softvision_project/services/services.dart';
import 'package:softvision_project/size_ext.dart';

import '../../utils/app_text_style.dart';
import '../../utils/util.dart';
import '../admin_student_details/student_details.dart';
import 'display_student_data_admin_viewmodel.dart';

class DisplayStudentDataAdmin extends StatefulWidget {
  String studentName;
  String email;
  String number;
  String whatsAppNumber;
  String fatherName;
  String fatherNumber;
  String schoolName;
  String cityName;
  String emailIDOfStudent;
  String district;
  String comments;
  String counsellingDoneBy;
  String dateOfCounselling;

  DisplayStudentDataAdmin({
    required this.studentName,
    required this.email,
    required this.number,
    required this.whatsAppNumber,
    required this.fatherName,
    required this.fatherNumber,
    required this.schoolName,
    required this.cityName,
    required this.emailIDOfStudent,
    required this.district,
    required this.comments,
    required this.counsellingDoneBy,
    required this.dateOfCounselling,
  });

  @override
  State<DisplayStudentDataAdmin> createState() =>
      _DisplayStudentDataAdminState();
}

class _DisplayStudentDataAdminState extends State<DisplayStudentDataAdmin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchData();
    });
  }

  @override
  void dispose() {
    _viewModel.dateController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  late DisplayStudentDataShowAdminViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<DisplayStudentDataShowAdminViewModel>();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                'Students',
                style: AppTextStyle.getTextStyle16FontWeight500,
              ),
              backgroundColor: Colors.blue,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Util.generateAndShareStudentList(_viewModel.data);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/icons/export.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.Sw, right: 5.Sw),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 50.Sh,
                        margin: EdgeInsets.only(left: 10.Sw, right: 10.Sw),
                        padding: EdgeInsets.all(10.Sh),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          onChanged: (s) {
                            _viewModel.queryString = s ?? "";
                            _viewModel.fetchData();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Search by Name / Email",
                            contentPadding: EdgeInsets.all(0.0),
                            isDense: true,
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  _viewModel.selectDate(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _viewModel.data.length,
                          itemBuilder: (context, index) {
                            Students student = _viewModel.data[index];
                            return Column(
                              children: [
                                Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ListTile(
                                      title: Text(
                                        Util.capitalizeEveryWord(
                                            _viewModel.data[index].studentName),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Reffered By : ${_viewModel.data[index].name}"),
                                          SizedBox(height: 5.Sh),
                                          Text("Institute : ${_viewModel.data[index].institute}"),
                                          SizedBox(height: 5.Sh),
                                        ],
                                      ),
                                      trailing: const Icon(Icons.arrow_forward),
                                      onTap: () {
                                        Students student = _viewModel.data[index];
                                        String id = _viewModel.data[index].id.toString();
                                        print(id);
                                        Get.to(() => AdminStudentDetails(id));
                                      }),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: _viewModel.showProgressbar,
                    child: Center(child: CircularProgressIndicator()))
              ],
            )));
  }

  expansionText(String text) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Text(
        text,
        style: AppTextStyle.getTextStyle14FontWeight500,
      ),
    );
  }

  Widget showData(String text, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(3),
      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              label,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 2,
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  diplayDialog(bool value, String name, String id) {
    String message =
        "Dou you want to Change the Payment Status of Student : " + name;
    if (value)
      message =
          "Dou you want to Change the Payment Status of Student : " + name;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Alert"),
            content: Text(message),
            actions: [
              InkWell(
                onTap: () async {
                  Navigator.of(context).pop();
                  await _viewModel.updateStudentStatus(id, value);
                  _viewModel.fetchData();
                },
                child: const Text("Yes"),
              ),
              const SizedBox(width: 40),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("No"),
              ),
            ],
          );
        });
  }

  getAdmissionWidget() {
    List<bool> _selections = [false, false, true]; // Default: Not Admitted

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildOption('Softvision', 0),
          _buildOption('GSB', 1),
          _buildOption('Not Admitted', 2),
        ],
      ),
    );
  }

  Widget _buildOption(String text, int index) {
    int _selectedIndex = 2;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color:
              _selectedIndex == index ? Colors.red.shade700 : Colors.grey[300],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
