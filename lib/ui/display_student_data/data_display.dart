import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/model/student_model.dart';
import 'package:softvision_project/size_ext.dart';

import '../../services/services.dart';
import '../../utils/app_text_style.dart';
import 'data_display_viewmodel.dart';

class DataDisplay extends StatefulWidget {
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

  DataDisplay({
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
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchData();
    });
  }

  late DataDisplayViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<DataDisplayViewModel>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Leads',
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
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 50.Sh,
                  margin: EdgeInsets.only(left:10.Sw, right :10.Sw),
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
                      hintText: "Search by Name",
                      contentPadding: EdgeInsets.all(0.0),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                          margin: EdgeInsets.only(left:5.Sw,right:5.Sw),
                          child: ListView.builder(
                            itemCount: _viewModel.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ExpansionTile(
                                    title: /*Text(
                                  data[index].studentName,
                                  style: AppTextStyle.getTextStyle16FontWeight600,
                                ),*/
                                        ListTile(
                                      leading: Image.asset(
                                      _viewModel.data[index].gender== "Male" ? "assets/icons/male.png" : "assets/icons/female.png",
                                        width: 36,
                                        height: 36,
                                      ),
                                      title: Text(
                                        _viewModel.data[index].studentName,
                                        style: AppTextStyle.getTextStyle18FontWeightBold,
                                      ),
                                      subtitle: Text("Admission: ${_viewModel.data[index].admitted_to}"),
                                    ),
                                    children: <Widget>[
                                      Container(
                                        height: 1.0,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                      ),
                                      SizedBox(height: 10.Sh),
                                      Column(
                                        children: [
                                          showData(_viewModel.data[index].email, "Email ",const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].watssapNo, "watssapNo ", Colors.white),
                                          showData(_viewModel.data[index].fatherName, "Father's Name ",const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].fatherNumber, "Father's Number ", Colors.white),
                                          showData(_viewModel.data[index].gender, "Gender ",const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].schoolName, "School Name ",Colors.white),
                                          showData(_viewModel.data[index].collage, "Collage ",const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].board, "Board/University ", Colors.white),
                                          showData(_viewModel.data[index].stream, "Stream/Graduation ",const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].courseOfInterest, "Course Interested in ",Colors.white),
                                          showData(_viewModel.data[index].city, "City ", const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].emailIdStudent, "Email ID Student ",Colors.white),
                                          showData(_viewModel.data[index].district, "District: ", const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].comments, "Comments: ",Colors.white),
                                          showData(getPametStatus(_viewModel.data[index].paymentStatus), "Payment Status ", const Color(0xfff6f6f6)),
                                          //showData(_viewModel.data[index].institute, "Institute: ",Colors.white),
                                          showData(_viewModel.data[index].admin_comments, "Admin Comments ", const Color(0xfff6f6f6)),
                                          showData(_viewModel.data[index].fees_above_50 == "1" ? "Yes" : "No" , "Fees above 50% ",Colors.white),
                                          showData(_viewModel.data[index].documents == "1" ? "Submitted" : "Pending", "Documents ", const Color(0xfff6f6f6)),

                                          SizedBox(height: 10.Sh),
                                ],
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ),
                ),
              ],
            ),
            Visibility(visible: _viewModel.showProgressbar,
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
  Widget showData(String text, String label,Color bgColor) {
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
              style: const TextStyle(fontWeight: FontWeight.bold,),
            ),
          ),
        ],
      ),
    );
  }

  String getPametStatus(paymentStatus) {
    return paymentStatus == "1" ? "Completed" : "Pending";
  }
}
