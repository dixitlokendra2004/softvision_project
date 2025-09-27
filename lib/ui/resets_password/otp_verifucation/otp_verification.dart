import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import TextInputFormatter
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/ui/login/login.dart';

import '../../../custom_widgets/gradient_button.dart';
import '../../../utils/app_text_style.dart';
import '../new_password/new_password.dart';
import 'otp_verification_viewmodel.dart';

class ResetOtpVerification extends StatefulWidget {
  String smsToSend;
  int otpForVerification;
 // Map<String, String> requestBody;
  String email;
  ResetOtpVerification( this.smsToSend, this.otpForVerification,this.email, {super.key});

  @override
  State<ResetOtpVerification> createState() => ResetOtpVerificationState();
}

class ResetOtpVerificationState extends State<ResetOtpVerification> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  late ResetOtpVerificationViewModel _viewModel;
  StreamController<bool> resendButtonController = StreamController<bool>();

  late Timer _resendTimer;
  late int _remainingTime;
  bool _isResendEnabled = false;

  void _startResendTimer() {
    _remainingTime = 60; // Set initial remaining time to 60 seconds
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--; // Decrease remaining time by 1 second
        if (_remainingTime == 0) {
          _resendTimer.cancel();
          _isResendEnabled = true;
          resendButtonController.add(true);
        }
      });
    });
  }

  void _resetResendTimer() {
    _resendTimer.cancel();
    _isResendEnabled = false;
    _startResendTimer();
    _viewModel.sendOtpToDevice();
  }


  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.smsToSend = widget.smsToSend;
      _viewModel.otpForVerification = widget.otpForVerification;
     //_viewModel.requestBody = widget.requestBody;
      _viewModel.email = widget.email;
      _viewModel.sendOtpToDevice();
    });
  }
  @override
  void dispose() {
    _resendTimer.cancel();
    resendButtonController.close();
    errorController!.close();
    textEditingController.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ResetOtpVerificationViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify OTP",
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
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.Sh,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/icons/verifyicon.png",height: 100,width: 100,),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: RichText(
                text:TextSpan(
                  text: "Enter the code sent to your ",
                  children: [
                    TextSpan(
                      text: "Mobile Number",
                      style: AppTextStyle.getTextStyle14FontWeight500,
                    ),
                  ],
                  style: AppTextStyle.getTextStyle14FontWeight500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _viewModel.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 30,
                        ),
                        child: PinCodeTextField(
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 4) {
                              return "";
                            } else if (v == _viewModel.currentText) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 60,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            inactiveColor: Colors.black38,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 200),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Allow only digits
                          ],
                          onCompleted: (v) {
                            _viewModel.enteredOtp = v;
                          },
                          onChanged: (value) {
                            debugPrint(value);
                            _viewModel.getCurrentText(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<bool>(
                      stream: resendButtonController.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Didn't receive the code? ",
                              style: TextStyle(color: Colors.black54, fontSize: 12),
                            ),
                            TextButton(
                              onPressed: snapshot.data ?? false ? () => _resetResendTimer() : null,
                              child: Text(
                                _isResendEnabled ? "RESEND" : "RESEND ($_remainingTime)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _isResendEnabled ? Colors.blue : Colors.grey, // Change color based on button state
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                      child: Container(
                        height: 40,
                        child: GradientButton(
                          text: 'Verify',
                          onPressed: () {
                            _viewModel.formKey.currentState!.validate();
                            if (_viewModel.currentText.length != 4 || _viewModel.currentText != _viewModel.currentText) {
                              errorController!.add(ErrorAnimationType.shake);

                              String dialogText =
                                  "Invalid OTP. Please try again.";
                              Fluttertoast.showToast(
                                  msg: dialogText,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            } else {
                              verified(context);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
            //   child: Text(
            //     _viewModel.hasError ? "*Please fill up all the cells properly" : "",
            //     style: AppTextStyle.getTextStyle12FontWeight400,
            //   ),
            // ),

          ],
        ),
      ),
    );
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  verified(BuildContext context) {
    _viewModel.hasError = false;
    print(_viewModel.otpForVerification.toString() +"  "+_viewModel.enteredOtp.toString());
    if(_viewModel.otpForVerification.toString() != _viewModel.enteredOtp.toString()) {
      String dialogText =
          "Incorrect OTP, please try again.";
      Fluttertoast.showToast(
          msg: dialogText,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Get.to(() => NewPassword(_viewModel.email));
      textEditingController.text = "";
     // _viewModel.submitData(context);
    }
  }
}
