import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../helpers/extensions/context_extension.dart';
import '../../theme/color/app_colors.dart';
import '../../theme/text_style/app_text_styles.dart';
import '../custom_loading/custom_loading.dart';
import '../custom_text/custom_text.dart';
import 'custom_form_field.dart';
import 'custom_select_item.dart';

class CustomSelectField<T> extends StatefulWidget {
  final List<CustomSelectItem<T>> items;
  final T? initialValueSingle;
  final List<T> initialValueMulti;
  final FormFieldBorder formFieldBorder;
  final Color? unFocusColor;
  final Color? focusColor;
  final Color? fillColor;
  final double radius;
  final Widget? label;
  final String? labelText;
  final String? hintText;
  final TextStyle? hintStyle;
  final CustomSelectSearchSetting? searchSetting;
  final bool isLoading;
  final bool isMultiSelect;
  final CustomSelectType type;
  final String? Function(List<T>?)? validatorMulti;
  final void Function(List<T>)? onChangedMulti;
  final String? Function(T?)? validatorSingle;
  final void Function(T?)? onChangedSingle;
  const CustomSelectField({
    super.key,
    required this.items,
    this.formFieldBorder = FormFieldBorder.outLine,
    this.unFocusColor,
    this.focusColor,
    this.radius = 8,
    this.fillColor,
    this.label,
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.searchSetting,
    this.isLoading = false,
    this.initialValueSingle,
    this.isMultiSelect = false,
    this.initialValueMulti = const [],
    this.type = CustomSelectType.menu,
    this.validatorMulti,
    this.onChangedMulti,
    this.validatorSingle,
    this.onChangedSingle,
  });

  @override
  State<CustomSelectField<T>> createState() => _CustomSelectFieldState<T>();
}

class _CustomSelectFieldState<T> extends State<CustomSelectField<T>> {
  late CustomSelectSearchSetting _searchSetting;
  @override
  void initState() {
    _searchSetting = widget.searchSetting ?? CustomSelectSearchSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.isMultiSelect) {
      true => DropdownSearch<T>.multiSelection(
        selectedItems: widget.initialValueMulti,
        items:
            (filter, infiniteScrollProps) =>
                widget.items.map((e) => e.value).toList(),
        itemAsString:
            (item) =>
                widget.items.firstWhereOrNull((e) => e.value == item)?.name ??
                "",
        compareFn: (item1, item2) => item1 == item2,
        decoratorProps: _dropDownDecorator(),
        suffixProps: _dropDownSuffix(),
        popupProps: _popup(),
        onChanged: widget.onChangedMulti,
        validator: widget.validatorMulti,
      ),

      false => DropdownSearch<T>(
        selectedItem: widget.initialValueSingle,
        items:
            (filter, infiniteScrollProps) =>
                widget.items.map((e) => e.value).toList(),
        itemAsString:
            (item) =>
                widget.items.firstWhereOrNull((e) => e.value == item)?.name ??
                "",
        compareFn: (item1, item2) => item1 == item2,
        decoratorProps: _dropDownDecorator(),
        suffixProps: _dropDownSuffix(),
        popupProps: _popup(),
        onChanged: widget.onChangedSingle,
        validator: widget.validatorSingle,
      ),
    };
  }

  DropDownDecoratorProps _dropDownDecorator() {
    return DropDownDecoratorProps(
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
          formFieldBorder: widget.formFieldBorder,
          radius: widget.radius,
          color: widget.unFocusColor ?? AppColors.textFormBorderColor(context),
        ),
        disabledBorder: _border(
          formFieldBorder: widget.formFieldBorder,
          radius: widget.radius,
          color: widget.unFocusColor ?? AppColors.textFormBorderColor(context),
        ),
        focusedBorder: _border(
          formFieldBorder: widget.formFieldBorder,
          radius: widget.radius,
          color: widget.focusColor ?? AppColors.primary(context),
        ),
        enabledBorder: _border(
          formFieldBorder: widget.formFieldBorder,
          radius: widget.radius,
          color: widget.unFocusColor ?? AppColors.textFormBorderColor(context),
        ),
        errorBorder: _border(
          formFieldBorder: widget.formFieldBorder,
          radius: widget.radius,
          color: Colors.red.shade700,
        ),
        focusedErrorBorder: _border(
          formFieldBorder: widget.formFieldBorder,
          radius: widget.radius,
          color: Colors.red.shade700,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
      ),
    );
  }

  DropdownSuffixProps _dropDownSuffix() {
    return DropdownSuffixProps(
      dropdownButtonProps: DropdownButtonProps(
        iconOpened:
            widget.isLoading
                ? CustomLoading(size: 18)
                : const Icon(Icons.keyboard_arrow_down_rounded),
        iconClosed:
            widget.isLoading
                ? CustomLoading(size: 18)
                : const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }

  PopupPropsMultiSelection<T> _popup() {
    return switch (widget.type) {
      CustomSelectType.menu => _dropDownMulti(),

      CustomSelectType.dialog => _dialogMulti(),

      CustomSelectType.bottomSheet => _bottomSheetMulti(),
    };
  }

  PopupPropsMultiSelection<T> _dropDownMulti() {
    return PopupPropsMultiSelection.menu(
      showSearchBox: widget.items.length > 5 ? true : false,
      searchFieldProps: _searchField(),
      fit: FlexFit.loose,
      itemBuilder: (context, item, isDisabled, isSelected) {
        final e = widget.items.firstWhereOrNull((e) => e.value == item);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              e?.child ??
              CustomText(
                e?.name ?? "",
                style: AppTextStyles.text18_500(context),
              ),
        );
      },
      menuProps: MenuProps(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  PopupPropsMultiSelection<T> _dialogMulti() {
    return PopupPropsMultiSelection.dialog(
      showSearchBox: widget.items.length > 5 ? true : false,
      searchFieldProps: _searchField(),
      fit: FlexFit.loose,

      itemBuilder: (context, item, isDisabled, isSelected) {
        final e = widget.items.firstWhereOrNull((e) => e.value == item);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              e?.child ??
              CustomText(
                e?.name ?? "",
                style: AppTextStyles.text18_500(context),
              ),
        );
      },
      textDirection: context.isRTL() ? TextDirection.rtl : TextDirection.ltr,
      checkBoxBuilder:
          (context, item, isDisabled, isSelected) => Checkbox(
            activeColor: AppColors.primary(context),
            value: isSelected,
            onChanged: (v) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      dialogProps: DialogProps(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  PopupPropsMultiSelection<T> _bottomSheetMulti() {
    return PopupPropsMultiSelection.modalBottomSheet(
      showSearchBox: widget.items.length > 5 ? true : false,
      searchFieldProps: _searchField(),
      constraints: BoxConstraints(maxHeight: context.height() * 0.75),
      fit: FlexFit.loose,
      itemBuilder: (context, item, isDisabled, isSelected) {
        final e = widget.items.firstWhereOrNull((e) => e.value == item);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              e?.child ??
              CustomText(
                e?.name ?? "",
                style: AppTextStyles.text18_500(context),
              ),
        );
      },
      textDirection: context.isRTL() ? TextDirection.rtl : TextDirection.ltr,
      checkBoxBuilder:
          (context, item, isDisabled, isSelected) => Checkbox(
            activeColor: AppColors.primary(context),
            value: isSelected,
            onChanged: (v) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      modalBottomSheetProps: ModalBottomSheetProps(
        scrollControlDisabledMaxHeightRatio: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  TextFieldProps _searchField() {
    return TextFieldProps(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        hintText: _searchSetting.hintText,
        fillColor: _searchSetting.fillColor ?? AppColors.grey100(context),
        filled: true,
        border: _border(
          formFieldBorder: _searchSetting.formFieldBorder,
          radius: _searchSetting.radius,
          color:
              _searchSetting.unFocusColor ??
              AppColors.textFormBorderColor(context),
        ),
        disabledBorder: _border(
          formFieldBorder: _searchSetting.formFieldBorder,
          radius: _searchSetting.radius,
          color:
              _searchSetting.unFocusColor ??
              AppColors.textFormBorderColor(context),
        ),
        focusedBorder: _border(
          formFieldBorder: _searchSetting.formFieldBorder,
          radius: _searchSetting.radius,
          color: _searchSetting.focusColor ?? AppColors.primary(context),
        ),
        enabledBorder: _border(
          formFieldBorder: _searchSetting.formFieldBorder,
          radius: _searchSetting.radius,
          color:
              _searchSetting.unFocusColor ??
              AppColors.textFormBorderColor(context),
        ),
      ),
    );
  }
}

InputBorder _border({
  required FormFieldBorder formFieldBorder,
  required Color color,
  required double radius,
}) {
  switch (formFieldBorder) {
    case FormFieldBorder.outLine:
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
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

class CustomSelectSearchSetting {
  final FormFieldBorder formFieldBorder;
  final Color? unFocusColor;
  final Color? focusColor;
  final Color? fillColor;
  final double radius;
  final Widget? label;
  final String? labelText;
  final String hintText;
  final TextStyle? hintStyle;

  const CustomSelectSearchSetting({
    this.formFieldBorder = FormFieldBorder.outLine,
    this.unFocusColor,
    this.focusColor,
    this.radius = 8,
    this.fillColor,
    this.label,
    this.labelText,
    this.hintText = 'Search',
    this.hintStyle,
  });
}
