import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/textfields.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
// import 'package:cloudinary_flutter/cloudinary_context.dart';
// import 'package:cloudinary_flutter/image/cld_image.dart';
// import 'package:cloudinary_url_gen/cloudinary.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EditProfileScreen());
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    User user =
        context.select<AuthenticationBloc, User>((bloc) => bloc.state.user);
    _usernameController.text = user.name;
    _emailController.text = user.email;

    // Cloudinary cloudinary = CloudinaryObject.fromCloudName(cloudName: "dz6ucd5lw");

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
                    isDark: isDark,
                    text: 'Edit Profile',
                    size: 32.0,
                    bold: true),
              ],
            ),
            SectionHelperText(
                isDark: isDark,
                text:
                    'Provide details about yourself and any other pertinent information.'),
            SectionText(
                isDark: isDark,
                text: "Basic Information",
                size: 20,
                bold: true),
            UserAvatarComponent(isDark: isDark, user: user),
            AppTextField(
                label: "Username",
                placeholder: "John Doe",
                controller: _usernameController,
                isDark: isDark),
            AppTextField(
                label: "Email",
                placeholder: "example@mail.com",
                controller: _emailController,
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
                BlocProvider.of<AuthenticationBloc>(context).add(
                    ProfileUpdateRequested(
                        _usernameController.text, _emailController.text));
              },
              isBlock: true,
              isLoading: _isLoading)),
    );
  }
}

class UserAvatarComponent extends StatefulWidget {
  const UserAvatarComponent(
      {super.key, required this.isDark, required this.user});

  final bool isDark;
  final User user;

  @override
  State<UserAvatarComponent> createState() => _UserAvatarComponentState();
}

class _UserAvatarComponentState extends State<UserAvatarComponent> {
  File? _imageFile;
  String? _imageURL;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker image = ImagePicker();
    final XFile? pickedFile = await image.pickImage(source: source);
    setState(() {
      if (pickedFile != null) _imageFile = File(pickedFile.path);
    });
  }

  Future<void> _uploadImage() async {
    await _pickImage(ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Profile Avatar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text("Recommended 300x300",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                )),
            Row(
              children: [
                AppOutlinedButton(
                    text: "Change",
                    onTap: () {
                      _uploadImage();
                      if (_imageFile != null) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            ProfileAvatarUpdateRequested(_imageFile!.path));
                      }
                    }),
                const SizedBox(width: 5),
                AppOutlinedButton(
                    text: "Remove",
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(ProfileAvatarRemoveRequested());
                    })
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CircleAvatar(
              backgroundImage: (widget.user.avatar != "")
                  ? NetworkImage(widget.user.avatar)
                  : const AssetImage('assets/placeholders/placeholder-user.jpg')
                      as ImageProvider<Object>,
              maxRadius: 50),
        ),
      ],
    );
  }
}
