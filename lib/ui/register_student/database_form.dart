import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_search_field.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/responsive_builder.dart';
import '../../model/location_model.dart';
import '../../utils/app_text_style.dart';
import '../widget/drop_down.dart';
import 'database_form_mobile_ui.dart';
import 'database_form_viewmodel.dart';
import 'database_form_web_ui.dart';

class RegisterStudent extends StatefulWidget {
  const RegisterStudent({Key? key}) : super(key: key);

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  late RegisterStudentViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RegisterStudentViewModel>();
    return Form(
      key: _viewModel.formKey,
      child: ResponsiveBuilder(
        mobile: DataBaseFormMobileUI(
            viewModel: _viewModel, textFields: getTextFields(_viewModel)),
        desktop: DataBaseFormWebUI(
            viewModel: _viewModel, textFields: getTextFields(_viewModel)),
      ),
    );
  }

  List<dynamic> getTextFields(RegisterStudentViewModel _viewModel) {
    return [
      // CustomTextFormField(
      //   padding: TextFormFieldPadding.PaddingT16,
      //   title: "Email *",
      //   hintText: "Enter Email",
      //   controller: _viewModel.emailController,
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter your email address';
      //     }
      //     // Email regex pattern
      //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      //     if (!emailRegex.hasMatch(value.trim())) {
      //       return 'Please enter a valid email address';
      //     }
      //     return null; // Return null if the validation passes
      //   },
      // ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "College *",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: const ["Select","Both","Softvision", "GSB"],
            selectedItem: _viewModel.selectedCollageStat,
            onChanged: (value) {
              _viewModel.selectedCollageStat = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "Name of Student *",
        hintText: "Enter Name",
        onlyText: true,
        controller: _viewModel.studentNameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid name.';
          }
          return null;
        },
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender *",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: const ["Select", "Male", "Female"],
            selectedItem: _viewModel.selectedGenderStat,
            onChanged: (value) {
              _viewModel.selectedGenderStat = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),
      // CustomTextFormField(
      //     padding: TextFormFieldPadding.PaddingT16,
      //     title: "Mobile Number of Student *",
      //     hintText: "Enter Number",
      //     onlyNumber: true,
      //     maxLength: 10,
      //     controller: _viewModel.numberController,
      //     validator: (String? value) {
      //       if (value == null || value.isEmpty) {
      //         return 'Contact number is required';
      //       }
      //       if (value.length != 10) {
      //         return 'Please enter a valid 10-digit contact number';
      //       }
      //       return null;
      //     }
      // ),
      CustomTextFormField(
          padding: TextFormFieldPadding.PaddingT16,
          title: "WhatsApp Mobile Number of Student",
          hintText: "Enter Number",
          onlyNumber: true,
          maxLength: 10,
          controller: _viewModel.whatsAppNumberController,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Contact number is required';
            }
            if (value.length != 10) {
              return 'Please enter a valid 10-digit contact number';
            }
            return null;
          }),
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "Email ID of Student",
        hintText: "Enter Email",
        controller: _viewModel.emailIDOfStudentController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          // Email regex pattern
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value.trim())) {
            return 'Please enter a valid email address';
          }
          return null; // Return null if the validation passes
        },
      ),
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "Parent’s Name",
        hintText: "Enter Parent Name",
        onlyText: true,
        controller: _viewModel.fatherNameController,
        validator: (value) {
           return null;
         },
      ),
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "Parent's Mobile Number",
        hintText: "Enter Number",
        onlyNumber: true,
        maxLength: 10,
        controller: _viewModel.fatherNumberController,
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
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "School / College Name",
        hintText: "Enter School / College Name",
        onlyText: true,
        controller: _viewModel.schoolNameController,
        validator: (value) {
          return null;
        },
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Board/University",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: const [
              "Select",
              "CBSE",
              "ICSE/ISC",
              "M.P Board",
              "Open School",
              "DAVV",
              "Other than DAVV"
            ],
            selectedItem: _viewModel.selectedBoardStat,
            onChanged: (value) {
              _viewModel.selectedBoardStat = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stream/Graduation *",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: const [
              "Select",
              "PCM",
              "PCB",
              "Commerce(With Maths)",
              "Commerce(Without Maths)",
              "Arts",
              "Under Graduation completed / \nAppeared in Final Year",
              "Graduation Completed / \nFinal Year of College."
            ],
            selectedItem: _viewModel.selectedStreamStat,
            onChanged: (value) {
              _viewModel.selectedStreamStat = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "City *",
        hintText: "Enter City",
        controller: _viewModel.cityController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid City.';
          }
          return null;
        },
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course Interested in",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: const [
              "Select",
              "BBA Core",
              "BBA Foreign Trade",
              "BCOM Plain",
              "BCOM Honours",
              "BCOM Computer Application",
              "BCOM Taxation",
              "BCA",
              "BA (Psychology / Sociology / \nPolitical Science / Economics)",
              "BA LLB",
              "BBA LLA",
              "LLB Honours",
              "BSC Biotechnology",
              "BSC Microbiology",
              "BSC Life-science",
              "BSC Computer Science",
              "B.Voc. Fashion Technology",
              "Fashion Design Certification (3 yrs.)",
              "MBA",
              "MCOM",
              "PGDCA",
              "MSC Biotechnology",
              "MSC Microbiology",
              "MSC Pharmaceutical Chemistry",
              "MSC Bio Chemistry",
            ],
            selectedItem: _viewModel.selectedCourseInterestedStat,
            onChanged: (value) {
              _viewModel.selectedCourseInterestedStat = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "District *",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: _viewModel.districts,
            selectedItem: _viewModel.selectedDistrictStat,
            onChanged: (value) {
              _viewModel.selectedDistrictStat = value;
              _viewModel.districtController.text = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),

      /*CustomSearchField<LocationModel>(
       // padding: TextFormFieldPadding.PaddingT16,
        title: "District *",
        hintText: "Enter District",
        controller: _viewModel.districtController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid District.';
          }
          return null;
        },
        apiCall: (s) => _viewModel.getCityByName(s),
        displayField: (LocationModel locationModel) {
          return locationModel.cityName;
        },
        onSelected: (LocationModel locationModel) {
          _viewModel.selectLocation(locationModel);
        },
        deselectValue: () {
          _viewModel.deselectLocation();
        },
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Secondary Data Source",
            style: AppTextStyle.getHeadingStyle(),
          ),
          const SizedBox(height: 5),
          CustomDropDownWeb(
            items: const ["Christmas","Walk In","Education Fair - Savin Jain",],
            selectedItem: _viewModel.selectedSecondaryDataSourceStat,
            onChanged: (value) {
              _viewModel.selectedSecondaryDataSourceStat = value;
              _viewModel.notifyListeners();
            },
          ),
        ],
      ),*/
      CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "Comments",
        hintText: "Comments",
        controller: _viewModel.commentsController,
         validator: (value) {
           return null;
         },
      ),
      /*CustomTextFormField(
        padding: TextFormFieldPadding.PaddingT16,
        title: "Counselling Done By",
        hintText: "Counselling Done By",
        controller: _viewModel.counsellingDoneByController,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter a Counselling Done By.';
        //   }
        //   return null;
        // },
      ),*/
      // CustomTextFormField(
      //   isDatePicker: true,
      //   padding: TextFormFieldPadding.PaddingT16,
      //   title: "Date of Counselling",
      //   hintText: "Date of Counselling",
      //   controller: _viewModel.dateOfCounsellingController,
      //   // validator: (value) {
      //   //   if (value == null || value.isEmpty) {
      //   //     return 'Please enter a Date of Counselling.';
      //   //   }
      //   //   return null;
      //   // },
      // ),
    ];
  }
}
