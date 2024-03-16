// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 65.0),
          height: displayWidth / 1.8,
          // decoration: BoxDecoration(color: Colors.blue.shade800),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://img.freepik.com/premium-photo/iconic-tower-bridge-view-connecting-london-with-southwark-thames-river-uk-beautiful-view-illuminated-bridge-night_536604-1805.jpg?size=626&ext=jpg'),
              fit: BoxFit.fill,
              opacity: .5
            ),
            color: Colors.black
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      // backgroundImage: AssetImage("assets/images/Profile Image.png"),
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black.withOpacity(.4),
                      ),
                      child: Icon(Iconsax.notification, color: isDark ? CustomColors.componentColorDark : CustomColors.componentColorLight),
                    )
                  ],
                ),
                Text("Hey, Adam Brooke 👋🏽",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text("Discover what's happening around you",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}