import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class CircleActionButton extends StatelessWidget {
  const CircleActionButton({
    super.key,
    required this.isDark,
    required this.onTap,
    required this.icon,
  });

  final bool isDark;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(42)),
          color: Colors.black.withOpacity(.4),
        ),
        child: Icon(icon,
            color: isDark
                ? CustomColors.componentColorDark
                : CustomColors.componentColorLight),
      ),
    );
  }
}