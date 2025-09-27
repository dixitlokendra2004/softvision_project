import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softvision_project/ui/display_student_data/data_display.dart';
import 'package:softvision_project/ui/login/login.dart';
import 'package:softvision_project/ui/profile_page/profile_page.dart';
import 'package:softvision_project/utils/sp_helper.dart';

import '../ui/register_student/database_form.dart';

class BeautifulListView extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': 'Register New Lead', 'iconPath': 'assets/icons/register.png'},
    {'title': 'Check My Leads', 'iconPath': 'assets/icons/lead.png'},
    // {'title': 'GSB Gallery', 'iconPath': 'assets/icons/gallerygsb.png'},
    // {'title': 'Register for Event', 'iconPath': 'assets/icons/event.png'},
    // {'title': 'SV Gallery', 'iconPath': 'assets/icons/gallerysv.png'},
    // {'title': 'Check Payout', 'iconPath': 'assets/icons/payout.png'},
    {'title': 'My Profile', 'iconPath': 'assets/icons/profile.png'},
    {'title': 'Logout', 'iconPath': 'assets/icons/logout.png'},
  ];

  BeautifulListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                leading: Image.asset(
                  items[index]['iconPath'],
                  width: 36,
                  height: 36,
                  //color: Colors.blue,
                ),
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
                      Get.to(() => const RegisterStudent());
                      break;
                    }
                    case 1 : {
                      checkMyLeads(context);
                      break;
                    }
                    case 2 : {
                      Get.to(() => const ProfilePage());
                      break;
                    }
                    case 3 : {
                      SharedPreferencesHelper.clearAll();
                      Get.offAll(() => const LoginPage());
                      break;
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
  checkMyLeads(BuildContext context) {
    Get.to(() => DataDisplay(
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
  }
}
