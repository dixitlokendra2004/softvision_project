import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/ui/profile_page/profile_viewmodel.dart';
import 'package:softvision_project/utils/sp_helper.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/gradient_button.dart';
import '../../model/student_model.dart';
import '../../utils/app_text_style.dart';
import '../widget/button_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfilePageViewModel _viewModel;
  String name = "";
  String address="";
  String mobileNumber ="";
  String institute = "";

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // This code block will be executed after the build completes
      _viewModel.showProgressbar = false;
      name = await SharedPreferencesHelper.getName();
      address = await SharedPreferencesHelper.getAddress();
      mobileNumber=  await SharedPreferencesHelper.getMobileNumber();
      institute=  await SharedPreferencesHelper.getInstitute();
      _viewModel.nameController.text = name;
      _viewModel.numberController.text = mobileNumber;
      _viewModel.addressController.text = address;
      _viewModel.instituteNameController.text = institute;
      _viewModel.refreshUI();
    });

  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ProfilePageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
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
          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,top: 20),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Stack(
                    //   children: [
                    //     _viewModel.image != null
                    //         ? CircleAvatar(
                    //       radius: 70,
                    // // _viewModel.image!
                    //       backgroundImage: MemoryImage(_viewModel.image!),
                    //       // backgroundImage: MemoryImage(base64Decode(_viewModel.base64String)),
                    //     )
                    //         : const CircleAvatar(
                    //       radius: 70,
                    //       backgroundImage:
                    //       AssetImage("assets/images/profile_image.png"),
                    //     ),
                    //     Positioned(
                    //       child: IconButton(
                    //         onPressed: () {
                    //          // _viewModel.selectImage();
                    //         },
                    //         icon: Icon(Icons.camera_alt,size: 40,color: Colors.blue,),
                    //       ),
                    //       bottom: -5,
                    //       left: 80,
                    //     ),
                    //   ],
                    // ),
                    // CustomTextFormField(
                    //   title: "Email",
                    //   hintText: "Email",
                    //   controller: _viewModel.emailController,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your email address';
                    //     }
                    //     // Email regex pattern
                    //     final emailRegex =
                    //     RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    //     if (!emailRegex.hasMatch(value)) {
                    //       return 'Please enter a valid email address';
                    //     }
                    //     return null; // Return null if the validation passes
                    //   },
                    // ),
                    // const SizedBox(height: 15),
                    // CustomTextFormField(
                    //   title: "Password",
                    //   hintText: "Password",
                    //   maxLength: 8,
                    //   controller: _viewModel.passwordController,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please enter password';
                    //     }
                    //     if (value.length != 8) {
                    //       return 'Password must be 8 digits';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Name",
                      hintText: "Name",
                      controller: _viewModel.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                        title: "Mobile Number",
                        hintText: "Number",
                        onlyNumber: true,
                        controller: _viewModel.numberController,
                        maxLength: 10,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Contact number is required';
                          }
                          if (value.length != 10) {
                            return 'Please enter a valid 10-digit contact number';
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Address",
                      hintText: "Enter Your Address",
                      controller: _viewModel.addressController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Institute Name",
                      hintText: "Institute Name",
                      controller: _viewModel.instituteNameController,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: GradientButton(
                        text: 'Update',
                        onPressed: () {
                         //Get.off(() =>   Students());
                           if (_viewModel.formKey.currentState!.validate()) {
                            _viewModel.submitData(context);
                           }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(visible : _viewModel.showProgressbar , child: const Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}

