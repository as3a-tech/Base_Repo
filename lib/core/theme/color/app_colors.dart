import 'package:flutter/material.dart';

import '../../helpers/extensions/context_extension.dart';

class AppColors {
  static Color primary(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff0270EB),
        dark: const Color(0xff0270EB),

        listen: listen,
      );
  static Color second(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffFAAB05),
        dark: const Color(0xffFAAB05),
        listen: listen,
      );
  static Color border(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF4F5F7),
        dark: const Color(0xffF4F5F7),
        listen: listen,
      );
  static Color scaffold(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF2F2F3),
        dark: const Color(0xffF2F2F3),
        listen: listen,
      );
  static Color appBar(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF2F2F3),
        dark: const Color(0xffF2F2F3),
        listen: listen,
      );
  static Color appBarText(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff1D1F2A),
        dark: const Color(0xff1D1F2A),
        listen: listen,
      );
  static Color hint(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff81828B),
        dark: const Color(0xff81828B),
        listen: listen,
      );
  static Color grey100(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffEDEDED),
        dark: const Color(0xffEDEDED),
        listen: listen,
      );
  static Color textPrimary(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff1D1F2A),
        dark: const Color(0xff1D1F2A),
        listen: listen,
      );
  static Color textSecondary(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff4F505B),
        dark: const Color(0xff4F505B),
        listen: listen,
      );
  static Color textTertiary(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff81828B),
        dark: const Color(0xff81828B),
        listen: listen,
      );
  static Color grey(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffBCBCBC),
        dark: const Color(0xffBCBCBC),
        listen: listen,
      );
  static Color grey50(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF8F9FA),
        dark: const Color(0xffF8F9FA),
        listen: listen,
      );

  static Color grey200(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffE8EAEE),
        dark: const Color(0xffE8EAEE),
        listen: listen,
      );
  static Color darkGrey(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff828282),
        dark: const Color(0xff828282),
        listen: listen,
      );

  static Color lightGrey(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffECECEC),
        dark: const Color(0xffECECEC),
        listen: listen,
      );

  static Color red50(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFFDEEEE),
        dark: const Color(0xFFFDEEEE),
        listen: listen,
      );
  static Color red600(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFD64F4F),
        dark: const Color(0xFFD64F4F),
        listen: listen,
      );

  static Color green50(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFEDFAF3),
        dark: const Color(0xFFEDFAF3),
        listen: listen,
      );
  static Color green600(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFF3BB774),
        dark: const Color(0xFF3BB774),
        listen: listen,
      );

  static Color black(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff000000),
        dark: const Color(0xff000000),
        listen: listen,
      );

  static Color white(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffffffff),
        dark: const Color(0xffffffff),
        listen: listen,
      );

  static Color offWhite(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF8F8F8),
        dark: const Color(0xffF8F8F8),
        listen: listen,
      );

  static Color textFormFill(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFFFFFFF),
        dark: const Color(0xFFFFFFFF),
        listen: listen,
      );

  static Color textFormBorderColor(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xFFFFFFFF),
    dark: const Color(0xFFFFFFFF),
    listen: listen,
  );

  static Color yellow50(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFFFF6E6),
        dark: const Color(0xFFFFF6E6),
        listen: listen,
      );
  static Color yellow600(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFE89900),
        dark: const Color(0xFFE89900),
        listen: listen,
      );

  static Color blue(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff5449F8),
        dark: const Color(0xff5449F8),
        listen: listen,
      );

  static Color textForm(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xff191C24),
        dark: const Color(0xff191C24),
        listen: listen,
      );

  static Color popup(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffffffff),
        dark: const Color(0xffffffff),
        listen: listen,
      );

  static Color buttonText(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffffffff),
        dark: const Color(0xffffffff),
        listen: listen,
      );

  static Color inActive(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xFFC4C5CE),
        dark: const Color(0xFFC4C5CE),
        listen: listen,
      );

  static Color searchField(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF3F6F8),
        dark: const Color(0xffF3F6F8),
        listen: listen,
      );
  static Color textDisabled(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffB3B4BC),
        dark: const Color(0xffB3B4BC),
        listen: listen,
      );
  static Color primary50(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffE6F1FD),
        dark: const Color(0xffE6F1FD),
        listen: listen,
      );
  static Color warning400(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffFBBF24),
        dark: const Color(0xffFBBF24),
        listen: listen,
      );
  static Color warning50(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffFFFAEB),
        dark: const Color(0xffFFFAEB),
        listen: listen,
      );

  static Color warning600(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffDC6803),
        dark: const Color(0xffDC6803),
        listen: listen,
      );
  static Color warning500(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF79009),
        dark: const Color(0xffF79009),
        listen: listen,
      );
  static Color systemError(BuildContext context, [bool listen = true]) =>
      context.getByTheme(
        light: const Color(0xffF97066),
        dark: const Color(0xffF97066),
        listen: listen,
      );
  static Color systemError100Color(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xffFEE4E2),
    dark: const Color(0xffFEE4E2),
    listen: listen,
  );

  static Color systemError600Color(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xffD92D20),
    dark: const Color(0xffD92D20),
    listen: listen,
  );
  static Color systemError500Color(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xffF04438),
    dark: const Color(0xffF04438),
    listen: listen,
  );
  static Color systemError300Color(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xffFDA29B),
    dark: const Color(0xffFDA29B),
    listen: listen,
  );
  static Color systemSuccess600Color(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xff039855),
    dark: const Color(0xff039855),
    listen: listen,
  );
  static Color systemSuccess50Color(
    BuildContext context, [
    bool listen = true,
  ]) => context.getByTheme(
    light: const Color(0xffECFDF3),
    dark: const Color(0xffECFDF3),
    listen: listen,
  );
}
