import 'dart:io';
import 'dart:ui';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';
import 'package:softvision_project/uploadimage/upload_image_viewmodel.dart';

import '../constants.dart';
import '../utils/app_text_style.dart';
import 'package:image/image.dart' as img;
class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  late UploadImageViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.fetchData();
    });
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // Read the image file
    File imageFile = File(pickedFile!.path);
    List<int> imageBytes = await imageFile.readAsBytes();

    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);
    if (image != null) {
      // Resize the image to reduce its dimensions
      img.Image resizedImage = img.copyResize(
          image,  width : 800); // Adjust the width as needed

      // Convert the resized image to bytes
      List<int> resizedImageBytes = img.encodeJpg(
          resizedImage, quality: 80); // Adjust the quality as needed

      // Save the resized image to a new file
      File resizedImageFile = await File(
          '${imageFile.parent.path}/resized_${imageFile.path
              .split('/')
              .last}').writeAsBytes(resizedImageBytes);

      // Upload the resized image file to PHP


      if (pickedFile != null) {
        setState(() {
          _viewModel.uploading = true; // Start uploading
        });
        // Upload the image file to PHP
        uploadImageToPhp(resizedImageFile.path);
        setState(() {
          _viewModel.uploading = false; // Stop uploading
        });
      } else {
        print('No image selected.');
      }
    }
  }
  Future<void> uploadImageToPhp(String imagePath) async {
    _viewModel.showProgressbar = true;
    _viewModel.refreshUI();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://silicon-technologies.co.in/softvision/upload.php'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      String dialogText =
          "Image uploaded successfully";
      Fluttertoast.showToast(
          msg: dialogText,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _viewModel.fetchData();
    } else {
      String dialogText = "Failed to upload image";
      Fluttertoast.showToast(
          msg: dialogText,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print('Failed to upload image');
    }
    _viewModel.showProgressbar = false;
    _viewModel.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UploadImageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Image",
          style: AppTextStyle.getTextStyle16FontWeight500,
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
        Column(
          children: [
            const SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16/9,
                autoPlay: false, // Disable auto-play
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _viewModel.currentIndex = index; // Update current index
                  });
                },
              ),
              items: _viewModel.imgList.map((image) {
                print(BASE_URL+"/"+image.imageName);
                return  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                    image: DecorationImage(
                      image: NetworkImage(BASE_URL+"/"+image.imageName),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            //Text('Selected index: $_currentIndex'), // Display current index
            SizedBox(height: 30.Sh,),
            ElevatedButton(
              onPressed: () {
                _viewModel.updateImageInfo(_viewModel.imgList[_viewModel.currentIndex].id.toString());
              },
              child: Text('Remove the selected Image'),
            ),
            SizedBox(height: 30.Sh,),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Upload New Image'),
            ),
          ],
        ),
          Visibility(
            visible: _viewModel.showProgressbar,
            child: const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                )),),
       ],
      ),
    );
  }
}
