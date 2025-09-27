import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/ui/dashboard/dashboard.dart';
import 'package:softvision_project/ui/login/login.dart';
import 'package:softvision_project/utils/sp_helper.dart';
import 'package:softvision_project/utils/util.dart';

import 'admin/dashboard_admin/dashboard_admin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      String? email = await SharedPreferencesHelper.getEmail();
      if (email == "") {
        Get.offAll(() => LoginPage());
      } else {
        if (email == "admin@gmail.com") {
          Get.off(() => DashboardAdmin());
        } else {
          Get.off(() => const Dashboard());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Util.deviceHeight = MediaQuery.of(context).size.height;
    Util.deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 236, 236, 1),
        body: Container(
          // Set full screen size
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // Use DecorationImage to set the background image
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/splash.jpg'), // Change to your image path
              fit: BoxFit.cover,
            ),
          ),


          child: Image.asset(
              'assets/images/splash.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
        ));
  }
}
