import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Scaffold(body: SecurityScreen()));
  }

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleActionButton(isDark: isDark, icon: Iconsax.arrow_left, onTap: () { Navigator.pop(context); },),
              const SizedBox(width: 10,),
              SectionText(
                  isDark: isDark, text: 'Security', size: 32.0, bold: true),
            ],
          ),
        ),
      ],
    );
  }
}