import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Scaffold(body: EditProfileScreen()));
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                  isDark: isDark, text: 'Edit Profile', size: 32.0, bold: true),
            ],
          ),
        ),
      ],
    );
  }
}