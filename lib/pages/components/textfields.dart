import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.label,
      required this.placeholder,
      required this.controller, required this.isDark});

  final bool isDark;
  final String label;
  final String placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: isDark ? CustomColors.placeholderTextColorDark : CustomColors.placeholderTextColorLight),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(CustomSizes.cardRadiusMd)),
                borderSide: BorderSide(color: isDark ? CustomColors.outlinedButtonColorDark : CustomColors.outlinedButtonColorLight, width: 1.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(CustomSizes.cardRadiusMd)),
                borderSide: BorderSide(color: CustomColors.primaryDark, width: 2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppLargeTextField extends StatelessWidget {
  const AppLargeTextField(
      {super.key,
      required this.label,
      required this.placeholder,
      required this.controller});

  final String label;
  final String placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),),
          ),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: isDark ? CustomColors.placeholderTextColorDark : CustomColors.placeholderTextColorLight),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(CustomSizes.cardRadiusMd)),
                borderSide: BorderSide(color: isDark ? CustomColors.outlinedButtonColorDark : CustomColors.outlinedButtonColorLight, width: 1.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(CustomSizes.cardRadiusMd)),
                borderSide: BorderSide(color: CustomColors.primaryDark, width: 2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
