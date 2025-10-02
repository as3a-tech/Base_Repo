import 'package:base_project/core/theme/color/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed, this.circleColor});
  final void Function()? onPressed;
  final Color? circleColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: CircleAvatar(
        backgroundColor: circleColor ?? Colors.transparent,
        radius: 20,
        child: Icon(Icons.arrow_back, color: AppColors.textPrimary(context)),
      ),
    );
  }
}
