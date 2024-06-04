import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class CustomAppBar extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onLeadingTap;

  const CustomAppBar({
    Key? key,
    required this.isDark,
    this.onLeadingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDark ? CustomColors.navBarBackgroundDark : CustomColors.navBarBackgroundLight,
      elevation: 0, 
      centerTitle: false,
      leading: CircleActionButton(
        isDark: isDark,
        icon: Iconsax.arrow_left,
        onTap: onLeadingTap,
      ),
      title: SectionText(
        isDark: isDark,
        text: 'Security',
        size: 32.0,
        bold: true,
      ),
    );
  }
}
