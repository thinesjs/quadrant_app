import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/app_bar.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Profile/EditProfileScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/ProfileScreen.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/FaceCaptureScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

import 'FaceCaptureScreen.dart';

class QEntrySettingsScreen extends StatefulWidget {
  const QEntrySettingsScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const QEntrySettingsScreen());
  }

  @override
  State<QEntrySettingsScreen> createState() => _QEntrySettingsScreenState();
}

class _QEntrySettingsScreenState extends State<QEntrySettingsScreen> {
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
                CircleActionButton(
                  isDark: isDark,
                  icon: Iconsax.arrow_left,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                SectionText(
                    isDark: isDark, text: 'Q-Entry', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(
                isDark: isDark,
                text:
                    'Manage your Q-Entry settings and enhance your shopping experiance.'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: isDark
                        ? CustomColors.cardColorDark
                        : CustomColors.cardColorLight,
                    borderRadius:
                        BorderRadius.circular(CustomPadding.tRoundEdgePadding)),
                child: Column(
                  children: [
                    ProfileButton(
                        title: "Setup",
                        caption: "Setup & Register Q-Entry",
                        icon: Iconsax.security_card,
                        onTap: () => {
                              Navigator.push(context, FacialCaptureScreen.route())
                            },
                        isDark: isDark),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
