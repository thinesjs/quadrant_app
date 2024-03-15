import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? selectedIndex;

  List<List<dynamic>> combinedList = [
    [const HomeScreen(), 'Home', Iconsax.home5],
    [const HomeScreen(), 'Search', Iconsax.search_status],
    [const HomeScreen(), 'Favouries', Iconsax.lovely],
    [const HomeScreen(), 'Profile', Iconsax.user]
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(selectedIndex != null) {
      currentIndex = selectedIndex!;
    }
    double displayWidth = MediaQuery.of(context).size.width;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: combinedList[currentIndex][0],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 0.0,
        selectedItemColor: const Color(0xFFD6354D),
        unselectedItemColor: const Color(0xFF7E7E7E),
        // showSelectedLabels: false,
        // selectedFontSize: 1,
        // unselectedFontSize: 12,
        items: 
          combinedList.map((page) {
            return BottomNavigationBarItem(
              label: page[1],
              icon: Icon(page[2]),
            );
          }).toList(),
      ),
    );
  }
}