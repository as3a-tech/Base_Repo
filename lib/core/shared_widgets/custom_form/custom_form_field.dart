import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/countries/countries.dart';
import '../../helpers/extensions/context_extension.dart';
import '../../theme/color/app_colors.dart';
import '../../theme/text_style/app_text_styles.dart';
import '../buttons/custom_button.dart';

enum FormFieldBorder { underLine, outLine, none }

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? hintText;
  final int? maxLines;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final Color? fillColor;
  final Color? focusColor;
  final Color? unFocusColor;
  final Color? passwordColor;
  final String? title;
  final String? otherSideTitle;
  final ui.TextDirection? textDirection;
  final ui.TextDirection? inputTextDirection;
  final CountryCodeModel? country;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(CountryCodeModel)? onCountrySelect;
  final FormFieldBorder formFieldBorder;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? phonePickStyle;
  final TextStyle? hintStyle;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;
  final Widget? label;
  final String? labelText;
  final String? prefixIconSvg;
  final String? suffixIconSvg;
  final double? width;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  const CustomFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.hintText,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 8,
    this.fillColor,
    this.focusColor,
    this.unFocusColor,
    this.title,
    this.textDirection,
    this.inputTextDirection,
    this.otherSideTitle,
    this.country,
    this.passwordColor,
    this.formFieldBorder = FormFieldBorder.outLine,
    this.inputFormatters,
    this.onCountrySelect,
    this.titleStyle,
    this.textStyle,
    this.hintStyle,
    this.maxLength,
    this.autovalidateMode,
    this.phonePickStyle,
    this.label,
    this.labelText,
    this.prefixIconSvg,
    this.suffixIconSvg,
    this.width,
    this.textAlign = TextAlign.start,
    this.focusNode,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.title != null) ...{
              Expanded(
                child: Text(
                  widget.title!,
                  style:
                      widget.titleStyle ??
                      AppTextStyles.formTitleStyle(context),
                ),
              ),
            },
            if (widget.otherSideTitle != null) ...{
              Text(
                widget.otherSideTitle!,
                style:
                    widget.titleStyle ?? AppTextStyles.formTitleStyle(context),
              ),
            },
          ],
        ),

        Directionality(
          textDirection:
              widget.textDirection != null
                  ? widget.textDirection!
                  : context.isRTL()
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
          child: TextFormField(
            textDirection: widget.inputTextDirection,
            focusNode: widget.focusNode,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            controller: widget.controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword ? _obscureText : false,
            style: widget.textStyle ?? AppTextStyles.textFormStyle(context),
            autovalidateMode:
                widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
            maxLines: widget.maxLines,
            cursorColor: widget.focusColor ?? AppColors.primary(context),
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            textAlign: widget.textAlign,
            decoration: InputDecoration(
              label: widget.label,
              labelText: widget.labelText,
              hintMaxLines: 2,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? AppTextStyles.hintStyle(context),
              fillColor:
                  widget.fillColor ??
                  (widget.formFieldBorder == FormFieldBorder.underLine
                      ? Colors.transparent
                      : AppColors.textFormFill(context)),
              filled: true,
              border: _border(
                color:
                    widget.unFocusColor ??
                    AppColors.textFormBorderColor(context),
              ),
              disabledBorder: _border(
                color:
                    widget.unFocusColor ??
                    AppColors.textFormBorderColor(context),
              ),
              focusedBorder: _border(
                color: widget.focusColor ?? AppColors.primary(context),
              ),
              enabledBorder: _border(
                color:
                    widget.unFocusColor ??
                    AppColors.textFormBorderColor(context),
              ),
              errorBorder: _border(color: Colors.red.shade700),
              focusedErrorBorder: _border(color: Colors.red.shade700),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              prefixIcon:
                  widget.country != null && !context.isRTL()
                      ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (widget.prefixIcon ?? const SizedBox()),
                          _selectCountryBTN(),
                        ],
                      )
                      : widget.prefixIcon,
              suffixIcon:
                  widget.country != null && context.isRTL()
                      ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _selectCountryBTN(),
                          (widget.suffixIcon ?? const SizedBox()),
                        ],
                      )
                      : widget.isPassword
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          size: 20,
                          color:
                              widget.passwordColor ?? AppColors.hint(context),
                        ),
                      )
                      : widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }

  InputBorder _border({required Color color}) {
    switch (widget.formFieldBorder) {
      case FormFieldBorder.outLine:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: color),
        );
      case FormFieldBorder.underLine:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: color),
        );
      case FormFieldBorder.none:
        return InputBorder.none;
    }
  }

  void _select() {}

  Widget _selectCountryBTN() {
    return SizedBox(
      width: 110,
      child: Center(
        child: CustomButton(
          width: 90,
          height: 32,
          radius: 4,
          color: AppColors.grey100(context),
          onPressed: widget.onCountrySelect != null ? _select : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.country != null)
                widget.country!.buildFlagWidget(size: 18),
              Text(
                '${widget.country?.countryCode}',
                style:
                    widget.phonePickStyle ??
                    AppTextStyles.text14_400(
                      context,
                    ).copyWith(color: AppColors.textSecondary(context)),
                textDirection: ui.TextDirection.ltr,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textSecondary(context),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
