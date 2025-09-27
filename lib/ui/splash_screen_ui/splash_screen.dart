import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softvision_project/ui/login/login.dart';
import '../../utils/util.dart';

class SplashScreenUI extends StatefulWidget {
  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAll(() => LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    Util.deviceHeight = MediaQuery.of(context).size.height;
    Util.deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 20,bottom: 20),
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            // Expanded(
            //   child: Image.asset(
            //     'assets/images/softvision_collage_image.png',
            //     fit: BoxFit.fill,
            //     width: 600,
            //   ),
            // ),
            Expanded(
              child: Image.asset(
                'assets/images/graduate_school_image.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const SizedBox(height: 20),
// Text(
// "Softvision Collage",
// style: AppTextStyle.getTextStyle18FontWeight400,
// ),
// const SizedBox(height: 50),
// Image.asset("assets/images/softvision_collage_image.png",width: 100,height: 100,),
// const SizedBox(height: 20),
// Text(
// "Graduate School of Business",
// style: AppTextStyle.getTextStyle18FontWeight400,
// ),
// const SizedBox(height: 50),
// Image.asset("assets/images/softvision_collage_image.png",width: 100,height: 100,),
// ],
// ),