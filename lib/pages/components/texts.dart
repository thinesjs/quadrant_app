import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class SectionText extends StatelessWidget {
  const SectionText({super.key, 
    required this.isDark, required this.text, this.size = 14, this.bold = false
  });

  final bool isDark;
  final double size;
  final bool bold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class SideSectionText extends StatelessWidget {
  const SideSectionText({super.key, 
    required this.isDark, required this.text, this.size = 14, this.bold = false, this.onTap
  });

  final bool isDark;
  final double size;
  final bool bold;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: isDark ? CustomColors.primaryDark : CustomColors.primaryLight,
        ),
      ),
    );
  }
}