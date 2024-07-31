import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/textfields.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => const SecurityScreen());
  }

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final TextEditingController _currentPwdController = TextEditingController();
  final TextEditingController _newPwdController = TextEditingController();
  final TextEditingController _newPwd2Controller = TextEditingController();

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
                SectionText(isDark: isDark, text: 'Security', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(isDark: isDark, text: 'Manage your password and enhance account protection with 2FA settings.'),
            AppTextField(
                label: "Current Password",
                placeholder: "",
                obscureText: true,
                controller: _currentPwdController,
                isDark: isDark),
            AppTextField(
                label: "New Password",
                placeholder: "",
                obscureText: true,
                controller: _newPwdController,
                isDark: isDark),
            AppTextField(
                label: "Repeat New Password",
                placeholder: "",
                obscureText: true,
                controller: _newPwd2Controller,
                isDark: isDark),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: AppFilledButton(
              isDark: isDark,
              text: "Save",
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