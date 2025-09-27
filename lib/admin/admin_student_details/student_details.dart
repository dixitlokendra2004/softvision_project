import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/admin/admin_student_details/student_details_viewmodel.dart';
import 'package:softvision_project/model/student_model.dart';

import '../../core/constant/app_colors.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../utils/app_text_style.dart';
import '../../utils/util.dart';

class AdminStudentDetails extends StatefulWidget {
  String id;
  AdminStudentDetails(this.id, {super.key});

  @override
  State<AdminStudentDetails> createState() => _AdminStudentDetailsState();
}

class _AdminStudentDetailsState extends State<AdminStudentDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchData(widget.id);
    });
  }

  late AdminStudentDetailsViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AdminStudentDetailsViewModel>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Student Details',
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
        ),
        body: buildWithData()

    ) ,
        

    );
  }

  studentDetails(String label, String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 2),
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

  getAdmissionWidget() {
   return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildOption('Softvision', 0),
        const SizedBox(width: 5),
        _buildOption('GSB', 1),
        const SizedBox(width: 5),
        _buildOption('Not Admitted', 2),
      ],
    );
  }

  Widget _buildOption(String text, int index) {

    return GestureDetector(
      onTap: () {
       setState(() {
          _viewModel.selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: getSelectionColor(index),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _viewModel.selectedIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  diplayErrorDialog() {
    String message =
        "Payment status cannot be changed unless admission is confirmed in Softvision OR GSB";
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Not Admitted"),
            content: Text(message),
            actions: [

              InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("  OK  "),
              ),
            ],
          );
        });
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
                  await _viewModel.fetchData(_viewModel.data!.id);
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

  @override
  void dispose() {
    _viewModel.status = false;
    super.dispose();
  }

  getSelectionColor(int index) {
    if(index == 2) {
      return _viewModel.selectedIndex == index ? Colors.red.shade700 : Colors
          .grey[300];
    } else {
      return _viewModel.selectedIndex == index ? Colors.green.shade700 : Colors
          .grey[300];
    }
  }

  Widget buildWithData() {
    if(_viewModel.data == null) return Visibility(
        visible: _viewModel.showProgressbar,
        child: const Center(child: CircularProgressIndicator()))
    ;
    return Stack(
      children: [
        Visibility(
            visible: _viewModel.status,
            child: Container(
              margin: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Util.capitalizeEveryWord(_viewModel.data!.studentName),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // refferedBy("Reffered By: ", _viewModel.data!.name,const Color(0xfff6f6f6)),
                    // refferedBy("Institute: ", _viewModel.data!.institute,Colors.white),
                    const SizedBox(height: 10),
                    studentDetails("Reffered By:", _viewModel.data!.name,
                        const Color(0xfff6f6f6)),
                    studentDetails("Institute: ", _viewModel.data!.institute,
                        Colors.white),
                    studentDetails("Email:", _viewModel.data!.email,
                        const Color(0xfff6f6f6)),
                    studentDetails(
                        "Number:", _viewModel.data!.number, Colors.white),
                    studentDetails("watssapNo:", _viewModel.data!.watssapNo,
                        const Color(0xfff6f6f6)),
                    studentDetails("Father's Name:",
                        _viewModel.data!.fatherName, Colors.white),
                    studentDetails(
                        "Father's Number:",
                        _viewModel.data!.fatherNumber,
                        const Color(0xfff6f6f6)),
                    studentDetails("School Name:",
                        _viewModel.data!.schoolName, Colors.white),
                    studentDetails("City:", _viewModel.data!.city,
                        const Color(0xfff6f6f6)),
                    studentDetails("Email ID Student:",
                        _viewModel.data!.emailIdStudent, Colors.white),
                    studentDetails("District:", _viewModel.data!.district,
                        const Color(0xfff6f6f6)),
                    studentDetails("Comments:", _viewModel.data!.comments,
                        Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                      "Admission Status",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    getAdmissionWidget(),
                    const SizedBox(height: 10),
                    Container(
                      height: 30,
                      //color: Colors.red,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _viewModel.feesStatus,
                            onChanged: (value) {
                              _viewModel.setFeesStatus(value);
                            },
                          ),
                          const Text(
                            "Fee 50% above",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      height: 30,
                      //color: Colors.blue,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _viewModel.documentStatus,
                            onChanged: (value) {
                              _viewModel.setDocmentStatus(value);
                            },
                          ),
                          const Text(
                            "Documents",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment Status :",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Switch(
                          value: _viewModel.data!.paymentStatus == "1"
                              ? true
                              : false,
                          onChanged: (value) {
                            if(_viewModel.selectedIndex == 2) {
                              diplayErrorDialog();
                            } else {
                              diplayDialog(value, _viewModel.data!.studentName,
                                  _viewModel.data!.id);
                            }
                          },
                          activeTrackColor: Colors.green.withAlpha(100),
                          activeColor: Colors.green,
                        )
                      ],
                    ),
                    const Text(
                      "Admin Comments",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      maxLines: 3,
                      controller: _viewModel.adminCommentController,
                      decoration: InputDecoration(
                        hintText: "Admin Comments",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.blueGray5002,
                          ),
                        ), // Border style
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        //margin: EdgeInsets.only(right: 10),
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _viewModel.updateStudentInfo();

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white,fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            )),
        Visibility(
            visible: _viewModel.showProgressbar,
            child: const Center(child: CircularProgressIndicator()))
      ],
    );
  }
}
