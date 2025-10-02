import 'package:collection/collection.dart';

enum ThemeEnum {
  light(0),
  dark(1);

  final int id;

  const ThemeEnum(this.id);

  static ThemeEnum fromId(int id) =>
      values.firstWhereOrNull((element) => element.id == id) ?? ThemeEnum.light;
}
