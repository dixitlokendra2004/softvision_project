import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';

import '../widget/beautiful_list_admin.dart';
import 'dashboard_admin_viewmodel.dart';

class DashboardAdmin extends StatefulWidget {
  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  late RegisterNewLeadAdminViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RegisterNewLeadAdminViewModel>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              // ClipRRect(
              //     borderRadius: BorderRadius.circular(10), // Rounded corners
              //     child: Container(
              //       height: 250.Sh,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.white.withOpacity(0.0), // Shadow color
              //             spreadRadius: 1,
              //             blurRadius: 1,
              //             offset: Offset(0, 1), // Shadow position
              //           ),
              //         ],
              //       ),
              //       child: Image.asset('assets/images/campus.jpeg',
              //           height: 250, fit: BoxFit.fill // Adjusted height
              //           ),
              //     )),

              Container(
                margin: EdgeInsets.only(top: 80.Sh),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/combinedlogo.png', // Replace with your image path
                  width: 280.Sw,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.Sw, top: 30.Sh),
                child: Text(
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(child: BeautifulListViewAdmin()),
        ],
      ),
    );
  }
}