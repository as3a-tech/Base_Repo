import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final List<EasyRichTextPattern>? patternList;
  final TextStyle? style;
  final bool selectable;
  final int? maxLines;
  final TextOverflow overflow;
  final bool dotAll;
  final bool caseSensitive;
  final Locale? locale;
  final TextAlign textAlign;
  final TextDirection? textDirection;

  const CustomText(
    this.text, {
    super.key,
    this.patternList,
    this.style,
    this.selectable = true,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.dotAll = false,
    this.caseSensitive = true,
    this.locale,
    this.textAlign = TextAlign.start,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRichText(
      text,
      defaultStyle: style,
      patternList: patternList,
      selectable: selectable,
      maxLines: maxLines,
      overflow: overflow,
      dotAll: dotAll,
      caseSensitive: caseSensitive,
      locale: locale,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
