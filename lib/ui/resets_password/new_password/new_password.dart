import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';

import '../../../custom_widgets/custom_text_field.dart';
import '../../../custom_widgets/gradient_button.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/sp_helper.dart';
import '../../login/login.dart';
import '../otp_verifucation/otp_verification.dart';
import 'new_password_viewmodel.dart';

class NewPassword extends StatefulWidget {
  String email;
  NewPassword(this.email, {super.key});
  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  late NewPasswordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<NewPasswordViewModel>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Email',
      //     style: AppTextStyle.getTextStyle16FontWeight500,
      //   ),
      //   backgroundColor: Colors.blue,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //       size: 25,
      //     ),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 150.Sh),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/combinedlogo.png', // Replace with your image path
                      width: 280.Sw,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.Sh),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _viewModel.formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          //color: Colors.red,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    "Reset Password",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle
                                        .getTextStyle25FontWeight700,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                  padding: TextFormFieldPadding.PaddingT16,
                                  title: "New Password",
                                  hintText: "Enter New Password",
                                  controller: _viewModel.passwordController,
                                  isObscureText: _viewModel.isObscureText,
                                  suffix: IconButton(
                                    icon: Icon(_viewModel.isObscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
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
                                Center(
                                  child: Container(
                                    height: 40,
                                    child: GradientButton(
                                      text: 'OK',
                                      onPressed: () {
                                        if (_viewModel.formKey.currentState!
                                            .validate()) {
                                          //Get.to(() => const LoginPage());
                                          _viewModel.submitData(
                                              context, widget.email);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.Sh),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
              visible: _viewModel.showProgressbar,
              child: Center(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              )),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
