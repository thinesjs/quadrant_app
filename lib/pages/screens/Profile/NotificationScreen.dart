import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const NotificationScreen());
  }

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleActionButton(isDark: isDark, icon: Iconsax.arrow_left, onTap: () { Navigator.pop(context); },),
                const SizedBox(width: 10,),
                SectionText(isDark: isDark, text: 'Notification', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(isDark: isDark, text: 'Customize your notification preferences and stay updated your way.'),
            SectionText(isDark: isDark, text: "Basic Information", size: 20, bold: true),
            // UserAvatarComponent(isDark: isDark, user: user),
            // AppTextField(label: "Username", placeholder: "John Doe", controller: _usernameController, isDark: isDark),
            // AppTextField(label: "Email", placeholder: "example@mail.com", controller: _emailController, isDark: isDark),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: AppFilledButton(isDark: isDark, text: "Save", onTap: () { }, isBlock: true)
      ),
    );
  }
}