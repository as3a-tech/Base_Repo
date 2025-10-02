import 'package:base_project/core/helpers/extensions/string_extension.dart';
import 'package:base_project/core/routes/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime? {
  DateTime? toStartOfDay() {
    final date = this;
    if (date != null) {
      return DateTime(date.year, date.month, date.day);
    }
    return null;
  }

  DateTime? toEndOfDay() {
    final date = this;
    if (date != null) {
      return DateTime(date.year, date.month, date.day, 23, 59, 59);
    }
    return null;
  }

  bool isSameDay(DateTime? other) {
    final date = this;
    if (date != null && other != null) {
      return date.year == other.year &&
          date.month == other.month &&
          date.day == other.day;
    }
    return false;
  }

  bool isAfterOrEqualTo(DateTime other) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = other.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(other);
    }
    return false;
  }

  bool isBeforeOrEqualTo(DateTime other) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = other.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(other);
    }
    return false;
  }

  bool isBetween(DateTime from, DateTime to) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(from);
      final isBefore = date.isBeforeOrEqualTo(to);
      return isAfter && isBefore;
    }
    return false;
  }

  String formate({String? format}) {
    final date = this;
    if (date != null) {
      return DateFormat(
        format ?? 'dd MMMM yyyy - hh:mm a',
        AppRouter.navigatorKey.currentContext!.locale.languageCode,
      ).format(date).toArabicNumbers();
    }
    return '';
  }

  String timeAgo({bool isShort = false}) {
    final date = this;
    if (date != null) {
      return timeago
          .format(
            date,
            locale:
                isShort
                    ? '${AppRouter.navigatorKey.currentContext!.locale.languageCode}_short'
                    : AppRouter
                        .navigatorKey
                        .currentContext!
                        .locale
                        .languageCode,
          )
          .toArabicNumbers();
    }
    return '';
  }
}
