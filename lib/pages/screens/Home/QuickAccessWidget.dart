import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class QuickAccessWidget extends StatelessWidget {
  const QuickAccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleTextWidget(text: "Quick Access"),
              GestureDetector(
                onTap: () { Navigator.pop(context); } ,
                child: Icon(Iconsax.close_square, size: 30,
                color: isDark ? CustomColors.textColorDark : CustomColors.textColorLight),)
            ],
          ),
        ],
      ),
    );
  }
}

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
        fontSize: CustomSizes.fontSizeLg,
          letterSpacing: 0.5,
          color:
              isDark ? CustomColors.textColorDark : CustomColors.textColorLight,
          fontWeight: FontWeight.bold),
    );
  }
}
