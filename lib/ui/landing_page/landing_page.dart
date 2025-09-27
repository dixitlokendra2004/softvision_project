import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/utils/app_decoration.dart';

import '../../utils/app_text_style.dart';
import 'landing_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_text_style.dart';
import 'landing_viewmodel.dart';

import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late LandingViewModel _viewModel;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<LandingViewModel>();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: 300,
        decoration: AppBoxDecoration.getSideBarDecoration(),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _showAddDialog(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey,
              height: 10,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: ListView.builder(
                  itemCount: _viewModel.lists.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Text(
                        _viewModel.lists[index],
                        style: AppTextStyle.getTextStyle22FontWeight500,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Screen Name'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          content: TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Enter",
              hintStyle: const TextStyle(color: Color(0xff94A3B8)),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: AppTextStyle.getTextStyle18FontWeight400,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _viewModel.lists.add(_textController.text); // Add new list of names
                  _textController.text = "";
                });
                Get.back(); // Close the dialog
              },
              child: Text(
                'OK',
                style: AppTextStyle.getTextStyle18FontWeight400,
              ),
            ),
          ],
        );
      },
    );
  }
}
