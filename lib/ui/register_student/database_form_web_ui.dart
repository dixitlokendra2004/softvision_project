import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/responsive_form.dart';
import '../../utils/app_text_style.dart';
import '../widget/button_widget.dart';
import '../widget/drop_down.dart';
import 'database_form_viewmodel.dart';

class DataBaseFormWebUI extends StatefulWidget {

  RegisterStudentViewModel viewModel;
  List<dynamic> textFields;
  DataBaseFormWebUI({Key? key,required this.viewModel,required this.textFields}) : super(key: key);

  @override
  State<DataBaseFormWebUI> createState() => _DataBaseFormWebUIState();
}

class _DataBaseFormWebUIState extends State<DataBaseFormWebUI> {
  late RegisterStudentViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RegisterStudentViewModel>();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20,right: 15,top: 20,bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ResponsiveFormWidget(textFields: widget.textFields),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: ButtonWebWidget(
                  title: "Submit",
                  titleColor: Colors.white,
                  titleFontSize: 15,
                  color: Colors.white,
                  onTap: () {
                    if (_viewModel.formKey.currentState!.validate()) {
                      _viewModel.submitData(context);
                    }
                  },
                  borderRadius: 10,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// SingleChildScrollView(
// child:  Column(
// children: [
// ResponsiveFormWidget(textFields: widget.textFields),
// ],
// ),
// ),