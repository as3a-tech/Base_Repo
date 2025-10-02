import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../routes/app_router.dart';
import '../theme/color/app_colors.dart';
import '../shared_widgets/action_dialog/action_dialog.dart';
import '../shared_widgets/custom_loading/custom_loading.dart';
import 'responsive_helper.dart';

class PopUpHelper {
  static void showAppDialog(Widget dialog, {bool willPop = true}) {
    showDialog(
      context: AppRouter.navigatorKey.currentContext!,
      barrierDismissible: willPop,
      builder: (context) {
        return PopScope(canPop: willPop, child: dialog);
      },
    );
  }

  static void showActionDialog({
    required String title,
    String? subtitle,
    required ActionDialogType type,
    required void Function() onOk,
    void Function()? onBack,
    String? backText,
    String? saveText,
  }) {
    showAppDialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ActionDialog(
          title: title,
          onOk: onOk,
          type: type,
          backText: backText,
          onBack: onBack,
          saveText: saveText,
          subtitle: subtitle,
        ),
      ),
    );
  }

  static void showAppBottomSheet(
    Widget bottomSheet, {
    bool willPop = true,
    bool isScrollControlled = false,
    bool enableDrag = true,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: isScrollControlled,
      isDismissible: willPop,
      enableDrag: enableDrag,
      context: AppRouter.navigatorKey.currentContext!,
      builder: (context) {
        return PopScope(canPop: willPop, child: bottomSheet);
      },
    );
  }

  static void loading({
    double size = 60,
    double radius = 8,
    double loadingSize = 30,
    Color? backgroundColor,
    Color? loadingColor,
  }) {
    FocusScope.of(
      AppRouter.navigatorKey.currentContext!,
    ).requestFocus(FocusNode());
    BotToast.showCustomLoading(
      toastBuilder:
          (cancelFunc) => Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  AppColors.scaffold(AppRouter.navigatorKey.currentContext!),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(
              child: CustomLoading(
                color:
                    loadingColor ??
                    AppColors.primary(AppRouter.navigatorKey.currentContext!),
                size: loadingSize,
              ),
            ),
          ),
    );
  }

  static void loadingPercent({
    double size = 60,
    double radius = 8,
    Color? backgroundColor,
    bool isLiner = false,
  }) {
    FocusScope.of(
      AppRouter.navigatorKey.currentContext!,
    ).requestFocus(FocusNode());
    BotToast.showCustomLoading(
      toastBuilder:
          (cancelFunc) => Container(
            width: isLiner ? double.infinity : size,
            height: size,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  AppColors.scaffold(AppRouter.navigatorKey.currentContext!),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(child: CustomPercentLoading(isLiner: isLiner)),
          ),
    );
  }

  static void loadingOff() {
    BotToast.closeAllLoading();
  }

  static void showDrawerDialog({required Widget child}) {
    showDialog(
      context: AppRouter.navigatorKey.currentContext!,
      builder: (context) {
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: getValueByDeviceScreenType<double>(
              mobile: double.infinity,
              tablet: 500,
              desktop: 500,
            ),
            child: Center(
              child: Dialog(
                insetPadding: EdgeInsets.all(
                  getValueByDeviceScreenType<double>(
                    mobile: 0,
                    tablet: 24,
                    desktop: 24,
                  ),
                ),
                backgroundColor: AppColors.popup(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getValueByDeviceScreenType<double>(
                      mobile: 0,
                      tablet: 8,
                      desktop: 8,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
