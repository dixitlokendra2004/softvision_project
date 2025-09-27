import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softvision_project/size_ext.dart';

import '../../constants.dart';
import '../../custom_widgets/beautiful_list.dart';
import 'dashboard_viewmodel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel?.fetchData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      body: Stack(children: [
        CarouselSlider(
            items: _viewModel?.imgList.map((image) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  image: DecorationImage(
                    image: NetworkImage(BASE_URL+"/"+image.imageName),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 400.Sh,
              aspectRatio: 1 / 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 380.Sh, right : 10.Sw, left: 10.Sw),
              decoration: BoxDecoration(
                color: Color(0XFFF7F7F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.only(top: 30.Sh),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/combinedlogo.png', // Replace with your image path
                width: 280.Sw,
              ),
            ),
            Flexible(
                child: Container(
                    color: Color(0XFFF7F7F7),
                    child: BeautifulListView())),
          ],
        ),
        Visibility(
          visible: _viewModel!.showProgressbar,
          child: const Center(
              child: Center(
                child: CircularProgressIndicator(),
              )),),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
