import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({super.key, required this.isDark, required this.text, required this.onTap});

  final bool isDark;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({super.key, required this.isDark, required this.text, required this.onTap, this.isBlock = false});

  final bool isDark;
  final String text;
  final VoidCallback onTap;
  final bool isBlock;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}