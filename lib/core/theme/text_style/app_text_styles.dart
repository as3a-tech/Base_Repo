import 'package:flutter/widgets.dart';

import '../../helpers/extensions/context_extension.dart';
import '../color/app_colors.dart';

class AppTextStyles {
  static TextStyle appBarStyle(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.appBar(context, listen),
        fontFamily: context.fontFamily(),
      );

  static TextStyle buttonStyle(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.buttonText(context, listen),
      );

  static TextStyle hintStyle(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.hint(context, listen),
      );

  static TextStyle textFormStyle(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textForm(context, listen),
      );

  static TextStyle formTitleStyle(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );

  static TextStyle otpStyle(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.primary(context, listen),
      );

  static TextStyle text20_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text14_400(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary(context, listen),
      );

  static TextStyle text14_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );

  static TextStyle text18_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text18_600(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text16_600(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text16_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text16_400(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary(context, listen),
      );

  static TextStyle text11_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text12_400(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text12_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text10_400(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text12_600(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text14_600(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text10_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
  static TextStyle text24_500(BuildContext context, [bool listen = true]) =>
      TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary(context, listen),
      );
}
