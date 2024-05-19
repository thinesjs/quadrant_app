import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          child: SectionText(
              isDark: isDark, text: 'Cart', size: 32.0, bold: true),
        ),
      ],
    );
  }
}