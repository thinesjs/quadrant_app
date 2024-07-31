import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/textfields.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => const Scaffold(body: SupportScreen()));
  }

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
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
                SectionText(isDark: isDark, text: 'Help & Support', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(isDark: isDark, text: 'Find answers to your questions and get the assistance you need.'),
            SectionText(isDark: isDark, text: "What'd you need help with?", size: 20, bold: true),
            AppTextField(
                label: "Issue Title",
                placeholder: "",
                controller: _titleController,
                isDark: isDark),
            AppLargeTextField(
                label: "Issue Description",
                placeholder: "",
                controller: _descController),
            SectionHelperText(isDark: isDark, text: "You will be contacted through your email hereinafter.", size: 14),
            SectionHelperText(isDark: isDark, text: "Make sure to check your inbox or spam in few working days.", size: 14, bold: true,),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: AppFilledButton(
              isDark: isDark,
              text: "Submit Ticket",
              onTap: () {
                Navigator.pop(context);
                // BlocProvider.of<AuthenticationBloc>(context).add(
                //     ProfileUpdateRequested(
                //         _usernameController.text, _emailController.text));
              },
              isBlock: true,
              isLoading: false)),
    );
  }
}