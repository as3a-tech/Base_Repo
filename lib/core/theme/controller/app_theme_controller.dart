import 'package:flutter/material.dart';

import '../enum/theme_enum.dart';
import '../../database/hive_helper.dart';

class AppThemeController extends ChangeNotifier {
  AppThemeController() {
    _theme = HiveHelper.getTheme();
    notifyListeners();
  }

  late ThemeEnum _theme;
  set theme(ThemeEnum value) {
    _theme = value;
    HiveHelper.updateTheme(_theme);
    notifyListeners();
  }

  ThemeEnum get theme => _theme;
}
