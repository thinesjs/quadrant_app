import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/add_card.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/list_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddressesScreen());
  }

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
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
                SectionText(isDark: isDark, text: 'Addresses', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(isDark: isDark, text: 'Update and manage your shipping and billing addresses.'),
            AddCardComponent(isDark: isDark, text: "Add New Address", onTap: () {}),
            ListCardComponent(isDark: isDark, text: "text", onTap: () {}, isDefault: false,)


          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   height: 50,
      //   margin: const EdgeInsets.all(10),
      //   child: AppFilledButton(isDark: isDark, text: "Save", onTap: () { }, isBlock: true)
      // ),
    );
  }
}