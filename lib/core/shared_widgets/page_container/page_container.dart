import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/extensions/context_extension.dart';
import '../../theme/color/app_colors.dart';

enum StatusBarTheme { light, dark }

class PageContainer extends StatelessWidget {
  final Widget child;
  final Color? statusBarColor;
  final Color statusBarForegroundColor;
  final StatusBarTheme? statusBarTheme;
  final bool top;
  final bool bottom;
  final bool right;
  final bool left;

  const PageContainer({
    super.key,
    required this.child,
    this.statusBarColor,
    this.statusBarForegroundColor = Colors.transparent,
    this.statusBarTheme,
    this.top = true,
    this.bottom = true,
    this.right = true,
    this.left = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: statusBarColor ?? AppColors.appBar(context),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: statusBarForegroundColor,
          statusBarIconBrightness: _android(
            statusBarTheme ??
                context.getByTheme(
                  light: StatusBarTheme.dark,
                  dark: StatusBarTheme.light,
                ),
          ),
          statusBarBrightness: _ios(
            statusBarTheme ??
                context.getByTheme(
                  light: StatusBarTheme.dark,
                  dark: StatusBarTheme.light,
                ),
          ),
        ),
        child: SafeArea(
          top: top,
          bottom: bottom,
          right: right,
          left: left,
          child: child,
        ),
      ),
    );
  }

  Brightness _android(StatusBarTheme statusBarTheme) {
    switch (statusBarTheme) {
      case StatusBarTheme.dark:
        return Brightness.dark;
      case StatusBarTheme.light:
        return Brightness.light;
    }
  }

  Brightness _ios(StatusBarTheme statusBarTheme) {
    switch (statusBarTheme) {
      case StatusBarTheme.dark:
        return Brightness.light;
      case StatusBarTheme.light:
        return Brightness.dark;
    }
  }
}
