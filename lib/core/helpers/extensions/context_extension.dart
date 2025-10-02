import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

import '../../theme/controller/app_theme_controller.dart';
import '../../theme/enum/theme_enum.dart';

extension ContextExtension on BuildContext {
  dynamic getByTheme({
    required dynamic light,
    required dynamic dark,
    bool listen = true,
  }) {
    switch (Provider.of<AppThemeController>(this, listen: listen).theme) {
      case ThemeEnum.light:
        return light;
      case ThemeEnum.dark:
        return dark;
    }
  }

  double width() => MediaQuery.sizeOf(this).width;

  double height() => MediaQuery.sizeOf(this).height;

  String fontFamily() =>
      apiTr(ar: 'IBMPlexSansArabic', en: 'IBMPlexSansArabic');
  String fontFamilyAr() => 'IBMPlexSansArabic';
  String fontFamilyEn() => 'IBMPlexSansArabic';

  String apiTr({required String ar, required String en}) {
    String text = '';
    switch (locale.languageCode) {
      case 'ar':
        text = ar;
        break;
      case 'en':
        text = en;
        break;
    }
    return text;
  }

  dynamic getByLang({required dynamic ar, required dynamic en}) {
    switch (locale.languageCode) {
      case 'ar':
        return ar;
      case 'en':
        return en;
    }
  }

  void doByLang({required VoidCallback ar, required VoidCallback en}) {
    switch (locale.languageCode) {
      case 'ar':
        ar.call();
        break;
      case 'en':
        en.call();
        break;
    }
  }

  bool isRTL() {
    return intl.Bidi.isRtlLanguage(locale.languageCode);
  }
}
