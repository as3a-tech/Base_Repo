import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../helpers/extensions/context_extension.dart';
import '../../theme/color/app_colors.dart';
import '../../theme/text_style/app_text_styles.dart';

class CustomOtpField extends StatefulWidget {
  final int length;
  final TextEditingController? controller;
  final void Function(String)? onCompleted;
  const CustomOtpField({
    super.key,
    this.length = 4,
    this.controller,
    this.onCompleted,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Pinput(
          controller: widget.controller,
          defaultPinTheme: PinTheme(
            height: 63,
            width: 74,
            textStyle: AppTextStyles.otpStyle(context),
            decoration: BoxDecoration(
              color: AppColors.grey200(context),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          focusedPinTheme: PinTheme(
            height: 63,
            width: 74,
            textStyle: AppTextStyles.otpStyle(context),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary(context)),
              color: AppColors.textFormFill(context),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          submittedPinTheme: PinTheme(
            height: 63,
            width: 74,
            textStyle: AppTextStyles.otpStyle(context),
            decoration: BoxDecoration(
              color: AppColors.textFormFill(context),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          errorPinTheme: PinTheme(
            height: 63,
            width: 74,
            textStyle: AppTextStyles.otpStyle(context),
            decoration: BoxDecoration(
              color: AppColors.grey200(context),
              border: Border.all(color: Colors.red.shade700),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          errorBuilder: (errorText, pin) {
            return Align(
              alignment: context.getByLang(
                ar: AlignmentDirectional.centerEnd,
                en: AlignmentDirectional.centerStart,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  errorText!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
          validator: (s) {
            return s!.trim().length == widget.length
                ? null
                : context.apiTr(
                  ar: 'الكود مكون من ${widget.length} ارقام',
                  en: 'The code consists of ${widget.length} digits',
                );
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onCompleted: widget.onCompleted,
        ),
      ),
    );
  }
}
