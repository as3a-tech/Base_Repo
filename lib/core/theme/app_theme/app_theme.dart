import 'package:flutter/material.dart';

import '../../helpers/extensions/context_extension.dart';
import '../color/app_colors.dart';
import '../text_style/app_text_styles.dart';

ThemeData appThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.primary(context),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    hintColor: AppColors.hint(context),
    brightness: context.getByTheme(
      light: Brightness.light,
      dark: Brightness.dark,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary(context),
      alignedDropdown: true,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary(context),
      secondary: AppColors.second(context),
      surface: AppColors.white(context),
      brightness: context.getByTheme(
        light: Brightness.light,
        dark: Brightness.dark,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.appBar(context),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.appBarStyle(context),
    ),
    scaffoldBackgroundColor: AppColors.scaffold(context),
    fontFamily: context.fontFamily(),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary(context),
    ),
    platform: TargetPlatform.iOS,
  );
}
