import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/ui/profile_page/profile_viewmodel.dart';
import 'package:softvision_project/ui/register_user/register_viewmodel.dart';

import '../../core/constant/app_strings.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/gradient_button.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../widget/button_widget.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late ResiterUserViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This code block will be executed after the build completes
      _viewModel.showProgressbar = false;
      _viewModel.refreshUI();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ResiterUserViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.register,
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
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      title: "Email *",
                      hintText: AppString.email,
                      controller: _viewModel.emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Password *",
                      hintText: AppString.password,
                      controller: _viewModel.passwordController,
                      isObscureText: _viewModel.isObscureText,
                      suffix: IconButton(
                        icon: Icon(_viewModel.isObscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          _viewModel.getObscure();
                          _viewModel.refreshUI();
                        },
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Name *",
                      hintText: AppString.name,
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
                        title: "Mobile Number *",
                        hintText: AppString.number,
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
                        }),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Address *",
                      hintText: AppString.enterYourAddress,
                      controller: _viewModel.againPasswordController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      title: "Institute Name *",
                      hintText: AppString.instituteHintTextName,
                      controller: _viewModel.instituteNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Institute name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: GradientButton(
                        text: AppString.registerUser,
                        onPressed: () async {
                         // Get.to(() => OtpVerification());
                          if (_viewModel.formKey.currentState!.validate()) {
                            await _viewModel.submitData(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
              visible: _viewModel.showProgressbar,
              child: const Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
