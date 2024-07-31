import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/blocs/qentry/bloc/qentry_bloc.dart';
import 'package:quadrant_app/pages/components/expandable_fab.dart';
import 'package:quadrant_app/pages/components/material_sheet.dart';
import 'package:quadrant_app/pages/screens/Checkout/CheckoutScreen.dart';
import 'package:quadrant_app/pages/screens/Product/ProductUPCScanner.dart';
import 'package:quadrant_app/pages/screens/Q-Wallet/EwalletScreen.dart';
import 'package:quadrant_app/pages/screens/Cart/CartScreen.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/ProfileScreen.dart';
import 'package:quadrant_app/pages/screens/Search/SearchScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/enums/cart_type.dart';

final GlobalKey<_MainPageState> mainPageKey = GlobalKey<_MainPageState>();

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => MainPage(key: mainPageKey));
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
    if (selectedIndex != null) {
      currentIndex = selectedIndex!;
    }

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocBuilder<QentryBloc, QentryState>(
      builder: (context, state) {
        bool isFloatingActionBarVisible = state is QentryVerified;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: screensList[currentIndex][0],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: isDark
                            ? CustomColors.navBarBackgroundDark
                            : CustomColors.navBorderDark,
                        width: 1.0))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: onTap,
              elevation: 0.0,
              enableFeedback: true,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: const Color(0xFFD6354D),
              unselectedItemColor: const Color(0xFF7E7E7E),
              backgroundColor: isDark
                  ? CustomColors.navBarBackgroundDark
                  : CustomColors.navBarBackgroundLight,
              items: screensList.map((page) {
                return BottomNavigationBarItem(
                  label: page[1],
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(page[2]),
                  ),
                );
              }).toList(),
            ),
          ),
          floatingActionButton: isFloatingActionBarVisible && mainPageKey.currentState?.currentIndex != 3
            ? ExpandableFab(
                distance: 70,
                children: [
                  ActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialSheetRoute<void>(
                          builder: (BuildContext context) =>
                              const ProductUPCScanner(),
                        ),
                      );
                    },
                    icon: const Icon(Iconsax.barcode, color: CustomColors.subTextColorDark),
                  ),
                  ActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CheckoutScreen(
                            cartType: CartType.IN_STORE,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Iconsax.bag_tick_2, color: CustomColors.subTextColorDark),
                  ),
                ],
              )
            : null,
        );
      },
    );
  }
}
