import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/utils/app_text_style.dart';
import '../login/login.dart';


class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.only(top: 80.Sh),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/combinedlogo.png', // Replace with your image path
              width: 280.Sw,
            ),
          ),
          const SizedBox(height: 25),
          Container(
              margin: EdgeInsets.all(20.Sw),
              child:  Text("You have been successfully registered. Our Admission coordinators shall review and approve your registration soon.  For any queries you may reach out to us on the numbers \n\n9109199488, \n9109185825.",
              style: AppTextStyle.getTextStyle14FontWeight500)),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //subtitle: Text('Subtitle here'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                      Get.offAll(() => const LoginPage());
                },
              ),
            ),
          )

        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
