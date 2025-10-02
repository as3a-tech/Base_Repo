import 'package:flutter/material.dart';

late DeviceScreenType _deviceScreenType;

void updateDeviceScreenType(BoxConstraints constraints) {
  if (constraints.maxWidth >= DeviceScreenType.desktop.breakPoint) {
    _deviceScreenType = DeviceScreenType.desktop;
  } else if (constraints.maxWidth >= DeviceScreenType.tablet.breakPoint) {
    _deviceScreenType = DeviceScreenType.tablet;
  } else {
    _deviceScreenType = DeviceScreenType.mobile;
  }
}

enum DeviceScreenType {
  mobile(0.0),
  tablet(980.0),
  desktop(1366.0);

  final double breakPoint;

  const DeviceScreenType(this.breakPoint);

  static bool get isDesktop => _deviceScreenType == DeviceScreenType.desktop;
  static bool get isTablet => _deviceScreenType == DeviceScreenType.tablet;
  static bool get isMobile => _deviceScreenType == DeviceScreenType.mobile;
}

T getValueByDeviceScreenType<T>({
  required T mobile,
  T? tablet,
  T? desktop,
}) {
  return switch (_deviceScreenType) {
    DeviceScreenType.mobile => mobile,
    DeviceScreenType.tablet => tablet ?? mobile,
    DeviceScreenType.desktop => desktop ?? tablet ?? mobile,
  };
}

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return switch (_deviceScreenType) {
      DeviceScreenType.mobile => mobile,
      DeviceScreenType.tablet => tablet ?? mobile,
      DeviceScreenType.desktop => desktop ?? tablet ?? mobile,
    };
  }
}
