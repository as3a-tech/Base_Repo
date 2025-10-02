import 'package:flutter/material.dart';

class CustomSelectItem<T> {
  final T value;
  final String name;
  final Widget? child;

  CustomSelectItem({required this.value, required this.name, this.child});
}

enum CustomSelectType { menu, dialog, bottomSheet }
