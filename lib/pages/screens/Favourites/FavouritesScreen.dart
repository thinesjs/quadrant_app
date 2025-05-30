import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          child: SectionText(
              isDark: isDark, text: 'Favourites', size: 32.0, bold: true),
        ),
      ],
    );
  }
}