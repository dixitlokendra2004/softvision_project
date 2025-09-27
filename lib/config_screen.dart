import 'package:softvision_project/splash_screen.dart';
import 'package:softvision_project/ui/dashboard/dashboard_viewmodel.dart';
import 'package:softvision_project/ui/display_student_data/data_display_viewmodel.dart';
import 'package:softvision_project/ui/landing_page/landing_viewmodel.dart';
import 'package:softvision_project/ui/login/login.dart';
import 'package:softvision_project/ui/login/login_viewModel.dart';
import 'package:softvision_project/ui/otp_verification_user/otp_verification_viewmodel.dart';
import 'package:softvision_project/ui/profile_page/profile_viewmodel.dart';
import 'package:softvision_project/ui/register_student/database_form_viewmodel.dart';
import 'package:softvision_project/ui/register_user/register_viewmodel.dart';
import 'package:softvision_project/ui/resets_password/email/email_viewmodel.dart';
import 'package:softvision_project/ui/resets_password/new_password/new_password_viewmodel.dart';
import 'package:softvision_project/ui/resets_password/otp_verifucation/otp_verification_viewmodel.dart';
import 'package:softvision_project/uploadimage/upload_image_viewmodel.dart';
import 'package:softvision_project/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'admin/activate_user/activate_user_viewmodel.dart';
import 'admin/admin_student_details/student_details_viewmodel.dart';
import 'admin/associate/associate_viewmodel.dart';
import 'admin/dashboard_admin/dashboard_admin_viewmodel.dart';
import 'admin/display_student_data_admin/display_student_data_admin_viewmodel.dart';
class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => LandingViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterStudentViewModel()),
        ChangeNotifierProvider(create: (_) => DataDisplayViewModel()),
        ChangeNotifierProvider(create: (_) => ProfilePageViewModel()),
        ChangeNotifierProvider(create: (_) => ResiterUserViewModel()),
        ChangeNotifierProvider(create: (_) => OtpVerificationUserViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterNewLeadAdminViewModel()),
        ChangeNotifierProvider(create: (_) => DisplayStudentDataShowAdminViewModel()),
        ChangeNotifierProvider(create: (_) => ActivateUserViewModel()),
        ChangeNotifierProvider(create: (_) => AdminStudentDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => EmailPageViewModel()),
        ChangeNotifierProvider(create: (_) => ResetOtpVerificationViewModel()),
        ChangeNotifierProvider(create: (_) => NewPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => UploadImageViewModel()),
        ChangeNotifierProvider(create: (_) => AssociatePageViewModel()),






      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: SplashScreen(),
        theme: ThemeData(
          primaryColor: Colors.blue,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            // Customize text styles using Montserrat font
            displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            // Add more text styles as needed
          ),
        ),
      ),
    );
  }
}