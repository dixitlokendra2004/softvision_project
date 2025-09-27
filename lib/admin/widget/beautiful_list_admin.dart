import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softvision_project/ui/login/login.dart';
import 'package:softvision_project/uploadimage/upload_image.dart';
import 'package:softvision_project/utils/sp_helper.dart';

import '../activate_user/activate_user.dart';
import '../associate/associate_page.dart';
import '../display_student_data_admin/display_student_data_admin.dart';

class BeautifulListViewAdmin extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': "Activate / DeActivate User", 'iconPath': 'assets/icons/register.png'},
    {'title': 'Student List', 'iconPath': 'assets/icons/payout.png'},
    {'title': 'Upload Promo Image', 'iconPath': 'assets/icons/gallerygsb.png'},
    // {'title': 'Register for Event', 'iconPath': 'assets/icons/event.png'},
    // {'title': 'SV Gallery', 'iconPath': 'assets/icons/gallerysv.png'},
    // {'title': 'Check Payout', 'iconPath': 'assets/icons/payout.png'},
    // {'title': 'My Profile', 'iconPath': 'assets/icons/profile.png'},
    {'title': 'Associate', 'iconPath': 'assets/icons/logout.png'},
    {'title': 'Logout', 'iconPath': 'assets/icons/logout.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                /*leading: Image.asset(
                  items[index]['iconPath'],
                  width: 36,
                  height: 36,
                  //color: Colors.blue,
                ),*/
                title: Text(
                  items[index]['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //subtitle: Text('Subtitle here'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Handle item tap
                  switch(index){
                    case 0 : {
                      Get.to(() => ActivateUser());
                      break;
                    }
                    case 1 : {
                      Get.to(() => DisplayStudentDataAdmin(
                        studentName: "",
                        email: "",
                        number: "",
                        whatsAppNumber: "",
                        fatherName: "",
                        fatherNumber: "",
                        schoolName: "",
                        cityName: "",
                        emailIDOfStudent: "",
                        district: "",
                        comments: "",
                        counsellingDoneBy: "",
                        dateOfCounselling: "",
                      ));
                      break;
                    }
                    case 2 : {
                      Get.to(() => UploadImage());
                      break;
                    }
                    case 3 : {
                      Get.to(() => AssociatePage());
                      break;
                    }
                    case 4 : {
                      SharedPreferencesHelper.clearAll();
                      Get.offAll(() => const LoginPage());
                      break;
                    }
                    // case 3 : {
                    //   SharedPreferencesHelper.clearAll();
                    //   Get.offAll(() => LoginPage());
                    //   break;
                    // }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
  // checkMyLeads(BuildContext context) {
  //   Get.to(() => AssociatePage());
  // }
}
