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
import '../new_password/new_password.dart';
import '../otp_verifucation/otp_verification.dart';
import 'email_viewmodel.dart';

class EmailPage extends StatefulWidget {
  final String email;
  const EmailPage({required this.email, Key? key}) : super(key: key);

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  late EmailPageViewModel _viewModel;
  String email = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _viewModel.showProgressbar = false;
      // email = await SharedPreferencesHelper.getEmail();
      _viewModel.emailController.text = widget.email;
      ;
      _viewModel.refreshUI();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<EmailPageViewModel>();
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
                                  title: "Email",
                                  hintText: "Enter Email",
                                  controller: _viewModel.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email address';
                                    }
                                    // Email regex pattern
                                    final emailRegex = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegex.hasMatch(value.trim())) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null; // Return null if the validation passes
                                  },
                                ),
                                const SizedBox(height: 15),
                                Center(
                                  child: Container(
                                    height: 40,
                                    child: GradientButton(
                                      text: 'Next',
                                      onPressed: () {
                                        if (_viewModel.formKey.currentState!
                                            .validate()) {
                                          //_viewModel.submitData(context);
                                          email =
                                              _viewModel.emailController.text;
                                          int otpForVerification =
                                              _viewModel.getOtp();
                                          _viewModel.getSms(
                                              email, otpForVerification);
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
              child:
                  Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
