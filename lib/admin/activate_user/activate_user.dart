import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';

import '../../utils/app_text_style.dart';
import '../../utils/util.dart';
import 'activate_user_viewmodel.dart';

class ActivateUser extends StatefulWidget {
  const ActivateUser({Key? key}) : super(key: key);

  @override
  State<ActivateUser> createState() => _ActivateUserState();
}

class _ActivateUserState extends State<ActivateUser> {
  late ActivateUserViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ActivateUserViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activate / DeActivate',
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
              Util.generateAndShareUserList(_viewModel.users);
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
                child: ListView.builder(
                  itemCount: _viewModel.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= _viewModel.users.length) {
                      return SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            _viewModel.users[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(_viewModel.users[index].email,),
                          trailing:
                          Switch(
                            value: _viewModel.users[index].active == "1"
                                ? true
                                : false,
                            onChanged: (value) {
                             diplayDialog(value,_viewModel.users[index].name,_viewModel.users[index].email);
                            },
                            activeTrackColor: Colors.green.withAlpha(100),
                            activeColor: Colors.green,
                          )
                        // onTap: () {
                        //   // Handle item tap
                        // },
                      ),
                    ),);
                  },
                ),
              ),
            ],
          ),
          Visibility(visible: _viewModel.showProgressbar,
              child: Center(child: CircularProgressIndicator()))

        ],
      ),
    );
  }

  diplayDialog(bool value, String name, String email) {
    String message = "Dou you want to DeActivate user : "+ name;
    if(value)  message = "Dou you want to Activate user : "+ name;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Alert"),
            content:  Text(
                message),
            actions: [
              InkWell(
                onTap: () async {
                  Navigator.of(context)
                      .pop();
                  await _viewModel.updateUserStatus(email, value);
                  _viewModel.fetchData();
                },
                child: const Text("Yes"),
              ),
              const SizedBox(width: 40),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog
                },
                child: const Text("No"),
              ),
            ],
          );
        });
  }
}
