import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class CustomReqLabel extends StatelessWidget {
  final String title;
  const CustomReqLabel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return EasyRichText(
      '$title *',
      patternList: [
        EasyRichTextPattern(
          targetString: r'\*',
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
