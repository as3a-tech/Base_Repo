import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../theme/color/app_colors.dart';
import '../custom_media/custom_image.dart';

class SliderArguments {
  String? image;
  Widget? child;
  void Function()? onTap;
  SliderArguments({this.image, this.child, this.onTap});
}

class CustomSlider extends StatefulWidget {
  final List<SliderArguments> sliderArguments;
  final bool autoPlay;
  final bool hasDots;
  final bool isDotsOnContent;
  final double aspectRatio;
  final double radius;
  final BoxFit fit;

  const CustomSlider({
    super.key,
    required this.sliderArguments,
    this.autoPlay = true,
    this.hasDots = true,
    this.isDotsOnContent = true,
    this.aspectRatio = 333 / 158,
    this.radius = 12,
    this.fit = BoxFit.cover,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _index = 0;
  late CarouselSliderController _carouselController;
  @override
  void initState() {
    _carouselController = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items:
              widget.sliderArguments.map((item) {
                return GestureDetector(
                  onTap: item.onTap,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: widget.isDotsOnContent ? 0.0 : 20.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.white(context),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    child:
                        item.child ??
                        CustomImage(
                          radius: widget.radius,
                          image: item.image ?? "",
                          width: double.infinity,
                          height: 190,
                          fit: widget.fit,
                        ),
                  ),
                );
              }).toList(),
          options: CarouselOptions(
            aspectRatio: widget.aspectRatio,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            autoPlay: widget.autoPlay,
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (i, _) {
              setState(() {
                _index = i;
              });
            },
          ),
        ),
        if (widget.hasDots) ...{
          Positioned(
            bottom: 7,
            right: 0,
            left: 0,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: AnimatedSmoothIndicator(
                  activeIndex: _index,
                  count: widget.sliderArguments.length,
                  effect: ExpandingDotsEffect(
                    dotColor: AppColors.grey(context),
                    activeDotColor: AppColors.primary(context),
                    dotHeight: 7,
                    dotWidth: 7,
                  ),
                  onDotClicked: (i) {
                    _carouselController.animateToPage(i);
                  },
                ),
              ),
            ),
          ),
        },
      ],
    );
  }
}
