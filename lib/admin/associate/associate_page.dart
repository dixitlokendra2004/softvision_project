import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';

import '../../utils/app_text_style.dart';
import 'associate_viewmodel.dart';

class AssociatePage extends StatefulWidget {
  const AssociatePage({Key? key}) : super(key: key);

  @override
  State<AssociatePage> createState() => _AssociatePageState();
}

class _AssociatePageState extends State<AssociatePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchData();
    });
  }

  late AssociatePageViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AssociatePageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Associate",
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
                                // leading: Image.asset(
                                //   _viewModel.data[index].gender== "Male" ? "assets/icons/male.png" : "assets/icons/female.png",
                                //   width: 36,
                                //   height: 36,
                                // ),
                                title: Text(
                                  _viewModel.data[index].name,
                                  style: AppTextStyle.getTextStyle18FontWeightBold,
                                ),
                                subtitle: Text("Institute: ${_viewModel.data[index].institute}"),
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
                                    showData(_viewModel.data[index].id.toString(), "Id ", Colors.white),
                                    showData(_viewModel.data[index].mobileNumber, "Mobile Number",const Color(0xfff6f6f6)),
                                    showData(_viewModel.data[index].address, "Address", Colors.white),
                                    showData(_viewModel.data[index].active == 1 ? "Active" : "DeActivate", "Active", const Color(0xfff6f6f6)),
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
        )
    );

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

  String getActiveStatus(paymentStatus) {
    return paymentStatus == "1" ? "Active" : "DeActivate";
  }
}

