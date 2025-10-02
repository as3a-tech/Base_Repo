import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../helpers/responsive_helper.dart';
import '../../data/images/app_images.dart';
import '../../data/localization/app_locale_key.dart';
import '../../routes/app_router.dart';
import '../../theme/color/app_colors.dart';
import '../../theme/text_style/app_text_styles.dart';
import '../buttons/custom_button.dart';
import '../custom_media/custom_image.dart';

class ActionDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final ActionDialogType type;
  final void Function() onOk;
  final void Function()? onBack;
  final String? backText;
  final String? saveText;
  const ActionDialog({
    super.key,
    this.subtitle,
    required this.title,
    required this.onOk,
    required this.type,
    this.backText,
    this.saveText,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getValueByDeviceScreenType<double>(
        mobile: double.infinity,
        tablet: 500,
        desktop: 500,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.popup(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: type.lightColor(context),
            ),
            padding: const EdgeInsets.all(12),
            child: CustomImage(
              image: type.headIcon(),
              color: type.darkColor(context),
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.text20_500(
              context,
            ).copyWith(color: AppColors.textPrimary(context)),
          ),
          if (subtitle != null) ...{
            const SizedBox(height: 12),
            Text(
              subtitle!,
              style: AppTextStyles.text16_400(
                context,
              ).copyWith(color: AppColors.textSecondary(context)),
            ),
          },

          const SizedBox(height: 32),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomButton(
                  color: type.darkColor(context),
                  onPressed: () {
                    AppRouter.pop();
                    onOk.call();
                  },
                  text: saveText ?? AppLocaleKey.confirm.tr(),
                  style: AppTextStyles.buttonStyle(
                    context,
                  ).copyWith(color: AppColors.white(context)),
                ),
              ),
              Expanded(
                child: CustomButton(
                  color: type.lightColor(context),
                  onPressed: () {
                    AppRouter.pop();
                    onBack?.call();
                  },
                  text: backText ?? AppLocaleKey.cancel.tr(),
                  style: AppTextStyles.buttonStyle(
                    context,
                  ).copyWith(color: AppColors.darkGrey(context)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum ActionDialogType {
  fail,
  warning,
  success;

  headIcon() {
    switch (this) {
      case ActionDialogType.fail:
        return AppImages.danger;
      case ActionDialogType.warning:
        return AppImages.danger;
      case ActionDialogType.success:
        return AppImages.tickCircle;
    }
  }

  lightColor(BuildContext context) {
    switch (this) {
      case ActionDialogType.fail:
        return AppColors.red50(context);
      case ActionDialogType.warning:
        return AppColors.yellow50(context);
      case ActionDialogType.success:
        return AppColors.green50(context);
    }
  }

  darkColor(BuildContext context) {
    switch (this) {
      case ActionDialogType.fail:
        return AppColors.red600(context);
      case ActionDialogType.warning:
        return AppColors.yellow600(context);
      case ActionDialogType.success:
        return AppColors.green600(context);
    }
  }
}
