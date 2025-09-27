import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/gradient_button.dart';
import '../../utils/app_text_style.dart';
import 'enter_email_viewModel.dart';

class EnterEmailPage extends StatefulWidget {
  const EnterEmailPage({Key? key}) : super(key: key);

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  late EnterEmailViewModel _viewModel;

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
    _viewModel = context.watch<EnterEmailViewModel>();
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
                          margin: const EdgeInsets.only(left: 15,right: 15),
                          //color: Colors.red,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width : double.infinity,
                                  child: Text(
                                    "Reset Password",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.getTextStyle25FontWeight700,
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
                                    final emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                                      text: 'Submit',
                                      onPressed: () {
                                        if (_viewModel.formKey.currentState!.validate()) {
                                         // _viewModel.submitData(context);
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
          Visibility(visible : _viewModel.showProgressbar , child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}
