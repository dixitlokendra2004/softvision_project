import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/custom_widgets/gradient_button.dart';

import '../../custom_widgets/responsive_form.dart';
import '../../services/services.dart';
import '../../utils/app_text_style.dart';
import '../widget/button_widget.dart';
import 'database_form_viewmodel.dart';

class DataBaseFormMobileUI extends StatefulWidget {
  RegisterStudentViewModel viewModel;
  List<dynamic> textFields;
  DataBaseFormMobileUI(
      {Key? key, required this.viewModel, required this.textFields})
      : super(key: key);

  @override
  State<DataBaseFormMobileUI> createState() => _DataBaseFormMobileUIState();
}

class _DataBaseFormMobileUIState extends State<DataBaseFormMobileUI> {
  late RegisterStudentViewModel _viewModel;
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
    _viewModel = context.watch<RegisterStudentViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Register',
          style: AppTextStyle.getTextStyle16FontWeight500,
        ),
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
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ResponsiveFormWidget(textFields: widget.textFields),
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: GradientButton(
                      text: 'Submit',
                      onPressed: () {
                        // Check if any dropdown field is not selected
                        bool anyDropdownNotSelected = false;
                        if (_viewModel.selectedCollageStat == null || _viewModel.selectedCollageStat == "Select") {
                          anyDropdownNotSelected = true;
                        }
                        if (_viewModel.selectedGenderStat == null || _viewModel.selectedGenderStat == "Select") {
                          anyDropdownNotSelected = true;
                        }
                        if (_viewModel.selectedBoardStat == null || _viewModel.selectedBoardStat == "Select") {
                          anyDropdownNotSelected = true;
                        }
                        if (_viewModel.selectedStreamStat == null || _viewModel.selectedStreamStat == "Select") {
                          anyDropdownNotSelected = true;
                        }
                        if (_viewModel.selectedCourseInterestedStat == null || _viewModel.selectedCourseInterestedStat == "Select") {
                          anyDropdownNotSelected = true;
                        }
                        if (_viewModel.selectedDistrictStat == null || _viewModel.selectedDistrictStat == "Select") {
                          anyDropdownNotSelected = true;
                        }

                        // Show error message if any dropdown is not selected
                        if (anyDropdownNotSelected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select all required fields.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          // If all dropdowns are selected, validate the form and submit
                          if (_viewModel.formKey.currentState!.validate()) {
                            _viewModel.submitData(context);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(visible : _viewModel.showProgressbar , child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
