import 'package:flutter/material.dart';

import '../../theme/color/app_colors.dart';
import '../../theme/text_style/app_text_styles.dart';
import 'custom_button.dart';

class CustomTabBtns extends StatelessWidget {
  final List<String> tabs;
  final int selectedTab;
  final void Function(int)? onChanged;
  const CustomTabBtns({
    super.key,
    required this.tabs,
    required this.selectedTab,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: List.generate(
        tabs.length,
        (i) => Expanded(
          child: CustomButton(
            height: 40,
            text: tabs[i],
            hasShadow: selectedTab == i,
            color:
                selectedTab == i
                    ? AppColors.white(context)
                    : Colors.transparent,
            style: AppTextStyles.buttonStyle(context).copyWith(
              color:
                  selectedTab == i
                      ? AppColors.primary(context)
                      : AppColors.textDisabled(context),
            ),
            onPressed: selectedTab == i ? null : () => onChanged?.call(i),
          ),
        ),
      ),
    );
  }
}
