import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../theme/color/app_colors.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final Color? color;
  const CustomLoading({super.key, this.size = 35, this.color});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
      color: color ?? AppColors.primary(context),
      secondRingColor: color ?? AppColors.primary(context),
      thirdRingColor: color ?? AppColors.primary(context),
      size: size,
    );
  }
}

class CustomPercentLoading extends StatelessWidget {
  final bool isLiner;
  const CustomPercentLoading({super.key, this.isLiner = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<PercentLoadingController>(
      builder: (context, cont, _) {
        switch (isLiner) {
          case true:
            return LinearProgressIndicator(
              color: AppColors.primary(context),
              backgroundColor: AppColors.primary(
                context,
              ).withValues(alpha: 0.2),
              value: cont.percent / 100,
            );
          case false:
            return CircularProgressIndicator(
              color: AppColors.primary(context),
              value: cont.percent / 100,
            );
        }
      },
    );
  }
}

class PercentLoadingController extends ChangeNotifier {
  double _percent = 0.0;
  double get percent => _percent;
  set percent(double value) {
    _percent = value;
    log("percent => $_percent");
    notifyListeners();
  }
}
