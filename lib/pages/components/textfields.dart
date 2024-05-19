import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.label, required this.placeholder, required this.controller});

  final String label;
  final String placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}