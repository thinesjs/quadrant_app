import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class SideSectionText extends StatelessWidget {
  SideSectionText({
    Key? key, required this.isDark, required this.text, this.size = 14, this.bold = false
  }) : super(key: key);

  bool isDark;
  double size;
  bool bold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: isDark ? CustomColors.primaryDark : CustomColors.primaryLight,
      ),
    );
  }
}