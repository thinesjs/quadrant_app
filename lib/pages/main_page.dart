import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/ewallet/EwalletScreen.dart';
import 'package:quadrant_app/pages/screens/Cart/CartScreen.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/ProfileScreen.dart';
import 'package:quadrant_app/pages/screens/Search/SearchScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

final GlobalKey<_MainPageState> mainPageKey = GlobalKey<_MainPageState>();

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key); 

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => MainPage(key: mainPageKey));
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? selectedIndex;

  List<List<dynamic>> screensList = [
    [const HomeScreen(), 'Home', Iconsax.home5],
    [const SearchScreen(), 'Browse', Iconsax.search_status],
    [const EwalletScreen(), 'Q-Wallet', Iconsax.wallet],
    [const CartScreen(), 'Cart', Iconsax.shopping_cart],
    [const ProfileScreen(), 'Profile', Iconsax.user]
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void switchToScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(selectedIndex != null) {
      currentIndex = selectedIndex!;
    }
    
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: screensList[currentIndex][0],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 0.0,
        enableFeedback: true,
        selectedItemColor: const Color(0xFFD6354D),
        unselectedItemColor: const Color(0xFF7E7E7E),
        backgroundColor: isDark ? CustomColors.navBarBackgroundDark : CustomColors.navBarBackgroundLight,
        items: 
          screensList.map((page) {
            return BottomNavigationBarItem(
              label: page[1],
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(page[2]),
              ),
            );
          }).toList(),
      ),
    );
  }
}