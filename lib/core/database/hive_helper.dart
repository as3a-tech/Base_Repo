import 'package:hive/hive.dart';

import '../theme/enum/theme_enum.dart';
import 'hive_const.dart';

class HiveHelper {
  static final _box = Hive.box(HiveConst.appBox);

  static Future<void> updateTheme(ThemeEnum theme) async {
    await _box.put(HiveConst.theme, theme.id);
  }

  static ThemeEnum getTheme() {
    int themeId = _box.get(HiveConst.theme, defaultValue: ThemeEnum.light.id);
    return ThemeEnum.fromId(themeId);
  }

  static String getLang() {
    return '';
  }

  static String? getToken() {
    return '';
  }
}
