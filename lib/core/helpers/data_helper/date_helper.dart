import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../extensions/context_extension.dart';
import '../../data/localization/app_locale_key.dart';
import '../../routes/app_router.dart';
import '../../theme/color/app_colors.dart';
import '../../theme/text_style/app_text_styles.dart';
import '../pop_up_helper.dart';

class DateHelper {
  static Future<void> pickDate({
    required DateTime initialDate,
    required void Function(DateTime) onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
    Color? mainColor,
  }) async {
    PopUpHelper.showAppBottomSheet(
      Container(
        padding: const EdgeInsets.all(15),
        height: 400,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.popup(AppRouter.navigatorKey.currentContext!, false),
        ),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          initialSelectedDate: initialDate,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          selectionMode: DateRangePickerSelectionMode.single,
          selectionRadius: 8,
          selectionColor:
              mainColor ??
              AppColors.primary(AppRouter.navigatorKey.currentContext!, false),
          selectionTextStyle: AppTextStyles.text14_400(
            AppRouter.navigatorKey.currentContext!,
            false,
          ).copyWith(
            color: AppColors.white(
              AppRouter.navigatorKey.currentContext!,
              false,
            ),
          ),
          showActionButtons: true,
          confirmText: tr(AppLocaleKey.ok),
          cancelText: tr(AppLocaleKey.cancel),
          onCancel: () => AppRouter.pop(),

          onSubmit: (date) {
            AppRouter.pop();
            if (date != null) {
              final result = date as DateTime;
              onChanged.call(
                DateTime(result.year, result.month, result.day, 0, 0, 0),
              );
            }
          },
          minDate: firstDate ?? DateTime(2019, 1, 1),
          maxDate: lastDate ?? DateTime.now().add(Duration(days: 365)),
          monthCellStyle: DateRangePickerMonthCellStyle(
            todayCellDecoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary(
                  AppRouter.navigatorKey.currentContext!,
                  false,
                ),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppTextStyles.text14_400(
              AppRouter.navigatorKey.currentContext!,
              false,
            ).copyWith(
              color: AppColors.black(
                AppRouter.navigatorKey.currentContext!,
                false,
              ),
            ),
          ),
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: DateTime.sunday,
          ),
        ),
      ),
    );
  }

  static Future<void> pickRangeDate({
    required PickerDateRange initialRange,
    required void Function(PickerDateRange) onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
    Color? mainColor,
  }) async {
    PopUpHelper.showAppBottomSheet(
      Container(
        padding: const EdgeInsets.all(15),
        height: 400,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.popup(AppRouter.navigatorKey.currentContext!, false),
        ),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          initialSelectedRange: initialRange,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          selectionMode: DateRangePickerSelectionMode.range,
          selectionRadius: 8,
          selectionColor:
              mainColor ??
              AppColors.primary(AppRouter.navigatorKey.currentContext!, false),
          selectionTextStyle: AppTextStyles.text14_400(
            AppRouter.navigatorKey.currentContext!,
            false,
          ).copyWith(
            color: AppColors.white(
              AppRouter.navigatorKey.currentContext!,
              false,
            ),
          ),
          showActionButtons: true,
          confirmText: tr(AppLocaleKey.ok),
          cancelText: tr(AppLocaleKey.cancel),
          onCancel: () => AppRouter.pop(),
          onSubmit: (date) {
            AppRouter.pop();
            if (date != null) {
              final result = date as PickerDateRange;
              onChanged.call(
                PickerDateRange(
                  DateTime(
                    result.startDate!.year,
                    result.startDate!.month,
                    result.startDate!.day,
                    0,
                    0,
                    0,
                  ),
                  DateTime(
                    result.endDate!.year,
                    result.endDate!.month,
                    result.endDate!.day,
                    23,
                    59,
                    59,
                  ),
                ),
              );
            }
          },
          minDate: firstDate ?? DateTime(2019, 1, 1),
          maxDate: lastDate ?? DateTime.now().add(Duration(days: 365)),
          monthCellStyle: DateRangePickerMonthCellStyle(
            todayCellDecoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary(
                  AppRouter.navigatorKey.currentContext!,
                  false,
                ),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppTextStyles.text14_400(
              AppRouter.navigatorKey.currentContext!,
              false,
            ).copyWith(
              color: AppColors.black(
                AppRouter.navigatorKey.currentContext!,
                false,
              ),
            ),
          ),
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: DateTime.sunday,
          ),
        ),
      ),
    );
  }

  static Future<void> pickTime(
    BuildContext context, {
    required DateTime initialDate,
    required void Function(DateTime) onSuccess,
    Color? mainColor,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: initialDate.hour,
        minute: initialDate.minute,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
            data: ThemeData(fontFamily: context.fontFamily()).copyWith(
              colorScheme: ColorScheme.dark(
                primary: mainColor ?? AppColors.primary(context),
                secondary: mainColor ?? AppColors.primary(context),
                onPrimary: backgroundColor,
                surface: backgroundColor,
                onSurface: textColor,
              ),
              timePickerTheme: TimePickerThemeData(
                dayPeriodTextColor: WidgetStateColor.resolveWith(
                  (states) =>
                      states.contains(WidgetState.selected)
                          ? backgroundColor
                          : textColor,
                ),
              ),

              dialogTheme: DialogTheme(backgroundColor: backgroundColor),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: textColor),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      DateTime time = DateTime(0000, 00, 00, picked.hour, picked.minute);
      onSuccess.call(time);
    }
  }

  static DateTime? convertJsonDate(String? jsonDate) {
    if (jsonDate != null) {
      return DateTime.parse(jsonDate).toLocal();
    }
    return null;
  }
}
