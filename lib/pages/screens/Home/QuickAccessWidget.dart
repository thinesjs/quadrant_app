import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/category_button.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class QuickAccessWidget extends StatelessWidget {
  QuickAccessWidget({Key? key}) : super(key: key);

  final List<Item> items = [
    Item(name: 'Price Check', icon: Iconsax.barcode),
    Item(name: 'Vouchers', icon: Iconsax.discount_circle),
    Item(name: 'Q-Wallet', icon: Iconsax.wallet),
    Item(name: 'Help', icon: Iconsax.info_circle),
  ];

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 19),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemGridButton(
                  context: context,
                  items: items[index],
                  isDark: isDark,
                  onTap: () {
                    mainPageKey.currentState?.switchToScreen(2);
                    Navigator.pop(context); 
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CategoryScreen(
                    //         categoryName: categories[index].name),
                    //   ),
                    // );
                  },
                ).animate().fade().slideY(begin: -0.2);
              },
            ),
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
