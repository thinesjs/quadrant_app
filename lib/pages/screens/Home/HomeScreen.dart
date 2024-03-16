// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/routes/route_helper.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 65.0),
          height: displayWidth / 1.5,
          // decoration: BoxDecoration(color: Colors.blue.shade800),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://live.staticflickr.com/4475/37095348433_626859af3c_b.jpg'),
              fit: BoxFit.fill,
              opacity: .5
            ),
            color: Colors.black
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => {Get.toNamed(RouteHelper.getProfile())},
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(42)),
                          color: Colors.black.withOpacity(.4),
                        ),
                        child: Icon(Iconsax.notification, color: isDark ? CustomColors.componentColorDark : CustomColors.componentColorLight),
                      )
                    ],
                  ),
                ),
                Text("Hey, Adam Brooke 👋🏽",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textColorDark
                  ),
                ),
                Text("Discover what's happening around you",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: CustomColors.textColorDark
                  ),
                ),
                CustomTextField(hint: 'Search restaurants, salon…', txtController: usernameController, isLoading: false, onChange: (String val) {  },)
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}