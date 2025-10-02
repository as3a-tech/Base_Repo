import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../core/helpers/data_helper/date_helper.dart';
import '../../core/data/images/app_images.dart';
import '../../core/networking/app_urls.dart';
import '../../core/shared_widgets/buttons/custom_button.dart';
import '../../core/shared_widgets/buttons/custom_tab_btns.dart';
import '../../core/shared_widgets/custom_linear_slider/custom_linear_slider.dart';
import '../../core/shared_widgets/custom_media/custom_image.dart';
import '../../core/shared_widgets/custom_slider/custom_slider.dart';

class HomeArgs {
  int? id;
  String? name;

  HomeArgs({this.id, this.name});

  HomeArgs.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id?.toString();
    if (name != null) data['name'] = name;
    return data;
  }
}

class HomeScreen extends StatefulWidget {
  final HomeArgs args;
  const HomeScreen({super.key, required this.args});

  static const routeName = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          children: [
            CustomTabBtns(
              tabs: ['Tab 1', 'Tab 2'],
              selectedTab: _tab,
              onChanged: (v) {
                setState(() {
                  _tab = v;
                });
              },
            ),
            CustomSlider(
              sliderArguments: [
                SliderArguments(image: AppUrls.testAppleLogo),
                SliderArguments(image: AppUrls.testBlueCarImage),
                SliderArguments(image: AppUrls.testNoonLogo),
                SliderArguments(image: AppUrls.testCarLogoImage),
              ],
            ),
            CustomLinearSlider(value: 50, min: 0, max: 100),
            CustomButton(
              prefixIcon: CustomImage(
                image: AppImages.tickCircle,
                color: Colors.white,
              ),
              text: 'Pick Date',
              onPressed: () {
                DateHelper.pickRangeDate(
                  initialRange: PickerDateRange(
                    DateTime.now(),
                    DateTime.now().add(const Duration(days: 5)),
                  ),
                  onChanged: (v) {
                    log('Selected Date => ${v.startDate} - ${v.endDate}');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
