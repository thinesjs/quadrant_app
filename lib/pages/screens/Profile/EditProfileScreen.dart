import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/textfields.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EditProfileScreen());
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    User user = context.select<AuthenticationBloc, User>((bloc) => bloc.state.user);
    _usernameController.text = user.name;
    _emailController.text = user.email;

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
                SectionText(isDark: isDark, text: 'Edit Profile', size: 32.0, bold: true),
              ],
            ),
            SectionHelperText(isDark: isDark, text: 'Provide details about yourself and any other pertinent information.'),
            SectionText(isDark: isDark, text: "Basic Information", size: 20, bold: true),
            UserAvatarComponent(isDark: isDark, user: user),
            AppTextField(label: "Username", placeholder: "John Doe", controller: _usernameController, isDark: isDark),
            AppTextField(label: "Email", placeholder: "example@mail.com", controller: _emailController, isDark: isDark),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: AppFilledButton(isDark: isDark, text: "Save", onTap: () { print("hey"); }, isBlock: true ,isLoading: false)
      ),
    );
  }
}

class UserAvatarComponent extends StatelessWidget {
  const UserAvatarComponent({super.key, required this.isDark, required this.user});

  final bool isDark;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Profile Avatar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )
            ),
            const Text("Recommended 300x300",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )
            ),
            Row(
              children: [
                AppOutlinedButton(isDark: isDark, text: "Change", onTap: () { print("hey"); }),
                const SizedBox(width: 5),
                AppOutlinedButton(isDark: isDark, text: "Remove", onTap: () { })
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CircleAvatar(
            backgroundImage: (user.avatar != "") ? NetworkImage(user.avatar) : const AssetImage('assets/placeholders/placeholder-user.jpg') as ImageProvider<Object>,
            maxRadius: 50
          ),
        ),
      ],
    );
  }
}