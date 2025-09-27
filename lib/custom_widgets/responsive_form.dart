import 'package:flutter/material.dart';
import 'package:softvision_project/custom_widgets/responsive_builder.dart';


import '../utils/util.dart';

class ResponsiveFormWidget extends StatefulWidget {
  List<dynamic> textFields;

  ResponsiveFormWidget({super.key, required this.textFields});

  @override
  State<ResponsiveFormWidget> createState() => _ResponsiveFormWidgetState();
}

class _ResponsiveFormWidgetState extends State<ResponsiveFormWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: widget.textFields
            .map(
              (e) => Container(
            margin: getPadding(top: 8, bottom: 8),
            child: e,
          ),
        )
            .toList(),
      ),
      desktop: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildDesktopRows(),
      ),
    );
  }

  List<Widget> _buildDesktopRows() {
    List<Widget> rows = [];
    for (int i = 0; i < widget.textFields.length; i += 3) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < 3 && i + j < widget.textFields.length; j++) {
        rowChildren.add(
          Expanded(
            child: Container(
              padding: getPadding(top: 4, bottom: 4, right: (j != 2) ? 16 : 0),
              child: (widget.textFields[i + j] as Widget),
            ),
          ),
        );
      }
      if (rowChildren.length < 3) {
        rowChildren
            .addAll(List.generate(3 - rowChildren.length, (index) => Spacer()));
      }
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ),
      ));
    }
    return rows;
  }

// List<Widget> _buildDesktopRows() {
//   List<Widget> rows = [];
//   for (int i = 0; i < widget.textFields.length; i += 3) {
//     List<Widget> rowChildren = [];
//     for (int j = 0; j < 3 && i + j < widget.textFields.length; j++) {
//       rowChildren.add(
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
//             child: widget.textFields[i + j],
//           ),
//         ),
//       );
//     }
//     rows.add(Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: rowChildren,
//       ),
//     ));
//   }
//   return rows;
// }
}
