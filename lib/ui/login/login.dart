import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/ui/landing_page/landing_page.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/gradient_button.dart';
import '../../utils/app_text_style.dart';
import '../register_user/register_user.dart';
import '../resets_password/email/email.dart';
import '../widget/button_widget.dart';
import 'login_viewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginViewModel _viewModel;

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
    _viewModel = context.watch<LoginViewModel>();

    return Scaffold(
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
                                    "Member Login",
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
                                CustomTextFormField(
                                  padding: TextFormFieldPadding.PaddingT16,
                                  title: "Password",
                                  hintText: "Enter Password",
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
                                SizedBox(height: 25.Sh),
                                Center(
                                  child: Container(
                                    height: 40,
                                    child: GradientButton(
                                      text: 'Login',
                                      onPressed: () {
                                        if (_viewModel.formKey.currentState!
                                            .validate()) {
                                          _viewModel.submitData(context);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.Sh),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => const RegisterUser());
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Register Now",
                                          style: AppTextStyle
                                              .getTextStyleBlue12FontWeight500,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => EmailPage(
                                            email: _viewModel
                                                .emailController.text));
                                      },
                                      child: Text(
                                        'Forgot Password',
                                        style: AppTextStyle
                                            .getTextStyleBlue12FontWeight500,
                                      ),
                                    ),
                                  ],
                                ),

                                /*Container(
                                  width: double.infinity,
                                  child: ButtonWebWidget(
                                    title: "Login To Your Account",
                                    color: Colors.white,
                                    onTap: () {
                                      if (_viewModel.formKey.currentState!.validate()) {
                                        _viewModel.submitData(context);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) =>  const RegisterNewLeadPage()),
                                        // );
                                      }
                                    },
                                    backgroundColor: Colors.blue,
                                    titleColor: Colors.white,
                                    borderRadius: 10,
                                    titleFontSize: 18,
                                  ),
                                ),*/
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
                  )),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of resources or controllers
    _viewModel.emailController.text = "";
    _viewModel.passwordController.text = "";
    super.dispose();
  }
}
